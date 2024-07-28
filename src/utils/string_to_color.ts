import { Colors } from "../shared/styles/colors";

const stringToColor = (text: string) => {
    const colors = [
        Colors.fitsawBlue, Colors.fitsawGreen, Colors.fitsawOrange, Colors.fitsawPurple, Colors.fitsawRed
    ];

    let hash = 0;

    for (let i = 0; i < text.length; i++) {
        hash += text[i].charCodeAt(0);
    }

    return colors[hash % 5];
}

export default stringToColor;