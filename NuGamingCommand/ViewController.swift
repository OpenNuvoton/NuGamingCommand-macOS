//
//  ViewController.swift
//  NuGamingCommand
//
//  Created by MS70MAC on 2023/8/25.
//

import Cocoa
import USBDeviceSwift

class ViewController: NSViewController {
    
    @IBOutlet weak var sendHexHeader: NSTextField!
    @IBOutlet weak var sendHexRW: NSTextField!
    @IBOutlet weak var sendHex1: NSTextField!
    @IBOutlet weak var sendHex2: NSTextField!
    @IBOutlet weak var sendHex3: NSTextField!
    @IBOutlet weak var sendHex4: NSTextField!
    @IBOutlet weak var sendHex5: NSTextField!
    @IBOutlet weak var sendHex6: NSTextField!
    @IBOutlet weak var sendHex7: NSTextField!
    @IBOutlet weak var sendHex8: NSTextField!
    @IBOutlet weak var sendHex9: NSTextField!
    @IBOutlet weak var sendHex10: NSTextField!
    @IBOutlet weak var sendHex11: NSTextField!
    @IBOutlet weak var sendHex12: NSTextField!
    @IBOutlet weak var sendHex13: NSTextField!
    @IBOutlet weak var sendHex14: NSTextField!
    @IBOutlet weak var sendHex15: NSTextField!
    @IBOutlet weak var sendHex16: NSTextField!
    @IBOutlet weak var sendHex17: NSTextField!
    @IBOutlet weak var sendHex18: NSTextField!
    @IBOutlet weak var sendHex19: NSTextField!
    @IBOutlet weak var sendHex20: NSTextField!
    @IBOutlet weak var sendHex21: NSTextField!
    @IBOutlet weak var sendHex22: NSTextField!
    @IBOutlet weak var sendHex23: NSTextField!
    @IBOutlet weak var sendHex24: NSTextField!
    
    @IBOutlet weak var readHexHeader: NSTextField!
    @IBOutlet weak var readHexRW: NSTextField!
    @IBOutlet weak var readHex1: NSTextField!
    @IBOutlet weak var readHex2: NSTextField!
    @IBOutlet weak var readHex3: NSTextField!
    @IBOutlet weak var readHex4: NSTextField!
    @IBOutlet weak var readHex5: NSTextField!
    @IBOutlet weak var readHex6: NSTextField!
    @IBOutlet weak var readHex7: NSTextField!
    @IBOutlet weak var readHex8: NSTextField!
    @IBOutlet weak var readHex9: NSTextField!
    @IBOutlet weak var readHex10: NSTextField!
    @IBOutlet weak var readHex11: NSTextField!
    @IBOutlet weak var readHex12: NSTextField!
    @IBOutlet weak var readHex13: NSTextField!
    @IBOutlet weak var readHex14: NSTextField!
    @IBOutlet weak var readHex15: NSTextField!
    @IBOutlet weak var readHex16: NSTextField!
    @IBOutlet weak var readHex17: NSTextField!
    @IBOutlet weak var readHex18: NSTextField!
    @IBOutlet weak var readHex19: NSTextField!
    @IBOutlet weak var readHex20: NSTextField!
    @IBOutlet weak var readHex21: NSTextField!
    @IBOutlet weak var readHex22: NSTextField!
    @IBOutlet weak var readHex23: NSTextField!
    @IBOutlet weak var readHex24: NSTextField!
    
    //    @IBOutlet weak var textFields: [NSTextField]!
    
    @IBOutlet weak var devicesComboBox: NSComboBox!
    @IBOutlet weak var connectButton: NSButton!
    @IBOutlet weak var tabListView: NSTableView!
    @IBOutlet weak var tabListView2: NSTableView!
    //    @IBOutlet weak var noteFields: NSTextField!
    @IBOutlet var noteTextview: NSTextView!
    @IBOutlet weak var homeKeyCheckbox: NSButton!
    @IBOutlet weak var homeKeyTime: NSTextField!
    @IBOutlet weak var transmitButton: NSButton!
    @IBOutlet weak var setIDButton: NSButton!
    @IBOutlet weak var idText: NSTextField!
    
    var timer: Timer?
    var sendFields: [NSTextField] = []
    var readFields: [NSTextField] = []
    
