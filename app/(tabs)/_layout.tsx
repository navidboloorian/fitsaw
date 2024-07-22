import { Tabs } from "expo-router";
import { Image, StyleSheet, View, Text, GestureResponderEvent } from "react-native";
import { Colors } from "../../src/shared/styles/colors";
import { logo } from "../../src/shared/assets/images";
import FontAwesome from "@expo/vector-icons/FontAwesome5";
import PlusButton from "../../src/shared/components/IconButton";
import IconButton from "../../src/shared/components/IconButton";

type TabIconProps = {
    focused: boolean,
    iconName: "list" | "history" | "dumbbell",
    color: string,
}

const TabIcon = ({focused, iconName, color} : TabIconProps) => {
    const styles = StyleSheet.create({
        boundingBox: {
            flex: 1,
            height: 48,
            width: 60,
            borderRadius: 3,
            alignItems: "center",
            justifyContent: "center"
        },
        focused: {
            backgroundColor: color,
        },
        notFocused: {
            backgroundColor: Colors.screenBackground,
        }
    });

    return(
        <View style={[styles.boundingBox, focused ? styles.focused : styles.notFocused]}>
            <FontAwesome name={iconName} size={24} color={focused ? Colors.screenBackground : color}/>
        </View>
    )
}

const TabLayout = () => {
    const styles = StyleSheet.create({
        logo: {
            flex: 1,
            height: 100,
            resizeMode: "contain"
        }
    });

    const exercisesPlus = (event: GestureResponderEvent) => {

    }

    return (
        <Tabs
            screenOptions={{
                tabBarStyle: {
                    backgroundColor: Colors.screenBackground,
                    borderColor: Colors.screenBackground,
                    borderWidth: 0,
                    marginBottom: 10,
                    marginTop: 10,
                },
                headerStyle: {
                    backgroundColor: Colors.screenBackground,
                    borderColor: Colors.screenBackground,
                },
                headerTitleAlign: "center",
                headerShadowVisible: false,
                headerTitle: () => <Image style={styles.logo} source={logo} />,
                tabBarLabel: () => null,
                tabBarHideOnKeyboard: true
            }}
            sceneContainerStyle={{backgroundColor: Colors.screenBackground}}
        >
            <Tabs.Screen 
                name="exercises" 
                options={{
                    tabBarIcon: ({focused}) => <TabIcon focused={focused} iconName={"dumbbell"} color={Colors.fitsawBlue} />,
                    headerRight: () => <IconButton icon={<FontAwesome color={Colors.primaryText} size={16} name={"plus"} />} />
                }} 
            />
            <Tabs.Screen name="routines" options={{tabBarIcon: ({focused}) => <TabIcon focused={focused} iconName={"list"} color={Colors.fitsawRed} /> }} />
            <Tabs.Screen name="history" options={{tabBarIcon: ({focused}) => <TabIcon focused={focused} iconName={"history"} color={Colors.fitsawGreen} /> }} />
        </Tabs>
    );
}

export default TabLayout;