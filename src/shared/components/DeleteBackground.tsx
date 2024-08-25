import { BackgroundBox } from "./BackgroundBox";
import { StyleSheet } from "react-native";
import { Colors } from "../styles/colors";
import FontAwesome from "@expo/vector-icons/FontAwesome5";

type DeleteBackgroundProps = {
    width?: string
}

export const DeleteBackground = ({width} : DeleteBackgroundProps) => {
    const styles = StyleSheet.create({
        deleteContainer: {
            display: "flex",
            justifyContent: "center",
            flexDirection: "row",
            alignItems: "center"
        }
    }); 

    return (
        <BackgroundBox style={[styles.deleteContainer, {height: "100%", width: width ? width : "90%"}]} color={Colors.fitsawRed}>
            <FontAwesome name="trash-alt" size={16} color={Colors.primaryText} />
        </BackgroundBox>
    );
}