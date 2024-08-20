import { RoutineExercise } from "./routine_exercise";

export type Routine = {
    id?: number,
    name: string,
    notes: string,
    units: string,
    creator?: number,
    routineExercises: RoutineExercise[],
    tags: string[]
}