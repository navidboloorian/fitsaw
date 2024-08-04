import { Colors } from "../styles/colors";
import { TextInput, StyleSheet } from "react-native";
import FontAwesome from "@expo/vector-icons/FontAwesome5";
import { BackgroundBox } from "./components";

type SearchBarProps = {
    searchQuery: string,
    setSearchQuery: (query: string) => void
    placeholder?: string,
}

export const SearchBar = ({searchQuery, setSearchQuery, placeholder} : SearchBarProps) => {
    const styles = StyleSheet.create({
        input: {
            fontFamily: "OpenSans_400Regular",
            fontSize: 16,
            color: Colors.primaryText,
            flex: 1,
        },
        italics: {
            fontStyle: "italic"
        },
        searchIcon: {
            width: 50,
        }
    });

    return (
        <BackgroundBox row paddingTop={5} paddingBottom={5}>
            <TextInput  
                placeholderTextColor={Colors.secondaryText}
                placeholder={placeholder == null ? "Search..." : placeholder}
                style={[styles.input, searchQuery.length == 0 ? styles.italics : null]}
                value={searchQuery}
                onChangeText={setSearchQuery}
            />
            <FontAwesome styles={styles.searchIcon} size={16} name={"search"} color={Colors.secondaryText} />
        </BackgroundBox>
    );
}