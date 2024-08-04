import { View } from "react-native";
import { Colors } from "../styles/colors";
import { StyleSheet } from "react-native";

type Props = {
    children: JSX.Element[] | JSX.Element,
    color?: string,
    row?: boolean,
    paddingLeft?: number,
    paddingRight?: number,
    paddingTop?: number,
    paddingBottom?: number,
    style?: StyleSheet | {}
}

export const BackgroundBox = ({children, color, row, paddingLeft, paddingRight, paddingBottom, paddingTop, style} : Props) => {
    const styles = StyleSheet.create({
        backgroundBox: {
            backgroundColor: color ? color : Colors.boxBackground1,
            width: "90%",
            alignSelf: "center",
            paddingTop: paddingTop != null ? paddingTop : 10,
            paddingRight: paddingRight != null ? paddingRight : 10,
            paddingLeft: paddingLeft != null ? paddingLeft : 10,
            paddingBottom: paddingBottom != null ? paddingBottom : 10,
            borderRadius: 5,
            elevation: 1,
        },
        row: {
            flexDirection: "row",
            alignItems: "center"
        }
    });

    return <View style={[styles.backgroundBox, row ? styles.row : null, style]}>{children}</View>;
}