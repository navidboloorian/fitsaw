import { useQuery } from "@tanstack/react-query"
import { useSQLiteContext } from "expo-sqlite";
import { FlatList, Text, View } from "react-native"
import { getHistory } from "../api/history_api";
import { useHistory } from "../hooks/use_history";
import { Loading } from "../../../shared/components/Loading";
import { FitsawText } from "../../../shared/components/FitsawText";
import { BackgroundBox } from "../../../shared/components/BackgroundBox";
import { Spacer } from "../../../shared/components/Spacer";
import { HistoryRoutine } from "../model/history_routine";
import { SummaryGraph } from "../../active_routine/ui/SummaryGraph";
import { FitsawError } from "../../../shared/shared";

export const HistoryList = () => {
    const db = useSQLiteContext();
    const {date} = useHistory();
    const historyQuery = useQuery({
        queryKey: ["history", date],
        queryFn: () => getHistory(db, date)
    });

    const renderHistory = (historyRoutine : HistoryRoutine) => {
        return (
            <BackgroundBox>
                <FitsawText size={16} bold>{historyRoutine.name}</FitsawText>
                <>
                    {
                        historyRoutine.routineExercises.map((routineExercise, index) => (
                                <View key={index}> 
                                    <FitsawText bold>{routineExercise.exercise.name}</FitsawText>
                                    <SummaryGraph routineExercise={routineExercise} isHistory />
                                </View>
                            )
                        )
                    }
                </>
            </BackgroundBox>
        );
    }

    if (historyQuery.isFetching || historyQuery.isLoading) return <Loading />

    if (historyQuery.isError) {
        throw new FitsawError({name: "QUERY_ERROR", message: "There was an error getting your history."});
    }

    const historyList = historyQuery.data;

    return (
        <>
            <Spacer height={10} />
            <FlatList
                data={historyList}
                renderItem={({item}) => renderHistory(item)}
                ItemSeparatorComponent={() => <Spacer height={10} />}
            />
            <Spacer height={10} />
        </>
    );
}