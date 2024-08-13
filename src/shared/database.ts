import { type SQLiteDatabase } from "expo-sqlite";

export const initDb = async (db : SQLiteDatabase) => {
    await db.execAsync(`
        PRAGMA foreign_keys = ON;
        
        CREATE TABLE IF NOT EXISTS exercises (
            id INTEGER PRIMARY KEY NOT NULL,
            creator INTEGER,
            name VARCHAR(100) NOT NULL UNIQUE,
            type VARCHAR NOT NULL,
            measurement VARCHAR NOT NULL,
            notes TEXT
        );

        CREATE TABLE IF NOT EXISTS tags (
            id INTEGER PRIMARY KEY NOT NULL,
            name VARCHAR NOT NULL,
            exercise_id INTEGER,
            routine_id INTEGER,
            FOREIGN KEY (exercise_id) REFERENCES exercises(id) ON DELETE CASCADE,
            FOREIGN KEY (routine_id) REFERENCES routines(id) ON DELETE CASCADE
        );

        CREATE TABLE IF NOT EXISTS routines (
            id INTEGER PRIMARY KEY NOT NULL,
            name VARCHAR NOT NULL UNIQUE,
            notes TEXT,
            units VARCHAR,
            creator INTEGER
        );

        CREATE TABLE IF NOT EXISTS routine_exercises (
            id INTEGER PRIMARY KEY NOT NULL,
            exercise_id INTEGER NOT NULL,
            routine_id INTEGER NOT NULL,
            rest INTEGER NOT NULL,
            position INTEGER NOT NULL,
            time INTEGER,
            reps INTEGER,
            FOREIGN KEY (exercise_id) REFERENCES exercises(id) on DELETE CASCADE,
            FOREIGN KEY (routine_id) REFERENCES routines(id) on DELETE CASCADE
        );
    `);
}