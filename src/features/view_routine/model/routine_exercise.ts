import { Exercise } from "../../view_exercise/model/model"
import { Routine } from "./routine"

export type RoutineExercise = {
    exercise: Exercise,
    routine?: Routine,
    sets: number,
    rest?: number,
    position?: number,
    time?: number[],
    reps?: number[]
}