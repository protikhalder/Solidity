// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;


import "./IERC20.sol";

contract ERC20 is IERC20{

    uint public totalSupply;
    mapping(address=> uint) public balanceOf;
    mapping(address=>mapping(address=>uint)) public allowance;

    string public TokenName ="VDTz";
    string public TokenSymbol = "BDT";
    uint public decimals = 18;

    constructor(uint initialSupply){
        totalSupply = initialSupply * 10**uint(decimals);
        balanceOf[msg.sender] = totalSupply;


    }


    // simple transfer function

    function transfer(address sender, uint tokenAmount) external returns(bool) {
        require(balanceOf[msg.sender]>tokenAmount, "insufficient balance");
        balanceOf[msg.sender]-=tokenAmount;
        balanceOf[sender] +=tokenAmount;
        emit Transfer(msg.sender, sender, tokenAmount );
        return true;

        
    }

    function approve(address spender, uint tokenAmount) external returns(bool){
        allowance[msg.sender][spender] =tokenAmount;
        emit Approval(msg.sender, spender, tokenAmount);
        return true;

        
    }

    function transferFrom(address sender, address sependerToken, uint amount) external returns(bool){
         require(balanceOf[sender] >= amount,"Not enough tokens!");
         require(allowance[sender][msg.sender] >= amount, "You are not approved to spend this amoutn!" );
         allowance[sender][msg.sender] -= amount;
         balanceOf[sender] -=amount;
         balanceOf[sependerToken]+=amount;
        emit Transfer(sender, sependerToken , amount);
        return true;
    }

    






}

