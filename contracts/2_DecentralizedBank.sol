/* 
Smart contract that can add investor wallets to a decentralized bank and then allocate (pay) them funds. 
Can select different accounts from our test accounts and use the payInvestors functions to send funds. 
The checkInvestors function should return to you how many investors wallets have been added to the bank

*/

pragma solidity >= 0.7.0 < 0.9.0;

contract AddressWallets
{
    address payable[] investorWallets ;

    mapping (address => uint) investors;

    function checkInvestors() public view returns (uint) 
    {
        return investorWallets.length;
    }

    function payInvestors(address payable investorAddress, uint amount) public
    {
        investorWallets.push(investorAddress);
        investors[investorAddress] = amount;
    }
}   