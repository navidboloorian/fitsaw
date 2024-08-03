import { SQLiteDatabase, useSQLiteContext } from "expo-sqlite";
import Exercise from "../model/exercise";

export const createExercise = async (db : SQLiteDatabase, exercise : Exercise) : Promise<void> => {
    const dbExercise = await db.runAsync(
        "INSERT INTO exercises (name, creator, type, measurement, notes) VALUES (?, ?, ?, ?, ?)", 
        [exercise.name, exercise.creator || null, exercise.type, exercise.measurement, exercise.notes]
    );

    const id =  dbExercise.lastInsertRowId;

    for (const tag of exercise.tags) {
        await db.runAsync("INSERT INTO tags (exercise_id, name) VALUES (?, ?)", [id, tag]);
    }
}

export const deleteExercise = async (db : SQLiteDatabase, id : number) : Promise<void> => {
    await db.runAsync("DELETE FROM exercises WHERE id = ?", id);
}

export const updateExercise = async (db: SQLiteDatabase, exercise: Exercise) : Promise<void> => {
    await db.runAsync("UPDATE exercises SET name = ?, creator = ?, type = ?, measurement = ?, notes = ? WHERE id = ?", [exercise.name, exercise.creator || null, exercise.type, exercise.measurement, exercise.notes, exercise.id!]);
    await db.runAsync("DELETE FROM tags WHERE exercise_id = ?", exercise.id!);
    
    for (const tag of exercise.tags) {
        await db.runAsync("INSERT INTO tags (exercise_id, name) VALUES (?, ?)", [exercise.id!, tag]);
    }
} 

export const getExercise = async (db : SQLiteDatabase, id : number) : Promise<Exercise | null> => {
    const exercise : Exercise | null = await db.getFirstAsync("SELECT * FROM exercises WHERE id = ?", id);

    if (exercise) {
        const tempTags = await db.getAllAsync<{name : string}>("SELECT name FROM tags WHERE exercise_id = ?", id);
        const tags = tempTags.map((tagObj) => tagObj.name); 

        exercise.tags = tags;
    }

    return exercise;
}

export const getAllExercises = async (db : SQLiteDatabase) : Promise<Exercise[]> => {
    const exercises : Exercise[] = await db.getAllAsync("SELECT * FROM exercises ORDER BY name");

    for (const exercise of exercises) {
        const tempTags = await db.getAllAsync<{name : string}>("SELECT name FROM tags WHERE exercise_id = ?", exercise.id!);
        const tags = tempTags.map((tagObj) => tagObj.name); 

        exercise.tags = tags;
    }

    return exercises;
}