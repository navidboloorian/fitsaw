import { Pressable, FlatList, View, TextInput } from "react-native";
import { BackgroundBox, Collapsible, FitsawText, Spacer } from "../../../shared/components/components";
import { Colors } from "../../../shared/styles/colors";

export const RoutineExerciseCard = () => {
    return (
        <BackgroundBox color={Colors.boxBackground2} style={{width: "100%"}}>
            <Collapsible 
                header={<FitsawText bold>Title</FitsawText>} 
                body={
                    <>
                        <View style={{flexDirection: "row", alignItems: "center"}}>
                            <TextInput maxLength={2} placeholder="0" placeholderTextColor={Colors.secondaryText} style={{color: Colors.primaryText}}/><FitsawText>Rest</FitsawText><Spacer width={10} />
                            <TextInput maxLength={2} placeholder="0" placeholderTextColor={Colors.secondaryText} style={{color: Colors.primaryText}}/><Spacer width={10} /><FitsawText>Sets</FitsawText>
                        </View>
                        <FlatList 
                            data={[12, 1]}
                            renderItem={({item}) => (
                                <View style={{flexDirection: "row", justifyContent: "space-between", alignItems: "center"}}>
                                    <FitsawText>Set</FitsawText>
                                    <View style={{flexDirection: "row", alignItems: "center"}}>
                                        <TextInput maxLength={2} placeholder="0" placeholderTextColor={Colors.secondaryText} style={{color: Colors.primaryText}}/>
                                        <FitsawText>Reps</FitsawText>
                                    </View>
                                </View>
                            )
                        }
                        />
                    </>
                }
            />
            
        </BackgroundBox>
    );
}