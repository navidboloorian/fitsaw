import { View, StyleSheet } from "react-native";
import { BackgroundBox } from "../../../shared/components/BackgroundBox";
import { FitsawText } from "../../../shared/components/FitsawText";
import { RoutineExercise } from "../../view_routine/model/routine_exercise";
import { ColorFormat, ColorHex, CountdownCircleTimer } from "react-native-countdown-circle-timer";
import { Colors } from "../../../shared/styles/colors";
import { timeNumToString } from "../../../shared/components/TimeInput";
import { Spacer } from "../../../shared/components/Spacer";

type CurrentExerciseProps = {
    routineExercise : RoutineExercise,
    currSet : number,
    goNext : () => void
}

export const CurrentExercise = ({routineExercise, currSet, goNext} : CurrentExerciseProps) => {
    const styles = StyleSheet.create({
        row: {
            display: "flex",
            flexDirection: "row",
            alignItems: "baseline"
        },
        horCenter: {
            justifyContent: "center"
        },
        vertCenter: {
            alignItems: "center"
        }
    }); 

    const {exercise, reps, times, weights, sets} = routineExercise;

    return (
        <BackgroundBox>
            <View style={styles.row}><FitsawText size={24} bold>{exercise.name}</FitsawText><FitsawText>{` set ${currSet + 1} of ${sets}`}</FitsawText></View>
            {
                routineExercise.exercise.measurement === "reps" 
                ?  
                    <View style={[styles.row, styles.horCenter]}>
                        {
                            routineExercise.exercise.type === "weighted"
                            ?
                                <View style={[styles.row, styles.horCenter]}><FitsawText size={32} bold>{weights[currSet].toString()}</FitsawText><FitsawText> lbs for </FitsawText><Spacer width={5} /></View>
                            :
                                <></>
                        }
                        <FitsawText size={32} bold>{reps[currSet].toString()}</FitsawText><FitsawText> reps</FitsawText>
                    </View>
                : 
                    <View style={[styles.horCenter, styles.vertCenter]}>
                         {
                            routineExercise.exercise.type === "weighted"
                            ?
                                <View style={[styles.row, styles.horCenter]}><FitsawText size={32} bold>{weights[currSet].toString()}</FitsawText><FitsawText> lbs for </FitsawText><Spacer width={5} /></View>
                            :
                                <></>
                        }
                        <CountdownCircleTimer
                            isPlaying
                            duration={times[currSet] as number}
                            colors={[Colors.fitsawBlue as ColorHex, Colors.fitsawGreen as ColorHex, Colors.fitsawPurple as ColorHex, Colors.fitsawOrange as ColorHex, Colors.fitsawRed as ColorHex, Colors.fitsawRed as ColorHex]}
                            colorsTime={[times[currSet] as number, (times[currSet] as number) * 0.8, (times[currSet] as number) * 0.6, (times[currSet] as number) * 0.4, (times[currSet] as number) * 0.2, 0]}
                            trailColor={Colors.boxBackground1 as ColorFormat}
                            strokeLinecap="square"
                            onComplete={() => goNext()}
                        >
                            {({ remainingTime }) => <FitsawText size={32} bold>{timeNumToString(remainingTime)}</FitsawText>}
                        </CountdownCircleTimer>
                    </View>
            }
            {
                routineExercise.exercise.notes.length > 0 
                ?
                    <FitsawText>{routineExercise.exercise.notes}</FitsawText>
                :
                    <></>
            }
        </BackgroundBox>
    );
}