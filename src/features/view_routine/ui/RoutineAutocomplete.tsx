import { useState } from "react";
import { BackgroundBox, FitsawText, Loading, SearchBar } from "../../../shared/components/components";
import { Colors } from "../../../shared/styles/colors";
import { useQuery } from "@tanstack/react-query";
import { getAllExercises } from "../../view_exercise/api/exercise_api";
import { Exercise } from "../../view_exercise/model/model";
import { useSQLiteContext } from "expo-sqlite";
import { StyleSheet, Pressable, FlatList } from "react-native";
import { Error } from "../../../shared/components/components";
import FontAwesome from "@expo/vector-icons/FontAwesome5";

type RoutineAutocompleteProps = {
    addRoutineExercise: (exercise : Exercise) => void
}

export const RoutineAutocomplete = ({addRoutineExercise} : RoutineAutocompleteProps) => {
    const styles = StyleSheet.create({
        autocompleteBox: {
            position: "absolute",
            top: 38,
            width: "100%",
            paddingTop: 5,
            paddingBottom: 5,
            zIndex: 2
        },
        autocompleteRow: {
            flexDirection: "row", 
            justifyContent: "space-between", 
            alignItems: "center",
            paddingTop: 5,
            paddingBottom: 5
        }
    });
    
    const db = useSQLiteContext();
    const [query, setQuery] = useState("");
    const exercises = useQuery(
        {
            queryKey: ["exercises"],
            queryFn: () : Promise<Exercise[] | null> => getAllExercises(db)
        }
    );

    if (exercises.isLoading) {
        return <Loading />;
    }

    if (exercises.isError) {
        return <Error message={"There was an error loading the exercise list."} />;
    }

    const exerciseList = query == "" ? null : exercises.data!.filter((exercise) => {
        if (exercise.name.toLowerCase().includes(query.toLowerCase())) return true;

        for (const tag of exercise.tags) {
            if (tag.toLowerCase().includes(query.toLowerCase())) return true;
        }

        return false;
    });

    return (
        <>
            <SearchBar 
                displayIcon={false} 
                color={Colors.boxBackground2} 
                searchQuery={query} 
                style={{width: "100%"}} 
                setSearchQuery={setQuery} 
                placeholder="Add exercise..."
            />
            {
                // need to remove scrolling and add tags
                exerciseList && exerciseList.length > 0 ? (
                    <BackgroundBox style={styles.autocompleteBox} color={Colors.boxBackground2}>
                        <FlatList
                            scrollEnabled={false}
                            data={exerciseList}
                            renderItem={
                                ({item}) => (
                                    <Pressable 
                                        style={styles.autocompleteRow} 
                                        onPress={() => {
                                                addRoutineExercise(item);
                                                setQuery("");
                                            }
                                        }
                                    >
                                        <FitsawText>{item.name}</FitsawText>
                                        <FontAwesome color={Colors.primaryText} size={10} name={"plus"} />
                                    </Pressable>
                                )
                            }
                            keyExtractor={exercise => exercise.id!.toString()}
                        />
                    </BackgroundBox>
                ) : (
                    <></>
                )
            }
        </>
    );
}