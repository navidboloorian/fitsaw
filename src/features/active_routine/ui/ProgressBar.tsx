import { StyleSheet } from "react-native";
import { BackgroundBox } from "../../../shared/components/components";
import { Colors } from "../../../shared/styles/colors";

type ProgressBarProps = {
    progressPercentage: number
}

export const ProgressBar = ({progressPercentage} : ProgressBarProps) => {
    const styles = StyleSheet.create({
        bar: {
            height: "100%",
            flex: progressPercentage * 100,
        },
        unfilled: {
            height: "100%",
            flex: 100 - (progressPercentage * 100)
        }
    });
    
    return (
        <BackgroundBox row paddingBottom={0} paddingLeft={0} paddingRight={0} paddingTop={0}>
            <BackgroundBox style={styles.bar} color={Colors.fitsawGreen} />
            <BackgroundBox style={styles.unfilled} />
        </BackgroundBox>
    );
}