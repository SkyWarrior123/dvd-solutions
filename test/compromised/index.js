const { ethers } = require("ethers");
const atob = require("atob");

function hexToAscii(hexStr) {
    let asciiStr = "";
    for (let i = 0; i < hexStr.length; i += 2) {
        asciiStr += String.fromCharCode(parseInt(hexStr.substr(i, 2), 16));
    }
    return asciiStr;
}

const leakedInformation = [
    "4d4867335a444531596d4a684d6a5a6a4e54497a4e6a677a596d5a6a4d32526a4e324e6b597a566b4d574934595449334e4451304e4463314f54646a5a6a526b595445334d44566a5a6a5a6a4f546b7a4d44597a4e7a5130",
    "4d4867324f474a6b4d444977595751784f445a694e6a5133595459354d574d325954566a4d474d784e5449355a6a49785a574e6b4d446c6b59324d304e5449304d5451774d6d466a4e6a426959544d334e324d304d545535"
];

leakedInformation.forEach((hexStr) => {
    const asciiStr = hexToAscii(hexStr);
    const decodedStr = atob(asciiStr);
    const privateKey = decodedStr.startsWith("0x") ? decodedStr : "0x" + decodedStr;  // Fix here

    console.log("Private Key:", privateKey);

    try {
        const wallet = new ethers.Wallet(privateKey);
        console.log("Wallet address:", wallet.address);
    } catch (error) {
        console.error("Error creating wallet:", error.message);
    }
});
