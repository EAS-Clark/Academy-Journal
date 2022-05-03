/**
 * @openapi
 * /api/validate/{command}:
 *  get:
 *    description: Validate the bot command being used with this API
 *    produces:
 *     - application/json
 *    parameters:
 *     - name: command
 *       in: path
 *       required: true
 *       type: string    
 *    responses:
 *       200:
 *         description: Returns JSON document with validation results
 */

var sql = require('../route_functions/sql.js');

module.exports = function (app) {
  app.get('/api/command/:command', (req, res, next) => {

    var getResponse = sql.func(req);
    getResponse.then((response) => {
      res.send(response)
    }).catch(err => {
      res.send(err);
    });
  });
}



/*
posablle need to use
var string = 'http://localhost:3000/image/upload/https://cdn.discordapp.com/attachments/597445991699841056/965911868197703700/IMG_2164.PNG';
var b = new Buffer(string);
var s = b.toString('base64');
console.log(s);


var b = new Buffer(s, 'base64')
var c = b.toString();
console.log(c);

// Decode the String
*/




// search by name 



