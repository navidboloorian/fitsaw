import { Exercise } from "../../view_exercise/model/model";

export type RoutineExercise = {
    exercise: Exercise,
    sets: number,
    rest: number | string,
    position?: number,
    weights: number[],
    times: (number | string)[],
    reps: number[]
}