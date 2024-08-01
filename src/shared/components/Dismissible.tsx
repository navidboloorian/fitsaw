import React, { useRef, useState } from "react"
import { PanResponder, Animated, StyleSheet, Dimensions} from "react-native"
import FontAwesome from "@expo/vector-icons/FontAwesome5";
import { Colors } from "../styles/colors";
import BackgroundBox from "./BackgroundBox";

type DismissibleProps = {
    children: JSX.Element[] | JSX.Element,
    onDismiss: () => void
}

const Dismissible = ({children, onDismiss} : DismissibleProps) => {
    const translateX = useRef(new Animated.Value(0)).current;
    const heightScale = useRef(new Animated.Value(1)).current;
    const clampedX = translateX.interpolate({
        inputRange: [-1000, 0, 1000],
        outputRange: [-1000, 0, 0],
    });

    const panResponder = useRef(
        PanResponder.create({
            onMoveShouldSetPanResponder: () => true,
            onMoveShouldSetPanResponderCapture: () => true,
            onPanResponderMove: Animated.event([null, {dx: translateX}], {useNativeDriver: false}),
            onPanResponderRelease: (_, {dx}) => {
                const screenWidth = Dimensions.get("window").width;

                if (Math.abs(dx) >= 0.5 * screenWidth) {
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
            width: "90%",
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

export default Dismissible;