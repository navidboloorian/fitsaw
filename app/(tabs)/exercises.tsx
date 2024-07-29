import { useState } from "react";
import SearchBar from "../../src/shared/components/SearchBar";
import FitsawText from "../../src/shared/components/FitsawText";
import { useQuery } from "@tanstack/react-query";
import { getAllExercises } from "../../src/features/create_exercise/api/exercise_api";
import { FlatList, Text } from "react-native";
import BackgroundBox from "../../src/shared/components/BackgroundBox";
import { useSQLiteContext } from "expo-sqlite";
import Spacer from "../../src/shared/components/Spacer";
import Exercise from "../../src/features/create_exercise/model/exercise";
import TagList from "../../src/shared/components/TagList";

const Exercises = () => {
    const [searchQuery, setSearchQuery] : [string, (query: string) => void] = useState("");
    const db = useSQLiteContext();
    const exercises = useQuery(
        {
            queryKey: ["exercises"], 
            queryFn: async () : Promise<Exercise[]> => await getAllExercises(db)
        }
    );

    if (exercises.isError || exercises.isPending) {
        return <Text>Zere has been error</Text>;
    }

    return (
        <>
            <SearchBar searchQuery={searchQuery} setSearchQuery={setSearchQuery} placeholder={"Search exercises..."} />
            <Spacer height={10} />
            <FlatList
                data={exercises.data}
                renderItem={({item}) => 
                    <BackgroundBox>
                        <FitsawText>{item.name}</FitsawText>
                        <Spacer height={5} />
                        <TagList tags={item.tags} />
                    </BackgroundBox>}
                keyExtractor={exercise => exercise.id!.toString()}
                ItemSeparatorComponent={() => <Spacer height={10} />}
            />
        </>
    );
}

export default Exercises;