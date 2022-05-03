
let query = "";
module.exports = function (connection, params, resolve, reject) {

//|| req.get("user") != "EAS-rhysmorgan1986"
    if (req.get("user") != "EAS-Clark" ) {
        resolve({ "status": "Fail", "status_message": "Not Authorised", "discord_message": "Not authorised to delete images" });

    } else {
        query = `DELETE FROM image_HTML_URl WHERE id=?`

        connection.query(query, params[2], function (err, result, fields) {
            if (err) {
                console.log(err)
                resolve({ "status": "Fail", "status_message": "Edit deleted", "discord_message": "Fail to delete images" });
            }
            resolve({ "status": "success", "status_message": "Image deleted", "discord_message": "Succesfully deleted image" });
        });
    }


}