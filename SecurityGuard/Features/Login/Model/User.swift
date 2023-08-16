//
//  User.swift
//  SecurityGuard
//
//  Created by Arash Zeinoddini on 8/9/23.
//

import Foundation

struct User: Codable {
    let username: String
    let password: String
    var devices: [Device]? = nil
}
