import { View, StyleSheet, Pressable } from "react-native";
import FitsawText from "./FitsawText";
import { Colors } from "../styles/colors";
import FontAwesome from "@expo/vector-icons/FontAwesome5";
import stringToColor from "../../utils/string_to_color";

export type TagProps = {
    text: string,
    dismissible?: boolean,
    onPress?: () => void,
}

const Tag = ({dismissible, text, onPress} : TagProps) => {
    const styles = StyleSheet.create({
        tagBox: {
            display: "flex",
            alignSelf: "flex-start",
            paddingLeft: 8,
            paddingRight: 8,
            paddingTop: 5,
            paddingBottom: 5,
            borderRadius: 10000, // high number so we don't have to worry abt differen't widths and heights
            backgroundColor: stringToColor(text),
            flexDirection: "row",
            alignItems: "center",
            flexWrap: "wrap",
        },
        dismissible: {
            marginRight: 5,
        }
    });

    return (
        <Pressable onPress={onPress ? onPress : null}>
            <View style={styles.tagBox}>
                {dismissible ? <FontAwesome style={styles.dismissible} name="times" size={12} color={Colors.boxBackground1} /> : null}
                <FitsawText size={12} bold color={Colors.boxBackground1}>
                    {text}
                </FitsawText>
            </View>
        </Pressable>
    );
}

export default Tag;