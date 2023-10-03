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
    
    func login(username: String?, password: String?) -> String? {
        guard (username?.count ?? 0) > 0 && (password?.count ?? 0) > 0 else {
            let error = NSLocalizedString("Enter username and password", comment: "")
            return error
        }
        guard let registeredUser = User.getUser() else {
            let error = NSLocalizedString("User is not registered", comment: "")
            return error
        }
        if registeredUser.username == username && registeredUser.password == password {
            return nil
        }
        else {
            let error = NSLocalizedString("Username or password is not correct", comment: "")
            return error
        }
    }
    
    func isUserValidToRegister(username: String?, password: String?) -> String? {
        let charactersLimit = 2
        if (username?.count ?? 0) > charactersLimit && (password?.count ?? 0) > charactersLimit {
            return nil
        }
        else {
            let error = NSLocalizedString("Username and password should be bigger than %i characters", comment: "")
            let formattedError = String(format: error, charactersLimit)
            return formattedError
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
