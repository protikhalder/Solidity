// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.2 <0.9.0;

contract Automotive{
    address public owner;
    mapping(address=> bool) public buyer;
    string public vehicleMake; // VehicleInformation
    string public vehicleModel;
    uint public price;

    //Every time sell will happend We need initialz this Happend

    event Purchase(address Buyer, string make, string model, uint price);


    constructor() {
        owner = msg.sender;
    }

    function buyVehicle(string memory _make, string memory model)public payable {
        require(msg.value>=price);
        require(buyer[msg.sender] == false);
        vehicleMake = _make;
        vehicleModel = model;
        buyer[msg.sender] = true;

        emit Purchase(msg.sender, _make, model, price);

  


    }



}