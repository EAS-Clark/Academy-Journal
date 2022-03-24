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
    for(let i = 0; i < phoneBook.length; i++){
        console.log("Name: " + phoneBook[i].firstName + " " + phoneBook[i].lastName);
    }
    
}

function ContactPrintOne(name){
    this.name = name;
    for(let i = 0; i < phoneBook.length; i++){
        if (phoneBook[i].firstName === name){
            console.log("Name: " + phoneBook[i].firstName + " " + phoneBook[i].lastName + "\nPhone number: " + phoneBook[i].phoneNumber);
        }
    }
}

function ContactDeleteOne(name){
    this.name = name;
    for(let i = 0; i < phoneBook.length; i++){
        if (phoneBook[i].firstName === name){
            console.log(i);
            phoneBook.splice(i, 1);
        }
    }
    ContactPrintAll();
}

function MainMenu(){
    inquirer.prompt([
        {
            name: "action",
            type: "input",
            message: "Type for action :\n\t0: Show all contacts\n\t1: Show contact\n\t2: Add contact\n\t3: Edit contact\n\t4: Delete contact\n\t5: Turn off\n",
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
                inquirer.prompt([{name: "name", type: "input", message: "Enter fisrt name of contact",}]).then((answer) => {ContactPrintOne(answer.name);});

                break;
            case "2":
                //Add contact
                ContactAdd();
                
                break;  
            case "3":
                //Edit contact
                inquirer.prompt([{name: "name", type: "input", message: "Enter fisrt name of contact",}]).then((answer) => {ContactDeleteOne(answer.name);});

                break;
            case "4":
                //Delete contact
                inquirer.prompt([{name: "name", type: "input", message: "Enter fisrt name of contact",}]).then((answer) => {ContactDeleteOne(answer.name);});

                
                break;
            case "5":
                //Turn off
                
        }

    });
}
function Run(){
  MainMenu();

}

Run();


  

/*
running = true;
    

let myPromise = new Promise(function(myResolve, myReject) {
let x = 0;

// The producing code (this may take some time)

if (x == 0) {
    myResolve("OK");
} else {
    myReject("Error");
}
});

myPromise.then(
function(value) {
    MainMenu()
    console.log(value); 

},
function(error) {console.log(error);}
);
*/