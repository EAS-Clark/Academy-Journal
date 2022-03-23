//node modules 
const inquirer = require("inquirer");

class Contact {
    constructor(firstName, lastName, phoneNumber) {
        this.firstName = firstName;
        this.lastName = lastName;
        this.phoneNumber = phoneNumber;
    }
}

let phoneBook = [];

let test1 = new Contact("Clark","Brooks","2324234")
let test2 = new Contact("Tim","sdfsdf","8765")
let test3 = new Contact("Max","sfg","467")

phoneBook = [test1, test2];
phoneBook.unshift(test3);

function ContactAdd(){
    inquirer.prompt([
        {
            name: "first_name",
            type: "input",
            message: "First name?",
        },
        {
            name: "last_name",
            type: "input",
            message: "Last name?",
        },
        {
            name: "phone_number",
            type: "input",
            message: "Phone number?",

        }
    ]).then((answer) => {
        let tep = new Contact(answer.first_name,answer.last_name,answer.phone_number)
        phoneBook.unshift(tep);
    });
}

function ContactPrintAll(){
    for(let i =0; i < phoneBook.length; i++){
        console.log(phoneBook[i].firstName);
    }
    
}

function Run(){
    
    ContactAdd();
    
 
    ContactPrintAll();
}

Run();