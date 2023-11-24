//
//  AppDelegate.swift
//  NuGamingCommand
//
//  Created by MS70MAC on 2023/9/15.
//

import Cocoa
import USBDeviceSwift

@main
class AppDelegate: NSObject, NSApplicationDelegate {

    //宣告 HID Device白名單
    let rfDeviceMonitor = HIDDeviceMonitor([
        HIDMonitorData(vendorId: 1046, productId: 16128),
        HIDMonitorData(vendorId: 5218, productId: 16292)
        ], reportSize: 64)


    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Insert code here to initialize your application
        
        //開始搜尋 HID Device
        let rfDeviceDaemon = Thread(target: self.rfDeviceMonitor, selector:#selector(self.rfDeviceMonitor.start), object: nil)
        rfDeviceDaemon.start()
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }

    func applicationSupportsSecureRestorableState(_ app: NSApplication) -> Bool {
        return true
    }


}

