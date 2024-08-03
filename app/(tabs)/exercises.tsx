import { useState } from "react";
import SearchBar from "../../src/shared/components/SearchBar";
import FitsawText from "../../src/shared/components/FitsawText";
import { useQuery } from "@tanstack/react-query";
import { deleteExercise, getAllExercises } from "../../src/features/create_exercise/api/exercise_api";
import { FlatList, Pressable, Text, View } from "react-native";
import BackgroundBox from "../../src/shared/components/BackgroundBox";
import { useSQLiteContext } from "expo-sqlite";
import Spacer from "../../src/shared/components/Spacer";
import Exercise from "../../src/features/create_exercise/model/exercise";
import TagList from "../../src/shared/components/TagList";
import Dismissible from "../../src/shared/components/Dismissible";
import { Link, router, useFocusEffect } from "expo-router";
import { useQueryClient, useMutation } from "@tanstack/react-query";

const Exercises = () => {
    const db = useSQLiteContext();
    const queryClient = useQueryClient();
    const [searchQuery, setSearchQuery] : [string, (query: string) => void] = useState("");
    const exercises = useQuery(
        {
            queryKey: ["exercises"], 
            queryFn: () : Promise<Exercise[]> => getAllExercises(db)
        }
    );

    useFocusEffect(() => {
        queryClient.refetchQueries({queryKey: ["exercises"]});
    });

    const onDismiss = async (id : number) => {
        deleteExercise(db, id);
    }

    const mutation = useMutation({
        mutationFn: onDismiss
    });

    if (exercises.isError || exercises.isLoading) {
        return <Text>Zere has been error</Text>;
    }

    return (
        <>
            <SearchBar searchQuery={searchQuery} setSearchQuery={setSearchQuery} placeholder={"Search exercises..."} />
            <Spacer height={10} />
            <FlatList
                data={exercises.data}
                renderItem={({item}) =>
                    <Dismissible 
                        onPress={() => {
                            const id = item.id;
                            router.navigate({pathname: "/view_exercise/[id]", params: {id}});
                        }} 
                        onDismiss={() => onDismiss(item.id!)}
                    >
                        <BackgroundBox style={{width: "100%"}}>
                            <FitsawText>{item.name}</FitsawText>
                                {item.tags.length > 0 ? <Spacer height={5} /> : <></>}
                            <TagList tags={item.tags} />
                        </BackgroundBox>
                    </Dismissible>
                }
                keyExtractor={exercise => exercise.id!.toString()}
                ItemSeparatorComponent={() => <Spacer height={10} />}
            />
        </>
    );
}

export default Exercises;