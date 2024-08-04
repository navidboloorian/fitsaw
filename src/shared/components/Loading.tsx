import { ActivityIndicator, View } from "react-native"
import { Colors } from "../styles/colors"

export const Loading = () => {
    return(
        <View style={{justifyContent: "center", alignItems: "center", height: "100%"}}>
            <ActivityIndicator size={128} color={Colors.fitsawBlue} />
        </View>
    ); 
}