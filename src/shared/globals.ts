export enum SnackbarStatus {
    Success,
    Failure
}

type ErrorNameType = "FORM_ERROR" | "QUERY_ERROR";

export class FitsawError extends Error {
    name: ErrorNameType;
    message: string;

    constructor({
        name,
        message
    } : {
        name: ErrorNameType;
        message: string;
    }) {
        super();
        this.name = name;
        this.message = message;
    }
}