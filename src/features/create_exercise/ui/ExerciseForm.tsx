import { TextInput, View, StyleSheet, Text, ScrollView} from "react-native";
import { Colors } from "../../../shared/styles/colors";
import { useState } from "react";
import { createExercise, updateExercise } from "../api/exercise_api";
import {Exercise} from "../model/model";
import { useMutation } from "@tanstack/react-query";
import { useSQLiteContext } from "expo-sqlite";
import { useGlobalStore } from "../../../shared/hooks/use_global_store";
import { router } from "expo-router";
import { SnackbarStatus } from "../../../shared/globals";
import { useEffect } from "react";
import { BackgroundBox, InputErrors, ToggleButton, TagTextInput, BottomButton, Loading, Error } from "../../../shared/components/components";
import { FitsawError, ErrorNameType } from "../../../shared/shared";

type ExerciseFormProps = {
    initialExercise ?: Exercise | null
}

type FormErrorsType = {
    name: string[],
    notes: string[]
}

export const ExerciseForm = ({initialExercise} : ExerciseFormProps) => {
    const db = useSQLiteContext();
    const [isWeighted, setIsWeighted] = useState<boolean>(false);
    const [isTimed, setIsTimed] = useState<boolean>(false);
    const [tags, setTags] = useState<string[]>([]);
    const [name, setName] = useState<string>("");
    const [notes, setNotes] = useState<string>("");
    const [multilineHeight, setMultilineHeight] = useState<number | undefined>(undefined);
    const [isFormDisabled, setIsFormDisabled] = useState<boolean>(false);
    const [formErrors, setFormErrors] = useState<FormErrorsType>({name: [], notes: []});
    const showSnackbar = useGlobalStore((state) => state.showSnackbar);

    useEffect(() => {
        if (initialExercise) {
            setName(initialExercise.name);
            initialExercise.type === "weighted" ? setIsWeighted(true) : setIsWeighted(false);
            initialExercise.measurement === "time" ? setIsTimed(true) : setIsTimed(false);
            setNotes(initialExercise.notes);

            if (initialExercise.tags) setTags(initialExercise.tags);
        }
    }, []);
    
    const styles = StyleSheet.create({
        grid: {
            display: "flex",
            gap: 10,
        },
        input: {
            color: Colors.primaryText,
            fontFamily: "OpenSans_400Regular",
        },
        multiline: {
            height: multilineHeight ? multilineHeight : "auto" 
        }
    });

    const submitForm = () => {
        setIsFormDisabled(true);
        const currFormErrors : FormErrorsType = {name: [], notes: []};

        if (name.length < 3 || name.length > 100) {
            currFormErrors.name.push("Exercise name must be between 3 and 100 characters long");

            setFormErrors(currFormErrors);
        }

        if (currFormErrors.name.length || currFormErrors.notes.length) {
            throw new FitsawError({name: "FORM_ERROR", message: "Form content errors."});
        }

        const exercise = {
            name: name,
            notes: notes,
            measurement: isTimed ? "time" : "reps",
            type: isWeighted ? "weighted" : "not weighted",
            tags: tags
        } as Exercise;


        if (initialExercise) {
            exercise.id = initialExercise.id;
            return updateExercise(db, exercise);
        }
        else return createExercise(db, exercise);
    }

    const exerciseMutation = useMutation({
        mutationFn: submitForm,
        onSuccess: () => {
            setIsFormDisabled(false);
            showSnackbar(SnackbarStatus.Success, initialExercise ? "Exercise updated!" : "Exercise created!");
            router.back();
        },
        onError: () => setIsFormDisabled(false)
    });
    
    useEffect(() => {
        if (exerciseMutation.isError) {
            showSnackbar(SnackbarStatus.Failure, initialExercise ? "There was an error updating the exercise." : "There was an error creating the exercise.");
        }
    }, [exerciseMutation]);

    if (exerciseMutation.isPending) {
        return <Loading />
    }

    return (
        <ScrollView>
            <View style={styles.grid}>
                <BackgroundBox paddingTop={5} paddingBottom={5}>
                    <TextInput 
                        style={styles.input}
                        placeholder="Exercise name"
                        placeholderTextColor={Colors.secondaryText}
                        onChangeText={setName}
                        value={name}
                    />
                    <InputErrors errors={formErrors.name} />
                </BackgroundBox>
                <ToggleButton selected={isWeighted} setSelected={setIsWeighted} leftText="Not Weighted" rightText="Weighted"/>
                <ToggleButton selected={isTimed} setSelected={setIsTimed} leftText="Reps" rightText="Time"/>
                <BackgroundBox>
                    <TextInput 
                        style={[styles.input, styles.multiline]}
                        placeholder="Notes"
                        placeholderTextColor={Colors.secondaryText}
                        multiline
                        numberOfLines={4}
                        value={notes}
                        onChangeText={setNotes}
                        onContentSizeChange={({nativeEvent}) => setMultilineHeight(nativeEvent.contentSize.height)}
                        textAlignVertical="top"
                    />
                </BackgroundBox>
                <TagTextInput tags={tags} setTags={setTags} />
                <BottomButton text={initialExercise ? "Update" : "Create"} disabled={isFormDisabled} onPress={() => {exerciseMutation.mutate()}} />
            </View>
        </ScrollView>
    ); 
}
