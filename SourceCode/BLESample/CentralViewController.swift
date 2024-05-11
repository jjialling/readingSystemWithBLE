//
//  CentralViewController.swift
//  BLESample
//
//  Created by 蔡佳玲 on 2021/2/8.
//

import UIKit
import SwiftUI

class CentralViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{

    let manager = StudentDataManager()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return array.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellIdentifier = "Datacell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! StudentTableViewCell
        cell.cardIDLabel.text = String(array[indexPath.row].cardID)
        cell.nameLabel.text = array[indexPath.row].name
        cell.studentIDLabel.text = String(array[indexPath.row].studentID)
        cell.birthLabel.text = array[indexPath.row].birth
        cell.seatLabel.text = String(array[indexPath.row].seatNumber)
        cell.genderLabel.text = array[indexPath.row].gender
        cell.classroomLabel.text = array[indexPath.row].classroom
        
        return cell
    }
    
    var data = String()
    private var array = [StudentTable]()
    
    override func viewDidAppear(_ animated: Bool) {
        let title = "Message"
        let message = "Its time to Tap your card on the Reader!"
        let confirmMsg = "OK"
        showAlert(title: title, message: message, confirmMsg: confirmMsg, complete: nil)
    }
    
    override func viewDidLoad() {
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "清除", style: .done, target: self, action: #selector(cleanBtn))
        if #available(iOS 16.0, *) {
            self.navigationItem.rightBarButtonItem?.isHidden = true
        } else {
            // Fallback on earlier versions
        }
    }
    
    func showAlert(title: String, message: String, confirmMsg: String, complete: (() -> Void)? = nil) {
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let confirmAction = UIAlertAction(title: confirmMsg, style: .default) { (action) in
            if let complete = complete {
                complete()
            }
        }

        alertVC.addAction(confirmAction)
        DispatchQueue.main.async {
            self.present(alertVC, animated: true, completion: nil)
        }
    }
    
    func reciveData(data:String){
        
        let reciveData = data.replacingOccurrences(of: "\n", with: "")
        
        DispatchQueue.global().async {
            self.manager.filterStudentList(cardID: Int(reciveData) ?? 0) { [weak self] list in
                guard let self = self else { return }
                self.array = list
                
                DispatchQueue.main.async {
                    if !self.array.isEmpty {
                        self.tableView.reloadData()
                        if #available(iOS 16.0, *) {
                            self.navigationItem.rightBarButtonItem?.isHidden = false
                        } else {
                            // Fallback on earlier versions
                        }
                    } else {
                        let title = "MESSAGE"
                        let message = "Cannot find this student infomation\nPlease registe now!"
                        let confirmMsg = "GO"
                        self.showAlert(title: title, message: message, confirmMsg: confirmMsg) {
                            let vc = StudentAccountsViewController(cardID: reciveData)
                            vc.modalPresentationStyle = .fullScreen
                            self.present(vc, animated: true, completion: nil)
                        }
                        if #available(iOS 16.0, *) {
                            self.navigationItem.rightBarButtonItem?.isHidden = true
                        } else {
                            // Fallback on earlier versions
                        }
                    }
                }
                
            }
        }
    }
    @objc func cleanBtn() {
        if #available(iOS 16.0, *) {
            self.navigationItem.rightBarButtonItem?.isHidden = true
        } else {
            // Fallback on earlier versions
        }
        self.array.removeAll()
        tableView.reloadData()
    }
    @IBOutlet weak var tableView: UITableView!
    
}
