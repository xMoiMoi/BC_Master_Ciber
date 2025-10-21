// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

// Librería de OpenZeppelin
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

// Nuestro token personalizado basado en el estándar ERC20
contract MyToken is ERC20 {
    constructor(uint256 initialSupply) ERC20("MyToken", "MTK") {
        _mint(msg.sender, initialSupply);
    }
}
