import { View } from "react-native";
import { Colors } from "../styles/colors";
import { Dimensions, StyleSheet } from "react-native";

type Props = {
    children: JSX.Element[] | JSX.Element,
    color?: string,
    row?: boolean,
    paddingLeft?: number,
    paddingRight?: number,
    paddingTop?: number,
    paddingBottom?: number,
}

const BackgroundBox = ({children, color, row, paddingLeft, paddingRight, paddingBottom, paddingTop} : Props) => {
    const styles = StyleSheet.create({
        backgroundBox: {
            backgroundColor: color ? color : Colors.boxBackground1,
            marginLeft: Dimensions.get('window').width * 0.05,
            marginRight: Dimensions.get('window').width * 0.05,
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

    return <View style={[styles.backgroundBox, row ? styles.row : null]}>{children}</View>;
}

export default BackgroundBox;