import { useActiveRoutine } from "../lib/use_active_routine";
import { ProgressBar } from "./ProgressBar";

export const ActiveRoutineFrame = () => {
    const setCurrentStep = useActiveRoutine((state) => state.setCurrentStep);
    const setTotalSteps = useActiveRoutine((state) => state.setTotalSteps);
    const routine = useActiveRoutine((state) => state.activeRoutine);

    const totalSteps = () => {
        let total = 0;

        for (const routineExercise of routine!.routineExercises) {
            total += routineExercise.sets;
        }

        return total;
    }

    setCurrentStep(0);
    setTotalSteps(totalSteps());

    return <ProgressBar />;
}