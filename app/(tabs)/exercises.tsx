import { SearchableList } from "../../src/shared/components/components";
import { useQuery, useQueryClient } from "@tanstack/react-query";
import { deleteExercise, getAllExercises } from "../../src/features/view_exercise/api/exercise_api";
import { useSQLiteContext } from "expo-sqlite";
import { Exercise } from "../../src/features/view_exercise/model/model";
import { useMutation } from "@tanstack/react-query";

const Exercises = () => {
    const db = useSQLiteContext();
    const queryClient = useQueryClient();
    const queryFn = useQuery(
        {
            queryKey: ["exercises"], 
            queryFn: () : Promise<Exercise[]> => getAllExercises(db)
        }
    );

    const mutation = useMutation({
        mutationFn: async (id : number) => deleteExercise(db, id),
        onSuccess: () => {
            queryClient.invalidateQueries({queryKey: ["exercises"]});
            queryClient.invalidateQueries({queryKey: ["history"]});
        },
        mutationKey: ["routines"]
    });

    return (
        <SearchableList 
            queryFn={queryFn}
            queryKey="exercises"
            mutation={mutation}
            searchPlaceholder="Search exercises..."
            viewItemPath="/view_exercise/[id]"
            errorMessage="Failed to load exercises"
        />
    );
}

export default Exercises;