import { ActivityIndicator, DimensionValue, View } from "react-native";
import { Colors } from "../styles/colors";

type LoadingProps = {
    color? : string,
    size? : number
    height? : DimensionValue
}

export const Loading = ({color, size, height} : LoadingProps) => {
    return(
        <View style={{justifyContent: "center", alignItems: "center", height: height ? "auto" : "100%"}}>
            <ActivityIndicator size={size ? size : 128} color={color ? color : Colors.fitsawBlue} />
        </View>
    ); 
}