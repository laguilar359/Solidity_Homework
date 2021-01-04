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
        
        // We may either have 1 or 2 wei leftover, so transfer the msg.value - amount * 3 back to msg.sender.
        // This will re-multiply the amount by 3, then subtract it from the msg.value to account for any leftover wei, 
        // and send it back to Human Resources.
        msg.sender.transfer(msg.value - amount*3);
        
        balanceContract = address(this).balance;
    }
    
    /** Create a fallback function using function() external payable, and call the deposit function from within it.
     * This will ensure that the logic in deposit executes if Ether is sent directly to the contract. 
     * This is important to prevent Ether from being locked in the contract since we don't have a withdraw function in this use-case.
     */
    function fallback() external payable {
        function() deposit;
        
    }
}