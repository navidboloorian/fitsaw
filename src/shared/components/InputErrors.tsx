import { StyleSheet, View } from "react-native"
import { Colors } from "../styles/colors";
import { FitsawText } from "./FitsawText";

type InputErrorsProps = {
    errors?: string[]
}

export const InputErrors = ({errors} : InputErrorsProps) => {
    const styles = StyleSheet.create({
        errorList: {
            marginBottom: 5,
        }
    }); 

    if (!errors) {
        return <></>;
    }

    if (errors.length) {
        return (
            <View style={styles.errorList}>
                {errors.map((error, index) => <FitsawText key={index} size={12} color={Colors.fitsawRed}>{error}</FitsawText>)}
            </View>
        );
    }

    return <></>;
}   