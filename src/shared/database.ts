import { type SQLiteDatabase } from "expo-sqlite";

export const initDb = async (db : SQLiteDatabase) => {
    await db.execAsync(`
        CREATE TABLE IF NOT EXISTS exercises (
            id INTEGER PRIMARY KEY NOT NULL,
            creator INTEGER,
            name VARCHAR NOT NULL,
            type VARCHAR NOT NULL,
            measurement VARCHAR NOT NULL,
            notes TEXT
        );

        CREATE TABLE IF NOT EXISTS tags (
            id INTEGER PRIMARY KEY NOT NULL,
            exercise_id INTEGER REFERENCES exercises(id),
            name VARCHAR NOT NULL
        );

        CREATE INDEX IF NOT EXISTS exercise_id_idx ON tags(exercise_id);
    `);
}