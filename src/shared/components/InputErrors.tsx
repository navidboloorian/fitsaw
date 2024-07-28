import { StyleSheet, View } from "react-native"
import { Colors } from "../styles/colors";
import FitsawText from "./FitsawText";

export type InputErrorsProps = {
    errors: string[]
}

const InputErrors = ({errors} : InputErrorsProps) => {
    const styles = StyleSheet.create({
        errorList: {
            marginBottom: 5,
        }
    }); 

    if (errors.length) {
        return (
            <View style={styles.errorList}>
                {errors.map((error, index) => <FitsawText size={12} color={Colors.fitsawRed}>{error}</FitsawText>)}
            </View>
        );
    }

    return <></>;
}   

export default InputErrors;