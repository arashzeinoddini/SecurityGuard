//
//  AddDeviceViewController.swift
//  SecurityGuard
//
//  Created by Arash Zeinoddini on 8/16/23.
//

import UIKit

class AddDeviceViewController: UIViewController {

    @IBOutlet private weak var nameTextField: UITextField!
    @IBOutlet private weak var descTextField: UITextField!
    @IBOutlet private weak var phoneNumberTextField: UITextField!
    @IBOutlet private weak var passwordTextField: UITextField!
    
    let addDeviceViewModel = AddDeviceViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction private func addDeviceTapped() {
        let (_, error) = addDeviceViewModel.addDevice(name: nameTextField.text, desc: descTextField.text, phoneNumber: phoneNumberTextField.text, password: passwordTextField.text)
        guard error  == nil else {
            AlertController.shared.present(in: self, message: error ?? "")
            return
        }
        
        AlertController.shared.present(in: self, message: "The device has been added successfully") {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let controller = storyboard.instantiateViewController(withIdentifier: "HomeViewController")
            self.navigationController?.pushViewController(controller, animated: true)
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
