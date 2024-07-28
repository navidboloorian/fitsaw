import Tag from "./Tag";
import BackgroundBox from "./BackgroundBox";
import { useState } from "react";
import { TextInput, View, StyleSheet, Text} from "react-native";
import { Colors } from "../styles/colors";
import InputErrors from "./InputErrors";
import TagList from "./TagList";

const TagTextInput = () => {
    const styles = StyleSheet.create({
        input: {
            color: Colors.primaryText,
        }
    }); 

    const [currentTag, setCurrentTag] = useState<string>("");
    const [tags, setTags] = useState<string[]>([]);
    const [errors, setErrors] = useState<string[]>([]);

    const addTag = () => {
        const trimmedTag = currentTag.trim();

        if (trimmedTag.length > 0 && tags.indexOf(trimmedTag) < 0 && trimmedTag.length <= 25) {
            setTags([...tags, trimmedTag]);
            setCurrentTag("");
        }

        const currentErrors = [];

        if (trimmedTag.length == 0) {
            currentErrors.push("Tag can't be empty.");
        }

        if (trimmedTag.length > 25) {
            currentErrors.push("Tag must be 25 characters or fewer.")
        }
        
        if (tags.indexOf(trimmedTag) >= 0) {
            currentErrors.push("Tag must be unique.")
        }

        setErrors(currentErrors);
    }

    const removeTag = (indexToRemove : number) => {
        setTags(tags.filter((_, index) => index != indexToRemove))
    }

    return (
        <BackgroundBox>
            <TextInput
                value={currentTag}
                onChangeText={setCurrentTag}
                style={styles.input}
                placeholder="Tags"
                placeholderTextColor={Colors.secondaryText}
                onSubmitEditing={() => addTag()}
            />
            <InputErrors errors={errors} />
            <TagList tags={tags} dismissible onPress={removeTag}/>
        </BackgroundBox>
    );
}

export default TagTextInput;