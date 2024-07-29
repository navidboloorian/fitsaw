type Exercise = {
    id? : number;
    name: string;
    creator: number;
    type: string;
    measurement: string;
    notes: string;
    tags: string[];
}

export default Exercise;