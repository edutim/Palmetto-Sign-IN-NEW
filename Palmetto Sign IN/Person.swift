//
//  Person.swift
//  MyTests
//
//  Created by Timothy Hart on 2/7/23.
//

import Foundation

struct Person: Codable, Hashable {
    var id = UUID().uuidString
    var firstName: String
    var lastName: String
    var email: String
    var username: String
    var role: String
    var reasonForVisit: String
    var campus: String
    var date: Date
    //var active: Bool   // added CAM 5/5/23
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

struct ReturnedPerson: Codable, Hashable {
    var firstName: String
    var lastName: String
    var email: String
    var username: String
    var role: String
    var reasonForVisit: String
    //var active: Bool // added CAM 5/5/23
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(firstName)
        hasher.combine(lastName)
        hasher.combine(email)
    }
}