    var connectedDevice:RFDevice?
    var devices:[RFDevice] = []
    var buttonInfoArray : [ButtonInfo] = []
    var buttonInfoArray2 : [ButtonInfo] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sendFields = [sendHexHeader,sendHexRW,sendHex1,sendHex2,sendHex3,sendHex4,sendHex5,sendHex6,sendHex7,sendHex8,sendHex9,sendHex10,sendHex11,sendHex12,sendHex13,sendHex14,sendHex15,sendHex16,sendHex17,sendHex18,sendHex19,sendHex20,sendHex21,sendHex22,sendHex23,sendHex24]
        readFields = [readHexHeader,readHexRW,readHex1,readHex2,readHex3,readHex4,readHex5,readHex6,readHex7,readHex8,readHex9,readHex10,readHex11,readHex12,readHex13,readHex14,readHex15,readHex16,readHex17,readHex18,readHex19,readHex20,readHex21,readHex22,readHex23,readHex24]
        
        devicesComboBox.dataSource = self
        self.tabListView.delegate = self
        self.tabListView.dataSource = self
        self.tabListView2.delegate = self
        self.tabListView2.dataSource = self
        tabListView.headerView = nil
        tabListView2.headerView = nil
        noteTextview.string = ""
        homeKeyCheckbox.target = self
        homeKeyCheckbox.action = #selector(checkboxStateChanged(_:))
        idText.delegate = self
        // 設定只接受數字
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .none
        idText.formatter = numberFormatter
        
        //宣告接收事件通知
        NotificationCenter.default.addObserver(self, selector: #selector(self.usbConnected), name: .HIDDeviceConnected, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.usbDisconnected), name: .HIDDeviceDisconnected, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.hidReadData), name: .HIDDeviceDataReceived, object: nil)
        
        //        //使用IOHIDManagerCreate取得USB HID裝置列表
        //        let manager = IOHIDManagerCreate(kCFAllocatorDefault, IOOptionBits(kIOHIDOptionsTypeNone))
        //        let matchingDict = [kIOHIDDeviceUsagePageKey: kHIDPage_GenericDesktop,
        //                            kIOHIDDeviceUsageKey: kHIDUsage_GD_Keyboard] as CFDictionary
        
        //取得JSON1資料
        guard let url = Bundle.main.url(forResource: "get_command", withExtension: "json") else {
            return
        }
        
        do {
            let jsonData = try Data(contentsOf: url)
            let decoder = JSONDecoder(hexDataDecoding: true)
            buttonInfoArray = try decoder.decode([ButtonInfo].self, from: jsonData)
            print(buttonInfoArray)
            self.tabListView.reloadData()
        } catch {
            print("Error decoding JSON: \(error)")
        }
        
        //取得JSON2資料
        guard let url = Bundle.main.url(forResource: "set_command", withExtension: "json") else {
            return
        }
        
        do {
            let jsonData = try Data(contentsOf: url)
            let decoder = JSONDecoder(hexDataDecoding: true)
            buttonInfoArray2 = try decoder.decode([ButtonInfo].self, from: jsonData)
            print(buttonInfoArray2)
            self.tabListView2.reloadData()
        } catch {
            print("Error decoding JSON: \(error)")
        }
        
    }
    
    @IBAction func ConnectButton(_ sender: NSButton) {
        DispatchQueue.main.async {
            if (self.devices.count > 0) {
                if (self.connectedDevice != nil) {
                    self.connectButton.title = "Connect"
                    self.devicesComboBox.isEnabled = true
                    self.connectedDevice = nil
                } else {
                    self.connectButton.title = "Disconnect"
                    self.devicesComboBox.isEnabled = false
                    self.connectedDevice = self.devices[self.devicesComboBox.integerValue] //選定 connected Device
                    self.GetID()
                    
                    
                }
            }
        }
        
    }
    
    func GetID(){
        if let connectedDevice = self.connectedDevice{
            
            let byteArray: [UInt8] = [0xB4]
            MSILed.getCMD(usbDevice: connectedDevice, cmdBuffer: byteArray) { asd, istrue in}
            
            
        }
    }
    @IBAction func SetID(_ sender: NSButton) {
        if idText.stringValue.count < 8 {
            let alert = NSAlert()
            alert.messageText = "Informational"
            alert.informativeText = "ID input error."
            alert.alertStyle = .informational
            
            // 添加確定按鈕
            alert.addButton(withTitle: "ok")
            
            // 顯示訊息視窗
            alert.runModal()
            return
        }
        
        let inputString = idText.stringValue
        var byteArray: [UInt8] = []

        var index = inputString.startIndex
        while index < inputString.endIndex {
            let endIndex = inputString.index(index, offsetBy: 2, limitedBy: inputString.endIndex) ?? inputString.endIndex
            let substring = inputString[index..<endIndex]
            
            if let byte = UInt8(substring, radix: 16) {
                byteArray.append(byte)
            }
            
            index = endIndex
        }

        let data = Data(byteArray)
        
        let sendByteArray: [UInt8] = [0xB6] + data
        MSILed.getCMD(usbDevice: connectedDevice!, cmdBuffer: sendByteArray) { asd, istrue in}
    }
    
