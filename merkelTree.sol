// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.2 <0.9.0;

contract Merkeltree{
    function verfity(
        bytes32[] memory Proof,bytes32 root, bytes32 leaf, uint index 
        )public pure returns(bool){

            bytes32 hash = leaf;
            for(uint i=0 ;i<Proof.length;i++){
                if(index%2==0){
                    hash = keccak256(abi.encodePacked(hash, Proof[i]));  //[even , 0 1 (2) 3 4 5 6 7]

                }
                else{
                    hash = keccak256(abi.encodePacked( Proof[i], hash)); //[odd , 0 1 2 (3) 4 5 6 7]
                }
                    index = index /2;
            }
        return hash == root;

    }

    
}