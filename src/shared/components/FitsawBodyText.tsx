import { Text, ActivityIndicator, StyleSheet} from "react-native";
import { useFonts } from "expo-font";
import { OpenSans_400Regular } from "@expo-google-fonts/open-sans";
import { Colors } from "../styles/colors";

export type Props = {
    children: JSX.Element | string,
}

const FitsawBodyText = ({children} : Props) => {
    const styles = StyleSheet.create({
        text: {
            fontFamily: "OpenSans_400Regular",
            fontSize: 16,
            color: Colors.primaryText,
        },
    });

    const [loaded] = useFonts({OpenSans_400Regular});

    if (!loaded) {
        return <ActivityIndicator />;
    }

    return <Text style={styles.text}>{children}</Text>;
}

export default FitsawBodyText;