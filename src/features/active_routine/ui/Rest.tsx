import { BackgroundBox, FitsawText } from "../../../shared/components/components";
import { timeNumToString } from "../../../shared/components/TimeInput";
import { ColorFormat, ColorHex, CountdownCircleTimer } from "react-native-countdown-circle-timer";
import { Colors } from "../../../shared/styles/colors";
import { View } from "react-native";

type RestProps = {
    time : number,
    goNext : () => void
}

export const Rest = ({time, goNext} : RestProps) => {
    return (
        <BackgroundBox>
            <FitsawText size={24} bold>Rest</FitsawText>
            <View style={{alignSelf: "center"}}>
                <CountdownCircleTimer
                    isPlaying
                    duration={time}
                    colors={[Colors.fitsawBlue as ColorHex, Colors.fitsawGreen as ColorHex, Colors.fitsawPurple as ColorHex, Colors.fitsawOrange as ColorHex, Colors.fitsawRed as ColorHex, Colors.fitsawRed as ColorHex]}
                    colorsTime={[time, time * 0.8, time * 0.6, time * 0.4, time * 0.2, 0]}
                    trailColor={Colors.boxBackground1 as ColorFormat}
                    strokeLinecap="square"
                    onComplete={() => goNext()}
                >
                    {({ remainingTime }) => <FitsawText size={32} bold>{timeNumToString(remainingTime)}</FitsawText>}
                </CountdownCircleTimer>
            </View>
        </BackgroundBox>
    );
}