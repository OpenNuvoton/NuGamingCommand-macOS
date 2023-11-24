//
//  MSILed.swift
//  NuGamingCommand
//
//  Created by MS70MAC on 2023/10/12.
//

import Foundation

enum HID_CMD: UInt8 {
    case HID_CMD_ACK = 0x5a
    case HID_CMD_ISP = 0xA0
    case HID_CMD_GET_FW = 0xB0
    case HID_CMD_GET_PARTON = 0xB2
    case HID_CMD_GET_ID = 0xB4
    case HID_CMD_SET_ID = 0xB6
    case HID_CMD_HOMEKEY = 0xC0
    case HID_CMD_AUDIO_VOLUME = 0xC2
}

struct ButtonInfo: Codable {
    var type: String
    var Name: String
    var CMD: Data
    var Note: String
}

class MSILed {
    
    static func getID(usbDevice: RFDevice, callback: @escaping (UInt?, Bool) -> Void) {

        let sendBytes: [UInt8] = [0x01, HID_CMD.HID_CMD_GET_ID.rawValue]
        let data = Data(sendBytes)
        usbDevice.write(data)
        
    }
    
    static func setID(usbDevice: RFDevice, ID: [UInt8], callback: @escaping (Bool) -> Void) {
        
        let sendBytes = [0x01, HID_CMD.HID_CMD_SET_ID.rawValue] + ID
        let data = Data(sendBytes)
        usbDevice.write(data)
        
    }
    
    static func getButton(usbDevice: RFDevice, callback: @escaping (Int?, Bool) -> Void) {
        
        let sendBytes: [UInt8] = [0x01, HID_CMD.HID_CMD_HOMEKEY.rawValue]
        let data = Data(sendBytes)
        usbDevice.write(data)
        
    }
    
    static func setCMD(usbDevice: RFDevice, cmdBuffer: [UInt8], callback: @escaping ([UInt8]?, Bool) -> Void) {
   
        
        var sendBytes = [0x01] + cmdBuffer + [0x0D]
        
        while sendBytes.count < 64 {
            sendBytes += [0x00]
        }
        
        let data = Data(sendBytes)
        usbDevice.write(data)

    }
    
    static func getCMD(usbDevice: RFDevice, cmdBuffer: [UInt8], callback: @escaping ([UInt8]?, Bool) -> Void) {
        
        var sendBytes = [0x01] + cmdBuffer + [0x0D]
        
        while sendBytes.count < 64 {
            sendBytes += [0x00]
        }
        
        let data = Data(sendBytes)
        usbDevice.write(data)
      
    }
}
