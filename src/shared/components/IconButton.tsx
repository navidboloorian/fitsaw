import { Pressable, StyleSheet } from "react-native";
import FontAwesome from "@expo/vector-icons/FontAwesome5";

type IconButtonProps = {
    icon: typeof FontAwesome,
    onPress: () => void
}

export const IconButton = ({icon, onPress} : IconButtonProps) => {
    const styles = StyleSheet.create({
        button: {
            width: 48,
            height: 48,
            alignItems: "center",
            justifyContent: "center",
            flex: 1
        }
    })

    return(
        <Pressable onPress={onPress} style={styles.button}>
            {icon}
        </Pressable>
    )
}