import { useLocalSearchParams } from "expo-router";
import { useQuery } from "@tanstack/react-query";
import { useSQLiteContext } from "expo-sqlite";
import { Loading } from "../../src/shared/components/Loading";
import { getRoutine } from "../../src/features/view_routine/api/routine_api";
import { RoutineForm } from "../../src/features/view_routine/ui/ui";
import { Routine } from "../../src/features/view_routine/model/model";

const ViewRoutine = () => {
    const {id} = useLocalSearchParams<{id : string}>();
    const db = useSQLiteContext();

    const routine = useQuery(
        {
            queryKey: ["routine", id], 
            queryFn: () : Promise<Routine | null> => getRoutine(db, parseInt(id!)),
        }
    );

    if (routine.isLoading || routine.isFetching) {
        return <Loading />;
    }

    return (
        <>
            <RoutineForm initialRoutine={routine.data}/>
        </>
    );
}

export default ViewRoutine;