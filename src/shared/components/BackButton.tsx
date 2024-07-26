import React from "react";
import IconButton from "./IconButton";
import { Colors } from "../styles/colors";
import FontAwesome from "@expo/vector-icons/FontAwesome5";
import { router } from "expo-router";

const BackButton = () => {
    return (
        <IconButton 
            icon={<FontAwesome color={Colors.primaryText} size={16} name={"arrow-left"} />}
            onPress={() => router.back()} 
        />
    );
}

export default BackButton;