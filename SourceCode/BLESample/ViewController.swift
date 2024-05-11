//
//  ViewController.swift
//  BLESample
//
//  Created by 蔡佳玲 on 2021/1/29.
//

import UIKit
import CoreBluetooth


class ViewController: UIViewController,CBCentralManagerDelegate, CBPeripheralDelegate ,UITableViewDelegate, UITableViewDataSource{
    
    var centralManager: CBCentralManager!
    var connectPeripheral: CBPeripheral!
    var TargetService : CBService!
    var peripherals = [CBPeripheral]()
    
    var passData:String = ""
    var newVC: CentralViewController?
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return peripherals.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "Peripheralcell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        cell.textLabel?.text = peripherals[indexPath.row].name
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        //"raspberrypi"
        if peripherals[indexPath.row].name == "raspberrypi" {
            
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [self] in
                   let storyboard = UIStoryboard(name: "Main", bundle: nil)
                   
                newVC = (storyboard.instantiateViewController(withIdentifier: "CentralViewController") ) as? CentralViewController
                self.navigationController?.pushViewController(newVC!, animated: true)

            }

        }
    }
    
    

    
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        if central.state == CBManagerState.poweredOn {
                print("BLE powered on")
            central.scanForPeripherals(withServices: nil, options: [CBCentralManagerScanOptionAllowDuplicatesKey: true])
        }else {
                print("Something wrong with BLE")
        }
    }
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "sendSegue" {
            if let showCV = segue.destination as? CentralViewController {
                showCV.data = passData
            }
        }
    }
    
    @IBAction func disConnect(_ sender: Any) {
        self.centralManager.cancelPeripheralConnection(self.connectPeripheral!)
        self.connectPeripheral = nil
        self.title = ""
        disConnectbtn.title = ""
    }
    
    func setUp(){
        peripherals = []
        centralManager = CBCentralManager(delegate: self, queue:nil)
    }
  
    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
        for newPeripheral in peripherals {
            if peripheral == newPeripheral  { return }
        }
        
        if peripheral.name != nil {
            peripherals.append(peripheral)

        }
        if peripheral.name == "raspberrypi" {
            connectPeripheral = peripheral
            centralManager.connect(connectPeripheral, options: nil)
            
        }
        tableView.reloadData()
    
    }
    
    func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
        print("didConnectPeripheral")
        self.title =  "已連上raspberrypi"
        peripheral.delegate = self
        peripheral.discoverServices(nil)
        let controller = UIAlertController(title: "MESSAGE", message: "Connect!", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        controller.addAction(okAction)
        present(controller, animated: true, completion: nil)
    }
    
    func centralManager(_ central: CBCentralManager, didFailToConnect peripheral: CBPeripheral, error: Error?) {
        print(("Failed to connect to connect", peripheral, String(describing: error)))
        let controller = UIAlertController(title: "MESSAGE", message: "Peer removed pairing information", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        controller.addAction(okAction)
        present(controller, animated: true, completion: nil)
    }
    func centralManager(_ central: CBCentralManager, didDisconnectPeripheral peripheral: CBPeripheral, error: Error?) {
        print("didDisconnectPeripheral")
        self.title =  "未連上raspberrypi"
    }
    
    func peripheral(_ peripheral: CBPeripheral, didDiscoverServices error: Error?) {
        guard let services = peripheral.services else { return }
        for service in services {
            peripheral.discoverCharacteristics(nil, for: service)
        }
       
    }
    
    func peripheral(_ peripheral: CBPeripheral, didDiscoverCharacteristicsFor service: CBService, error: Error?) {
        
        guard let characteristics = service.characteristics else {
            return
        }
        for characteristic in characteristics{
            peripheral.readValue(for: characteristic)
            peripheral.setNotifyValue(true, for: characteristic)
        }

    }
    
    func peripheral(_ peripheral: CBPeripheral, didUpdateValueFor characteristic: CBCharacteristic, error: Error?) {
        let resultStr = NSString(data: characteristic.value ?? Data(base64Encoded: "")!, encoding: String.Encoding.utf8.rawValue)
        passData = resultStr! as String
        if newVC != nil {
            newVC?.reciveData(data: passData)
        }
    }

    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var disConnectbtn: UIBarButtonItem!
}

