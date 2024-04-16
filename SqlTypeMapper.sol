pragma solidity ^0.8.0;

contract SQLTypeMapper {
    mapping(uint => string) private typeMappings;

    constructor() {
        // Common SQL Server data type mappings
        typeMappings[1] = "INT";
        typeMappings[2] = "VARCHAR";
        typeMappings[3] = "DATETIME";
        typeMappings[4] = "DECIMAL";
        typeMappings[5] = "BIT";
        typeMappings[6] = "CHAR";
        typeMappings[7] = "FLOAT";
        typeMappings[8] = "BIGINT";
        typeMappings[9] = "NUMERIC";
        typeMappings[10] = "SMALLINT";
        typeMappings[11] = "DATE";
        typeMappings[12] = "TIME";
        typeMappings[13] = "NCHAR";
        typeMappings[14] = "NVARCHAR";
        typeMappings[15] = "XML";
        typeMappings[16] = "TEXT";
    }

    function getSQLType(uint typeId) public view returns (string memory) {
        require(bytes(typeMappings[typeId]).length > 0, "Invalid type ID");
        return typeMappings[typeId];
    }
}
