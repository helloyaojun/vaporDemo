import Vapor
import VaporMySQL

let drop = Droplet()
let driver = try MySQLDriver.init(host: "localhost", user: "root", password: "", database: "yaojun")


drop.get { req in
    return try drop.view.make("welcome", [
    	"message": drop.localization[req.lang, "welcome", "title"]
    ])
}

drop.get("users") { req in
    let result = try driver.mysql("select nickname,uid,username from users;")
    return try JSON(node: result[0])
}

drop.resource("posts", PostController())

drop.run()
