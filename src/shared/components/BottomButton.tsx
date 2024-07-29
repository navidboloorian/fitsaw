import { Pressable, StyleSheet } from "react-native";
import BackgroundBox from "./BackgroundBox";
import { Colors } from "../styles/colors";
import FitsawText from "./FitsawText";

export type BottomButtonProps = {
    text: string,
    color?: string,
    onPress?: () => void
}

const BottomButton = ({text, color, onPress} : BottomButtonProps) => {
    const styles = StyleSheet.create({
        button: {
            width: "100%",
            alignItems: "center",
            padding: 10,
            borderRadius: 5,
        }
    });

    return (
            <BackgroundBox 
                color={color ? color : Colors.fitsawBlue}
                paddingLeft={0}
                paddingRight={0}
                paddingTop={0}
                paddingBottom={0}
            >
                <Pressable style={styles.button} onPress={onPress}>
                    <FitsawText bold color={Colors.boxBackground1}>
                        {text}
                    </FitsawText>
                </Pressable>
            </BackgroundBox>
    );
}

export default BottomButton;