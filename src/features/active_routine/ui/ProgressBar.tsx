import { StyleSheet, View } from "react-native";
import { BackgroundBox, FitsawText } from "../../../shared/components/components";
import { Colors } from "../../../shared/styles/colors";

type ProgressBarProps = {
    curr: number,
    total: number
}

export const ProgressBar = ({curr, total} : ProgressBarProps) => {
    const progressPercentage = curr/total;

    const styles = StyleSheet.create({
        bar: {
            height: 30,
            width: "100%",
            flex: progressPercentage === 1 ? 1 : progressPercentage * 100,
        },
        unfilled: {
            height: 30,
            flex: progressPercentage === 1 ? 0 : 100 - (progressPercentage * 100)
        },
        labelWrapper: {
            width: "100%",
            position: "absolute",
            justifyContent: "center",
            alignItems: "center"
        }
    });
    
    return (
        <BackgroundBox row paddingBottom={0} paddingLeft={0} paddingRight={0} paddingTop={0}>
            {progressPercentage !== 0 ? <BackgroundBox paddingLeft={0} paddingRight={0} style={styles.bar} color={Colors.fitsawGreen} /> : <></>}
            {progressPercentage === 1 ? <></> : <BackgroundBox paddingLeft={0} paddingRight={0} style={styles.unfilled} />}
            <View style={styles.labelWrapper}>
                <FitsawText bold color={progressPercentage >= 0.5 ? Colors.screenBackground : Colors.primaryText}>
                    {`${curr}/${total}`}
                </FitsawText>
            </View>
        </BackgroundBox>
    );
}