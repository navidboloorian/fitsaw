import { TextInput, View, StyleSheet, Text, ScrollView, FlatList} from "react-native";
import { Colors } from "../../../shared/styles/colors";
import { useState } from "react";
import { createExercise, updateExercise } from "../api/exercise_api";
import {Exercise} from "../model/model";
import { useMutation, useQueryClient } from "@tanstack/react-query";
import { useSQLiteContext } from "expo-sqlite";
import { useGlobalStore } from "../../../shared/hooks/use_global_store";
import { router } from "expo-router";
import { SnackbarStatus } from "../../../shared/globals";
import { useEffect } from "react";
import { BackgroundBox, InputErrors, ToggleButton, TagTextInput, BottomButton, Loading, Error, Spacer, FitsawText } from "../../../shared/components/components";
import { FitsawError } from "../../../shared/shared";

type ExerciseFormProps = {
    initialExercise?: Exercise | null
}

type FormErrorsType = {
    name: string[],
    notes: string[]
}

export const ExerciseForm = ({initialExercise} : ExerciseFormProps) => {
    const db = useSQLiteContext();
    const queryClient = useQueryClient();
    const [isWeighted, setIsWeighted] = useState<boolean>(false);
    const [isTimed, setIsTimed] = useState<boolean>(false);
    const [tags, setTags] = useState<string[]>([]);
    const [name, setName] = useState<string>("");
    const [notes, setNotes] = useState<string>("");
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
            throw new FitsawError({name: "FORM_ERROR", message: "There is an error(s) in the form."});
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
        
        return createExercise(db, exercise);
    }

    const exerciseMutation = useMutation({
        mutationFn: submitForm,
        onSuccess: () => {
            queryClient.invalidateQueries({queryKey: ["exercises"]}); // ensures that exercise list is updated
            setIsFormDisabled(false);
            showSnackbar(SnackbarStatus.Success, initialExercise ? "Exercise updated!" : "Exercise created!");
            router.back();
        },
        onError: () => setIsFormDisabled(false)
    });
    
    useEffect(() => {
        if (exerciseMutation.isError) {
            const errorMessage = exerciseMutation.error.message;

            if (errorMessage.indexOf("UNIQUE") != -1) {
                showSnackbar(SnackbarStatus.Failure, "An exercise with this name already exists.");
            }
            else {
                showSnackbar(SnackbarStatus.Failure, initialExercise ? "There was an error updating the exercise." : "There was an error creating the exercise.");
            }
        }
    }, [exerciseMutation]);

    if (exerciseMutation.isPending) {
        return <Loading />;
    }

    const pageComponents = [
        <BackgroundBox paddingTop={5} paddingBottom={5}>
            <TextInput 
                style={styles.input}
                placeholder="Exercise name"
                placeholderTextColor={Colors.secondaryText}
                onChangeText={setName}
                value={name}
            />
            <InputErrors errors={formErrors.name} />
        </BackgroundBox>,
        <TagTextInput tags={tags} setTags={setTags} />,
        <ToggleButton selected={isWeighted} setSelected={setIsWeighted} leftText="Not Weighted" rightText="Weighted"/>,
        <ToggleButton selected={isTimed} setSelected={setIsTimed} leftText="Reps" rightText="Time"/>,
        <BackgroundBox>
            <TextInput 
                style={styles.input}
                placeholder="Notes"
                placeholderTextColor={Colors.secondaryText}
                multiline
                numberOfLines={4}
                value={notes}
                onChangeText={setNotes}
                textAlignVertical="top"
            />
        </BackgroundBox>,
        <BottomButton 
            contents={
                        isFormDisabled ? 
                                <Loading size={16} color={Colors.screenBackground} height="auto" /> : 
                                <FitsawText bold color={Colors.screenBackground}>{initialExercise ? "Update" : "Create"}</FitsawText>
                    } 
            disabled={isFormDisabled}
            onPress={() => exerciseMutation.mutate()} 
        />
    ]

    return (
        <FlatList
            keyExtractor={(_, index) => index.toString()}
            data={pageComponents}
            renderItem={({item}) => item}
            ItemSeparatorComponent={() => <Spacer height={10} />}
        />
    ); 
}
