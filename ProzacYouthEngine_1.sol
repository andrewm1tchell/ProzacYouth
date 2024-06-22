// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract ProzacYouthEngine_1 {
    function getAnimHeader(string memory andrewUrl) public view returns (string memory) {
         return 
            string(abi.encodePacked("<!doctypehtml><html lang=en><meta content='text/html; charset=UTF-8'http-equiv=Content-Type><meta content='width=device-width,initial-scale=1'name=viewport><meta content='ie=edge'http-equiv=X-UA-Compatible><meta developer='Andrew Mitchell'><title>Prozac Youth</title>"));
    }

    function getAnimFooter() public pure returns (string memory) {
        return "<body></body></html>";
    }
}