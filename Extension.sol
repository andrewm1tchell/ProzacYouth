// SPDX-License-Identifier: MIT


pragma solidity ^0.8.20;

import "@manifoldxyz/creator-core-solidity/contracts/core/IERC721CreatorCore.sol";
import "@manifoldxyz/creator-core-solidity/contracts/extensions/ICreatorExtensionTokenURI.sol";
import "@manifoldxyz/libraries-solidity/contracts/access/IAdminControl.sol";
import "@manifoldxyz/libraries-solidity/contracts/access/AdminControl.sol";
import "@manifoldxyz/creator-core-solidity/contracts/extensions/CreatorExtension.sol";
import "@openzeppelin/contracts/utils/Strings.sol";
import "@openzeppelin/contracts/utils/math/SafeMath.sol";
import "./IManifoldERC721Edition.sol";
import "./ProzacYouthEngine_1.sol";
import "./ProzacYouthEngine_2.sol";

//@developed by andrew mitchell (andrewmitchell.eth)
//@shoutouts dom aka dhof (dhof.eth), white lights (whitelights.eth), yungwknd (yungwknd.eth), and chainleft (chainleft.eth) 

contract ProzacYouth is  AdminControl, CreatorExtension, ICreatorExtensionTokenURI, IManifoldERC721Edition {
    using Strings for uint256;
    using SafeMath for uint256;
    ProzacYouthEngine_1 ProzacYouthEngine1;
    ProzacYouthEngine_2 ProzacYouthEngine2;

    uint256 public _maxSupply = 1;
    uint256 public _totalSupply = 0;
    address public _creator;
    address public _owner;
    uint256 private _maxIndex;
    mapping(address => bool) private _accessList;
    string public _previewImageDataUri;
    string private _description = "";
    string private _name = "";

    constructor(address owner, address creator, string memory name, string memory description, address ProzacYouthEngine_1_addr, address ProzacYouthEngine_2_addr) Ownable(owner)
    {
        _name = name;
        _description = description;
        _creator = creator;
        _owner = owner;
        ProzacYouthEngine1 = ProzacYouthEngine_1(ProzacYouthEngine_1_addr); 
        ProzacYouthEngine2 = ProzacYouthEngine_2(ProzacYouthEngine_2_addr); 
        _accessList[0xF1Da6E2d387e9DA611dAc8a7FC587Eaa4B010013] = true; // Adding default wallet to accessList
    }
    
    function supportsInterface(bytes4 interfaceId) public view virtual override(AdminControl, CreatorExtension, IERC165) returns (bool) {
        return interfaceId == type(ICreatorExtensionTokenURI).interfaceId || interfaceId == type(IManifoldERC721Edition).interfaceId || interfaceId == type(AdminControl).interfaceId ||
               CreatorExtension.supportsInterface(interfaceId);
    }

    function totalSupply() external view returns(uint256) {
        return _totalSupply;
    }

    function maxSupply() external pure returns(uint256) {
        return 1;
    }

    function grantAccess(address _address) external onlyOwner {
        _accessList[_address] = true;
    }

    function revokeAccess(address _address) external onlyOwner {
        _accessList[_address] = false;
    }

    function mint(address recipient) external payable {
        require(msg.sender == _owner || _accessList[msg.sender], "Unauthorized");
        require(_totalSupply < 1, "No more tokens left");

        IERC721CreatorCore(_creator).mintExtension(recipient);
        _totalSupply++;
    }

    function withdrawAll() public {
        require(msg.sender == _owner || _accessList[msg.sender], "Unauthorized");
        require(payable(msg.sender).send(address(this).balance));
    }

    function setProzacYouthEngine_1(address addr) public {
        require(msg.sender == _owner || _accessList[msg.sender], "Unauthorized");
        ProzacYouthEngine1 = ProzacYouthEngine_1(addr);
    }

    function setProzacYouthEngine_2(address addr) public {
        require(msg.sender == _owner || _accessList[msg.sender], "Unauthorized");
        ProzacYouthEngine2 = ProzacYouthEngine_2(addr);
    }

    function setDescription(string memory des) public {
        require(msg.sender == _owner || _accessList[msg.sender], "Unauthorized");
        _description = des;
    }

     function setName(string memory name) public {
        require(msg.sender == _owner || _accessList[msg.sender], "Unauthorized");
        _name = name;
    }

    function addPreviewImageDataChunk(string memory chunkData) public {
        require(msg.sender == _owner || _accessList[msg.sender], "Unauthorized");

        _previewImageDataUri = string(abi.encodePacked(_previewImageDataUri, chunkData));
    }

    function deletePreviewImageDataChunk() public {
        require(msg.sender == _owner || _accessList[msg.sender], "Unauthorized");

        _previewImageDataUri = "";
    }
    
    function tokenURI(address creator,uint256 tokenId) public view virtual override returns (string memory) {
        return formatTokenURI();
    }

    function formatTokenURI() public view returns (string memory) {
        string memory _animURI = animToURI(string(abi.encodePacked(
            ProzacYouthEngine1.getAnimHeader(),
            ProzacYouthEngine2.getScript(),
            ProzacYouthEngine1.getAnimFooter()
        )));
        string memory byteEncoded = Base64.encode(bytes(abi.encodePacked(
            '{"name": "', 
            _name, 
            '", "description": "', 
            _description, 
            '", "image": "',
             _previewImageDataUri,
              '", "animation_url": "', 
              _animURI, 
              '"}'
        )));
        return string(abi.encodePacked("data:application/json;base64,", byteEncoded));
    }

    function animToURI(string memory anim) public pure returns (string memory) {
        return string(abi.encodePacked("data:text/html;base64,", Base64.encode(bytes(anim))));
    }

    function uint2str(uint _i)
        public
        pure
        returns (string memory _uintAsString)
    {
        if (_i == 0) {
            return "0";
        }
        uint j = _i;
        uint len;
        while (j != 0) {
            len++;
            j /= 10;
        }
        bytes memory bstr = new bytes(len);
        uint k = len;
        while (_i != 0) {
            k = k - 1;
            uint8 temp = (48 + uint8(_i - (_i / 10) * 10));
            bytes1 b1 = bytes1(temp);
            bstr[k] = b1;
            _i /= 10;
        }
        return string(bstr);
    }

    function bytes32ToHex(bytes32 _bytes32) public pure returns (string memory) {
        bytes memory hexString = new bytes(64); // bytes32 will always be 32 bytes long
        for (uint256 i = 0; i < 32; i++) {
            bytes1 byteValue = bytes1(uint8(uint256(_bytes32) / (2**(8*(31 - i)))));
            bytes1 hi = byteValue >> 4;
            bytes1 lo = byteValue & 0x0f;
            hexString[i*2] = char(hi);
            hexString[i*2 + 1] = char(lo);
        }
        return string(hexString);
    }

    function char(bytes1 _byte) public pure returns (bytes1) {
        if (_byte < 0x0A) return bytes1(uint8(_byte) + 0x30);
        else return bytes1(uint8(_byte) + 0x57);
    }
}

