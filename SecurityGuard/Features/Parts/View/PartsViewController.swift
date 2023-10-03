//
//  PartsViewController.swift
//  SecurityGuard
//
//  Created by Arash Zeinoddini on 9/8/23.
//

import UIKit
import MessageUI
import Presentr

class PartsViewController: UIViewController, MFMessageComposeViewControllerDelegate, DeviceSelectorViewControllerDelegate {

    @IBOutlet weak var deviceButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupView()
    }
    
    func setupView() {
        setDeviceButtonTitle()
    }
    
    func setDeviceButtonTitle() {
        let deviceName = "  " + (User.getUser()?.selectedDevice?.name ?? "")
        deviceButton.setTitle(deviceName, for: .normal)
    }
    
    @IBAction func deviceSelectorTapped() {
        let presenter: Presentr = {
            let width = ModalSize.custom(size: 300)
            let height = ModalSize.custom(size: 300)
            let center = ModalCenterPosition.center
            let customType = PresentationType.custom(width: width, height: height, center: center)
            let customPresenter = Presentr(presentationType: customType)
            customPresenter.transitionType = .coverVertical
            customPresenter.dismissTransitionType = .crossDissolve
            customPresenter.roundCorners = true
            customPresenter.cornerRadius = 6
            customPresenter.keyboardTranslationType = .moveUp
            customPresenter.backgroundColor = .black
            customPresenter.backgroundOpacity = 0.6
            customPresenter.backgroundTap = .dismiss
            customPresenter.dismissOnSwipeDirection = .bottom
            customPresenter.dismissOnSwipe = true
            return customPresenter
        }()
        let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = mainStoryboard.instantiateViewController(withIdentifier: "DeviceSelectorViewController") as! DeviceSelectorViewController
        controller.delegate = self
        customPresentViewController(presenter, viewController: controller, animated: true)
    }
    
    @IBAction func activeTapped(sender: UIButton) {
        
        guard MFMessageComposeViewController.canSendText() else {
            AlertController.shared.present(in: self, message: "This device can't send SMS")
            return
        }
        
        var body = ""
        let password = User.getUser()?.selectedDevice?.password ?? ""
        let phoneNumber = User.getUser()?.selectedDevice?.phoneNumber ?? ""
        
        switch sender.tag {
        case 101:
            body = "P" + password + "P3"
        case 102:
            body = "P" + password + "P1"
        case 103:
            body = "P" + password + "P2"
        default:
            break
        }
        
        let controller = MFMessageComposeViewController()
        controller.body = body
        controller.recipients = [phoneNumber]
        controller.messageComposeDelegate = self
        self.present(controller, animated: true, completion: nil)
    }
    
    @IBAction func inactiveTapped(sender: UIButton) {
        guard MFMessageComposeViewController.canSendText() else {
            AlertController.shared.present(in: self, message: "This device can't send SMS")
            return
        }
        
        var body = ""
        let password = User.getUser()?.selectedDevice?.password ?? ""
        let phoneNumber = User.getUser()?.selectedDevice?.phoneNumber ?? ""
        
        switch sender.tag {
        case 201:
            body = "P" + password + "P0"
        case 202:
            body = "P" + password + "P10"
        case 203:
            body = "P" + password + "P20"
        default:
            break
        }
        
        let controller = MFMessageComposeViewController()
        controller.body = body
        controller.recipients = [phoneNumber]
        controller.messageComposeDelegate = self
        self.present(controller, animated: true, completion: nil)
    }
    
    // MARK: - MFMessageComposeViewControllerDelegate
    func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
        //... handle sms screen actions
        controller.dismiss(animated: true, completion: nil)
        
    }
    
    // MARK: - DeviceSelectorViewControllerDelegate
    func deviceSelectorViewControllerDidFinish(selectedDevice: Device) {
        setDeviceButtonTitle()
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
