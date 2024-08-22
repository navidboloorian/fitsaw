import { create } from "zustand";
import { Routine } from "../../view_routine/model/routine";

type ActiveRoutineState = {
    activeRoutine? : Routine,
    exerciseIndex? : number,
    setIndex? : number,
    totalSteps? : number,
    currentStep? : number
}

type ActiveRoutineAction = {
    setActiveRoutine : (activeRoutine : Routine) => void,
    setExerciseIndex : (exerciseIndex : number) => void,
    setSetIndex : (setIndex : number) => void,
    setTotalSteps : (totalSteps : number) => void,
    setCurrentStep : (currentStep : number) => void
}

export const useActiveRoutine = create<ActiveRoutineState & ActiveRoutineAction>((set) => ({
    setActiveRoutine: (activeRoutine) => set({activeRoutine: activeRoutine}),
    setExerciseIndex: (exerciseIndex) => set({exerciseIndex: exerciseIndex}),
    setSetIndex: (setIndex) => set({setIndex: setIndex}),
    setTotalSteps: (totalSteps) => set({totalSteps: totalSteps}),
    setCurrentStep: (currentStep) => set({currentStep: currentStep})
}));