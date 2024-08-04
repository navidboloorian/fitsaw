import { create } from "zustand";
import { SnackbarStatus } from "../globals";

type GlobalState = {
    isSnackbarVisible: boolean,
    snackbarStatus: SnackbarStatus,
    snackbarMessage: string,
    duration: number
}

type GlobalAction = {
    hideSnackbar: () => void,
    showSnackbar: (status: SnackbarStatus, message: string) => void,
    setDuration: (duration: number) => void
}

export const useGlobalStore = create<GlobalState & GlobalAction>((set) => ({
    isSnackbarVisible: false,
    snackbarStatus: SnackbarStatus.Success,
    snackbarMessage: "",
    duration: 3000,
    hideSnackbar: () => set({isSnackbarVisible: false}),
    showSnackbar: (status, message) => set({isSnackbarVisible: true, snackbarStatus: status, snackbarMessage: message}),
    setDuration: (duration) => set({duration: duration})
}));