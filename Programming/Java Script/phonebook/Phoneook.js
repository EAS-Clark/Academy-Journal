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

let test1 = new Contact("Clark", "Brooks", "2324234")
let test2 = new Contact("Tim", "sdfsdf", "8765")
let test3 = new Contact("Max", "sfg", "467")

phoneBook = [test1, test2];
phoneBook.unshift(test3);

function ContactGenerator() {
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
      
        let tep = new Contact(answer.first_name, answer.last_name, answer.phone_number);
        phoneBook.unshift(tep);
    });

}

function ContactEditOne(name) {
    this.name = name;
    for (let i = 0; i < phoneBook.length; i++) {
        if (phoneBook[i].firstName === name) {
            ContactDeleteOne(name);
            phoneBook.unshift(ContactGenerator());
        }
    }
   
}

function ContactPrintAll() {
    for (let i = 0; i < phoneBook.length; i++) {
        console.log("Name: " + phoneBook[i].firstName + " " + phoneBook[i].lastName);
    }

}

function ContactPrintOne(name) {
    this.name = name;
    for (let i = 0; i < phoneBook.length; i++) {
        if (phoneBook[i].firstName === name) {
            console.log("Name: " + phoneBook[i].firstName + " " + phoneBook[i].lastName + "\nPhone number: " + phoneBook[i].phoneNumber);
        }
    }
}

function ContactDeleteOne(name) {
    this.name = name;
    for (let i = 0; i < phoneBook.length; i++) {
        if (phoneBook[i].firstName === name) {
            console.log("Removing " + phoneBook[i].firstName + " " + phoneBook[i].firstName + " from the phone book");
            phoneBook.splice(i, 1);
        }
    }
}

async function MainMenu() {
    inquirer.prompt([
        {
            name: "action",
            type: "list",
            message: "Select a action",
            choices: ["Show all contacts", "Show contact", "Add contact", "Edit contact", "Delete contact", "Turn off"]
        }
    ]).then((answer) => {
        console.log(answer.action);

        switch (answer.action) {
            case "Show all contacts":
                ContactPrintAll();

                break;
            case "Show contact":
                inquirer.prompt([{ name: "name", type: "input", message: "Enter fisrt name of contact", }]).then((answer) => { ContactPrintOne(answer.name); });

                break;
            case "Add contact":
                phoneBook.unshift(ContactGenerator());

                
                break;
            case "Edit contact":
                inquirer.prompt([{ name: "name", type: "input", message: "Enter fisrt name of contact", }]).then((answer) => { ContactEditOne(answer.name); });

                break;
            case "Delete contact":
                inquirer.prompt([{ name: "name", type: "input", message: "Enter fisrt name of contact", }]).then((answer) => { ContactDeleteOne(answer.name); });

                break;
            case "Turn off":
            //Turn off

        }
    })


}

  
MainMenu();




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
