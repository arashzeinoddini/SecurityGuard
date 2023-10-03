//
//  DeviceSelectorViewController.swift
//  SecurityGuard
//
//  Created by Arash Zeinoddini on 9/11/23.
//

import UIKit

protocol DeviceSelectorViewControllerDelegate {
    func deviceSelectorViewControllerDidFinish(selectedDevice: Device)
}

class DeviceSelectorViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView : UITableView!
    var delegate : DeviceSelectorViewControllerDelegate?
    
    var devices: [Device] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupView()
    }
    
    func setupView() {
        devices = User.getUser()?.devices ?? []
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        devices.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DeviceTableViewCell", for: indexPath) as! DeviceTableViewCell
        let device = devices[indexPath.row]
        cell.nameLabel.text = device.name
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let device = devices[indexPath.row]
        var user = User.getUser()
        user?.selectedDevice = device
        User.register(user: user!)
        delegate?.deviceSelectorViewControllerDidFinish(selectedDevice: device)
        self.dismiss(animated: true)
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
