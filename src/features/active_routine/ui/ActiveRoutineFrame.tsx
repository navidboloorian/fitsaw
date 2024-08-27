import { FlatList } from "react-native";
import { CurrentExercise } from "./CurrentExercise";
import { ProgressBar } from "./ProgressBar";
import { Spacer } from "../../../shared/components/Spacer";
import { BottomButton } from "../../../shared/components/BottomButton";
import { FitsawText } from "../../../shared/components/FitsawText";
import { Colors } from "../../../shared/styles/colors";
import { Routine } from "../../view_routine/model/routine";
import { useEffect, useState } from "react";
import { Rest } from "./Rest";
import { RoutineSummary } from "./RoutineSummary";
import { router } from "expo-router";
import { useSQLiteContext } from "expo-sqlite";
import { useMutation, useQueryClient } from "@tanstack/react-query";
import { createHistoryRoutine } from "../../history/api/history_api";
import { HistoryRoutine } from "../../history/model/history_routine";

type ActiveRoutineFrameProps = {
    routine: Routine
}

export const ActiveRoutineFrame = ({routine} : ActiveRoutineFrameProps) => {
    const db = useSQLiteContext();
    const queryClient = useQueryClient();
    const [exerciseIdx, setExerciseIdx] = useState(0);
    const [currSet, setCurrSet] = useState(0);
    const [totalSteps, setTotalSteps] = useState(1);
    const [isResting, setIsResting] = useState(false);
    const [isFinished, setIsFinished] = useState(false);
    const [buttonText, setButtonText] = useState("");
    const [currStep, setCurrStep] = useState(0);

    const historyMutation = useMutation({
        mutationFn: () => {
            const historyRoutine : HistoryRoutine = {
                routine: routine,
                name: routine.name,
                routineExercises: routine.routineExercises,
            };

            return createHistoryRoutine(db, historyRoutine);
        },
        onSuccess: () => {
            queryClient.invalidateQueries({queryKey: ["history-dates", "history"]});
            router.back();
        },
        onError: (e) => console.log(e)
    });

    const goNext = () => {
        if (isFinished) {
            historyMutation.mutate();
            return;
        }

        if (!isResting && currSet === routine.routineExercises[exerciseIdx].sets - 1 && exerciseIdx === routine.routineExercises.length - 1) {
            setIsFinished(true);
            return;
        }

        if (!isResting && (routine.routineExercises[exerciseIdx].rest as number) > 0) {
            setIsResting(true);
        }
        else if (isResting) {
            setIsResting(false);
            return;
        }

        if (currSet === routine.routineExercises[exerciseIdx].sets - 1) {
            setCurrSet(0);
            setExerciseIdx(exerciseIdx + 1);
        }
        else {
            setCurrSet(currSet + 1);
        }

        setCurrStep(currStep + 1);
    }

    useEffect(() => {
        let total = 0;

        for (const routineExercise of routine.routineExercises) {
            total += routineExercise.sets;
        }

        setTotalSteps(total);
    }, []);

    useEffect(() => {
        const isLastExercise = exerciseIdx === routine.routineExercises.length - 1 && currSet === routine.routineExercises[exerciseIdx].sets - 1;

        if (isFinished) {
            setButtonText("Done");
        }
        else if (isLastExercise && !isResting) {
            setButtonText("Finish");
        }
        else if (!isLastExercise && !isResting && (routine.routineExercises[exerciseIdx].rest as number) > 0) {
            setButtonText(`Next: Rest`);
        }
        else {
            if (currSet === routine.routineExercises[exerciseIdx].sets - 1 && !isLastExercise) {
                setButtonText(`Next: ${routine.routineExercises[exerciseIdx + 1].exercise.name}`);
            }
            else {
                setButtonText(`Next: ${routine.routineExercises[exerciseIdx].exercise.name}`);
            }
        }
    }, [exerciseIdx, currSet, isResting, isFinished]);
    

    const pageComponents = [
        <ProgressBar curr={isFinished ? totalSteps : currStep} total={totalSteps} />,
        <></>, // placeholder element that gets replaced by current exercise, finished screen, or rest screen 
        <BottomButton onPress={goNext} contents={<FitsawText bold color={Colors.screenBackground}>{buttonText}</FitsawText>} />,
        <Spacer height={10} />
    ]

    return (
        <FlatList 
            keyExtractor={(_, index) => index.toString()}
            data={pageComponents}
            renderItem={({item, index}) => {
                    if (index === 1 && isFinished) return <RoutineSummary routine={routine} />;
                    else if (index === 1 && isResting) return <Rest time={routine.routineExercises[exerciseIdx].rest as number} goNext={goNext} />;
                    else if (index === 1 && !isResting) return <CurrentExercise routineExercise={routine.routineExercises[exerciseIdx]} currSet={currSet} goNext={goNext} />;

                    return item;
                }
            }
            ItemSeparatorComponent={() => <Spacer height={10} />}
        />
    );
}