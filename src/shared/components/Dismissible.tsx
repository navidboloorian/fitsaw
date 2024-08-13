import React, { useRef } from "react"
import { PanResponder, Animated, StyleSheet, Dimensions, DimensionValue} from "react-native"
import FontAwesome from "@expo/vector-icons/FontAwesome5";
import { Colors } from "../styles/colors";
import { BackgroundBox } from "./BackgroundBox";

type DismissibleProps = {
    children: JSX.Element[] | JSX.Element,
    width?: DimensionValue,
    onDismiss: () => void
}

export const Dismissible = ({children, width, onDismiss} : DismissibleProps) => {
    const translateX = useRef(new Animated.Value(0)).current;

    // upon deletion, play animation and shrink height of box to zero
    const heightScale = useRef(new Animated.Value(1)).current;

    // disable right swipe via clampings
    const clampedX = translateX.interpolate({
        inputRange: [-1000, 0, 1000],
        outputRange: [-1000, 0, 0],
    });

    const panResponder = useRef(
        PanResponder.create({
            // setting dx and dy threshholds so that taps aren't accidentally captured by the pan responder
            onMoveShouldSetPanResponder: (_, gestureState) => Math.abs(gestureState.dx) > 1.5 && Math.abs(gestureState.dy) > 1.5,
            onMoveShouldSetPanResponderCapture: (_, gestureState) => Math.abs(gestureState.dx) > 1.5 && Math.abs(gestureState.dy) > 1.5,
            onPanResponderMove: Animated.event([null, {dx: translateX}], {useNativeDriver: false}),
            onPanResponderRelease: (_, {dx}) => {
                const screenWidth = Dimensions.get("window").width;

                if (Math.abs(dx) >= 0.5 * screenWidth) {
                    // full swipe
                    Animated.timing(translateX, {
                        toValue: -screenWidth,
                        duration: 200,
                        useNativeDriver: true
                    }).start();

                    Animated.timing(heightScale, {
                        toValue: 0,
                        duration: 200,
                        useNativeDriver: true
                    }).start();

                    onDismiss();
                }
                else {
                    // early release
                    Animated.spring(translateX, {
                        toValue: 0,
                        bounciness: 10,
                        useNativeDriver: true
                    }).start();
                }
            }
        }),         
    ).current;

    const styles = StyleSheet.create({
        background: {
            width: "100%",
            height: "100%",
            position: "absolute",
            alignItems: "center",
            justifyContent: "center",
        },
        container: {
            width: width ? width : "90%",
            transform: [{scaleY: heightScale}],
            alignSelf: "center",
        }
    });

    return (
        <Animated.View style={styles.container}>
            <BackgroundBox style={styles.background} color={Colors.fitsawRed}>
                <FontAwesome name="trash-alt" />
            </BackgroundBox>
            <Animated.View
                style={{transform: [{translateX: clampedX}]}}
                {...panResponder.panHandlers}
            >
                {children}
            </Animated.View>
        </Animated.View>
    );
}