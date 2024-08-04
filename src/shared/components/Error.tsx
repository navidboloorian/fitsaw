import FontAwesome from "@expo/vector-icons/FontAwesome5";
import { View } from "react-native";
import { Colors } from "../styles/colors";
import {FitsawText} from "./FitsawText";

type ErrorProps = {
    message: string
}

export const Error = ({message} : ErrorProps) => {
    return (
        <View style={{justifyContent: "center", alignItems: "center", height: "100%"}}>
            <FontAwesome name="exclamation-triangle" color={Colors.fitsawRed} size={128} />
            <FitsawText>{message}</FitsawText>
        </View>
    );
}