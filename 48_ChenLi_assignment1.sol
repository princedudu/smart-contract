// solidity version
pragma solidity ^0.4.14;

contract payroll{
    uint salary = 1 ether;
    address employee = 0xca35b7d915458ef540ade6068dfe2f44e8fa733c;
    uint payDuration = 10 seconds;
    uint lastPayday = now;
    
    // Change employee address
    function setEmployee(address e) {
        if(employee == e) {
            revert();
        }

        oldTransfer();
        employee = e;
    }
    
    // Change salary
    function setSalary(uint s) {
        if(salary == s) {
            revert();
        }
        
        oldTransfer();
        salary = s * 1 ether;
    }
    
    // calcualte the old transfer
    function oldTransfer() returns(uint) {
        uint payment = salary * (now - lastPayday) / payDuration;
        employee.transfer(payment);
        lastPayday = now;
    }
    
    // add fund to the balance
    function addFund() payable returns(uint) {
        return this.balance;
    }
    
    // Return the remaining pay day.
    function calculateRunway() returns(uint) {
        return this.balance / salary;
    }
    
    // Check if fund is enough for paying
    function hasEnoughFund() returns(bool) {
        return calculateRunway() > 0;
    }
    
    // Get paid by the contract address
    function getPaid() returns(uint) {
        if(msg.sender != employee) {
            revert();
            
        }

        uint nextPayday = lastPayday + payDuration;
        if(nextPayday > now) {
            revert();
        }
         
        lastPayday = nextPayday;
        employee.transfer(salary);
        return salary; 
    }
    
}
