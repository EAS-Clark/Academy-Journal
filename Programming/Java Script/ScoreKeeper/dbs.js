'use strict';

const fs = require("fs");
let filename = "data/score.json";

function getData(filename){
    
    fs.readFile(filename, "utf8", (err, jsonString) => {
        if (err) {
          console.log("File read failed:", err);
          return;
        }
        return jsonString;
    });

}

console.log( getData("data/score.json"));