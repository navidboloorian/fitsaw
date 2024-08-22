import { TextInput, View, StyleSheet, FlatList} from "react-native";
import { Colors } from "../../../shared/styles/colors";
import { useEffect, useState } from "react";
import { useSQLiteContext } from "expo-sqlite";
import { useGlobalStore } from "../../../shared/hooks/use_global_store";
import { BackgroundBox, TagTextInput, BottomButton, Spacer, FitsawText, Dismissible, InputErrors, Loading } from "../../../shared/components/components";
import { RoutineAutocomplete } from "./RoutineAutocomplete";
import { RoutineExercise } from "../model/routine_exercise";
import { Exercise } from "../../view_exercise/model/exercise";
import { RoutineExerciseCard } from "./RoutineExerciseCard";
import { createRoutine, updateRoutine } from "../api/routine_api";
import { Routine } from "../model/model";
import { useMutation } from "@tanstack/react-query";
import { FitsawError, SnackbarStatus } from "../../../shared/shared";
import { router } from "expo-router";

type FormErrorsType = {
    name: string[],
    notes: string[],
    exercises: string[]
}

type RoutineFormProps = {
    initialRoutine? : Routine | null
}

export const RoutineForm = ({initialRoutine} : RoutineFormProps) => {
    const db = useSQLiteContext();
    const [tags, setTags] = useState<string[]>([]);
    const [name, setName] = useState<string>("");
    const [notes, setNotes] = useState<string>("");
    const [routineExercises, setRoutineExercises] = useState<RoutineExercise[]>([]);
    const [multilineHeight, setMultilineHeight] = useState<number | undefined>(undefined); // prevents multiline from capturing scroll events
    const [isFormDisabled, setIsFormDisabled] = useState<boolean>(false);
    const [isLoading, setIsLoading] = useState<boolean>(true);
    const [formErrors, setFormErrors] = useState<FormErrorsType>({name: [], notes: [], exercises: []});
    const [isChanged, setIsChanged] = useState<boolean>(false);

    // decides behavior upon successful mutation: start -> start routine, update -> show snackbar and pop page
    const [mutationReferrer, setMutationReferrer] = useState<"update" | "start" | undefined>(undefined); 
    const showSnackbar = useGlobalStore((state) => state.showSnackbar);

    const areTagsEqual = () => {

        if (!tags || !initialRoutine!.tags) return false;
        if (tags.length !== initialRoutine!.tags.length) return false;

        for (let i = 0; i < tags.length; i++) {
            if (tags[i] !== initialRoutine!.tags[i]) return false;
        }

        return true;
    }

    useEffect(() => {
        if (initialRoutine) {
            setName(initialRoutine.name);
            setNotes(initialRoutine.notes);
            setRoutineExercises(initialRoutine.routineExercises);

            if (initialRoutine.tags) setTags(initialRoutine.tags);
        }
            
        setIsLoading(false);
    }, []);

    useEffect(() => {
        // checks to see if any of the routine's information has been changed and only updates the database upon start if a change has occurred
        if (initialRoutine && !isLoading && !isChanged) {
            if (name !== initialRoutine.name 
                || notes !== initialRoutine.notes 
                || !areTagsEqual()) {
                setIsChanged(true);
            }
            else {
                setIsChanged(false);
            }
        }
    }, [name, notes, tags, routineExercises, isLoading]);
    
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
        },
        routineExerciseCardContainer: {
            width: "100%",
            zIndex: 1
        }
    });

    const submitForm = () => {
        setIsFormDisabled(true);
        const currFormErrors : FormErrorsType = {name: [], notes: [], exercises: []};

        if (name.length < 3 || name.length > 100) {
            currFormErrors.name.push("Routine name must be between 3 and 100 characters long");
        }

        if (routineExercises.length < 1 || routineExercises.length > 50) {
            currFormErrors.exercises.push("Routine must have between 1 and 50 exercises");
        }

        setFormErrors(currFormErrors);

        if (currFormErrors.name.length || currFormErrors.notes.length || currFormErrors.exercises.length) {
            throw new FitsawError({name: "FORM_ERROR", message: "There is an error(s) in the form."});
        }

        const routine : Routine = {
            name: name,
            notes: notes,
            units: "lbs",
            tags: tags,
            routineExercises: routineExercises
        };

        if (initialRoutine) {
            routine.id = initialRoutine.id;
            return updateRoutine(db, routine);
        }

        return createRoutine(db, routine);
    }

    const rotuineMutation = useMutation({
        mutationFn: submitForm,
        onSuccess: () => {
            if (mutationReferrer === "update") {    
                setIsFormDisabled(false);
                showSnackbar(SnackbarStatus.Success, initialRoutine ? "Routine Updated" : "Routine created!");
                router.back();
            }
            else {
                const id = initialRoutine!.id!.toString();
                router.replace({pathname: "/active_routine/[id]", params: {id}});
            }
        },
        onError: () => setIsFormDisabled(false)
    })

    const updateRoutineExercise = (index : number, routineExercise : RoutineExercise) => {
        const tempRoutineExercises = [...routineExercises];
        tempRoutineExercises[index] = routineExercise;

        setRoutineExercises(tempRoutineExercises);
        setIsChanged(true);
    }

    // add exercise to list of routine exercises
    const addRoutineExercise = (exercise : Exercise) => {
        setRoutineExercises([...routineExercises, {exercise: exercise, sets: 1, rest: 1, reps: [1], weights: [1], times: [1]}]);
    }

    // TODO: does not work, must be fixed
    const deleteRoutineExercise = (index : number) => {
        setRoutineExercises(routineExercises.filter((_, i) => (i != index)));
    }

    const pageComponents = [
        <View style={{gap: 10, height: "100%"}}>
            <BackgroundBox paddingTop={5} paddingBottom={5}>
                <TextInput 
                    style={styles.input}
                    placeholder="Routine name"
                    placeholderTextColor={Colors.secondaryText}
                    onChangeText={setName}
                    value={name}
                />
                <InputErrors errors={formErrors.name} />
            </BackgroundBox>
            <TagTextInput tags={tags} setTags={setTags} />
            <BackgroundBox style={{zIndex: 1}}>
                <RoutineAutocomplete addRoutineExercise={addRoutineExercise} />
                {routineExercises.length > 0 ? <Spacer height={5} /> : <></>}
                <FlatList
                    data={routineExercises}
                    renderItem={({item, index}) => (
                        <Dismissible 
                            onDismiss={() => deleteRoutineExercise(index)}
                            width={"100%"}
                        >
                            <BackgroundBox 
                                style={styles.routineExerciseCardContainer} 
                                color={Colors.boxBackground2} 
                                paddingLeft={0} 
                                paddingRight={0} 
                                paddingBottom={0} 
                                paddingTop={0}
                            >
                                <RoutineExerciseCard 
                                    index={index}
                                    routineExercise={item}
                                    updateRoutineExercise={updateRoutineExercise}
                                />
                            </BackgroundBox>
                        </Dismissible>
                    )}
                    ItemSeparatorComponent={() => <Spacer height={5} />}
                />
                <InputErrors errors={formErrors.exercises} />
            </BackgroundBox>
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
            <BottomButton 
                contents={
                            isFormDisabled ? 
                                <Loading size={16} color={Colors.screenBackground} height="auto" /> : 
                                <FitsawText bold color={Colors.screenBackground}>{initialRoutine ? "Update" : "Create"}</FitsawText>
                        } 
                disabled={isFormDisabled}
                onPress={() => {
                    setMutationReferrer("update");
                    rotuineMutation.mutate();
                }} 
            />
            {
                initialRoutine ? 
                    <BottomButton 
                        contents={
                            isFormDisabled ?
                                <Loading size={16} color={Colors.screenBackground} height="auto" /> : 
                                <FitsawText bold color={Colors.screenBackground}>Start</FitsawText>
                        } 
                        disabled={isFormDisabled}
                        onPress={() => {
                            if (isChanged) {
                                setMutationReferrer("start");
                                rotuineMutation.mutate();
                            }
                            else {
                                const id = initialRoutine!.id!.toString();

                                router.replace({pathname: "/active_routine/[id]", params: {id}});
                            }
                        }} 
                    /> 
                : 
                    <></>
            }
            <Spacer height={10} />
        </View>
    ]

    if (isLoading) return <Loading />;

    return (
        <FlatList
            contentContainerStyle={{flexGrow: 1}}
            data={pageComponents}
            renderItem={({item}) => item}
        />
    ); 
}
