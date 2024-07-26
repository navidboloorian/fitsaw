import { View, Pressable, StyleSheet } from "react-native";
import FontAwesome from "@expo/vector-icons/FontAwesome5";

export type PlusButtonProps = {
    icon: typeof FontAwesome,
    onPress: () => void
}

const IconButton = ({icon, onPress} : PlusButtonProps) => {
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
        <Pressable onPress={onPress}>
            <View style={styles.button}>
                {icon}
            </View>
        </Pressable>
    )
}

export default IconButton;