import { useState } from "react";
import SearchBar from "../../src/shared/components/SearchBar";
import FitsawBodyText from "../../src/shared/components/FitsawBodyText";
import IconButton from "../../src/shared/components/IconButton";
import FontAwesome from "@expo/vector-icons/FontAwesome5";
import { Colors } from "../../src/shared/styles/colors";

const Exercises = () => {
    const [searchQuery, setSearchQuery] : [string, (query: string) => void] = useState("");

    return (
        <>
            <SearchBar searchQuery={searchQuery} setSearchQuery={setSearchQuery} placeholder={"Search exercises..."} />
            <FitsawBodyText>
                {searchQuery}
            </FitsawBodyText>
            <IconButton icon={<FontAwesome color={Colors.primaryText} size={16} name={"plus"} />} />
        </>
    );
}

export default Exercises;