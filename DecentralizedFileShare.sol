// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.2 <0.9.0;




contract Upload{
    struct Access{
        address user;
        bool accessi;
    }

    mapping(address=>string[])value;
    mapping(address=>mapping(address=>bool))ownership;
    mapping(address=>Access[])accessList;
    mapping(address=>mapping(address=>bool))periousdata;


    function add(address _user, string memory url) external{
        value[_user].push(url);
    }

    function allow(address _user) external{
        ownership[msg.sender][_user]=true;
        if(periousdata[msg.sender][_user]){
            for(uint i=0; i<accessList[msg.sender].length;i++){
                if(accessList[msg.sender][i].user==_user){
                    accessList[msg.sender][i].accessi = true;
                }

            }
        }else{
            accessList[msg.sender].push(Access(_user, true));

        }
     

    }

    function disallow(address _user) external{
        ownership[msg.sender][_user]=false;
        for(uint i=0; i<accessList[msg.sender].length; i++){
            if(accessList[msg.sender][i].user == _user){
                accessList[msg.sender][i].accessi=false;

            }
        }
    }



    function  display(address _user)public view returns(string[] memory) {
        require(_user==msg.sender || ownership[ _user][msg.sender], "You dont have access");
        return value[_user];

    }

    function shareAccess() public view returns(Access[] memory){
        return accessList[msg.sender];
    }
}