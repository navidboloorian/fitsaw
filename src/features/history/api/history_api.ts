import { SQLiteDatabase } from "expo-sqlite";
import { HistoryRoutine } from "../model/history_routine";
import { RoutineExercise } from "../../view_routine/model/routine_exercise";
import { dbRoutineExercise, dbStats } from "../../view_routine/api/routine_api";
import { Exercise } from "../../view_exercise/model/model";

export const createHistoryRoutine = async (db : SQLiteDatabase, historyRoutine : HistoryRoutine) : Promise<void> => {
    const dbRoutineHistory = await db.runAsync(
        "INSERT INTO history_routines (name, date, routine_id) VALUES (?, date('now'), ?)",
        [historyRoutine.routine.name, historyRoutine.routine.id!]
    );

    const id = dbRoutineHistory.lastInsertRowId;

    for (let i = 0; i < historyRoutine.routineExercises.length; i++) {
        const routineExercise : RoutineExercise = historyRoutine.routineExercises[i];

        const dbHistoryRoutineExercise = await db.runAsync(
            "INSERT INTO history_routine_exercises (name, sets, history_routine_id, exercise_id, position) VALUES (?, ?, ?, ?, ?)", 
            [routineExercise.exercise.name, routineExercise.sets, id, routineExercise.exercise.id!, i]
        );

        for (let i = 0; i < routineExercise.sets; i++) {
            await db.runAsync(
                "INSERT INTO history_routine_exercise_stats (history_routine_exercise_id, weight, reps, time, position) VALUES (?, ?, ?, ?, ?)",
                [
                    dbHistoryRoutineExercise.lastInsertRowId, 
                    routineExercise.weights ? routineExercise.weights[i] : null, 
                    routineExercise.reps ? routineExercise.reps[i] : null, 
                    routineExercise.times ? routineExercise.times[i] : null, i
                ]
            );
        }
    }
}

export const getHistory = async (db : SQLiteDatabase, date : string) : Promise<HistoryRoutine[]> => {
    const historyRoutines = await db.getAllAsync<HistoryRoutine>("SELECT * FROM history_routines WHERE date = ?", [date]);
    const routineExercises : RoutineExercise[] = [];

    for (const historyRoutine of historyRoutines) {
        const dbRoutineExercises = await db.getAllAsync<dbRoutineExercise>("SELECT * FROM history_routine_exercises WHERE history_routine_id = ?", [historyRoutine.id!]);


        for (const dbRoutineExercise of dbRoutineExercises) {
            const exercise : Exercise | null = await db.getFirstAsync<Exercise>("SELECT * FROM exercises WHERE id = ?", dbRoutineExercise.exercise_id);
            const dbStats : dbStats[] | null = await db.getAllAsync<dbStats>("SELECT * FROM history_routine_exercise_stats WHERE history_routine_exercise_id = ? ORDER BY position", dbRoutineExercise.id);

            const weights : number[] = [];
            const times : number[] = [];
            const reps : number[] = [];

            for (const stat of dbStats) {
                weights.push(stat.weight);
                times.push(stat.time);
                reps.push(stat.reps);
            }

            const routineExercise : RoutineExercise = {
                exercise: exercise!,
                sets: dbRoutineExercise.sets,
                rest: dbRoutineExercise.rest,
                weights: weights,
                reps: reps,
                times: times,
            }

            routineExercises.push(routineExercise);
        }

        historyRoutine.routineExercises = routineExercises;
    }
    
    return historyRoutines;
}

export const getDates = async (db : SQLiteDatabase) : Promise<string[]> => {
    const dbDates = await db.getAllAsync<{date : string}>("SELECT DISTINCT date FROM history_routines");
    const dates : string[] = [];

    for (const dbDate of dbDates) {
        dates.push(dbDate.date);
    }

    return dates;
}