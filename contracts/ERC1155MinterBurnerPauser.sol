pragma solidity 0.6.12;

import "@openzeppelin/contracts/presets/ERC1155PresetMinterPauser.sol";

contract ERC1155MinterBurnerPauser is ERC1155PresetMinterPauser {
  constructor(string memory uri) ERC1155PresetMinterPauser(uri) public {
    // Do nothing. This exists to make the ERC1155PresetMinterPauser contract available to 
    // consuming interfaces (e.g., the relayer)
  }
}