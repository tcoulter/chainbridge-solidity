pragma solidity 0.6.12;

/**
    @title Interface to be used with handlers that support ERC20s and ERC721s.
    @author ChainSafe Systems.
 */
interface IERCHandler {
    /**
        @notice Correlates {resourceID} with {contractAddress}.
        @param resourceID ResourceID to be used when making deposits.
        @param contractAddress Address of contract to be called when a deposit is made and a deposited is executed.
     */
    function setResource(bytes32 resourceID, address contractAddress) external;
    /**
        @notice Marks {contractAddress} as mintable/burnable.
        @param contractAddress Address of contract to be used when making or executing deposits.
     */
    function setBurnable(address contractAddress) external;
    /**
        @notice Used to manually release funds from ERC safes. This signature is not supported by ERC1155 handlers.
        @param tokenAddress Address of token contract to release.
        @param recipient Address to release tokens to.
        @param amountOrTokenID Either the amount of ERC20 tokens or the ERC721 token ID to release.
     */
    function withdraw(address tokenAddress, address recipient, uint256 amountOrTokenID) external;
    /**
        @notice Used to manually release funds from ERC safes (updated signature to support ERC 1155)
        @param tokenAddress Address of token contract to release.
        @param recipient Address to release tokens to.
        @param tokenID ERC721 or ERC1155 token ID to release.
        @param amount ERC20 or ERC1155 amount of token to release.
        @param extraData The optional data parameter for ERC1155.
     */
    function withdraw(address tokenAddress, address recipient, uint256 tokenID, uint256 amount, bytes memory extraData) external;
}
