
const express = require('express');
const fileUpload = require('express-fileupload');

const path = require('path');
const app = express();

const fs = require("fs");


app.use(express.static('public'));
app.use(express.text());
app.use(fileUpload());
app.use(express.raw({ type: 'image/*', limit: '5mb' }));




fs.readdirSync(path.join(__dirname, "routes")).forEach(function(file) {
  if (file[0] === ".") {
    return;
  }
  require(path.join(__dirname, "routes", file))(app);
});

app.listen(3000, () => {
  console.log('listening on port 3000');
});
