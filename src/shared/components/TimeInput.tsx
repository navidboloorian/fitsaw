import { useState } from "react";
import { Colors } from "../styles/colors";
import { TextInput, StyleSheet } from "react-native";
import { TimeFieldType } from "../../features/view_routine/ui/ui";

type TimeInputProps = {
    value : string,
    index? : number,
    fieldType : TimeFieldType,
    updateValue : (fieldType : TimeFieldType, value : string, pushUpstream : boolean, index? : number) => void,
}

export const timeNumToString = (timeNum : number) => {
    let mins = Math.floor(timeNum / 60).toString();
    let seconds = (timeNum % 60).toString();

    if (mins.length === 1) mins = `0${mins}`;
    if (seconds.length === 1) seconds = `0${seconds}`; 

    return `${mins}:${seconds}`;
}   

export const timeStringToNum = (timeString : string) => {
    let mins = Math.min(59, parseInt(timeString.substring(0, timeString.indexOf(":"))));
    let seconds = Math.min(59, parseInt(timeString.substring(timeString.indexOf(":") + 1)));

    return (mins * 60) + seconds;
}

export const TimeInput = ({value, updateValue, fieldType, index} : TimeInputProps) => {
    const styles = StyleSheet.create({
        input: {
            width: 45,
            color: Colors.primaryText
        }
    });

    const updateTime = (timeVal : string) => {
        let leftSubstring = "";
        let rightSubstring = "";

        if (timeVal.match(/[^:\d]/)) return;

        if (timeVal.length === 4) {
            leftSubstring = `0${timeVal[0]}`;

            if (timeVal[1] === ":") {
                rightSubstring = timeVal.substring(2);
            }
            else {
                rightSubstring = `${timeVal[1]}${timeVal[3]}`;
            }
        }
        else if (timeVal.length === 6) {
            if (timeVal[0] === "0") {
                if (timeVal[3] === ":") {
                    leftSubstring = timeVal.substring(1, 3);
                }
                else {
                    leftSubstring = `${timeVal[1]}${timeVal[3]}`;
                }

                rightSubstring = timeVal.substring(4);
            }
            else {
                leftSubstring = timeVal.substring(0, 2);
                
                if (timeVal.substring(3, 5).indexOf(":") > -1) rightSubstring = timeVal.substring(4, 6);
                else rightSubstring = timeVal.substring(3, 5);
            }
        }

        if (leftSubstring === "" && rightSubstring === "") {
            leftSubstring = "00";
            rightSubstring = "01";
        }

        updateValue(fieldType, `${leftSubstring}:${rightSubstring}`, false, index);
    }

    return(
        <TextInput
            keyboardType="numeric"
            value={value}
            onChangeText={(text) => updateTime(text)}
            style={styles.input}
            maxLength={6}
            onSubmitEditing={(e) => updateValue(fieldType, e.nativeEvent.text, true, index)}
            onEndEditing={(e) => updateValue(fieldType, e.nativeEvent.text, true, index)}
        />
    )
}