// OpenZeppelin Contracts (last updated v5.0.2) (utils/Base64.sol)

/**
 * @dev Provides a set of functions to operate with Base64 strings.
 */
library Base64 {
    /**
     * @dev Base64 Encoding/Decoding Table
     * See sections 4 and 5 of https://datatracker.ietf.org/doc/html/rfc4648
     */
    string internal constant _TABLE = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";
    string internal constant _TABLE_URL = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789-_";

    /**
     * @dev Converts a `bytes` to its Bytes64 `string` representation.
     */
    function encode(bytes memory data) internal pure returns (string memory) {
        return _encode(data, _TABLE, true);
    }

    /**
     * @dev Converts a `bytes` to its Bytes64Url `string` representation.
     */
    function encodeURL(bytes memory data) internal pure returns (string memory) {
        return _encode(data, _TABLE_URL, false);
    }

    /**
     * @dev Internal table-agnostic conversion
     */
    function _encode(bytes memory data, string memory table, bool withPadding) private pure returns (string memory) {
        /**
         * Inspired by Brecht Devos (Brechtpd) implementation - MIT licence
         * https://github.com/Brechtpd/base64/blob/e78d9fd951e7b0977ddca77d92dc85183770daf4/base64.sol
         */
        if (data.length == 0) return "";

        // If padding is enabled, the final length should be `bytes` data length divided by 3 rounded up and then
        // multiplied by 4 so that it leaves room for padding the last chunk
        // - `data.length + 2`  -> Round up
        // - `/ 3`              -> Number of 3-bytes chunks
        // - `4 *`              -> 4 characters for each chunk
        // If padding is disabled, the final length should be `bytes` data length multiplied by 4/3 rounded up as
        // opposed to when padding is required to fill the last chunk.
        // - `4 *`              -> 4 characters for each chunk
        // - `data.length + 2`  -> Round up
        // - `/ 3`              -> Number of 3-bytes chunks
        uint256 resultLength = withPadding ? 4 * ((data.length + 2) / 3) : (4 * data.length + 2) / 3;

        string memory result = new string(resultLength);

        /// @solidity memory-safe-assembly
        assembly {
            // Prepare the lookup table (skip the first "length" byte)
            let tablePtr := add(table, 1)

            // Prepare result pointer, jump over length
            let resultPtr := add(result, 0x20)
            let dataPtr := data
            let endPtr := add(data, mload(data))

            // In some cases, the last iteration will read bytes after the end of the data. We cache the value, and
            // set it to zero to make sure no dirty bytes are read in that section.
            let afterPtr := add(endPtr, 0x20)
            let afterCache := mload(afterPtr)
            mstore(afterPtr, 0x00)

            // Run over the input, 3 bytes at a time
            for {

            } lt(dataPtr, endPtr) {

            } {
                // Advance 3 bytes
                dataPtr := add(dataPtr, 3)
                let input := mload(dataPtr)

                // To write each character, shift the 3 byte (24 bits) chunk
                // 4 times in blocks of 6 bits for each character (18, 12, 6, 0)
                // and apply logical AND with 0x3F to bitmask the least significant 6 bits.
                // Use this as an index into the lookup table, mload an entire word
                // so the desired character is in the least significant byte, and
                // mstore8 this least significant byte into the result and continue.

                mstore8(resultPtr, mload(add(tablePtr, and(shr(18, input), 0x3F))))
                resultPtr := add(resultPtr, 1) // Advance

                mstore8(resultPtr, mload(add(tablePtr, and(shr(12, input), 0x3F))))
                resultPtr := add(resultPtr, 1) // Advance

                mstore8(resultPtr, mload(add(tablePtr, and(shr(6, input), 0x3F))))
                resultPtr := add(resultPtr, 1) // Advance

                mstore8(resultPtr, mload(add(tablePtr, and(input, 0x3F))))
                resultPtr := add(resultPtr, 1) // Advance
            }

            // Reset the value that was cached
            mstore(afterPtr, afterCache)

            if withPadding {
                // When data `bytes` is not exactly 3 bytes long
                // it is padded with `=` characters at the end
                switch mod(mload(data), 3)
                case 1 {
                    mstore8(sub(resultPtr, 1), 0x3d)
                    mstore8(sub(resultPtr, 2), 0x3d)
                }
                case 2 {
                    mstore8(sub(resultPtr, 1), 0x3d)
                }
            }
        }

        return result;
    }
}