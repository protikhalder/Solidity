// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.2 <0.9.0;


contract TokenSell{
    string  name = "Funtoken";
    string   symbol = "FUN";
    string  standard = "Funtoken v.0.1";
    uint public totalSupply;
    uint8 public decimal = 2;

    address  OwnerOfContract;
    uint userId;

    mapping(address=>uint) public balanceOf;
    mapping(address=>mapping(address=>uint)) allowance;
    
   

    struct TokenHolerInfo{
        address from;
        address to;
        uint tokenId;
        uint valueOftoken;
        bool execute;
    }


    mapping(address=>TokenHolerInfo) tokenHolerInfos;
     address []  public tokenHolder;

    //  Moeny Fect
     uint tokenPrice = 2 ether;
     address payable[] public CheckpayableAddress;

     event Transfer(address indexed _from, address indexed to,uint valueOftoken );
     event Approval(address indexed owner, address indexed spender,uint valueOftoken );
 

    constructor(uint initalvalue){
        OwnerOfContract = msg.sender;
        totalSupply = initalvalue * 10**uint8(decimal);
   
        balanceOf[msg.sender] = totalSupply;
    }

    function inc() internal{
        userId++;

    }

    modifier onlyOwner(){
        require(msg.sender == OwnerOfContract);
        _;
    }

     function  transfer (address _to, uint _valueOftoken) public onlyOwner  returns(bool){
        require(balanceOf[msg.sender]>= _valueOftoken);
        balanceOf[msg.sender]-=_valueOftoken;
        balanceOf[_to]+=_valueOftoken;
        
        // inc();
        // TokenHolerInfo storage TokenHolerInfos = tokenHolerInfos[_to];
        // TokenHolerInfos.to = _to;
        // TokenHolerInfos.from = msg.sender;
        // TokenHolerInfos.tokenId =userId;
        // TokenHolerInfos.valueOftoken = _valueOftoken;
        // tokenHolder.push(_to);
    

       
        emit Transfer(msg.sender, _to, _valueOftoken);
        return true;
        
     }

     function approve(address spender, uint _valueOftoken) public onlyOwner returns(bool){
        allowance[msg.sender][spender] = _valueOftoken;
        emit Approval(msg.sender, spender, _valueOftoken);
        return true;
     }

     function trnsferFrom(address spender, address receiver, uint _valueOftoken) public returns( bool) {
        require(balanceOf[msg.sender]>= _valueOftoken, "Not enough tokens!");
        require(allowance[spender][msg.sender]>_valueOftoken, "You are not approved to spend this amoutn!" );
        allowance[spender][msg.sender]-=_valueOftoken;
        balanceOf[msg.sender]-=_valueOftoken;
        balanceOf[receiver]+=_valueOftoken;
        emit Transfer(spender, receiver, _valueOftoken);
        return true;

        
     }

     function  getTokenHolinftomantion(address _addr)public view returns(address, address, uint, uint, bool) {
        return(tokenHolerInfos[_addr].from,
         tokenHolerInfos[_addr].to,
          tokenHolerInfos[_addr].tokenId,
           tokenHolerInfos[_addr].valueOftoken,
           tokenHolerInfos[_addr].execute

           );
        
     }

     function PulicPayfortoken(address _to ,uint _valueOftoken) public payable{
        require(msg.value ==  _valueOftoken * tokenPrice);
        CheckpayableAddress.push(payable(msg.sender));

        inc();
        TokenHolerInfo storage TokenHolerInfos = tokenHolerInfos[_to];
        TokenHolerInfos.to = msg.sender;
        TokenHolerInfos.from = _to;
        TokenHolerInfos.tokenId =userId;
        TokenHolerInfos.valueOftoken = _valueOftoken;
        tokenHolder.push(_to);
        emit Transfer(_to, msg.sender, _valueOftoken);

     }

     function withDraw(address _addr) onlyOwner external {
         uint money = address(this).balance;
         payable(_addr).transfer(money);
     }


     function WhoGaveMoney()public view returns(address[] memory )  {
        return tokenHolder;

        
     }






}