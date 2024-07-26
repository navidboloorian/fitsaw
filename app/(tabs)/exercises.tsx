import { useState } from "react";
import SearchBar from "../../src/shared/components/SearchBar";
import FitsawBodyText from "../../src/shared/components/FitsawBodyText";
import { createExercise } from "../../src/features/create_exercise/api/exercise_api";
import Exercise from "../../src/features/create_exercise/model/exercise";

const Exercises = () => {
    const [searchQuery, setSearchQuery] : [string, (query: string) => void] = useState("");

    createExercise(new Exercise("testing", 1, "testing", "testing", "testing"));

    return (
        <>
            <SearchBar searchQuery={searchQuery} setSearchQuery={setSearchQuery} placeholder={"Search exercises..."} />
            <FitsawBodyText>
                {searchQuery}
            </FitsawBodyText>
        </>
    );
}

export default Exercises;