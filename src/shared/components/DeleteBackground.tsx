import { BackgroundBox } from "./BackgroundBox";
import { Pressable, StyleSheet } from "react-native";
import { Colors } from "../styles/colors";
import FontAwesome from "@expo/vector-icons/FontAwesome5";

type DeleteBackgroundProps = {
    width?: string
    onPress: () => void
}

export const DeleteBackground = ({width, onPress} : DeleteBackgroundProps) => {
    const styles = StyleSheet.create({
        deleteContainer: {
            display: "flex",
            justifyContent: "flex-end",
            flexDirection: "row",
            alignItems: "center",
            paddingRight: 18
        }
    }); 

    return (
        <Pressable onPress={onPress}>
            <BackgroundBox style={[styles.deleteContainer, {height: "100%", width: width ? width : "90%"}]} color={Colors.fitsawRed}>
                <FontAwesome name="trash-alt" size={16} color={Colors.primaryText} />
            </BackgroundBox>
        </Pressable>
    );
}