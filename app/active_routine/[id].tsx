import { useQuery } from "@tanstack/react-query";
import { useLocalSearchParams } from "expo-router";
import { useSQLiteContext } from "expo-sqlite";
import { Routine } from "../../src/features/view_routine/model/routine";
import { getRoutine } from "../../src/features/view_routine/api/routine_api";
import { Loading } from "../../src/shared/components/components";
import { ActiveRoutineFrame } from "../../src/features/active_routine/ui/ActiveRoutineFrame";
import { useActiveRoutine } from "../../src/features/active_routine/lib/use_active_routine";

const ActiveRoutine = () => {
    const {id} = useLocalSearchParams<{id : string}>();
    const db = useSQLiteContext();
    const setActiveRoutine = useActiveRoutine((state) => state.setActiveRoutine);

    const routine = useQuery(
        {
            queryKey: ["routine", id], 
            queryFn: () : Promise<Routine | null> => getRoutine(db, parseInt(id!)),
        }
    );

    if (routine.isLoading || routine.isFetching) {
        return <Loading />;
    }

    setActiveRoutine(routine.data!);

    return (
        <>
            <ActiveRoutineFrame />
        </>
    );
}

export default ActiveRoutine;