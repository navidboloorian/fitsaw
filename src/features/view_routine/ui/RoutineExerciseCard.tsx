import { Pressable, FlatList, View, TextInput } from "react-native";
import { BackgroundBox, Collapsible, FitsawText, Spacer, TimeInput, timeNumToString, timeStringToNum } from "../../../shared/components/components";
import { Colors } from "../../../shared/styles/colors";
import { RoutineExercise } from "../model/routine_exercise";
import { useRef, useState } from "react";

type SetRowProps = {
    index : number,
    timeValue? : number | string,
    repValue? : number,
    weightValue? : number,
    isTimed : boolean,
    isWeighted : boolean,
    onNumberChange: (fieldType : NumberFieldType, value : string, index? : number) => void,
    onTimeChange: (fieldType : TimeFieldType, value : string, pushUpstream : boolean, index? : number) => void
}

const SetRow = ({index, onNumberChange, onTimeChange, isTimed, isWeighted, timeValue, repValue, weightValue} : SetRowProps) => {
    return (
        <View style={{flexDirection: "row", justifyContent: "space-between", alignItems: "center"}}>
            <FitsawText>Set {(index + 1).toString()}</FitsawText>
            <View style={{flexDirection: "row", alignItems: "center"}}>
                {
                    isWeighted ? 
                        <>
                            <TextInput 
                                value={weightValue!.toString()} 
                                maxLength={2} 
                                placeholder="0" 
                                keyboardType="numeric"
                                placeholderTextColor={Colors.secondaryText} 
                                style={{color: Colors.primaryText}}
                                onChangeText={(text) => onNumberChange(NumberFieldType.Weight, text, index)}
                            />
                            <FitsawText>lbs</FitsawText>
                            <Spacer width={10}/>
                        </>
                    :
                        <></>
                }
                {
                    isTimed ? 
                        <>
                            <TimeInput
                                value={typeof timeValue === "string" ? timeValue as string : timeNumToString(timeValue!)} 
                                fieldType={TimeFieldType.Time}
                                updateValue={onTimeChange}
                                index={index}
                            />
                            <FitsawText>Time</FitsawText>
                        </>
                    :
                        <>
                            <TextInput 
                                value={repValue!.toString()} 
                                maxLength={2} 
                                placeholder="0" 
                                keyboardType="numeric"
                                placeholderTextColor={Colors.secondaryText} 
                                style={{color: Colors.primaryText}}
                                onChangeText={(text) => onNumberChange(NumberFieldType.Reps, text, index)}
                            />
                            <FitsawText>Reps</FitsawText>
                        </>
                }
            </View>
        </View>
    );
}

type RoutineExerciseCardProps = {
    index : number,
    routineExercise : RoutineExercise,
    updateRoutineExercise : (index : number, routineExercise : RoutineExercise) => void
}

enum NumberFieldType {
    Sets,
    Reps,
    Weight
}

export enum TimeFieldType {
    Time,
    Rest
}

export const RoutineExerciseCard = ({index, routineExercise, updateRoutineExercise} : RoutineExerciseCardProps) => {
    const isTimed = routineExercise.exercise.measurement === "time";
    const isWeighted = routineExercise.exercise.type === "weighted"; 

    const updateTimeField = (fieldType : TimeFieldType, valueString : string, submitChange : boolean, arrIndex? : number) => {
        let value;

        if (submitChange) {
            value = timeStringToNum(valueString);
        } else {
            value = valueString;
        }

        if (fieldType === TimeFieldType.Rest) {
            routineExercise.rest = value;
        } else if (fieldType === TimeFieldType.Time) {
            routineExercise.times[arrIndex!] = value;
        }

        updateRoutineExercise(index, routineExercise);
    }

    const updateNumberField = (fieldType : NumberFieldType, valueString : string, arrIndex? : number) => {
        if (valueString.match(/[^\d]/)) return;

        const value = valueString === "" ? 0 : parseInt(valueString);

        if (fieldType === NumberFieldType.Reps) {
            routineExercise.reps[arrIndex!] = value;
        } else if (fieldType === NumberFieldType.Weight) {
            routineExercise.weights[arrIndex!] = value;
        } else if (fieldType === NumberFieldType.Sets) {
            routineExercise.sets = value;
        }

        updateRoutineExercise(index, routineExercise);
    }

    const updateSetRows = (setsString : string) => {
        const sets = Math.max(1, parseInt(setsString));
        const numRows = routineExercise.times.length;

        if (sets > numRows) {
            for (let i = 0; i < sets - numRows; i++) {
                routineExercise.times.push(1);
                routineExercise.reps.push(1);
                routineExercise.weights.push(1);
            }
        }
        else {
            for (let i = 0; i < numRows - sets; i++) {
                routineExercise.times.pop();
                routineExercise.reps.pop();
                routineExercise.weights.pop();
            }
        }

        routineExercise.sets = sets;
        
        updateRoutineExercise(index, routineExercise);
    }

    return (
        <BackgroundBox color={Colors.boxBackground2} style={{width: "100%"}}>
            <Collapsible 
                header={<FitsawText bold>{routineExercise.exercise.name}</FitsawText>} 
                body={
                    <>
                        <View style={{flexDirection: "row", alignItems: "center"}}>
                            <TimeInput 
                                value={typeof routineExercise.rest === "string" ? routineExercise.rest as string : timeNumToString(routineExercise.rest)} 
                                updateValue={updateTimeField}
                                fieldType={TimeFieldType.Rest}
                            />
                            <FitsawText>Rest</FitsawText>
                            <Spacer width={10} />
                            <TextInput 
                                keyboardType="numeric"
                                value={routineExercise.sets.toString()}
                                maxLength={2} 
                                placeholder="0" 
                                onChangeText={(text) => updateNumberField(NumberFieldType.Sets, text, undefined)}
                                placeholderTextColor={Colors.secondaryText} 
                                style={{color: Colors.primaryText}}
                                onSubmitEditing={(e) => updateSetRows(e.nativeEvent.text)}
                                onBlur={() => updateSetRows(routineExercise.sets.toString())}
                            />
                            <FitsawText>Sets</FitsawText>
                        </View>
                        <FlatList 
                            removeClippedSubviews={false}
                            data={isTimed ? routineExercise.times : routineExercise.reps}
                            renderItem={({item, index}) => (
                                    <SetRow 
                                        index={index} 
                                        timeValue={isTimed ? item : undefined}
                                        repValue={!isTimed ? item as number : undefined}
                                        weightValue={isWeighted ? routineExercise.weights[index] as number : undefined}
                                        onNumberChange={updateNumberField}
                                        onTimeChange={updateTimeField}
                                        isTimed={isTimed}
                                        isWeighted={isWeighted}
                                    />
                                )
                            }
                        />
                    </>
                }
            />
            
        </BackgroundBox>
    );
}