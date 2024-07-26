import Exercise from "../model/exercise";
import { useSQLiteContext } from "expo-sqlite";

export const createExercise = async (exercise : Exercise) : Promise<Exercise> => {
    const db = useSQLiteContext();

    const result = await db.runAsync(
        "INSERT INTO exercises (name, creator, type, measurement, notes) VALUES (?, ?, ?, ?, ?)", 
        [exercise.name, exercise.creator, exercise.type, exercise.measurement, exercise.notes]
    );

    return new Exercise("Testing", 1, "Testing", "Testing", "Testing");
}

export const deleteExercise = (id : number) => {}

export const updateExercise = (id : number) => {}

export const getExercise = (id : number) => {}

export const getAllExercises = () => {}