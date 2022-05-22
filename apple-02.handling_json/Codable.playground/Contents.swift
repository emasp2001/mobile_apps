
import UIKit

struct user: Codable {
    // Main data of this class.
  var name:String?
  var last_name:String
  var age:String
  
    // To handle if different names are in the JSON received.
  enum CodingKeys: String, CodingKey {
    case name
    case last_name = "apellido"
    case age
  }
}

let json_data = """
{
  "name":  "Emmanuel",
  "apellido":  "Perez",
  "age": "Veinte"
}
"""

  // Decode the data.
let my_data = json_data.data(using: .utf8)!
print(my_data)
let my_user = try JSONDecoder().decode(user.self, from: my_data)
print(my_user)
