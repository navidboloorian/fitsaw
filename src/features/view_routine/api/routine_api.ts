import { SQLiteDatabase } from "expo-sqlite";
import { Routine } from "../model/routine";
import { RoutineExercise } from "../model/routine_exercise";
import { Exercise } from "../../view_exercise/model/exercise";

type dbRoutineExercise = {
    id: number, 
    exercise_id : number, 
    routine_id : number, 
    position: number, 
    sets : number, 
    rest : number
}

type dbStats = {
    id: number,
    weight: number,
    reps: number,
    time: number,
    position: number
}

export const createRoutine = async (db : SQLiteDatabase, routine : Routine) => {
    const dbRoutine = await db.runAsync(
        "INSERT INTO routines (name, creator, units, notes) VALUES (?, ?, ?, ?)", 
        [routine.name, routine.creator || null, routine.units, routine.notes]
    );

    const id = dbRoutine.lastInsertRowId;

    for (let i = 0; i < routine.routineExercises.length; i++) {
        const routineExercise : RoutineExercise = routine.routineExercises[i];

        const dbRoutineExercise = await db.runAsync(
            "INSERT INTO routine_exercises (exercise_id, routine_id, sets, rest, position) VALUES (?, ?, ?, ?, ?)", 
            [routineExercise.exercise.id!, id, routineExercise.sets, routineExercise.rest, i]
        );

        for (let i = 0; i < routineExercise.sets; i++) {
            await db.runAsync(
                "INSERT INTO routine_exercise_stats (routine_exercise_id, reps, time, weight, position) VALUES (?, ?, ?, ?, ?)",
                [dbRoutineExercise.lastInsertRowId, routineExercise.reps[i], routineExercise.times[i], routineExercise.weights[i], i]
            );
        }
    }

    for (const tag of routine.tags) {
        await db.runAsync("INSERT INTO tags (routine_id, name) VALUES (?, ?)", [id, tag]);
    }
}   

export const getRoutine = async (db: SQLiteDatabase, id: number) => {
    const routine : Routine | null = await db.getFirstAsync("SELECT * FROM routines WHERE id = ?", id);

    if (routine) {
        const tempTags = await db.getAllAsync<{name : string}>("SELECT name FROM tags WHERE routine_id = ?", id);
        const tags = tempTags.map((tagObj) => tagObj.name); 

        routine.tags = tags;

        const dbRoutineExercises : dbRoutineExercise[] = await db.getAllAsync<dbRoutineExercise>("SELECT * FROM routine_exercises WHERE routine_id = ? ORDER BY position", id);
        const routineExercises : RoutineExercise[] = [];

        for (const dbRoutineExercise of dbRoutineExercises) {
            const exercise : Exercise | null = await db.getFirstAsync<Exercise>("SELECT * FROM exercises WHERE id = ?", dbRoutineExercise.exercise_id);
            const dbStats : dbStats[] | null = await db.getAllAsync<dbStats>("SELECT * FROM routine_exercise_stats WHERE routine_exercise_id = ? ORDER BY position", dbRoutineExercise.id);

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

        routine.routineExercises = routineExercises;
    }

    return routine;
}

export const getAllRoutines = async (db: SQLiteDatabase) => {
    const routines : Routine[] = await db.getAllAsync("SELECT * FROM routines ORDER BY name");

    for (const routine of routines) {
        const tempTags = await db.getAllAsync<{name : string}>("SELECT name FROM tags WHERE routine_id = ?", routine.id!);
        const tags = tempTags.map((tagObj) => tagObj.name); 

        routine.tags = tags;
    }

    return routines;
}

export const deleteRoutine = async (db : SQLiteDatabase, id : number) => {
    await db.runAsync("DELETE FROM routines WHERE id = ?", id);
}

export const updateRoutine = async (db: SQLiteDatabase, routine : Routine) => {
    await db.runAsync("UPDATE routines SET name = ?, creator = ?, units = ?, notes = ? WHERE id = ?", [routine.name, routine.creator || null, routine.units, routine.notes, routine.id!]);
    await db.runAsync("DELETE FROM tags WHERE routine_id = ?", routine.id!);
    await db.runAsync("DELETE FROM routine_exercises WHERE routine_id = ?", routine.id!);

    for (let i = 0; i < routine.routineExercises.length; i++) {
        const routineExercise : RoutineExercise = routine.routineExercises[i];

        const dbRoutineExercise = await db.runAsync(
            "INSERT INTO routine_exercises (exercise_id, routine_id, sets, rest, position) VALUES (?, ?, ?, ?, ?)", 
            [routineExercise.exercise.id!, routine.id!, routineExercise.sets, routineExercise.rest, i]
        );

        for (let i = 0; i < routineExercise.sets; i++) {
            await db.runAsync(
                "INSERT INTO routine_exercise_stats (routine_exercise_id, reps, time, weight, position) VALUES (?, ?, ?, ?, ?)",
                [dbRoutineExercise.lastInsertRowId, routineExercise.reps[i], routineExercise.times[i], routineExercise.weights[i], i]
            );
        }
    }

    for (const tag of routine.tags) {
        await db.runAsync("INSERT INTO tags (routine_id, name) VALUES (?, ?)", [routine.id!, tag]);
    }
}