// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 < 0.9.0;

contract NFTs {}

contract Surprise {
    string public reports;

    constructor (string memory whatyouwant){
        reports = whatyouwant;
    }
}

contract BankContract {

    constructor () {
        bankAccount = BankAccount({bankAddress: msg.sender, balance: msg.sender.balance});
    }


    struct BankAccount {
        address bankAddress;
        uint256 balance;
    }

    struct User{
        string name;
        uint id;
        uint256 balance;
        address wallet;
    }
    

    BankAccount private bankAccount;

    mapping (address => User) users;

    function addAccount(string memory _name, uint _id) external {
        require(users[msg.sender].id == 0, "Account already exist!");
        users[msg.sender] = User({name: _name,
                                  id: _id,
                                  balance: 0,
                                  wallet: msg.sender});
        }

    function deposit(uint  _amount) external payable {
        require(_amount > 0, "Deposit amount is 0!");
        users[msg.sender].balance += _amount;
        //payable(bankAccount.bankAddress).transfer(msg.value);
    }

    function transfer(address _to, uint _amount) external payable {
        require(_amount > 0, "Transfer amount is 0!");
        require(users[msg.sender].balance >= _amount, "No sufficient fund!");
        require((users[_to].id > 0), "Destination account DOESN'T exist!");

        users[msg.sender].balance -= _amount;
        users[_to].balance += _amount;
        //payable(_to).transfer(_amount);
    }

    function withdraw(uint256 _amount) external {
        require(users[msg.sender].balance >= _amount, "Not sufficient fund!");
        users[msg.sender].balance -= _amount;
        //payable(msg.sender).transfer(_amount);
    }



    function getBankInfo() external view returns (address, uint256) {
        require(msg.sender == bankAccount.bankAddress, "NOT Admin");
        return (bankAccount.bankAddress,
                bankAccount.balance);
    }

    function getUserInfo() external view returns(string memory,
                                                 uint,
                                                 uint256,
                                                 address){
        return (users[msg.sender].name,
                users[msg.sender].id,
                users[msg.sender].balance,
                users[msg.sender].wallet);
    }

}