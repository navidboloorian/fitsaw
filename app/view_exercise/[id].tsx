import { useLocalSearchParams } from "expo-router";
import ExerciseForm from "../../src/features/create_exercise/ui/ExerciseForm";
import { useQuery } from "@tanstack/react-query";
import Exercise from "../../src/features/create_exercise/model/exercise";
import { getExercise } from "../../src/features/create_exercise/api/exercise_api";
import { useSQLiteContext } from "expo-sqlite";
import FitsawText from "../../src/shared/components/FitsawText";

const ViewExercise = () => {
    const {id} = useLocalSearchParams<{id : string}>();
    const db = useSQLiteContext();

    const exercise = useQuery(
        {
            queryKey: ["exercise", id], 
            queryFn: () : Promise<Exercise | null> => getExercise(db, parseInt(id!)),
        }
    );

    if (exercise.isLoading || exercise.isFetching) {
        return <FitsawText>Loading</FitsawText>
    }

    console.log(exercise.data)

    return (
        <>
            <ExerciseForm initialExercise={exercise.data}/>
        </>
    );
}

export default ViewExercise;