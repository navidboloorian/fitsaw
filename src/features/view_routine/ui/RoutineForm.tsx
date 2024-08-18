import { TextInput, View, StyleSheet, FlatList} from "react-native";
import { Colors } from "../../../shared/styles/colors";
import { useState } from "react";
import { useSQLiteContext } from "expo-sqlite";
import { useGlobalStore } from "../../../shared/hooks/use_global_store";
import { BackgroundBox, ToggleButton, TagTextInput, BottomButton, Spacer, FitsawText, Dismissible } from "../../../shared/components/components";
import { RoutineAutocomplete } from "./RoutineAutocomplete";
import { RoutineExercise } from "../model/routine_exercise";
import { Exercise } from "../../view_exercise/model/exercise";
import { RoutineExerciseCard } from "./RoutineExerciseCard";


export const RoutineForm = () => {
    const db = useSQLiteContext();
    const [tags, setTags] = useState<string[]>([]);
    const [name, setName] = useState<string>("");
    const [notes, setNotes] = useState<string>("");
    const [routineExercises, setRoutineExercises] = useState<RoutineExercise[]>([]);
    const [multilineHeight, setMultilineHeight] = useState<number | undefined>(undefined); // prevents multiline from capturing scroll events
    const [isFormDisabled, setIsFormDisabled] = useState<boolean>(false);
    const showSnackbar = useGlobalStore((state) => state.showSnackbar);
    
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
    }

    const updateRoutineExercise = (index : number, routineExercise : RoutineExercise) => {
        const tempRoutineExercises = [...routineExercises];
        tempRoutineExercises[index] = routineExercise;

        setRoutineExercises(tempRoutineExercises);
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
            <BottomButton text="Create" disabled={isFormDisabled} />
            <Spacer height={10} />
        </View>
    ]

    return (
        <FlatList
            contentContainerStyle={{flexGrow: 1}}
            data={pageComponents}
            renderItem={({item}) => item}
        />
    ); 
}
