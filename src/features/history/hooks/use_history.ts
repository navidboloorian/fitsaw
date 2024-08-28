import { create } from "zustand";

type HistoryState = {
    date? : string
}

type HistoryAction = {
    setDate : (date : string) => void
}

export const useHistory = create<HistoryState & HistoryAction>((set) => ({
    setDate: (date) => set({date : date})
}));