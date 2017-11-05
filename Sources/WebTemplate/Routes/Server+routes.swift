//
//  Server+routes.swift
//  WebTemplate
//
//  Created by Filip Klembara on 11/5/17.
//

import Squirrel
import SquirrelConfig
import PathKit
import NutView

extension Server {
    func routes() {

        get("/") { () -> Any in
            struct Image {
                let src: String
                let description: String
            }

            let images = [
                Image(src: "/Images/1.jpg", description: "Image 1"),
                Image(src: "/Images/2.jpg", description: "Image 2"),
                Image(src: "/Images/3.jpg", description: "Image 3"),
            ]

            return try View(name: "Index", with: ["images": images, "title": "Squirrels"])
        }

        // /photos/1, /photos/2, ...
        get("/photos/:int") { (id: Int) in
            guard id > 0 && id < 4 else {
                throw HTTPError(status: .notFound)
            }
            return try Response(pathToFile: squirrelConfig.webRoot + "Images/\(id).jpg")
        }

        get("/request") { (request: Request) in
            return request.headers.map { "\($0.key): \($0.value)" }.joined(separator: "<br>")
        }

        struct Person: Codable {
            let name: String
            let age: UInt
        }

        // /person/Tom/21, /person/Penny/12, ...
        get("/person/:name/:age") { (request: Request, person: Person) in

            let header = request.headers.map { "\($0.key): \($0.value)" }.joined(separator: "<br>")
            return "\(person.name) is \(person.age) years old<br><br>\(header)"
        }

        struct Search: Codable {
            let q: String
            let numberOfResults: UInt?
        }

        // /search/foo%20bar, /search/foo%20bar?numberOfResults=4, ...
        get("/search/:q") { (search: Search) in
            var result = ""
            if let numberOfResults = search.numberOfResults {
                for i in 1...numberOfResults {
                    result += "\(i). \(search.q)<br>"
                }
            } else {
                result = search.q
            }
            return result
        }
    }
}
