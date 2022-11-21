/* 
Smart contract that can add investor wallets to a decentralized bank and then allocate (pay) them funds. 
*/

pragma solidity >= 0.7.0 < 0.9.0;

contract AddressWallets {

    uint payableValue;
    address payable[] investorWallets; 

    constructor() payable
    {
        payableValue = msg.value;
    }
    
    mapping(address => uint) investors;
    
    function addInvestors(address payable wallet, uint amount) public 
    {
        investorWallets.push(wallet);
        investors[wallet] = amount;
    }
    
    function checkInvestors() public view returns (uint) 
    {
        return investorWallets.length;
    }

    function payout() private
    {
        for (uint i = 0; i < investorWallets.length; i++)
        {
            investorWallets[i].transfer(investors[investorWallets[i]]);
        }
    }

    function makePayment() public {
         payout();
    }
}
