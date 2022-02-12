// SPDX-License-Identifier: MIT

pragma solidity ^0.8.4;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract NftSvg is ERC721, ERC721Enumerable, Ownable {
    // Public Variables
    address public contractOwner;

    // Constants
    string internal constant TABLE = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/';

    // Interface Overrrides
    /**
    *
    */
    function _beforeTokenTransfer(
    address from,
    address to,
    uint256 tokenId
    ) internal override(ERC721, ERC721Enumerable) {
        super._beforeTokenTransfer(from, to, tokenId);
    }

    /**
    *
    */
    function supportsInterface(bytes4 interfaceId) public view override(ERC721, ERC721Enumerable) returns (bool) {
        return super.supportsInterface(interfaceId);
    }

    /**
    *
    */
    constructor() ERC721("NftSvg", "NFS") {
        contractOwner = msg.sender;
    }

    /**
     */
    /**
     * Inspired by OraclizeAPI's implementation - MIT license
     * https://github.com/oraclize/ethereum-api/blob/b42146b063c7d6ee1358846c198246239e9360e8/oraclizeAPI_0.4.25.sol
     */
    function toString(uint256 value) internal pure returns (string memory) {
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
            digits -= 1;
            buffer[digits] = bytes1(uint8(48 + uint256(value % 10)));
            value /= 10;
        }
        return string(buffer);
    }

    /**
     */
    function base64Encode(bytes memory data) internal pure returns (string memory) {
        if (data.length == 0) return '';
        
        // load the table into memory
        string memory table = TABLE;

        // multiply by 4/3 rounded up
        uint256 encodedLen = 4 * ((data.length + 2) / 3);

        // add some extra buffer at the end required for the writing
        string memory result = new string(encodedLen + 32);

        assembly {
            // set the actual output length
            mstore(result, encodedLen)
            
            // prepare the lookup table
            let tablePtr := add(table, 1)
            
            // input ptr
            let dataPtr := data
            let endPtr := add(dataPtr, mload(data))
            
            // result ptr, jump over length
            let resultPtr := add(result, 32)
            
            // run over the input, 3 bytes at a time
            for {} lt(dataPtr, endPtr) {}
            {
               dataPtr := add(dataPtr, 3)
               
               // read 3 bytes
               let input := mload(dataPtr)
               
               // write 4 characters
               mstore(resultPtr, shl(248, mload(add(tablePtr, and(shr(18, input), 0x3F)))))
               resultPtr := add(resultPtr, 1)
               mstore(resultPtr, shl(248, mload(add(tablePtr, and(shr(12, input), 0x3F)))))
               resultPtr := add(resultPtr, 1)
               mstore(resultPtr, shl(248, mload(add(tablePtr, and(shr( 6, input), 0x3F)))))
               resultPtr := add(resultPtr, 1)
               mstore(resultPtr, shl(248, mload(add(tablePtr, and(        input,  0x3F)))))
               resultPtr := add(resultPtr, 1)
            }
            
            // padding with '='
            switch mod(mload(data), 3)
            case 1 { mstore(sub(resultPtr, 2), shl(240, 0x3d3d)) }
            case 2 { mstore(sub(resultPtr, 1), shl(248, 0x3d)) }
        }
        
        return result;
    }

    /**
     * Inspired by Java code
     * Converts a decimal value to a hex value without the #
     */
    function uintToHex (uint256 decimalValue) pure public returns (bytes memory) {
        uint remainder;
        bytes memory hexResult = "";
        string[16] memory hexDictionary = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "A", "B", "C", "D", "E", "F"];

        while (decimalValue > 0) {
            remainder = decimalValue % 16;
            string memory hexValue = hexDictionary[remainder];
            hexResult = abi.encodePacked(hexValue, hexResult);
            decimalValue = decimalValue / 16;
        }
        
        // Account for missing leading zeros
        uint len = hexResult.length;

        if (len == 5) {
            hexResult = abi.encodePacked("0", hexResult);
        } else if (len == 4) {
            hexResult = abi.encodePacked("00", hexResult);
        } else if (len == 3) {
            hexResult = abi.encodePacked("000", hexResult);
        } else if (len == 4) {
            hexResult = abi.encodePacked("0000", hexResult);
        }

        return hexResult;
    }

    /**
    * Returns metadata associated to token
    */
    function tokenURI(uint256 tokenId) public view override returns (string memory) {
        // Validate if tokenId exists
        require(_exists(tokenId), "Token ID does not exist.");
        
        string memory hexValue = string(uintToHex(tokenId));

        string memory json = base64Encode(
            bytes(
                string(
                abi.encodePacked(
                    '{"id": ', toString(tokenId), ', ',
                    '"name": "#', hexValue ,'", ',
                    '"token_name": "NftSvg", ',
                    '"token_symbol": "NFS", ',
                    '"description": "A Nft Svg", ',
                    '"background_color": "FFFFFF", ',
                    '"attributes": [',
                    '{',
                    '"trait_type": "hexadecimal", ',
                    '"value": "#', hexValue, '"',
                    '}',
                    '], ',
                    '"image": "data:image/svg+xml;base64,',
                    base64Encode(
                    bytes(
                        string(abi.encodePacked('<svg xmlns="http://www.w3.org/2000/svg" preserveAspectRatio="xMinYMin meet" viewBox="0 0 350 350"><rect width="100%" height="100%" /><rect y="0" width="100%" height="100%" fill="#', hexValue ,'" /></svg>'))
                    )
                    ),
                    '"}'
                )
                )
            )
        );

        return string(abi.encodePacked("data:application/json;base64,", json));
    }

    /**
     * Function to withdraw all Ether from this contract.
     */
    function withdraw() public {
        // get the amount of Ether stored in this contract
        uint amount = address(this).balance;

        // send all Ether to owner
        // Owner can receive Ether since the address of owner is payable
        (bool success, ) = contractOwner.call{value: amount}("");
        require(success, "Failed to send Ether");
    }

    /**
    * Main function to mint token
    * tokenId represents the decimal value between 0 and 16777215 (#000000 and #FFFFFF)
    */
    function mintToken(uint256 tokenId) public payable returns (uint256) {
        // Validate if valid decimal number
        require(tokenId >= 0 && tokenId <= 16777215, "Invalid decimal value, must be between 0 and 16777215");

        // Validate if exact eth amount is sent
        require(msg.value >= 0.01 ether, "There is a minimum price of 0.01 eth.");

        // Pay to the contractowner the value
        payable(contractOwner).transfer(msg.value);

        // Mint token
        _safeMint(msg.sender, tokenId);

        // Return tokenId
        return tokenId;
    }
}