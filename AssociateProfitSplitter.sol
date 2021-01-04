pragma solidity ^0.5.0;

contract AssociateProfitSplitter{
    address payable owner = msg.sender;
    
    // Define variables for three employees. Set to public and payable
    address payable employee_one;
    address payable employee_two;
    address payable employee_three;
    
    uint public balanceContract;
    // mapping(address => uint) balances;
    
    // Create a constructor function that accepts: address payable _one, _two, _three.
    constructor(address payable _one, address payable _two, address payable _three) public {
        // Within the constructor, set the employee addresses to equal the parameter values. 
        // This will allow you to avoid hardcoding the employee addresses.
        employee_one = _one;
        employee_two = _two;
        employee_three = _three;
    }
    
    // balance -- This function should be set to public view returns(uint), and must return the contract's current balance.
    function balance() public view returns(uint) {
        return balanceContract;
    }
    
    /** deposit - This function should set to public payable check, ensuring that only the owner can call the function.
     * Set a uint amount to equal msg.value / 3; in order to calculate the split value of the Ether.
     * Transfer the amount to employee_one.
     * Repeat the steps for employee_two and employee_three.
     */
    function deposit(uint amount) public payable {
        require(msg.sender == owner, "You don't own this account!");
        
        amount = msg.value / 3;
        
        employee_one.transfer(amount);
        employee_two.transfer(amount);
        employee_three.transfer(amount);
        
        msg.sender.transfer(msg.value - amount*3);
        
        balanceContract = address(this).balance;
    }
    
    function fallback() external payable {
        function() deposit;
        
    }
}
