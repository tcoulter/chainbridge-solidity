pragma solidity 0.6.12;

import "@openzeppelin/contracts/math/SafeMath.sol";
import "@openzeppelin/contracts/token/ERC1155/IERC1155.sol";
import "./ERC1155MinterBurnerPauser.sol";

/**
    @title Manages deposited ERC1155s.
    @author ChainSafe Systems.
    @notice This contract is intended to be used with ERC1155Handler contract.
 */
contract ERC1155Safe {
    using SafeMath for uint256;

    /**
        @notice Used to transfer tokens into the safe to fund proposals.
        @param tokenAddress Address of ERC1155 contract address.
        @param owner Address of current token owner.
        @param tokenID ID of token to transfer.
        @param amount The amount of a specific tokenID to send
        @param extraData The required data param on transfers (not used by all 1155's)
     */
    function fundERC1155(address tokenAddress, address owner, uint tokenID, uint amount, bytes memory extraData) public {
        IERC1155 erc1155 = IERC1155(tokenAddress);
        erc1155.safeTransferFrom(owner, address(this), tokenID, amount, extraData);
    }

    /**
        @notice Used to gain custoday of deposited token.
        @param tokenAddress Address of ERC1155 contract address.
        @param owner Address of current token owner.
        @param recipient Address to transfer token to.
        @param tokenID ID of token to transfer.
        @param amount The amount of a specific tokenID to send
        @param extraData The required data param on transfers (not used by all 1155's)

     */
    function lockERC1155(address tokenAddress, address owner, address recipient, uint tokenID, uint amount, bytes memory extraData) internal {
        IERC1155 erc1155 = IERC1155(tokenAddress);
        erc1155.safeTransferFrom(owner, recipient, tokenID, amount, extraData);
    }

    /**
        @notice Transfers custody of token to recipient.
        @param tokenAddress Address of ERC1155 contract address.
        @param owner Address of current token owner.
        @param recipient Address to transfer token to.
        @param tokenID ID of token to transfer.
        @param amount The amount of a specific tokenID to send
        @param extraData The required data param on transfers (not used by all 1155's)
     */
    function releaseERC1155(address tokenAddress, address owner, address recipient, uint256 tokenID, uint amount, bytes memory extraData) internal {
        IERC1155 erc1155 = IERC1155(tokenAddress);
        erc1155.safeTransferFrom(owner, recipient, tokenID, amount, extraData);
    }

    /**
        @notice Used to create new ERC1155s.
        @param tokenAddress Address of ERC1155 to mint.
        @param recipient Address to mint token to.
        @param tokenID ID of token to mint.
        @param extraData Optional data to send along with mint call.
     */
    function mintERC1155(address tokenAddress, address recipient, uint256 tokenID, uint amount, bytes memory extraData) internal {
        ERC1155MinterBurnerPauser erc1155 = ERC1155MinterBurnerPauser(tokenAddress);
        erc1155.mint(recipient, tokenID, amount, extraData);
    }

    /**
        @notice Used to burn ERC1155s.
        @param tokenAddress Address of ERC1155 to burn.
        @param owner Address of account that owns the tokens being burnt.
        @param tokenID ID of token to burn.
        @param amount of tokenID to burn.
     */
    function burnERC1155(address tokenAddress, address owner, uint256 tokenID, uint amount) internal {
        ERC1155MinterBurnerPauser erc1155 = ERC1155MinterBurnerPauser(tokenAddress);
        erc1155.burn(owner, tokenID, amount);
    }

}
