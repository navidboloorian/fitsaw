import { SQLiteDatabase, useSQLiteContext } from "expo-sqlite";
import Exercise from "../model/exercise";

export const createExercise = async (db : SQLiteDatabase, exercise : Exercise) : Promise<void> => {
    const dbExercise = await db.runAsync(
        "INSERT INTO exercises (name, creator, type, measurement, notes) VALUES (?, ?, ?, ?, ?)", 
        [exercise.name, exercise.creator, exercise.type, exercise.measurement, exercise.notes]
    );

    const exerciseId =  dbExercise.lastInsertRowId;

    for (const tag of exercise.tags) {
        await db.runAsync("INSERT INTO tags (exercise_id, name) VALUES (?, ?)", [exerciseId, tag]);
    }
}

export const deleteExercise = (id : number) => {}

export const updateExercise = (id : number) => {} 

export const getExercise = (id : number) => {}

export const getAllExercises = async (db : SQLiteDatabase) : Promise<Exercise[]> => {
    const exercises : Exercise[] = await db.getAllAsync("SELECT * FROM exercises ORDER BY name");

    for (const exercise of exercises) {
        const tempTags = await db.getAllAsync<{name : string}>("SELECT name FROM tags WHERE exercise_id = ?", exercise.id!);
        const tags = tempTags.map((tagObj) => tagObj.name); 

        exercise.tags = tags;
    }

    return exercises;
}