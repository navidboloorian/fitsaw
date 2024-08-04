import { StyleSheet, View } from "react-native"

type SpacerProps = {
    height: number
}

export const Spacer = ({height} : SpacerProps) => {
    const styles = StyleSheet.create({
        spacer: {
            height: height
        }
    });

    return <View style={styles.spacer}></View>;
}
