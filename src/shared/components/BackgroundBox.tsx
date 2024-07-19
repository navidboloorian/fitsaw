import { View } from "react-native";
import { Colors } from "../styles/colors";
import { Dimensions, StyleSheet } from "react-native";

export type Props = {
    children: JSX.Element,
    color?: string,
}

const BackgroundBox = ({children, color} : Props) => {
    const styles = StyleSheet.create({
        backgroundBox: {
            backgroundColor: color ? color : Colors.boxBackground1,
            marginLeft: Dimensions.get('window').width * 0.05,
            marginRight: Dimensions.get('window').width * 0.05,
            paddingLeft: 10,
            paddingRight: 10,
            paddingTop: 5,
            paddingBottom: 5,
            borderRadius: 5,
            elevation: 1,
        },
    });

    return <View style={styles.backgroundBox}>{children}</View>;
}

export default BackgroundBox;