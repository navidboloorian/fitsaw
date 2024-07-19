import { Stack } from "expo-router";
import { Colors } from "../src/shared/styles/colors";

const RootLayout = () => {
    return (
        <Stack
            screenOptions={{contentStyle: {backgroundColor: Colors.screenBackground}}}
        >
            <Stack.Screen name="(tabs)" options={{headerShown: false}}/>
        </Stack>
    );
}

export default RootLayout;