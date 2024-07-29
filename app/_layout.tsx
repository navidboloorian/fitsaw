import { Stack } from "expo-router";
import { Colors } from "../src/shared/styles/colors";
import { SQLiteProvider } from "expo-sqlite";
import { initDb } from "../src/shared/database";
import { View } from "react-native";
import Logo from "../src/shared/components/Logo";
import React from "react";
import BackButton from "../src/shared/components/BackButton";
import { QueryClient, QueryClientProvider } from "@tanstack/react-query";

const queryClient = new QueryClient();

const RootLayout = () => {
    return (
        <SQLiteProvider databaseName="fitsaw.db" onInit={initDb}>
            <QueryClientProvider client={queryClient}>
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
                        name="create_exercise/index" 
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
            </QueryClientProvider>
        </SQLiteProvider>
    );
}

export default RootLayout;