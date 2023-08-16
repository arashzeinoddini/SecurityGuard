//
//  LoginViewController.swift
//  SecurityGuard
//
//  Created by Arash Zeinoddini on 8/7/23.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var usernameTextField: PaddedTextField!
    @IBOutlet weak var passwordTextField: PaddedTextField!
    
    var loginViewModel = LoginViewModel()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        setupView()
    }
    
    private func setupView() {
        if loginViewModel.isUserRegistered {
            usernameTextField.placeholder = NSLocalizedString("Enter username", comment: "")
            passwordTextField.placeholder = NSLocalizedString("Enter password", comment: "")
        }
        else {
            usernameTextField.placeholder = NSLocalizedString("Set username", comment: "")
            passwordTextField.placeholder = NSLocalizedString("Set password", comment: "")
        }
        view.setNeedsLayout()
        view.layoutIfNeeded()
    }
    
    @IBAction private func loginViaUserTapped() {
        if !loginViewModel.isUserRegistered {
            
            let (isRegistered, error) = loginViewModel.isUserValidToRegister(username: usernameTextField.text, password: passwordTextField.text)
            
            if !isRegistered {
                let message = error!
                AlertController.shared.present(in: self, message: message)
                return
            }
            
            let user = User(username: usernameTextField.text!, password: passwordTextField.text!)
            if loginViewModel.register(user: user) {
                if let _ = user.devices {
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    let controller = storyboard.instantiateViewController(withIdentifier: "HomeViewController")
                    self.navigationController?.pushViewController(controller, animated: true)
                }
                else {
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    let controller = storyboard.instantiateViewController(withIdentifier: "AddDeviceViewController")
                    self.navigationController?.pushViewController(controller, animated: true)
                }
            }
            
        }
        else {
            let (isLoggedIn, error) = loginViewModel.login(username: usernameTextField.text, password: passwordTextField.text)
            if !isLoggedIn {
                let message = error!
                AlertController.shared.present(in: self, message: message)
                return
            }
            else {
                
                if let _ = loginViewModel.user?.devices {
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    let controller = storyboard.instantiateViewController(withIdentifier: "HomeViewController")
                    self.navigationController?.pushViewController(controller, animated: true)
                }
                else {
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    let controller = storyboard.instantiateViewController(withIdentifier: "AddDeviceViewController")
                    self.navigationController?.pushViewController(controller, animated: true)
                }
            }
        }
    }
    
    @IBAction private func loginViaFaceIDTapped() {
        
        if !loginViewModel.isUserRegistered {
            AlertController.shared.present(in: self, message: "Plese set username and password first")
            return
        }

        loginViewModel.loginWithFaceID { result, error in
            guard error == nil else {
                AlertController.shared.present(in: self, message: error!)
                return
            }
            AlertController.shared.present(in: self, message: "Congurajulation!")
        }
    }
    
    @IBAction private func dismissKeyboard() {
        view.endEditing(true)
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
