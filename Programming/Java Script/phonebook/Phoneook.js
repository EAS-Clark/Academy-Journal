//node modules 
const inquirer = reqired('inquirer')

console.log('Hello world');


// Constructor funcation
class Contact {
    firstName = '';
    lastName = '';
    phoneNumber = '';

    constructor(firstName, lastName, phoneNumber) {
        this.firstName = firstName;
        this.lastName = lastName;
        this.phoneNumber = phoneNumber;

        this.print = function () {
            console.log("Name: " + firstName + " " + lastName + "\nPhone number: " + phoneNumber);
        };

    }
}



const persion = new Contact('clark', 'brooks', '1234234');
persion.print();




