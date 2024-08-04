import { useState } from "react";
import { FitsawText } from "../../src/shared/components/components";
import { useQuery } from "@tanstack/react-query";
import { deleteExercise, getAllExercises } from "../../src/features/create_exercise/api/exercise_api";
import { FlatList, Pressable} from "react-native";
import { useSQLiteContext } from "expo-sqlite";
import {Exercise} from "../../src/features/create_exercise/model/model";
import { router, useFocusEffect } from "expo-router";
import { useQueryClient, useMutation } from "@tanstack/react-query";
import { Error, Loading, SearchBar, BackgroundBox, Spacer, TagList, Dismissible } from "../../src/shared/components/components";

const Exercises = () => {
    const db = useSQLiteContext();
    const queryClient = useQueryClient();
    const [searchQuery, setSearchQuery] = useState("");
    const exercises = useQuery(
        {
            queryKey: ["exercises"], 
            queryFn: () : Promise<Exercise[]> => getAllExercises(db)
        }
    );

    useFocusEffect(() => {
        // ensures that exercise list is refetched everytime it loads anew
        queryClient.refetchQueries({queryKey: ["exercises"]});
    });

    const onDismiss = async (id : number) => {
        deleteExercise(db, id);
    }

    const deleteMutation = useMutation({
        mutationFn: onDismiss
    });

    if (exercises.isLoading) {
        return <Loading />;
    }

    if (exercises.isError) {
        return <Error message={"There was an error loading the exercise list."} />;
    }

    // narrow down list based on search query
    const exerciseList = exercises.data!.filter((exercise) => exercise.name.toLocaleLowerCase().includes(searchQuery.toLowerCase()));

    return (
        <>
            <SearchBar searchQuery={searchQuery} setSearchQuery={setSearchQuery} placeholder={"Search exercises..."} />
            <Spacer height={10} />
            <FlatList
                data={exerciseList}
                renderItem={({item}) => 
                    (
                        <Dismissible 
                            onDismiss={() => deleteMutation.mutate(item.id!)}
                        >
                            <Pressable
                                onPress={() => {
                                    const id = item.id;
                                    router.navigate({pathname: "/view_exercise/[id]", params: {id}});
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

export default Exercises;