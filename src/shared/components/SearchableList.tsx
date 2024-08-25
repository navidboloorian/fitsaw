import { useState } from "react";
import { Pressable, Dimensions } from "react-native";
import { router, useFocusEffect } from "expo-router";
import { useQueryClient } from "@tanstack/react-query";
import { Exercise } from "../../features/view_exercise/model/model";
import { Loading } from "./Loading";
import { FitsawError } from "../globals";
import { Routine } from "../../features/view_routine/model/model";
import { SearchBar } from "./SearchBar";
import { Spacer } from "./Spacer";
import { BackgroundBox } from "./BackgroundBox";
import { FitsawText } from "./FitsawText";
import { TagList } from "./TagList";
import { Colors } from "../styles/colors";
import { SwipeListView }  from "react-native-swipe-list-view";
import { DeleteBackground } from "./DeleteBackground";

type SearchableListProps = {
    queryFn: any,
    queryKey: string,
    mutation: any,
    searchPlaceholder: string,
    viewItemPath: string,
    errorMessage: string,
}

export const SearchableList = ({queryFn, mutation, searchPlaceholder, viewItemPath, errorMessage} : SearchableListProps) => {
    const [searchQuery, setSearchQuery] = useState("");
    const [selectedItem, setSelectedItem] = useState<number | undefined>(undefined);
    const query = queryFn;

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
            <SwipeListView
                previewRowIndex={0}
                data={dataList}
                extraData={selectedItem}
                closeOnScroll
                recalculateHiddenLayout
                disableRightSwipe
                renderItem={({item, index}) => 
                    (
                        <Pressable
                            onPress={() => {
                                const id = item.id;
                                router.navigate({pathname: viewItemPath, params: {id}});
                            }} 
                            onLongPress={() => setSelectedItem(index)}
                        >
                            <BackgroundBox color={index === selectedItem ? Colors.fitsawRed : Colors.boxBackground1} style={{width: "90%"}}>
                                <FitsawText>{item.name}</FitsawText>
                                {item.tags.length > 0 ? <Spacer height={5} /> : <></>}
                                <TagList tags={item.tags} />
                            </BackgroundBox>
                        </Pressable>
                    )
                }
                renderHiddenItem={() => <DeleteBackground />}
                swipeGestureEnded={(rowKey, data) => {
                    if (Math.abs(data.translateX) > Dimensions.get("window").width * 0.5) deleteMutation.mutate(rowKey);
                }}
                keyExtractor={(item : Routine | Exercise) => item.id!.toString()}
                ItemSeparatorComponent={() => <Spacer height={10} />}
            />
        </>
    );
}