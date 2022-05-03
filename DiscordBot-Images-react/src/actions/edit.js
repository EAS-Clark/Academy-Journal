
let query = "";
module.exports = function (connection, params, resolve, reject) {


    if (req.get("user") != "EAS-Clark" ) {
        resolve({ "status": "Fail", "status_message": "Not Authorised", "discord_message": "Not authorised to edit images" });

    } else {
        query = `UPDATE image_HTML_URl
              SET Name_of_image=?, tag=?
              WHERE id=?`

        connection.query(query, [params[3], params[4], params[2]], function (err, result, fields) {

            if (err) {

                resolve({ "status": "Fail", "status_message": "Edit Fail", "discord_message": "Edit images data" });
            } else {
                resolve({ "status": "success", "status_message": "Image Edited", "discord_message": "Succesfully edited image data" });
            }

        });
    }



}