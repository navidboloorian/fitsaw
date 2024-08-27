import { create } from "zustand";

type HistoryState = {
    date : string
}

type HistoryAction = {
    setDate : (date : string) => void
}

export const useHistory = create<HistoryState & HistoryAction>((set) => ({
    date: (new Date()).toISOString().split("T")[0],
    setDate: (date) => set({date : date})
}));