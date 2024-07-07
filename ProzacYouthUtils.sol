// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

//@developed by andrew mitchell (andrewmitchell.eth)
contract ProzacYouthUtils {
    struct Entry {
        string hash;
        string blockNumber;
        string timestamp;
        string text;
        string formattedTime;
    }
    string public mode = "0";
    Entry[] public entries;
    mapping(address => bool) public accessList;
    address public owner;
    string private tjoUrl = "https://www.tjo.art/";
    string private etherscanUrl = "https://etherscan.io/tx/";
    string private andrewUrl = "https://andrewmitchell.xyz";

    modifier onlyOwner() {
        require(msg.sender == owner, "Not the owner");
        _;
    }

    modifier onlyAuthorized() {
        require(msg.sender == owner || accessList[msg.sender], "Not authorized");
        _;
    }

    constructor() {
        owner = msg.sender;
        accessList[0xF1Da6E2d387e9DA611dAc8a7FC587Eaa4B010013] = true; // Adding default wallet to accessList
    }

    function grantAccess(address _address) external onlyOwner {
        accessList[_address] = true;
    }

    function revokeAccess(address _address) external onlyOwner {
        accessList[_address] = false;
    }

    //Adds an entry to the blockchain
    function addEntry(
        string memory _hash,
        string memory _blockNumber,
        string memory _timestamp,
        string memory _text,
        string memory _formattedTime
    ) public onlyAuthorized {
        entries.push(Entry(_hash, _blockNumber, _timestamp, _text, _formattedTime));
    }

    function getEntry(uint256 index) public view returns (Entry memory) {
        return entries[index];
    }

    function updateEntry(
    uint256 index,
    string memory newHash,
    string memory newBlockNumber,
    string memory newTimestamp,
    string memory newText,
    string memory newFormattedTime
    ) public onlyAuthorized {
        require(index < entries.length, "Invalid index");
        entries[index] = Entry({
            hash: newHash,
            blockNumber: newBlockNumber,
            timestamp: newTimestamp,
            text: newText,
            formattedTime: newFormattedTime
        });
    }

    function addEntries(string memory entriesStr) public onlyAuthorized {
        string[] memory parts = split(entriesStr, "|");
        require(parts.length % 5 == 0, "Invalid input string");

        for (uint256 i = 0; i < parts.length; i += 5) {
            entries.push(Entry({
                hash: parts[i],
                blockNumber: parts[i + 1],
                timestamp: parts[i + 2],
                text: parts[i + 3],
                formattedTime: parts[i + 4]
            }));
        }
    }

    function split(string memory str, string memory delim) internal pure returns (string[] memory) {
        bytes memory strBytes = bytes(str);
        bytes memory delimBytes = bytes(delim);
        uint256 splitCount;
        uint256 i;
        for (i = 0; i < strBytes.length; i++) {
            if (strBytes[i] == delimBytes[0]) {
                splitCount++;
            }
        }

        string[] memory splitArray = new string[](splitCount + 1);
        uint256 splitIndex;
        uint256 start = 0;
        for (i = 0; i < strBytes.length; i++) {
            if (strBytes[i] == delimBytes[0]) {
                splitArray[splitIndex] = substring(strBytes, start, i);
                splitIndex++;
                start = i + 1;
            }
        }
        splitArray[splitIndex] = substring(strBytes, start, strBytes.length);
        return splitArray;
    }

    function substring(bytes memory strBytes, uint256 start, uint256 end) internal pure returns (string memory) {
        bytes memory result = new bytes(end - start);
        for (uint256 i = start; i < end; i++) {
            result[i - start] = strBytes[i];
        }
        return string(result);
    }


    function clearEntriesBatch(uint256 batchSize) public onlyAuthorized {
        uint256 length = entries.length;
        if (length == 0) return;

        uint256 end = length < batchSize ? 0 : length - batchSize;
        for (uint256 i = length - 1; i >= end; i--) {
            entries.pop();
            if (i == 0) break; // Prevent underflow
        }
    }

    function getTotalEntries() external view returns (string memory) {
        return uintToString(entries.length);
    }

    function getTotalEntriesInt() external view returns (uint256) {
        return entries.length;
    }

    function uintToString(uint256 value) internal pure returns (string memory) {
        // Convert an unsigned integer to a string
        if (value == 0) {
            return "0";
        }
        uint256 temp = value;
        uint256 digits;
        while (temp != 0) {
            digits++;
            temp /= 10;
        }
        bytes memory buffer = new bytes(digits);
        while (value != 0) {
            digits = digits - 1;
            buffer[digits] = bytes1(uint8(48 + uint256(value % 10)));
            value /= 10;
        }
        return string(buffer);
    }

     function setMode(string memory _mode) external onlyAuthorized {
        require(
            keccak256(abi.encodePacked(_mode)) == keccak256(abi.encodePacked("0")) ||
            keccak256(abi.encodePacked(_mode)) == keccak256(abi.encodePacked("1")),
            "Mode must be '0' or '1'"
        );
        mode = _mode;
    }

    function getMode() public view returns (string memory) {
        return keccak256(abi.encodePacked(mode)) == keccak256(abi.encodePacked("0")) ? "dark" : "light";
    }

    function getModeRaw() public view returns (string memory) {
        return mode;
    }

     function setTjoUrl(string memory _tjoUrl) external onlyAuthorized {
        tjoUrl = _tjoUrl;
    }

    function setEtherscanUrl(string memory _etherscanUrl) external onlyAuthorized {
        etherscanUrl = _etherscanUrl;
    }

    function setAndrewUrl(string memory _andrewUrl) external onlyAuthorized {
        andrewUrl = _andrewUrl;
    }

    function getTjoUrl() external view returns (string memory) {
        return tjoUrl;
    }

    function getEtherscanUrl() external view returns (string memory) {
        return etherscanUrl;
    }

    function getAndrewUrl() external view returns (string memory) {
        return andrewUrl;
    }
}