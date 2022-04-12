const express = require('express');
const path = require('path');



const app = express();
const port = process.env.PORT || 8080;


app.get('/', function(req, res) {
  res.sendFile(path.join(__dirname, '/public/index.html'));
});


// app.get('/', (req, res) => {
//   Item.find()
//     .then(items => res.render('index', { items }))
//     .catch(err => res.status(404).json({ msg: 'No items found' }));
// });

app.listen(port);
console.log('Server started at http://localhost:' + port);



module.exports = app;