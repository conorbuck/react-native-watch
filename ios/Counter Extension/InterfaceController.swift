//
//  InterfaceController.swift
//  Counter Extension
//
//  Created by cbuckley on 12/29/15.
//  Copyright © 2015 Facebook. All rights reserved.
//

import WatchKit
import Foundation
import WatchConnectivity

class InterfaceController: WKInterfaceController, WCSessionDelegate {

    private let session : WCSession? = WCSession.isSupported() ? WCSession.defaultSession() : nil
  
    override init() {
      super.init()
    
      session?.delegate = self
      session?.activateSession()
    }
  
    @IBOutlet var counterLabel: WKInterfaceLabel!
    @IBAction func counterAdd(sender: AnyObject) {
      print("Counter pressed")
      
      let messageData = [
          "some key": "some value"
      ]

      if let session = session where session.reachable {
        session.sendMessage(messageData,
          replyHandler: { replyData in
          }, errorHandler: { error in
            print(error)
        })
      }
    }
  
    func session(session: WCSession, didReceiveMessage message: [String : AnyObject], replyHandler: ([String : AnyObject]) -> Void) {
      let message = message as NSDictionary;
      let value = message.valueForKey("value") as! Int;

      print("received value" + String(value))
      
      self.counterLabel.setText(String(value))
    }

    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
        // Configure interface objects here.
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

}
