//
//  LoginViewModel.swift
//  SecurityGuard
//
//  Created by Arash Zeinoddini on 8/9/23.
//

import Foundation

class LoginViewModel {
    
    typealias FaceIDCompletion = (Bool, String?) -> Void

    private lazy var authManager = AuthManager()

    var isUserRegistered: Bool {
        let user = UserDefaults.standard.object(forKey: UserDefaults.Keys.user) as? Data
        return user != nil
    }
    
    var user: User? {
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
    func register(user: User) -> Bool {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(user) {
            UserDefaults.standard.set(encoded, forKey: UserDefaults.Keys.user)
            return true
        }
        return false
    }
    
    func login(username: String?, password: String?) -> (Bool, String?) {
        guard (username?.count ?? 0) > 0 && (password?.count ?? 0) > 0 else {
            let error = NSLocalizedString("Enter username and password", comment: "")
            return (false, error)
        }
        guard let registeredUser = user else {
            let error = NSLocalizedString("User is not registered", comment: "")
            return (false, error)
        }
        if registeredUser.username == username && registeredUser.password == password {
            return (true, nil)
        }
        else {
            let error = NSLocalizedString("Username or password is not correct", comment: "")
            return (false, error)
        }
    }
    
    func isUserValidToRegister(username: String?, password: String?) -> (Bool, String?) {
        let charactersLimit = 2
        if (username?.count ?? 0) > charactersLimit && (password?.count ?? 0) > charactersLimit {
            return (true, nil)
        }
        else {
            let error = NSLocalizedString("Username and password should be bigger than %i characters", comment: "")
            let formattedError = String(format: error, charactersLimit)
            return (false, formattedError)
        }
    }
    
    func loginWithFaceID(completation: @escaping FaceIDCompletion) {
        authManager.authenticateWithFaceID { result, error in
            guard error == nil else {
                completation(false, "Authetication failed")
                return
            }
            completation(result, nil)
        }
    }
}
