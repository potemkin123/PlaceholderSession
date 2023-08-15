import Foundation

struct User: Decodable {
    let id: Int
    let name: String
    let username: String
    let email: String
    let phone: String
    let website: String
    let company: Company
    let address: Address
}

struct Company: Decodable {
    let name: String
}

struct Address: Decodable {
    let street: String
    let suite: String
    let city: String
    let zipcode: String
}
