import { StyleSheet, View } from "react-native"

type SpacerProps = {
    height?: number
    width?: number
}

export const Spacer = ({ height, width } : SpacerProps) => {
    const styles = StyleSheet.create({
        spacer: {
            height: height,
            width: width
        }
    });

    return <View style={styles.spacer}></View>;
}
