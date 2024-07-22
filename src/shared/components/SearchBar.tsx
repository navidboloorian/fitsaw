import { Colors } from "../styles/colors";
import BackgroundBox from "./BackgroundBox";
import { TextInput, StyleSheet } from "react-native";

export type SearchBarProps = {
    searchQuery: string,
    setSearchQuery: (query: string) => void
}

const SearchBar = ({searchQuery, setSearchQuery} : SearchBarProps) => {
    const styles = StyleSheet.create({
        textInput: {
            fontFamily: "OpenSans_400Regular",
            fontSize: 16,
            color: Colors.primaryText,
        }
    });

    return (
        <BackgroundBox>
            <TextInput  
                style = {styles.textInput}
                value = {searchQuery}
                onChangeText = {setSearchQuery}
            />
        </BackgroundBox>
    );
}

export default SearchBar;