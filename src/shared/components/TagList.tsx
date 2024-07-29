import { View, StyleSheet } from "react-native";
import Tag from "./Tag";

export type TagListProps = {
    tags: string[],
    dismissible?: boolean,
    onPress?: (indexToRemove : number) => void,
}

const TagList = ({tags, dismissible, onPress} : TagListProps) => {
    const styles = StyleSheet.create({
        tagList: {
            display: "flex",
            flexDirection: "row",
            gap: 5,
            flexWrap: "wrap",
        }
    }); 

    if (tags.length) {
      return (
        <View style={styles.tagList}>
            {tags.map((tag, index) => <Tag key={index} text={tag} dismissible={dismissible} onPress={onPress ? () => onPress(index) : undefined} />)}
        </View>
      );
    }

    return <></>;
}

export default TagList;