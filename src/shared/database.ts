import { type SQLiteDatabase } from "expo-sqlite";

export const initDb = async (db : SQLiteDatabase) => {
    await db.execAsync(`
        PRAGMA foreign_keys = ON;
        
        CREATE TABLE IF NOT EXISTS exercises (
            id INTEGER PRIMARY KEY NOT NULL,
            creator INTEGER,
            name VARCHAR(100) NOT NULL,
            type VARCHAR NOT NULL,
            measurement VARCHAR NOT NULL,
            notes TEXT
        );

        CREATE TABLE IF NOT EXISTS tags (
            id INTEGER PRIMARY KEY NOT NULL,
            name VARCHAR NOT NULL,
            exercise_id INTEGER NOT NULL,
            FOREIGN KEY (exercise_id) REFERENCES exercises(id) ON DELETE CASCADE
        );
    `);
}