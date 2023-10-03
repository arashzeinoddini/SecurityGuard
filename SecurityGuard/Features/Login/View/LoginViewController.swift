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
            
            let error = loginViewModel.isUserValidToRegister(username: usernameTextField.text, password: passwordTextField.text)
            
            if let error = error {
                AlertController.shared.present(in: self, message: error)
                return
            }
            
            let user = User(username: usernameTextField.text!, password: passwordTextField.text!)
            if User.register(user: user) {
                if let _ = user.devices {
                    self.showMainTabbar()
                }
                else {
                    self.showAddDevice()
                }
            }
            
        }
        else {
            let error = loginViewModel.login(username: usernameTextField.text, password: passwordTextField.text)
            if let error = error {
                AlertController.shared.present(in: self, message: error)
                return
            }
            else {
                if let _ = User.getUser()?.devices {
                    self.showMainTabbar()
                }
                else {
                    self.showAddDevice()
                }
            }
        }
    }
    
    private func showMainTabbar() {
        let sceneDelegate = UIApplication.shared.connectedScenes
            .first!.delegate as! SceneDelegate
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "TabBarController") as! TabBarController
        sceneDelegate.window!.rootViewController = controller
        sceneDelegate.window?.makeKeyAndVisible()
    }
    
    private func showAddDevice() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "AddDeviceViewController")
        self.navigationController?.pushViewController(controller, animated: true)
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
            if let _ = User.getUser()?.devices {
                self.showMainTabbar()
            }
            else {
                self.showAddDevice()
            }
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
