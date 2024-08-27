export type Exercise = {
    id? : number,
    name: string,
    creator?: number,
    type: "weighted" | "not weighted",
    measurement: "time" | "reps",
    notes: string,
    tags: string[]
}