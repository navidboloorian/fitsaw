import { Colors } from "../styles/colors";
import { TextInput, StyleSheet } from "react-native";
import FontAwesome from "@expo/vector-icons/FontAwesome5";
import { BackgroundBox } from "./BackgroundBox";

type SearchBarProps = {
    searchQuery: string,
    setSearchQuery: (query: string) => void,
    color?: string,
    displayIcon?: boolean,
    placeholder?: string,
    style?: StyleSheet | {}
}

export const SearchBar = ({searchQuery, setSearchQuery, color, placeholder, style, displayIcon} : SearchBarProps) => {
    const styles = StyleSheet.create({
        input: {
            fontFamily: "OpenSans_400Regular",
            fontSize: 14,
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
        <BackgroundBox style={style} row color={color} paddingTop={5} paddingBottom={5}>
            <TextInput  
                placeholderTextColor={Colors.secondaryText}
                placeholder={placeholder == null ? "Search..." : placeholder}
                style={[styles.input, searchQuery.length == 0 ? styles.italics : null]}
                value={searchQuery}
                onChangeText={setSearchQuery}
            />
            {displayIcon === undefined || displayIcon ? <FontAwesome styles={styles.searchIcon} size={16} name={"search"} color={Colors.secondaryText} /> : <></>}
        </BackgroundBox>
    );
}