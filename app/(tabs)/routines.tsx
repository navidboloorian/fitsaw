import { useState } from "react";
import { FitsawText } from "../../src/shared/components/components";
import { useQuery } from "@tanstack/react-query";
import { deleteExercise, getAllExercises } from "../../src/features/view_exercise/api/exercise_api";
import { FlatList, Pressable } from "react-native";
import { useSQLiteContext } from "expo-sqlite";
import { router, useFocusEffect } from "expo-router";
import { useQueryClient, useMutation } from "@tanstack/react-query";
import { Error, Loading, SearchBar, BackgroundBox, Spacer, TagList, Dismissible } from "../../src/shared/components/components";
import { FitsawError } from "../../src/shared/globals";
import { deleteRoutine, getAllRoutines } from "../../src/features/view_routine/api/routine_api";
import { Routine } from "../../src/features/view_routine/model/model";

const Routines = () => {
    const db = useSQLiteContext();
    const queryClient = useQueryClient();
    const [searchQuery, setSearchQuery] = useState("");
    const routines = useQuery(
        {
            queryKey: ["routines"], 
            queryFn: () : Promise<Routine[]> => getAllRoutines(db)
        }
    );

    useFocusEffect(() => {
        // ensures that routine list is refetched everytime it loads anew
        queryClient.refetchQueries({queryKey: ["routines"]});
    });

    const onDismiss = async (id : number) => {
        deleteRoutine(db, id);
    }

    const deleteMutation = useMutation({
        mutationFn: onDismiss
    });

    if (routines.isLoading) {
        return <Loading />;
    }

    if (routines.isError) {
        throw new FitsawError({name: "FORM_ERROR", message: "There was an error loading the routines."});
    }

    // narrow down list based on search query
    const routineList = routines.data!.filter((routine) => {
        if (routine.name.toLowerCase().includes(searchQuery.toLowerCase())) return true;

        for (const tag of routine.tags) {
            if (tag.toLowerCase().includes(searchQuery.toLowerCase())) return true;
        }

        return false;
    });

    return (
        <>
            <SearchBar searchQuery={searchQuery} setSearchQuery={setSearchQuery} placeholder={"Search exercises..."} />
            <Spacer height={10} />
            <FlatList
                data={routineList}
                renderItem={({item}) => 
                    (
                        <Dismissible 
                            onDismiss={() => deleteMutation.mutate(item.id!)}
                        >
                            <Pressable
                                onPress={() => {
                                    const id = item.id;
                                    router.navigate({pathname: "/view_routine/[id]", params: {id}});
                                }} 
                            >
                                <BackgroundBox style={{width: "100%"}}>
                                    <FitsawText>{item.name}</FitsawText>
                                    {item.tags.length > 0 ? <Spacer height={5} /> : <></>}
                                    <TagList tags={item.tags} />
                                </BackgroundBox>
                            </Pressable>
                        </Dismissible>
                    )
                }
                keyExtractor={exercise => exercise.id!.toString()}
                ItemSeparatorComponent={() => <Spacer height={10} />}
            />
        </>
    );
}

export default Routines;