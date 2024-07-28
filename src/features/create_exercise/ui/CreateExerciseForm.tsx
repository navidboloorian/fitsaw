import { Text, TextInput, View, StyleSheet} from "react-native";
import { Colors } from "../../../shared/styles/colors";
import BackgroundBox from "../../../shared/components/BackgroundBox";
import ToggleButton from "../../../shared/components/ToggleButton";
import { useState } from "react";
import TagTextInput from "../../../shared/components/TagTextInput";

const CreateExerciseForm = () => {
    const styles = StyleSheet.create({
        grid: {
            display: "flex",
            gap: 10,
        },
        input: {
            color: Colors.primaryText,
            fontFamily: "OpenSans_400Regular",
        }
    });

    const [isWeighted, setIsWeighted] = useState(false);
    const [isTimed, setIsTimed] = useState(false);

    return (
        <View style={styles.grid}>
            <BackgroundBox paddingTop={5} paddingBottom={5}>
                <TextInput 
                    style={styles.input}
                    placeholder="Exercise name"
                    placeholderTextColor={Colors.secondaryText}
                />
            </BackgroundBox>
            <ToggleButton selected={isWeighted} setSelected={setIsWeighted} leftText="Not Weighted" rightText="Weighted"/>
            <ToggleButton selected={isTimed} setSelected={setIsTimed} leftText="Reps" rightText="Time"/>
            <BackgroundBox>
                <TextInput 
                    style={styles.input}
                    placeholder="Notes"
                    placeholderTextColor={Colors.secondaryText}
                    multiline
                    textAlignVertical="top"
                    numberOfLines={4}
                />
            </BackgroundBox>
            <TagTextInput />
        </View>
    ); 
}

export default CreateExerciseForm;