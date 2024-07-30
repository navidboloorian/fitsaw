import { create } from "zustand";
import { SnackbarStatus } from "../../globals";

type GlobalState = {
    isSnackbarVisible: boolean,
    snackbarStatus: SnackbarStatus,
    snackbarMessage: string,
}

type GlobalAction = {
    hideSnackbar: () => void,
    showSnackbar: (status: SnackbarStatus, message: string) => void,
}

export const useGlobalStore = create<GlobalState & GlobalAction>((set) => ({
    isSnackbarVisible: true,
    snackbarStatus: SnackbarStatus.Success,
    snackbarMessage: "",
    hideSnackbar: () => set({isSnackbarVisible: false}),
    showSnackbar: (status, message) => set({isSnackbarVisible: true, snackbarStatus: status, snackbarMessage: message}),
}));