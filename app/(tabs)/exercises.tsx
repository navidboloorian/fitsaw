import { Text } from "react-native";
import { useState } from "react";
import SearchBar from "../../src/shared/components/SearchBar";
import FitsawBodyText from "../../src/shared/components/FitsawBodyText";

const Exercises = () => {
    const [searchQuery, setSearchQuery] : [string, (query: string) => void] = useState("");

    return (
        <>
            <SearchBar searchQuery={searchQuery} setSearchQuery={setSearchQuery} />
            <FitsawBodyText>
                {searchQuery}
            </FitsawBodyText>
        </>
    );
}

export default Exercises;