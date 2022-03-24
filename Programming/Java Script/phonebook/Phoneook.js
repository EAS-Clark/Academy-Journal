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
        console.log(phoneBook[i].firstName + " " + phoneBook[i].lastName);
    }
    
}

function MainMenu(){
    inquirer.prompt([
        {
            name: "action",
            type: "input",
            message: "For action type:\n\t0: Show all contacts\n\t1: Show contact\n\t2: Add contact\n\t3: Edit contact\n\t4: Delete contact\n",
        }
    ]).then((answer) => {
        console.log(answer.action);
      
        switch(answer.action){
            case "0":
                //Show all contact
                ContactPrintAll();
                break;
            case "1":
                //Show contact

                break;
            case "2":
                //Add contact
                ContactAdd();
                break;  
            case "3":
                //Edit contact

                break;
            case "4":
                //Delete contact
                
        
        }

    });
}
function Run(){
    
    MainMenu();
 

}

Run();