import { View, StyleSheet, Pressable } from "react-native";
import FitsawText from "./FitsawText";
import BackgroundBox from "./BackgroundBox";
import { Colors } from "../styles/colors";
import { useGlobalStore } from "../hooks/use_global_store";
import { SnackbarStatus } from "../../globals";
import FontAwesome from "@expo/vector-icons/FontAwesome5";

type SnackbarType = {
    duration: number
}

const Snackbar = ({duration} : SnackbarType) => {
    const isVisible = useGlobalStore((state) => state.isSnackbarVisible);
    const status = useGlobalStore((state) => state.snackbarStatus);
    const snackbarMessage = useGlobalStore((state) => state.snackbarMessage);
    const hideSnackbar = useGlobalStore((state) => state.hideSnackbar);

    const hideWithDelay = () => {
        setTimeout(() => hideSnackbar(), duration);
    }

    const styles = StyleSheet.create({
        snackbar: {
            position: "absolute",
            bottom: 14,
            width: "100%",
        },
        snackbarContent: {
            display: "flex",
            flexDirection: "row",
            justifyContent: "space-between",
            alignItems: "center"
        }
    });

    const colorMap = {
        [SnackbarStatus.Success]: Colors.fitsawGreen,
        [SnackbarStatus.Failure]: Colors.fitsawRed,
    }

    if (!isVisible) {
        return <></>
    }

    hideWithDelay();

    return (
        
            <View style={styles.snackbar}>
                <BackgroundBox color={colorMap[status]}>
                    <View style={styles.snackbarContent}>
                        <FitsawText bold color={Colors.boxBackground1}>{snackbarMessage}</FitsawText>
                        <Pressable onPress={() => hideSnackbar()}><FontAwesome name={"times"} /></Pressable>
                    </View>
                </BackgroundBox>
            </View>
    )
}

export default Snackbar;