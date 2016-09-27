//
//  StatusMenuController.swift
//  Breakly
//
//  Created by Andrew Youngwerth on 9/27/16.
//  Copyright © 2016 Andrew Youngwerth. All rights reserved.
//
//  Icon made by Freepik from www.flaticon.com 

import Cocoa

class StatusMenuController: NSObject {
  @IBOutlet weak var statusMenu: NSMenu!
  @IBOutlet weak var toggleMenuItem: NSMenuItem!
  
  let statusItem = NSStatusBar.system().statusItem(withLength: NSVariableStatusItemLength)
  let notificationCenter = NSUserNotificationCenter.default
  var timer = Timer()
  
  func sendNote() {
    let note = NSUserNotification()
    note.title = "Time for a break"
    note.informativeText = "You've been sitting for 20 minutes"
    note.deliveryDate = Date(timeIntervalSinceNow: 0)

    notificationCenter.removeAllDeliveredNotifications()
    notificationCenter.deliver(note)
  }
  
  func toggle() {
    if timer.isValid {
      timer.invalidate()
      toggleMenuItem.title = "Turn On"
    } else {
      toggleMenuItem.title = "Turn Off"
      timer = Timer.scheduledTimer(timeInterval: 1200.0, target: self, selector: #selector(StatusMenuController.sendNote), userInfo: nil, repeats: true)

      RunLoop.main.add(timer, forMode: RunLoopMode.defaultRunLoopMode)
    }
  }
  
  override func awakeFromNib() {
    let icon = NSImage(named: "menuicon")
    icon?.isTemplate = true
    statusItem.image = icon
    statusItem.menu = statusMenu
    
    toggle()
  }
  
  @IBAction func toggleClicked(_ sender: NSMenuItem) {
    toggle()
  }
  
  @IBAction func quitClicked(_ sender: NSMenuItem) {
    NSApplication.shared().terminate(self)
  }
}
