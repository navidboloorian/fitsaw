import { useState } from "react";
import { useQuery } from "@tanstack/react-query";
import { FlatList, Pressable } from "react-native";
import { SQLiteDatabase, useSQLiteContext } from "expo-sqlite";
import { router, useFocusEffect } from "expo-router";
import { useQueryClient, useMutation } from "@tanstack/react-query";
import { Exercise } from "../../features/view_exercise/model/model";
import { Loading } from "./Loading";
import { FitsawError } from "../globals";
import { Routine } from "../../features/view_routine/model/model";
import { SearchBar } from "./SearchBar";
import { Spacer } from "./Spacer";
import { Dismissible } from "./Dismissible";
import { BackgroundBox } from "./BackgroundBox";
import { FitsawText } from "./FitsawText";
import { TagList } from "./TagList";

type SearchableListProps = {
    queryFn: any,
    queryKey: string,
    mutation: any,
    searchPlaceholder: string,
    viewItemPath: string,
    errorMessage: string,
}

export const SearchableList = ({queryFn, queryKey, mutation, searchPlaceholder, viewItemPath, errorMessage} : SearchableListProps) => {
    const db = useSQLiteContext();
    const queryClient = useQueryClient();
    const [searchQuery, setSearchQuery] = useState("");
    const query = queryFn;

    useFocusEffect(() => {
        // ensures that list is refetched everytime it loads anew
        queryClient.refetchQueries({queryKey: [queryKey]});
    });

    const deleteMutation = mutation;

    if (query.isLoading) {
        return <Loading />;
    }

    if (query.isError) {
        throw new FitsawError({name: "QUERY_ERROR", message: errorMessage});
    }

    // narrow down list based on search query
    const dataList = query.data!.filter((item : Routine | Exercise) => {
        if (item.name.toLowerCase().includes(searchQuery.toLowerCase())) return true;

        for (const tag of item.tags) {
            if (tag.toLowerCase().includes(searchQuery.toLowerCase())) return true;
        }

        return false;
    });

    return (
        <>
            <SearchBar searchQuery={searchQuery} setSearchQuery={setSearchQuery} placeholder={searchPlaceholder} />
            <Spacer height={10} />
            <FlatList
                data={dataList}
                renderItem={({item}) => 
                    (
                        <Dismissible 
                            onDismiss={() => deleteMutation.mutate(item.id!)}
                        >
                            <Pressable
                                onPress={() => {
                                    const id = item.id;
                                    router.navigate({pathname: viewItemPath, params: {id}});
                                }} 
                            >
                                <BackgroundBox style={{width: "100%"}}>
                                    <FitsawText>{item.name}</FitsawText>
                                    {item.tags.length > 0 ? <Spacer height={5} /> : <></>}
                                    <TagList tags={item.tags} />
                                </BackgroundBox>
                            </Pressable>
                        </Dismissible>
                    )
                }
                keyExtractor={(item : Routine | Exercise) => item.id!.toString()}
                ItemSeparatorComponent={() => <Spacer height={10} />}
            />
        </>
    );
}