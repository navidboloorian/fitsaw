import { Text, ActivityIndicator, StyleSheet} from "react-native";
import { OpenSans_400Regular, OpenSans_700Bold, useFonts } from "@expo-google-fonts/open-sans";
import { Colors } from "../styles/colors";

type Props = {
    children: JSX.Element | string,
    size?: number,
    color?: string,
    bold?: boolean,
}

export const FitsawText = ({children, size, color, bold} : Props) => {
    const styles = StyleSheet.create({
        text: {
            fontFamily: "OpenSans_400Regular",
            fontSize: size ? size : 14,
            fontWeight: bold ? "bold" : undefined, 
            color: color ? color : Colors.primaryText,
        },
    });

    const [loaded] = useFonts({OpenSans_400Regular,  OpenSans_700Bold});

    if (!loaded) {
        return <ActivityIndicator />;
    }

    return <Text style={styles.text}>{children}</Text>;
}

export default FitsawText;