    @objc func checkboxStateChanged(_ sender: NSButton) {
        
        // Declare a timer variable outside the scope
        let connectedDevice = self.connectedDevice
        if  (connectedDevice == nil){
            homeKeyCheckbox.state = .off
            return
        }
        if homeKeyCheckbox.state == .on {
            transmitButton.isEnabled = false
            connectButton.isEnabled = false
            setIDButton.isEnabled = false
            homeKeyTime.isEditable = false
        }else{
            transmitButton.isEnabled = true
            connectButton.isEnabled = true
            setIDButton.isEnabled = true
            homeKeyTime.isEditable = true
        }
        
        if let time = Double(homeKeyTime.stringValue) {
            // Successfully converted the string to a Double
            let adjustedTime = time * 0.001  // Adjust the time as needed
            
            if homeKeyCheckbox.state == .on {
                print("Checkbox is selected.")
                
                // Use the adjustedTime as the time interval for Timer
                timer = Timer.scheduledTimer(withTimeInterval: adjustedTime, repeats: true) { timer in
                    let byteArray: [UInt8] = [0xC0]
                    MSILed.getCMD(usbDevice: connectedDevice!, cmdBuffer: byteArray) { asd, istrue in }
                    print("Timer fired!")
                }
            } else {
                // Checkbox is deselected
                print("Checkbox is deselected.")
                timer?.invalidate()  // Stop the timer
                timer = nil
            }
        } else {
            // Failed to convert the string to a Double
            homeKeyCheckbox.state = .off
            return
        }
        
        
        
    }
    
    @IBAction func TransmitButton(_ sender: NSButton) {
        
        DispatchQueue.main.async {
            if let connectedDevice = self.connectedDevice{
                
                var byteArray: [UInt8] = [ ]
                
                var hexString = ""
                
                for sf in self.sendFields{
                    hexString.append(sf.stringValue)
                }
                
                byteArray = HexTool().hexStringToBytes(hexString)

                MSILed.getCMD(usbDevice: connectedDevice, cmdBuffer: byteArray) { asd, istrue in
                    
                }
                
            }
        }
        
    }
    
    @objc func usbConnected(notification: NSNotification) {
        guard let nobj = notification.object as? NSDictionary else {
            return
        }
        
        guard let deviceInfo:HIDDevice = nobj["device"] as? HIDDevice else {
            return
        }
        let device = RFDevice(deviceInfo)
        DispatchQueue.main.async {
            self.devices.append(device)
            self.devicesComboBox.reloadData()
        }
    }
    
    @objc func usbDisconnected(notification: NSNotification) {
        guard let nobj = notification.object as? NSDictionary else {
            return
        }
        
        guard let id:Int32 = nobj["id"] as? Int32 else {
            return
        }
        DispatchQueue.main.async {
            if let index = self.devices.index(where: { $0.deviceInfo.id == id }) {
                self.devices.remove(at: index)
                if (id == self.connectedDevice?.deviceInfo.id) {
                    self.connectedDevice = nil
                }
            }
            self.devicesComboBox.reloadData()
        }
    }
    
    
    //資料回來通知
    @objc func hidReadData(notification: Notification) {
        let obj = notification.object as! NSDictionary
        let data = obj["data"] as! Data
        
        //data to hex string
        print(data.toHexString())
        
        //getID
        if(data[1] == 0x5a){
            let idBytes = [data[2], data[3], data[4], data[5]]
            let idString = idBytes.map { String(format: "%02X", $0) }.joined()
            print(idString)
            DispatchQueue.main.async {
                self.idText.stringValue = idString
            }
            return
        }
        
        //HomeKey
        DispatchQueue.main.async {
            if(self.homeKeyCheckbox.state == .on){
                if(data[10] == 0x31){
                    let alert = NSAlert()
                    alert.messageText = "Informational"
                    alert.informativeText = "Home key is pressed"
                    alert.alertStyle = .informational
                    
                    // 添加確定按鈕
                    alert.addButton(withTitle: "ok")
                    
                    // 顯示訊息視窗
                    alert.runModal()
                }
                return
            }
        }
        DispatchQueue.main.async {
            for (i, byte) in data.enumerated() {
                if(i==0){
                    continue
                }
                if(byte == 0x0D || byte == 0x0d ){
                    self.readFields[25].stringValue = "0D"
                    return
                }
                
                self.readFields[i-1].stringValue = byte.toHexString()
            }
        }
        
        
        
        if let str = self.connectedDevice?.convertByteDataToString(data) {
            DispatchQueue.main.async {
                //                self.inputTextView?.string = "\(self.inputTextView!.string)\(str)\n"
                //                self.inputTextView?.scrollToEndOfDocument(self)
            }
        }
    }
    
    
    
}

