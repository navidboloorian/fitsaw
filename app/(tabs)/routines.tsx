import { useQuery, useQueryClient } from "@tanstack/react-query";
import { useSQLiteContext } from "expo-sqlite";
import { useMutation } from "@tanstack/react-query";
import { deleteRoutine, getAllRoutines } from "../../src/features/view_routine/api/routine_api";
import { Routine } from "../../src/features/view_routine/model/model";
import { SearchableList } from "../../src/shared/components/SearchableList";

const Routines = () => {
    const db = useSQLiteContext();
    const queryClient = useQueryClient();
    const queryFn = useQuery(
        {
            queryKey: ["routines"], 
            queryFn: () : Promise<Routine[]> => getAllRoutines(db)
        }
    );

    const mutation = useMutation({
        mutationFn: async (id : number) => deleteRoutine(db, id),
        onSuccess: () => {
            queryClient.invalidateQueries({queryKey: ["routines"]});
            queryClient.invalidateQueries({queryKey: ["history"]});
        },
        mutationKey: ["routines"]
    });

    return (
        <SearchableList 
            queryFn={queryFn}
            queryKey="routines"
            mutation={mutation}
            searchPlaceholder="Search routines..."
            viewItemPath="/view_routine/[id]"
            errorMessage="Failed to load routines"
        />
    );
}

export default Routines;