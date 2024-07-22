import { View, GestureResponderEvent, Pressable, StyleSheet } from "react-native";
import FontAwesome from "@expo/vector-icons/FontAwesome5";
import { Colors } from "../styles/colors";

export type PlusButtonProps = {
    icon: typeof FontAwesome,
    onPress?: (event: GestureResponderEvent) => void,
    padded?: boolean
}

const IconButton = ({icon, onPress} : PlusButtonProps) => {
    const styles = StyleSheet.create({
        button: {
            width: 32,
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