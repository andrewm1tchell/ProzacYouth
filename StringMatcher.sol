pragma solidity ^0.8.0;

contract StringMatcher {
    mapping(bytes32 => bool) private keywordHashes;

    constructor() {
        // Add all keywords to the mapping in the constructor
        string[153] memory keywords = [
                "ABORT", "DECIMAL", "INTERVAL", "PRESERVE",
                "ALL", "DECODE", "INTO", "PRIMARY",
                "ALLOCATE", "DEFAULT", "LEADING", "RESET",
                "ANALYSE", "DESC", "LEFT", "REUSE",
                "ANALYZE", "DISTINCT", "LIKE", "RIGHT",
                "AND", "DISTRIBUTE", "LIMIT", "ROWS",
                "ANY", "DO", "LOAD", "SELECT",
                "AS", "ELSE", "LOCAL", "SESSION_USER",
                "ASC", "END", "LOCK", "SETOF",
                "BETWEEN", "EXCEPT", "MINUS", "SHOW",
                "BINARY", "EXCLUDE", "MOVE", "SOME",
                "BIT", "EXISTS", "NATURAL", "TABLE",
                "BOTH", "EXPLAIN", "NCHAR", "THEN",
                "CASE", "EXPRESS", "NEW", "TIES",
                "CAST", "EXTEND", "NOT", "TIME",
                "CHAR", "EXTERNAL", "NOTNULL", "TIMESTAMP",
                "CHARACTER", "EXTRACT", "NULL", "TO",
                "CHECK", "FALSE", "NULLS", "TRAILING",
                "CLUSTER", "FIRST", "NUMERIC", "TRANSACTION",
                "COALESCE", "FLOAT", "NVL", "TRIGGER",
                "COLLATE", "FOLLOWING", "NVL2", "TRIM",
                "COLLATION", "FOR", "OFF", "TRUE",
                "COLUMN", "FOREIGN", "OFFSET", "UNBOUNDED",
                "CONSTRAINT", "FROM", "OLD", "UNION",
                "COPY", "FULL", "ON", "UNIQUE",
                "CROSS", "FUNCTION", "ONLINE", "USER",
                "CURRENT", "GENSTATS", "ONLY", "USING",
                "CURRENT_CATALOG", "GLOBAL", "OR", "VACUUM",
                "CURRENT_DATE", "GROUP", "ORDER", "VARCHAR",
                "CURRENT_DB", "HAVING", "OTHERS", "VERBOSE",
                "CURRENT_SCHEMA", "IDENTIFIER_CASE", "OUT", "VERSION",
                "CURRENT_SID", "ILIKE", "OUTER", "VIEW",
                "CURRENT_TIME", "IN", "OVER", "WHEN",
                "CURRENT_TIMESTAMP", "INDEX", "OVERLAPS", "WHERE",
                "CURRENT_USER", "INITIALLY", "PARTITION", "WITH",
                "CURRENT_USERID", "INNER", "POSITION", "WRITE",
                "CURRENT_USEROID", "INOUT", "PRECEDING", "RESET",
                "DEALLOCATE", "INTERSECT", "PRECISION", "REUSE",
                "DEC"
            ];

        // Loop through each keyword and store its hash
        for (uint i = 0; i < keywords.length; i++) {
            keywordHashes[keccak256(abi.encodePacked(keywords[i]))] = true;
        }
    }

    function containsKeyword(string memory input) public view returns (bool) {
        require(_isAlphabetic(input), "Input contains non-alphabetic characters");
        return keywordHashes[keccak256(abi.encodePacked(_toUpper(input)))];
    }

    function _toUpper(string memory str) internal pure returns (string memory) {
        bytes memory bStr = bytes(str);
        bytes memory bUpper = new bytes(bStr.length);
        for (uint i = 0; i < bStr.length; i++) {
            // Lowercase characters are between 97 ('a') and 122 ('z')
            if ((uint8(bStr[i]) >= 97) && (uint8(bStr[i]) <= 122)) {
                // Convert to uppercase
                bUpper[i] = bytes1(uint8(bStr[i]) - 32);
            } else {
                bUpper[i] = bStr[i];
            }
        }
        return string(bUpper);
    }

    function _isAlphabetic(string memory str) internal pure returns (bool) {
        bytes memory b = bytes(str);
        for (uint i = 0; i < b.length; i++) {
            bytes1 char = b[i];
            if (!((char >= 0x41 && char <= 0x5A) || (char >= 0x61 && char <= 0x7A))) {
                return false;
            }
        }
        return true;
    }
}
