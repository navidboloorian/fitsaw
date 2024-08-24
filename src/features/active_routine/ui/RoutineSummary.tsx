import { BackgroundBox } from "../../../shared/components/BackgroundBox";
import { Spacer } from "../../../shared/components/components";
import { FitsawText } from "../../../shared/components/FitsawText";
import { Routine } from "../../view_routine/model/routine";
import { SummaryGraph } from "./SummaryGraph";

type RoutineSummaryProps = {
    routine : Routine
}

export const chartConfig = {
};

export const RoutineSummary = ({routine} : RoutineSummaryProps) => {
    return (
        <BackgroundBox>
            <FitsawText bold size={32}>Congratulations!</FitsawText>
            <FitsawText>You've completed your routine! View your routine summary below:</FitsawText>
            <Spacer height={5} />
            <>
                {
                    routine.routineExercises.map((routineExercise) => (
                        <>
                            <FitsawText bold size={18}>{routineExercise.exercise.name}</FitsawText>
                            <SummaryGraph routineExercise={routineExercise} />
                        </>
                    ))
                }
            </>
        </BackgroundBox>
    );
}