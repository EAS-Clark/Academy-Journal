
let query = "";
let randomNumber;
module.exports = function (connection, params, resolve, reject) {


  console.log(params);
  if (params[2] == '*') {
    query = `SELECT * FROM image_HTML_URl`;

    connection.query(query, params[2], function (err, result, fields) {
      if (err) {
        console.log("result 1 " + result);
        reject({ "status": "failed", "status_message": "can't resolve query", "discord_message": "failed to find images with the tag of " + params[2] + "\ntry the command !image tags\nor you can try !image random *" });
      }

      try {
        randomNumber = getRandomInt(0, result.length - 1);
        resolve({ "status": "success", "status_message": "sending back image", "discord_message": result[randomNumber].HTML_URL });
      } catch (error) {
        reject({ "status": "failed", "status_message": "can't resolve query", "discord_message": "failed to find images with tags" });
      }


    });

  } else {
    query = `SELECT * FROM image_HTML_URl WHERE tag=?`

    query = `
    SELECT * FROM image_HTML_URl
    WHERE Name_of_image LIKE ?`;


    connection.query(query, `%${params[2]}%`, function (err, result, fields) {

      if (err) {
        reject({ "status": "failed", "status_message": "can't resolve query", "discord_message": "failed to find images with the tag of " + params[2] + "\ntry the command !image tags\nor you can try !image random *" });
      }

      try {
        randomNumber = getRandomInt(0, result.length - 1);
        resolve({ "status": "success", "status_message": "sending back image", "discord_message": result[randomNumber].HTML_URL });
      } catch (error) {
        reject({ "status": "failed", "status_message": "can't resolve query", "discord_message": "failed to find images with the tag of " + params[2] });
      }


    });
  }

}


function getRandomInt(min, max) {
  min = Math.ceil(min);
  max = Math.floor(max);
  return Math.floor(Math.random() * (max - min + 1)) + min;
}