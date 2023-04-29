// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

contract Token{
    address public owner;
    uint public rate;

    mapping (address => uint) public balances;
    mapping (address => uint) public status; //0: white 1: red 2: black
    mapping (address => mapping (address => bool)) public peers;
    mapping (address => address[]) public peers_list;

    constructor(uint256 _rate, uint _initial_amount){
        owner = msg.sender;
        rate = _rate;
        balances[msg.sender] = _initial_amount;
    }

    modifier restricted_owner() {
        require(msg.sender == owner);
        _;
    }

    function deposit() payable external { //purchase token using ETH
        payable(address(this)).transfer(msg.value);
        balances[msg.sender] += rate * msg.value;
    }

    function withdraw(uint _amount) external { //get back ETH
        require(balances[msg.sender] >= _amount, "don't have enough balance");

        balances[msg.sender] -= _amount;
        payable(msg.sender).transfer(_amount / rate);
    }

    function transfer(address _to, uint _amount) external {
        require(status[msg.sender] == 0, "You are not in the Whitelist");
        require(status[_to] == 0, "Receiver is not in the Whitelist");
        require(balances[msg.sender] >= _amount, "You don't have enough balance");

        if (peers[msg.sender][_to] == false) {
            peers[msg.sender][_to] = true;
            peers_list[msg.sender].push(_to);
            peers[_to][msg.sender] = true;
            peers_list[_to].push(msg.sender);
        }

        balances[msg.sender] -= _amount;
        balances[_to] += _amount;
    }

    function setBlacklist(address _add) external restricted_owner {
        if (status[_add] != 2) {
            status[_add] = 2; // make it black
            for (uint i = 0; i < peers_list[_add].length; i++) {
                if (status[peers_list[_add][i]] == 0) {
                    status[peers_list[_add][i]] = 1; // make it red
                }
            }
        }
    }

    function setWhitelist(address _add) external restricted_owner {
        if (status[_add] == 1) { //red
            status[_add] = 0;
        }
        if (status[_add] == 2) { //black
            status[_add] = 0;
            for (uint i = 0; i < peers_list[_add].length; i++) {
                if (status[peers_list[_add][i]] == 1) {
                    status[peers_list[_add][i]] = 0;
                }
            }
        }
    }


    function getBalance(address _addr) external view returns (uint) {
        return balances[_addr];
    }

    function getStatus(address _addr) external view returns (uint) {
        return status[_addr];
    }

    function getPeers(address _addr) external view returns (address[] memory) {
        return peers_list[_addr];
    }

    fallback() external payable {}
    
    receive() external payable {}

}