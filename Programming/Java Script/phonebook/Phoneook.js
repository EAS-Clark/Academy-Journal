//node modules 
const inquirer = require("inquirer");
const fs = require("fs");

class Contact {
    constructor(firstName, lastName, phoneNumber) {
        this.firstName = firstName;
        this.lastName = lastName;
        this.phoneNumber = phoneNumber;
    }
}

let phoneBook = [];


function saveData(data) {

    fs.writeFile("./PhoneData.json", JSON.stringify(data, null, 2), err => {
        if (err) {
            console.log(err);
        } else {
            console.log("File saved");

        }

    });
}

function updateData(input) {

    jsonReader("./PhoneData.json", (err, data) => {
        if (err) {
          console.log(err);
        } else {
            data + input;
            fs.writeFile("./PhoneData.json", JSON.stringify(data, null, 2), errorMessage => {
                if (err) {
                    console.log(err);
                } 
            });
        }
      });
}

//updateData(test3);


function jsonReader(filePath, cb) {
    fs.readFile(filePath, (err, fileData) => {
      if (err) {
        return cb && cb(err);
      }
      try {
        const object = JSON.parse(fileData);
        return cb && cb(null, object);
      } catch (err) {
        return cb && cb(err);
      }
    });
}



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

function ContactAdd(){
    phoneBook.unshift(ContactGenerator());
    saveData(phoneBook);
}

function ContactEditOne(name) {
    this.name = name;
    for (let i = 0; i < phoneBook.length; i++) {
        if (phoneBook[i].firstName === name) {
            ContactDeleteOne(name);
            phoneBook.unshift(ContactGenerator());
            saveData(phoneBook);
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

    jsonReader("./PhoneData.json", (err, fileData) => {
        if (err) {
          console.log(err);
          return;
        }
        phoneBook = fileData;
      });


    inquirer.prompt([
        {
            name: "action",
            type: "list",
            message: "Select a action",
            choices: ["Show all contacts", "Show contact", "Add contact", "Edit contact", "Delete contact", "Turn off"]
        }
    ]).then(({action}) => {
        console.log(action);

        switch (action) {
            case "Show all contacts":
                ContactPrintAll();

                break;
            case "Show contact":
                inquirer.prompt([{ name: "name", type: "input", message: "Enter fisrt name of contact", }]).then(({name}) => { ContactPrintOne(name); });

                break;
            case "Add contact":
                ContactAdd();

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






