import { useEffect, useState } from "react";
import { BackgroundBox } from "../../../shared/components/BackgroundBox";
import { Colors } from "../../../shared/styles/colors";
import { Routine } from "../../view_routine/model/routine";
import { LineChart } from "react-native-chart-kit";
import { View } from "react-native";
import { RoutineExercise } from "../../view_routine/model/model";
import { Loading } from "../../../shared/components/Loading";
import { timeNumToString } from "../../../shared/components/TimeInput";

type SummaryGraphProps = {
    routineExercise : RoutineExercise,
    isHistory : boolean
}

export const SummaryGraph = ({routineExercise, isHistory} : SummaryGraphProps) => {
    const [graphWidth, setGraphWidth] = useState(0);
    const [labels, setLabels] = useState<string[]>([]);
    const [legend, setLegend] = useState<string[]>([]);
    const [datasets, setDatasets] = useState<any[]>([]);
    const [isLoading, setIsLoading] = useState<boolean>(true);

    const {reps, weights, times, sets} = routineExercise;

    useEffect(() => {
        const newLabels = [];
        const newLegend = [];
        const newDatasets = [];

        for (let i = 1; i <= sets; i++) {
            newLabels.push(`set ${i}`);
        }

        if ((!isHistory && routineExercise.exercise.measurement === "time") || (isHistory && routineExercise.times.length > 0)) {
            const dataset = {
                data: times,
                color: (_ : any) => Colors.fitsawRed
            };

            newLegend.push("Time");
            newDatasets.push(dataset);
        }
        else {
            const dataset = {
                data: reps,
                color: (_ : any) => Colors.fitsawPurple
            };

            newLegend.push("Reps");
            newDatasets.push(dataset);
        }

        if ((!isHistory && routineExercise.exercise.type === "weighted") || (isHistory && routineExercise.weights.length > 0)) {
            const dataset = {
                data: weights,
                color: (_ : any) => Colors.fitsawOrange
            };

            newLegend.push("Weight");
            newDatasets.push(dataset);
        }

        setLabels(newLabels);
        setLegend(newLegend);
        setDatasets(newDatasets);
        setIsLoading(false);
    }, []);

    if (isLoading) return <Loading />

    return (
        <View onLayout={({nativeEvent}) => setGraphWidth(nativeEvent.layout.width)}>
            <LineChart 
                data={{
                    labels: labels,
                    datasets: datasets,
                    legend: legend
                }}
                width={graphWidth}
                height={200}
                chartConfig={{
                    backgroundColor: Colors.boxBackground1,
                    backgroundGradientFrom: Colors.boxBackground1,
                    backgroundGradientTo: Colors.boxBackground1,
                    decimalPlaces: 0, 
                    color: (_) => Colors.primaryText,
                    labelColor: (_) => Colors.primaryText,
                    propsForDots: {
                        r: "6",
                    }
                }}
                formatYLabel={(yValue) => routineExercise.exercise.measurement === "time" ? timeNumToString(parseInt(yValue)) : yValue}
                style={{
                    paddingRight: 35
                }}
            />
        </View>
    );
}