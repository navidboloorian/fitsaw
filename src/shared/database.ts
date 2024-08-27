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
            sets INTEGER NOT NULL,
            position INTEGER NOT NULL,

            FOREIGN KEY (exercise_id) REFERENCES exercises(id) on DELETE CASCADE,
            FOREIGN KEY (routine_id) REFERENCES routines(id) on DELETE CASCADE
        );

        CREATE TABLE IF NOT EXISTS routine_exercise_stats (
            id INTEGER PRIMARY KEY NOT NULL,
            time INTEGER,
            weight INTEGER,
            reps INTEGER,
            position INTEGER NOT NULL,
            routine_exercise_id INTEGER NOT NULL,

            FOREIGN KEY (routine_exercise_id) REFERENCES routine_exercises(id) ON DELETE CASCADE
        );

        CREATE TABLE IF NOT EXISTS history_routines (
            id INTEGER PRIMARY KEY NOT NULL,
            name TEXT NOT NULL,
            date TEXT NOT NULL,
            routine_id INTEGER NOT NULL,

            FOREIGN KEY (routine_id) REFERENCES routines(id)
        );

        CREATE TABLE IF NOT EXISTS history_routine_exercises (
            id INTEGER PRIMARY KEY NOT NULL,
            name TEXT NOT NULL,
            sets INTEGER NOT NULL,
            exercise_id INTEGER NOT NULL,
            history_routine_id INTEGER NOT NULL,
            position INTEGER NOT NULL,

            FOREIGN KEY (exercise_id) REFERENCES exercises(id),
            FOREIGN KEY (history_routine_id) REFERENCES history_routines(id)
        );

        CREATE TABLE IF NOT EXISTS history_routine_exercise_stats (
            id INTEGER PRIMARY KEY NOT NULL,
            history_routine_exercise_id INTEGER NOT NULL,
            weight INTEGER,
            reps INTEGER,
            time INTEGER,
            position INTEGER NOT NULL,

            FOREIGN KEY (history_routine_exercise_id) REFERENCES history_routine_exercises(id)
        );
    `);
}