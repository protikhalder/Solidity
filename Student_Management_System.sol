// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.2 <0.9.0;


contract Studentmanagement{

    struct Student{
        string Name;
        uint Age;
        bool encrollment;
        uint[] Grades;

    }


    mapping(uint=>Student) students;

    uint[] public studentsids;


    constructor(string memory _name, uint _age, bool _encrollment, uint[] memory grades){
        students[1] = Student(_name, _age,_encrollment,grades);

    }


    function addStudent(string memory _name, uint _age, bool _encrollment, uint[] memory grades) external{
        uint newID = studentsids.length +1;
        students[newID] = Student(_name, _age,_encrollment,grades);
        studentsids.push(newID);

    } 

    function update_student_imformation(uint ID, bool _encrollment) external{
        uint visiilty = 0;
        for(uint i =0; i<studentsids.length;i++){
            if(studentsids[i] == ID){
                visiilty = 1;
            }
        }
        require(visiilty!= 0, "student does not exist");
        students[ID].encrollment = _encrollment;


    } 

    // function getStudent(uint student_ID) public  view  returns(Student memory){
    //       uint visiilty = 0;
    //       for(uint i =0; i<studentsids.length;i++){
    //         if(studentsids[i] == student_ID){
    //             visiilty = 1;
    //         }
    //     }
    //     require(visiilty!= 0, "student does not exist");
    //     Student memory structstudent = students[student_ID];
    //     return structstudent;
    //     // return (structstudent.Name,structstudent.Age,structstudent.encrollment,structstudent.Grades);

    // }

    function getStudentreal(uint student_ID) public  view  returns(string memory, uint,bool, uint[]memory){
          uint visiilty = 0;
          for(uint i =0; i<studentsids.length;i++){
            if(studentsids[i] == student_ID){
                visiilty = 1;
            }
        }
        require(visiilty!= 0, "student does not exist");
        Student memory structstudent = students[student_ID];
  
        return (structstudent.Name,structstudent.Age,structstudent.encrollment,structstudent.Grades);

    }


    function updateAge(uint ID, uint age) external{
        uint visiility =0;
        for(uint i = 0;i<studentsids.length;i++ ){
            if(studentsids[i] == ID){
                visiility = 1;
            }
        }
         require(visiility!= 0, "student does not exist");
        students[ID].Age = age;
    } 

    function addGrades(uint id, uint[] memory y) external{
        uint visiility =0;
        for(uint i = 0;i<studentsids.length;i++ ){
            if(studentsids[i] == id){
                visiility = 1;
            }
        }
         require(visiility!= 0, "student does not exist");
         uint[] memory mearr = new uint[](3);
         for(uint i = 0; i<mearr.length;i++){
            mearr[i] = y[i]; 
         }
         students[id].Grades = mearr;

    } 


    

}

// string memory, uint,bool, uint[]memory

//protik,33,false,[56,67,78]