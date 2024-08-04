import { Image } from "react-native";
import { logo } from "../assets/assets";

export const Logo = () => {
    return <Image style={{width: 150, height: 50, resizeMode: "contain"}} source={logo} />;
}
