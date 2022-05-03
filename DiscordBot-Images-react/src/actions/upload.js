
let query = "";
module.exports = function (connection, params, resolve, reject) {


    if (params[2] == null) {
        reject({ "status": "failed", "status_message": "sending back image", "discord_message": "missing params url" });

    }
    if (params[3] == null) {
        reject({ "status": "failed", "status_message": "sending back image", "discord_message": "missing params name" });

    }
    if (params[4] == null) {
        reject({ "status": "failed", "status_message": "sending back image", "discord_message": "missing params tag" });

    }

    query = `SELECT * FROM image_HTML_URl WHERE HTML_URL=?`;

    connection.query(query, params[2], function (err, result, fields) {
        if (err) {
            reject(err)
        }
        try {
            reject({ "status": "failed", "status_message": "sending back image", "discord_message": "image already in saved" + "\nimage is saved as;\nid: " + result[0].id + " name: " + result[0].Name_of_image });
        } catch (error) {

            query = `SELECT * FROM image_HTML_URl WHERE Name_of_image=?`;
 
            connection.query(query, params[3], function (err, result, fields) {
                if (err) {
                    reject(err)
                }
                try {
                    reject({ "status": "failed", "status_message": "sending back image", "discord_message": "image already in saved urnder that name" + "\nimage is saved as;\nid: " + result[0].id + " name: " + result[0].Name_of_image });
                } catch (error) {

                    query = `INSERT INTO image_HTML_URl 
                  (HTML_URL, Name_of_image, tag) 
                  VALUES
                    (?, ?, ?)`;
 
                    connection.query(query, [params[2], params[3], params[4]], function (err, result, fields) {
                        if (err) {
                            reject({ "status": "failed", "status_message": "can't resolve query", "discord_message": "Failed to upload image (Url could be to big)" })
                        }
                        resolve({ "status": "success", "status_message": "sending back image", "discord_message": "Upload image. id: " + result.insertId + " Name: " + params[3] });
                    });
                }
            });
        }
    });

}