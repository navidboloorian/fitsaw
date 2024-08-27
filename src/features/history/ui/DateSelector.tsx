import { Pressable, StyleSheet, View } from "react-native"
import FontAwesome from "@expo/vector-icons/FontAwesome5";
import { Colors } from "../../../shared/styles/colors";
import { FitsawText } from "../../../shared/components/FitsawText";
import { useQuery } from "@tanstack/react-query";
import { getDates, getHistory } from "../api/history_api";
import { useSQLiteContext } from "expo-sqlite";
import { HistoryRoutine } from "../model/history_routine";
import { Loading } from "../../../shared/components/Loading";
import { useHistory } from "../hooks/use_history";
import { useState } from "react";

export const DateSelector = () => {
    const db = useSQLiteContext();
    const {date, setDate} = useHistory();
    const [dateIndex, setDateIndex] = useState(0);

    const formatDate = (originalDate : string) => {
        const months = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"];
        const year = originalDate.split("-")[0];
        const month = months[parseInt(originalDate.split("-")[1]) - 1];
        const day = originalDate.split("-")[2];

        return `${month} ${day}, ${year}`;
    }

    const dateQuery = useQuery({
        queryKey: ["history-dates"],
        queryFn: () : Promise<string[]> => getDates(db)
    });

    const styles = StyleSheet.create({
        container: {
            display: "flex",
            flexDirection: "row",
            justifyContent: "center",
            alignItems: "center",
            gap: 10
        }
    });

    if (dateQuery.isLoading || dateQuery.isPending) {
        return <Loading />
    }

    const dates = dateQuery.data!;

    if (dates && date !== dates[dateIndex]) setDate(dateQuery.data![dateIndex]);
    
    return ( 
        <View style={styles.container}>
            {
                dateIndex < dates.length - 1 
                ?
                    <Pressable onPress={() => setDateIndex(dateIndex + 1)}>
                        <FontAwesome size={20} name={"caret-left"} color={Colors.primaryText} />
                    </Pressable>
                :
                    <></>

            }
            <FitsawText size={20} bold>{formatDate(date)}</FitsawText>
            {
                dateIndex > 0
                ?
                    <Pressable onPress={() => setDateIndex(dateIndex - 1)}>
                        <FontAwesome size={20} name={"caret-right"} color={Colors.primaryText} />
                    </Pressable>
                :
                    <></>
            }
        </View>
    );
}