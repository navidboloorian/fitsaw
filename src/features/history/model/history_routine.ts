import { Routine, RoutineExercise } from "../../view_routine/model/model"

export type HistoryRoutine = {
    id? : number,
    dateTime? : string,
    routine : Routine,
    routineExercises : RoutineExercise[],
    name : string
}