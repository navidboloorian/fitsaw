import { Pressable, View, Animated, StyleSheet, Easing} from "react-native";
import FontAwesome from "@expo/vector-icons/FontAwesome5";
import { Colors } from "../styles/colors";
import { FitsawText } from "./FitsawText";
import { Spacer } from "./Spacer";
import { useRef, useState } from "react";

type CollapsibleProps = {
    header: JSX.Element,
    body: JSX.Element
}

export const Collapsible = ({header, body} : CollapsibleProps) => {
    const animatedValue = useRef(new Animated.Value(1)).current;
    const [isCollapsed, setIsCollapsed] = useState(false);

    const toggle = () => {
        Animated.timing(animatedValue, {
            toValue: isCollapsed ? 1 : 0,
            duration: 300,
            easing: Easing.cubic,
            useNativeDriver: false
        }).start();

        setIsCollapsed(!isCollapsed);
    }

    const maxHeight = animatedValue.interpolate({
        inputRange: [0, 1],
        outputRange: [0, 3000]
    });

    const arrowRotation = animatedValue.interpolate({
        inputRange: [0, 1],
        outputRange: ["-90deg", "0deg"]
    });

    const styles = StyleSheet.create({
        body: {
            overflow: "hidden",
            maxHeight: maxHeight,
        },
        arrow: {
            transform: [{rotate: arrowRotation}]
        }
    });

    return (
        <>
            <Pressable onPress={() => toggle()}>
                <View style={{flexDirection: "row", alignItems: "center"}}>
                    <Animated.View style={styles.arrow}><FontAwesome name={"caret-down"} color={Colors.primaryText} /></Animated.View>
                    <Spacer width={5} />
                    {header}
                </View>
            </Pressable>
            <Animated.View style={styles.body}>{body}</Animated.View>
        </>
    );  
}