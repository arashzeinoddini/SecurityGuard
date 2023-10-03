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
    var selectedDevice: Device?
    
    static func getUser() -> User? {
        guard let savedUser = UserDefaults.standard.object(forKey: UserDefaults.Keys.user) as? Data else {
            return nil
        }
        let decoder = JSONDecoder()
        guard let user = try? decoder.decode(User.self, from: savedUser) else {
            return nil
        }
        return user
    }
    
    @discardableResult
    static func register(user: User) -> Bool {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(user) {
            UserDefaults.standard.set(encoded, forKey: UserDefaults.Keys.user)
            return true
        }
        return false
    }
}
