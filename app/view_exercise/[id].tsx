import { useLocalSearchParams } from "expo-router";
import {ExerciseForm} from "../../src/features/view_exercise/ui/ui";
import { useQuery } from "@tanstack/react-query";
import {Exercise} from "../../src/features/view_exercise/model/model";
import { getExercise } from "../../src/features/view_exercise/api/exercise_api";
import { useSQLiteContext } from "expo-sqlite";
import { Loading } from "../../src/shared/components/Loading";

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
        return <Loading />;
    }

    return (
        <>
            <ExerciseForm initialExercise={exercise.data}/>
        </>
    );
}

export default ViewExercise;