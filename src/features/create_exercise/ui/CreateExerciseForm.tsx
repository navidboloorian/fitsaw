import { TextInput, View, StyleSheet, Text} from "react-native";
import { Colors } from "../../../shared/styles/colors";
import BackgroundBox from "../../../shared/components/BackgroundBox";
import ToggleButton from "../../../shared/components/ToggleButton";
import { useState } from "react";
import TagTextInput from "../../../shared/components/TagTextInput";
import BottomButton from "../../../shared/components/BottomButton";
import { createExercise } from "../api/exercise_api";
import Exercise from "../model/exercise";
import { useMutation } from "@tanstack/react-query";
import { useSQLiteContext } from "expo-sqlite";

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

    const db = useSQLiteContext();
    const [isWeighted, setIsWeighted] = useState<boolean>(false);
    const [isTimed, setIsTimed] = useState<boolean>(false);
    const [tags, setTags] = useState<string[]>([]);
    const [name, setName] = useState<string>("");
    const [notes, setNotes] = useState<string>("");

    const mutation = useMutation({
        mutationFn: (exercise : Exercise) => {
            return createExercise(db, exercise);
        }
    });

    const buildExercise = () => {
        return {
            name: name,
            notes: notes,
            measurement: isTimed ? "time" : "reps",
            type: isWeighted ? "weighted" : "not weighted",
            tags: tags
        } as Exercise;
    }

    if (mutation.isError) {
        return <Text>ERROR</Text>
    }

    if (mutation.isPending) {
        return <Text>LOADING</Text>;
    }

    return (
        <View style={styles.grid}>
            <BackgroundBox paddingTop={5} paddingBottom={5}>
                <TextInput 
                    style={styles.input}
                    placeholder="Exercise name"
                    placeholderTextColor={Colors.secondaryText}
                    onChangeText={setName}
                    value={name}
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
                    value={notes}
                    onChangeText={setNotes}
                />
            </BackgroundBox>
            <TagTextInput tags={tags} setTags={setTags} />
            <BottomButton text={"Create"} onPress={() => {mutation.mutate(buildExercise())}} />
        </View>
    ); 
}

export default CreateExerciseForm;