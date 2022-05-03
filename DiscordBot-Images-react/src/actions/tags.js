
let query = "";
module.exports = function (connection, params, resolve, reject) {

  query = `SELECT tag, count(*) FROM image_HTML_URl GROUP BY tag`

  connection.query(query, params[2], function (err, result, fields) {

    reject({ "status": "failed", "status_message": "can't resolve query", "discord_message": "Lit of tags: \n" + arrayToString(result) });
  });


}


function arrayToString(array) {

  let stringArry = "Tag: name - number of tag\n---------------------------\n";

  for (let i = 0; i <= array.length - 1; i++) {
    stringArry = stringArry + "Tag: " + array[i]["tag"] + " - " + array[i]["count(*)"] + "\n"
  }

  return stringArry;
}