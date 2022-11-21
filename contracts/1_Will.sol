// SPDX-License-Identifier: GPL-3.0

//Qd deploy and run : the value of a transaction is the amount of ether the owner will allocate to a smart contract (ex ici some à léguer)

pragma solidity >=0.7.0 <0.9.0;

contract Will 
{
    address owner;
    uint fortune;
    bool isDeceased;
    address payable[] familyWallets;
    mapping(address => uint) inheritance;

    constructor() payable 
    {
        owner = msg.sender; // address that is being called
        fortune = msg.value; // tells us how much is being sent
        isDeceased = false;
    }
    
    function addHeir(address payable heirWallet, uint inheritanceAmount) public
    {
        familyWallets.push(heirWallet); //add wallets to the family wallets
        inheritance[heirWallet] = inheritanceAmount; //add the inheritance amount for the wallet
    }

    function payout() private mustBeDeceased
    { 
         // pay each family member based on their wallet address
        for(uint i = 0; i < familyWallets.length; i++)
        {
            familyWallets[i].transfer(inheritance[familyWallets[i]]);                
        }
    }

    //Oracle switch simulation
    function hasDeceased() public onlyOwner {
        isDeceased = true;
        payout();
    }

    //only allocate funds if grandpa is deceased
    modifier mustBeDeceased {
        require(isDeceased == true);
        _;
    }

    //only person who can call the contract is the owner 
    modifier onlyOwner {
        require(msg.sender == owner);
        _;
    }

}