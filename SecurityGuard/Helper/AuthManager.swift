//
//  AuthManager.swift
//  SecurityGuard
//
//  Created by Arash Zeinoddini on 8/10/23.
//

import Foundation
import LocalAuthentication

class AuthManager {
    typealias AuthenticationCompletion = (Bool, Error?) -> Void
    
    func authenticateWithFaceID(completion: @escaping AuthenticationCompletion) {
        let context = LAContext()
        var error: NSError?
        
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            let reason = "Use Face ID to authenticate"
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { (success, authenticationError) in
                DispatchQueue.main.async {
                    completion(success, authenticationError)
                }
            }
        } else {
            DispatchQueue.main.async {
                completion(false, error)
            }
        }
    }
}
