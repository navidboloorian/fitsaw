import { Pressable, StyleSheet } from "react-native";
import { Colors } from "../styles/colors";
import {FitsawText} from "./FitsawText";
import { BackgroundBox } from "./BackgroundBox";

type BottomButtonProps = {
    text: string,
    color?: string,
    disabled?: boolean,
    onPress?: () => void
}

export const BottomButton = ({text, color, onPress, disabled} : BottomButtonProps) => {
    const styles = StyleSheet.create({
        button: {
            width: "100%",
            alignItems: "center",
            padding: 10,
            borderRadius: 5,
        }
    });

    return (
            <>
                <BackgroundBox 
                    color={color ? color : Colors.fitsawBlue}
                    paddingLeft={0}
                    paddingRight={0}
                    paddingTop={0}
                    paddingBottom={0}
                >
                    <Pressable disabled={disabled ? disabled : false} style={styles.button} onPress={onPress}>
                        <FitsawText bold color={Colors.boxBackground1}>
                            {text}
                        </FitsawText>
                    </Pressable>
                </BackgroundBox>
            </>
    );
}