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

    function clearEntries() public onlyAuthorized {
        delete entries;
    }


    //Wraps the entries into table rows for injecting into the animation url's HTML.
    function getEntriesHTML() external view returns (string memory) {
        string memory html;

        for (uint256 i = 0; i < entries.length; i++) {
            html = string(abi.encodePacked(
                html,
                "<tr class=\"table-row light-bg light-border light-text\">",
                "<td class=\"light-bg\" width=\"30%\" align=\"center\">",
                "<font class=\"small_text\">",
                "<a class=\"light-link\" target=\"_blank\" href=\"",
                tjoUrl,
                "\">Tjo</a>",
                "<font></font></font></td>",
                "<td align=\"right\" width=\"70%\" class=\"light-bg light-link\">",
                "<div class=\"postInfo desktop\">",
                "<span class=\"postNum desktop\">",
                "<a class=\"light-link\" style=\"font-size:12px;\" href=\"",
                etherscanUrl,
                entries[i].hash,
                "\" target=\"_blank\" title=\"Link to this transaction\">",
                entries[i].formattedTime,
                "</a></span></div></td></tr>",
                "<tr><td valign=\"middle\" align=\"left\" class=\"light-bg\">",
                "<ul align=\"left\" style=\"padding-left: 15px;font-size: 10px;\">",
                "<li class=\"light-text-3\">Block: ",
                entries[i].blockNumber,
                "</li><li class=\"light-text-3\">Location: UNKNOWN</li></ul></td>",
                "<td align=\"center\" valign=\"middle\" class=\"light-bg\">",
                "<font class=\"regular_text\">",
                "<div class=\"post reply\">",
                "<blockquote style=\"white-space: pre-line;margin-top:0px;\" class=\"postMessage light-text-2\" id=\"m34079983\"><br>",
                entries[i].text,
                "</blockquote></div></font></td></tr>"
            ));
        }

        return html;
    }

    function getTotalEntries() external view returns (string memory) {
        return uintToString(entries.length);
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
        return keccak256(abi.encodePacked(mode)) == keccak256(abi.encodePacked("0")) ? "light" : "dark";
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