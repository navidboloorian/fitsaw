import { Colors } from "../styles/colors";
import FitsawText from "./FitsawText";
import { Pressable, StyleSheet } from "react-native";
import { BackgroundBox } from "./components";

type ToggleButtonProps = {
    selected: boolean,
    setSelected: (selected: boolean) => void,
    leftText: string,
    rightText: string,
}

export const ToggleButton = ({selected, setSelected, leftText, rightText} : ToggleButtonProps) => {
    const styles = StyleSheet.create({
        toggle: {
            flex: 1,
            alignItems: "center",
            padding: 10,
        },
        selected: {
            backgroundColor: Colors.fitsawGreen,
            borderTopLeftRadius: selected ? 0 : 5,
            borderBottomLeftRadius: selected ? 0 : 5,
            borderTopRightRadius: selected ? 5 : 0,
            borderBottomRightRadius: selected ? 5 : 0,
        }
    });

    return (
        <BackgroundBox row paddingLeft={0} paddingBottom={0} paddingTop={0} paddingRight={0}>
            <Pressable 
                style={[styles.toggle, selected ? null : styles.selected]} 
                onPress={() => setSelected(false)}
            >
                <FitsawText color={selected ? Colors.primaryText : Colors.boxBackground1} bold={!selected}>
                    {leftText}
                </FitsawText>
            </Pressable>
            <Pressable 
                style={[styles.toggle, selected ? styles.selected : null]}
                onPress={() => setSelected(true)}
            >
                <FitsawText color={selected ? Colors.boxBackground1 : Colors.primaryText} bold={selected}>
                    {rightText}
                </FitsawText>
            </Pressable>
        </BackgroundBox>
    );
}