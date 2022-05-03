

let query = "";
module.exports = function (connection, params, resolve, reject) {

    resolve({ "status": "success", "status_message": "Get all actions", "discord_message": `How to use: 
    !image <action>
    action:
    **search** <id> - Get a image from the id
    **search** <name_of_image> - Get a image from the name of image
    **search** <url> - Get a image name and id from the url of the image
    **random** <*> - Get a random image from all tags
    **random** <tag> - Get a random image from a tag
    **stats** - Show the stats used by the bot
    **tags** - Get a list of available tags 
    **upload** <url> <name_of_image> <tag> - Upload a image
    
    Admin:
    **delete** <id> - Deletes an image selected by id
    **edit** <id> - Edit an image selected by id
` });


}


