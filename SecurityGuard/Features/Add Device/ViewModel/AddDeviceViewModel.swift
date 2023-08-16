//
//  AddDeviceViewModel.swift
//  SecurityGuard
//
//  Created by Arash Zeinoddini on 8/16/23.
//

import Foundation
class AddDeviceViewModel {
    
    @discardableResult
    func addDevice(name: String?, desc: String?, phoneNumber: String?, password: String?) -> (Bool, String?) {
        let loginViewModel = LoginViewModel()
        guard var user = loginViewModel.user else {
            return (false, "User is not exist")
        }
        guard let name = name , name.count > 0,
              let desc = desc, desc.count > 0,
              let phoneNumber = phoneNumber, phoneNumber.count > 0,
              let password = password, password.count > 0 else {
            return (false, "Fill all items")
        }
        let device = Device(name: name, desc: desc, phoneNumber: phoneNumber, password: password)
        var devices = user.devices ?? []
        devices.append(device)
        user.devices = devices
        loginViewModel.register(user: user)
        return (true, nil)
    }
}
