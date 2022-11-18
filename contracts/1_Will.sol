// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0;

contract Will 
{
    address owner;
    uint fortune;
    bool isDeceased;

    //payable: allow this function to send and receive ether
    constructor() public payable 
    {
        owner = msg.sender; //msg sender represents address that is being called
        fortune = msg.value; //msg value telle=s us how much ether is being sent
        isDeceased = false; //when contract is initialized, grandfather is not dead yet
    }

    //create modifier so the only person who can call the contract is the owner
    modifier onlyOwner 
    {
        require(msg.sender == owner);
        _; //shift back to the actual function
    }

    modifier mustBeDeceased 
    {
        require(isDeceased == true);
        _; 
    }

    //list of family wallets
    address payable[] familyWallets;

    //map through inheritance - create dictionnary key store value
    mapping(address => uint) inheritance;

    //set inheritance for each address
    function setInheritance(address payable wallet, uint amount) public
    {
        familyWallets.push(wallet); //add wallets to the family wallets
        inheritance[wallet] = amount; //add the inheritance amount for the wallet
    }


    //pay each family member based on their wallet address
    function payout() private mustBeDeceased {

        for(i=0; i < familyWallets.length; i++)
        {
            //transfer the fund from the contract address to the receiver address in the list
            familyWallets[i].transfer(inheritance[familyWallets[i]]);                   
        }

    }
}