extension ViewController : NSTextFieldDelegate{
    
    // NSTextFieldDelegate method to limit the length
      func controlTextDidChange(_ obj: Notification) {
          if let textField = obj.object as? NSTextField {
              let maxLength = 8
              if textField.stringValue.count > maxLength {
                  let index = textField.stringValue.index(textField.stringValue.startIndex, offsetBy: maxLength)
                  textField.stringValue = String(textField.stringValue.prefix(upTo: index))
              }
          }
      }
    
}

//USB HID 可連線裝置列表
extension ViewController:NSComboBoxDataSource{
    
    
    func numberOfItems(in comboBox: NSComboBox) -> Int {
        //        return 1
        return self.devices.count
    }
    
    func comboBox(_ comboBox: NSComboBox, objectValueForItemAt index: Int) -> Any? {
        //        return "xxx"
        return self.devices[index].deviceInfo.manufacturer + "_" + self.devices[index].deviceInfo.name
    }
}

//CMD Button 列表
extension ViewController : NSTableViewDelegate,NSTableViewDataSource {
    
    
    func numberOfRows(in tableView: NSTableView) -> Int {
        if tableView == self.tabListView {
            return buttonInfoArray.count
        } else if tableView == self.tabListView2 {
            return buttonInfoArray2.count
        }
        return 0
        
    }
    
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        var buttonInfo = buttonInfoArray[row]
        
        
        if tableView == self.tabListView {
            buttonInfo = buttonInfoArray[row]
        } else if tableView == self.tabListView2 {
            buttonInfo = buttonInfoArray2[row]
        }
        
        let itemCell = tableView.makeView(withIdentifier: NSUserInterfaceItemIdentifier("ButtonCell"), owner: self) as? NSTableCellView
        let titleCell = tableView.makeView(withIdentifier: NSUserInterfaceItemIdentifier("TitleCell"), owner: self) as? NSTableCellView
        
        if buttonInfo.type == "Item" {
            // 根据pyte属性返回ButtonCell
            itemCell!.textField?.stringValue = buttonInfo.Name
            return itemCell
        }
        
        if buttonInfo.type == "Header" {
            // 根据pyte属性返回TitleCell
            titleCell!.textField?.stringValue = buttonInfo.Name
            return titleCell
        }
        
        return nil
    }
    
    // 单元格点击事件处理
    func tableViewSelectionDidChange(_ notification: Notification) {
        if let tableView = notification.object as? NSTableView {
            
            var selectedButtonInfo : ButtonInfo? = nil
            for i in 0..<sendFields.count {
                sendFields[i].stringValue = ""
            }
            
            
            if tableView == self.tabListView {
                let selectedRow = tableView.selectedRow
                selectedButtonInfo = buttonInfoArray[selectedRow]// 获取选定行的数据
                
            }
            if tableView == self.tabListView2 {
                let selectedRow = tableView.selectedRow
                selectedButtonInfo = buttonInfoArray2[selectedRow]// 获取选定行的数据
                
            }
            
            // 在这里处理点击事件，可以根据选定的数据执行相应的操作
            // 例如，弹出对话框或导航到其他视图控制器等
            print("点击了按钮: \(selectedButtonInfo!.Name)")
            
            if(selectedButtonInfo!.type == "Header"){
                for i in 0..<sendFields.count {
                    sendFields[i].stringValue = ""
                }
            }
            
            for (i, byte) in selectedButtonInfo!.CMD.enumerated() {
                // 假设 sendFields 是一个数组，您可以通过 i 来访问索引并设置值
                if i < sendFields.count {
                    sendFields[i].stringValue = byte.toHexString()
                } else {
                    // 如果 i 超出了 sendFields 数组的范围，您可以选择是终止循环还是采取其他操作
                    break
                }
            }
            
            noteTextview.string = selectedButtonInfo!.Note
            sendFields[25].stringValue = "0D"
            
            
        }
    }
}
