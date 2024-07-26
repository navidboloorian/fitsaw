export default class Exercise {
    id?: number;
    name: string;
    creator: number;
    type: string;
    measurement: string;
    notes: string;

    constructor(
        name: string,
        creator: number,
        type: string,
        measurement: string,
        notes: string
    ) {
        this.name = name;
        this.creator = creator;
        this.type = type;
        this.measurement = measurement;
        this.notes = notes;
    }
}