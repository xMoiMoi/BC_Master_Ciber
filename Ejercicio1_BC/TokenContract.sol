// SPDX-License-Identifier: Unlicensed
pragma solidity 0.8.30;

contract TokenContract { 
    
    address public owner;

    struct Receivers {  
        string name;
        uint256 tokens;
    } 

    mapping(address => Receivers) public users;

    modifier onlyOwner(){ 
        require(msg.sender == owner, "Solo el propietario puede ejecutar esta funcion");
        _;
    }

    constructor(){ 
        owner = msg.sender; 
        users[owner].tokens = 100;   // El propietario empieza con 100 tokens
    } 
    
    function double(uint _value) public pure returns (uint){ 
        return _value * 2; 
    } 
       
    function register(string memory _name) public{ 
        users[msg.sender].name = _name; 
    } 
       
    function giveToken(address _receiver, uint256 _amount) onlyOwner public { 
        require(users[owner].tokens >= _amount, "No hay suficientes tokens"); 
        users[owner].tokens -= _amount; 
        users[_receiver].tokens += _amount; 
    } 

    // --- NUEVA FUNCIONALIDAD: comprar tokens con Ether ---
    function buyTokens(uint _amount) public payable {
        uint cost = _amount * 5 ether;  
        require(msg.value >= cost, "No has enviado suficiente Ether");  
        require(users[owner].tokens >= _amount, "El propietario no tiene suficientes tokens");  

        // Transferencia de tokens
        users[owner].tokens -= _amount; 
        users[msg.sender].tokens += _amount; 
    }

    // --- Consultar saldo de Ether del contrato ---
    function contractBalance() public view returns(uint) {
        return address(this).balance;
    }
}
