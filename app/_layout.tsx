import { Stack } from "expo-router";
import { Colors } from "../src/shared/styles/colors";
import { SQLiteProvider } from "expo-sqlite";
import { initDb } from "../src/shared/shared";
import { View } from "react-native";
import React from "react";
import { QueryClient, QueryClientProvider } from "@tanstack/react-query";
import { Snackbar, Logo, BackButton } from "../src/shared/components/components";
import { GestureHandlerRootView } from "react-native-gesture-handler";

const queryClient = new QueryClient();

const RootLayout = () => {
    return (
        <SQLiteProvider databaseName="fitsaw.db" onInit={initDb}>
            <QueryClientProvider client={queryClient}>
                <GestureHandlerRootView>
                    <Stack
                        screenOptions={
                            {
                                headerTintColor: Colors.primaryText,
                                contentStyle: {
                                    backgroundColor: Colors.screenBackground,
                                    borderColor: Colors.screenBackground,
                                },
                                headerBackTitleVisible: false,
                                headerBackVisible: false,
                                headerLeft: () => <View style={{marginLeft: -16, marginRight: 16 }}><BackButton /></View>
                            }
                        }
                    >
                        <Stack.Screen name="(tabs)" options={{headerShown: false}}/>
                        <Stack.Screen 
                            name="view_exercise/index" 
                            options={{
                                headerStyle: {
                                    backgroundColor: Colors.screenBackground,
                                },
                                headerTitleAlign: "center",
                                headerShadowVisible: false,
                                headerTitle: () => <Logo />
                            }}
                        />
                        <Stack.Screen 
                            name="view_exercise/[id]" 
                            options={{
                                headerStyle: {
                                    backgroundColor: Colors.screenBackground,
                                },
                                headerTitleAlign: "center",
                                headerShadowVisible: false,
                                headerTitle: () => <Logo />
                            }}
                        />
                        <Stack.Screen 
                            name="view_routine/index" 
                            options={{
                                headerStyle: {
                                    backgroundColor: Colors.screenBackground,
                                },
                                headerTitleAlign: "center",
                                headerShadowVisible: false,
                                headerTitle: () => <Logo />
                            }}
                        />
                        <Stack.Screen 
                            name="view_routine/[id]" 
                            options={{
                                headerStyle: {
                                    backgroundColor: Colors.screenBackground,
                                },
                                headerTitleAlign: "center",
                                headerShadowVisible: false,
                                headerTitle: () => <Logo />
                            }}
                        />
                        <Stack.Screen 
                            name="active_routine/[id]" 
                            options={{
                                headerStyle: {
                                    backgroundColor: Colors.screenBackground,
                                },
                                headerTitleAlign: "center",
                                headerShadowVisible: false,
                                headerTitle: () => <Logo />
                            }}
                        />
                    </Stack>
                    <Snackbar />
                </GestureHandlerRootView>
            </QueryClientProvider>
        </SQLiteProvider>
    );
}

export default RootLayout;