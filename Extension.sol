// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "@manifoldxyz/creator-core-solidity/contracts/core/IERC721CreatorCore.sol";
import "@manifoldxyz/creator-core-solidity/contracts/extensions/ICreatorExtensionTokenURI.sol";
import "@manifoldxyz/libraries-solidity/contracts/access/IAdminControl.sol";
import "@manifoldxyz/libraries-solidity/contracts/access/AdminControl.sol";
import "@manifoldxyz/creator-core-solidity/contracts/extensions/CreatorExtension.sol";
import "@openzeppelin/contracts/utils/Strings.sol";
import "@openzeppelin/contracts/utils/math/SafeMath.sol";
import "./IManifoldERC721Edition.sol";
import "./InvertebratesEngine_1.sol";
import "./InvertebratesEngine_2.sol";

library Base64 {
    /**
     * @dev Base64 Encoding/Decoding Table
     */
    string internal constant _TABLE = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";

    /**
     * @dev Converts a `bytes` to its Bytes64 `string` representation.
     */
    function encode(bytes memory data) internal pure returns (string memory) {
        /**
         * Inspired by Brecht Devos (Brechtpd) implementation - MIT licence
         * https://github.com/Brechtpd/base64/blob/e78d9fd951e7b0977ddca77d92dc85183770daf4/base64.sol
         */
        if (data.length == 0) return "";

        // Loads the table into memory
        string memory table = _TABLE;

        // Encoding takes 3 bytes chunks of binary data from `bytes` data parameter
        // and split into 4 numbers of 6 bits.
        // The final Base64 length should be `bytes` data length multiplied by 4/3 rounded up
        // - `data.length + 2`  -> Round up
        // - `/ 3`              -> Number of 3-bytes chunks
        // - `4 *`              -> 4 characters for each chunk
        string memory result = new string(4 * ((data.length + 2) / 3));

        /// @solidity memory-safe-assembly
        assembly {
            // Prepare the lookup table (skip the first "length" byte)
            let tablePtr := add(table, 1)

            // Prepare result pointer, jump over length
            let resultPtr := add(result, 32)

            // Run over the input, 3 bytes at a time
            for {
                let dataPtr := data
                let endPtr := add(data, mload(data))
            } lt(dataPtr, endPtr) {

            } {
                // Advance 3 bytes
                dataPtr := add(dataPtr, 3)
                let input := mload(dataPtr)

                // To write each character, shift the 3 bytes (18 bits) chunk
                // 4 times in blocks of 6 bits for each character (18, 12, 6, 0)
                // and apply logical AND with 0x3F which is the number of
                // the previous character in the ASCII table prior to the Base64 Table
                // The result is then added to the table to get the character to write,
                // and finally write it in the result pointer but with a left shift
                // of 256 (1 byte) - 8 (1 ASCII char) = 248 bits

                mstore8(resultPtr, mload(add(tablePtr, and(shr(18, input), 0x3F))))
                resultPtr := add(resultPtr, 1) // Advance

                mstore8(resultPtr, mload(add(tablePtr, and(shr(12, input), 0x3F))))
                resultPtr := add(resultPtr, 1) // Advance

                mstore8(resultPtr, mload(add(tablePtr, and(shr(6, input), 0x3F))))
                resultPtr := add(resultPtr, 1) // Advance

                mstore8(resultPtr, mload(add(tablePtr, and(input, 0x3F))))
                resultPtr := add(resultPtr, 1) // Advance
            }

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

        return result;
    }
}

//@author by andrew mitchell (andrewmitchell.eth)
//@shoutouts dom aka dhof (dhof.eth), white lights (whitelights.eth), yungwknd (yungwknd.eth), and chainleft (chainleft.eth) 

contract Invertebrates is  AdminControl, CreatorExtension, ICreatorExtensionTokenURI, IManifoldERC721Edition {
    using Strings for uint256;
    using SafeMath for uint256;
    InvertebratesEngine_1 invertebratesEngine_1;
    InvertebratesEngine_2 invertebratesEngine_2;

    uint256 public _maxSupply = 1000;
    uint256 public _price;
    uint256 public _totalSupply = 0;
    bool public _isPaused = false;
    bool public _useWhitelist = false;
    address public _creator;
    address public _owner;
    uint256 private _maxIndex;
    mapping(uint256 => string) public _moods;
    mapping(uint256 => uint256) public  _colors;
    mapping(uint256 => bytes32) public _hashes;
    mapping(uint256 => address) _whitelist;
    mapping(address => uint256) public _currentSeries;
    mapping(address => uint256) _walletsMinted;

    string[] public colorPalettes = ["8e0d00","c8c699","06142c","c7226c","740000","877b5d","e8d2a9","12151d","c4bf95","d32587","c5cab9","171b19","bc2c0e","790213","132e2b","952832","eb6521","e3d6c7","f7ebe3","000326","ededde","d72a2f","dcd7c7","d7d9c5","936b00","28762e","0b151f","a9dc97","82a5a0","ae9a6c","ba666b","c59e0c","2a3b2b","003283","d9cfa1","1f1912","1E6AE8","ccd1ad","2d92b0","1f2951","aa805c","131a13","a6e3a8","dbc7a6","577968","e3deb0","4f8465","4a5cff","dcdcc5","236264","021992","6fb157","d1c294","87cfe0","76a47f","021045","eddeb5","193573","699bac","4f6d97","112b73","40535e","8cd49e","357d76","dbd4c2","ad8129","c4bd99","c73200","47495f","e6ebdb","dbd4e0","113e76","7c613e","090d15","131e36","c09328","a8c2cc","bd928b","e8ebe0","d6deb3","ebe6cc","f2c7b0","ebe6d4","988264","0f1826","dbdebd","cfa400","ab0000","f2d6c4","a1ded4","7ea388","c6672f","3a4e20","885838","8b8981","e0e3d4","748a82","5c0300","d9c930","e0e6f0","2b5b7a","747029","faf0eb","151f42","1f5cff","121418","f5f0f5","b6101b","4a6d9b","f2f7c9","000a9b","b0baa6","d9ded6","1d1921"];
    string[] public moods = ["0","1","2","3","4","5","6","7","8","9","10","11","12","13","14","15","16","17","18","19","20","21","22","23","24","25","26"];
    string[] public _finalImageData;
    string private description =
        "Invertebrates by Andrew Mitchell (2024)";

    constructor(address owner, address creator, address invertebratesEngine_1_addr, address invertebratesEngine_2_addr) Ownable(owner)
    {
        
        _creator = creator;
        _owner = owner;
        invertebratesEngine_1 = InvertebratesEngine_1(invertebratesEngine_1_addr); 
        invertebratesEngine_2 = InvertebratesEngine_2(invertebratesEngine_2_addr); 

    }

    function supportsInterface(bytes4 interfaceId) public view virtual override(AdminControl, CreatorExtension, IERC165) returns (bool) {
        return interfaceId == type(ICreatorExtensionTokenURI).interfaceId || interfaceId == type(IManifoldERC721Edition).interfaceId || interfaceId == type(AdminControl).interfaceId ||
               CreatorExtension.supportsInterface(interfaceId);
    }

    function totalSupply() external view returns(uint256) {
        return _totalSupply;
    }

    function maxSupply() external view returns(uint256) {
        return _maxSupply;
    }

    function setPrice(uint256 price) external {
        require(msg.sender == _owner, "Unauthorized");
        _price = price;
    }
    
    function setPause(bool pause) external {
        require(msg.sender == _owner, "Unauthorized");
        _isPaused = pause;
    }
        
    function setUseWhitelist(bool useWhitelist) external {
        require(msg.sender == _owner, "Unauthorized");
        _useWhitelist = useWhitelist;
    }

    function setTotalSupply(uint256 totalSupply) external {
        require(msg.sender == _owner, "Unauthorized");
        _totalSupply = totalSupply;
    }

    function setWhitelist(uint256 index, address user) external {
        require(msg.sender == _owner, "Unauthorized");
        _whitelist[index] = user;
        if (index > _maxIndex) {
            _maxIndex = index;
        }
    }

    function getWhitelist() external view returns (address[] memory) {
        address[] memory whitelistAddresses = new address[](_maxIndex + 1);
        for (uint256 i = 0; i <= _maxIndex; i++) {
            whitelistAddresses[i] = _whitelist[i];
        }
        return whitelistAddresses;
    }
    function svgToURI(string memory svg) public pure returns (string memory) {
        return string(abi.encodePacked("data:image/svg+xml;base64,", Base64.encode(bytes(svg))));
    }

    function generateRandomValues(bytes32 _hash) public pure returns (uint256[2] memory) {
        uint256[2] memory randomValues;

        for (uint256 i = 0; i < 2; i++) {
            // Take one byte from the hash, convert it to a number between 0-100
            randomValues[i] = uint256(uint8(_hash[i])) % 101;
        }

        return randomValues;
    }

    function mint(address recipient) external payable {
        require(msg.sender == _owner, "Unauthorized");
        require(!_isPaused, "Sale has not started");
        require((_useWhitelist && _whitelist[_totalSupply] == recipient) || !_useWhitelist, "This token is not reserved for you.");
        require(msg.value >=_price, "Not enough ETH sent");
        require(_totalSupply < _maxSupply, "No more tokens left");
        require(_walletsMinted[recipient] < 5, "Max mint count reached");

        IERC721CreatorCore(_creator).mintExtension(recipient);
        _totalSupply++;
        _walletsMinted[recipient]++;
        bytes32 hash = keccak256(abi.encodePacked(block.timestamp, block.difficulty, blockhash(block.number - 1), recipient));
        _hashes[_totalSupply] =  hash;
        uint256[2] memory rands = generateRandomValues(hash);
        _colors[_totalSupply] = rands[0] * (colorPalettes.length / 101);
        _moods[_totalSupply] = moods[rands[1] * (moods.length / 101)];
    }

    function withdrawAll() public {
        require(msg.sender == _owner, "Unauthorized");
        require(payable(msg.sender).send(address(this).balance));
    }

    function setInvertebratesEngine_1(address addr) public {
        require(msg.sender == _owner, "Unauthorized");
        invertebratesEngine_1 = InvertebratesEngine_1(addr);
    }

    function setInvertebratesEngine_2(address addr) public {
        require(msg.sender == _owner, "Unauthorized");
        invertebratesEngine_2 = InvertebratesEngine_2(addr);
    }


    function setDescription(string memory des) public {
        require(msg.sender == _owner, "Unauthorized");
        description = des;
    }

    function setImageData(string[] memory img) public {
        require(msg.sender == _owner, "Unauthorized");
        _finalImageData = img;
    }

    function tokenURI(address creator,uint256 tokenId) public view virtual override returns (string memory) {
        return formatTokenURI(tokenId);
    }

    function formatTokenURI(uint256 tokenId) public view returns (string memory) {
        string memory _imageURI = svgToURI(invertebratesEngine_1.getSVGforThumbnail());
        string memory tokenIdStr = uint2str(tokenId);
        string memory colorPalette = colorPalettes[(_colors[tokenId])];
        string memory _animURI = animToURI(string(abi.encodePacked(
            invertebratesEngine_1.getAnimHeader(tokenIdStr),
            invertebratesEngine_2.getScriptHeader(tokenIdStr, uint2str(_colors[tokenId]), bytes32ToHex(_hashes[tokenId]), _moods[tokenId]),
            invertebratesEngine_1.getAnimFooter()
        )));
        string memory byteEncoded = Base64.encode(bytes(abi.encodePacked(
            '{"name": "Invertebrates #',
            tokenIdStr,
            '", "description": "_description", ',
            '"attributes":[{ "trait_type": "Mood", "value": "',
            _moods[tokenId],
            '" }, { "trait_type": "Color", "value": "',
            colorPalette,
             '" }], "image": "',
            _imageURI,
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