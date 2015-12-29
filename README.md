# react-native-watch
react-native-watch includes a demo iOS app with React Native bindings to communicate with iOS WatchKit apps.

![Screen capture](http://www.gfycat.com/LiveImpassionedCleanerwrasse)

** Note: This demo does not use RN views for the UI since WKInterface components are not yet supported. But fear not, using Interface Builder to build out a Watch app UI is not too difficult to learn :) **

## Goal
This repo aims to eventually become an npm module with iOS and Android libraries to provide a simple and cross platform API for watch messaging.

## Getting Started

The demo project should just required a build and run in XCode. However, if you would like to integrate the bindings in your application, you can follow these steps:

1. Copy these files into your project where you see fit:
    These files contain the Objective C RCT module declaration for RN:
     WatchManager.m 
     WatchManager.h
    This is the wrapper for native module:
     WatchManager.js
2.  Create a watch app (plenty of tutorials out there) or use an existing. In your Exension’s default InterfaceController.swift, you’ll have to import WatchConnectivity and implement the WCSessionDelegate. You can add the didReceiveMessage handler like below. (You can also find an example of sending messages in InterfaceController.swift).
    ```
        import WatchConnectivity
       
        class InterfaceController: WKInterfaceController, WCSessionDelegate {
       
            ...
       
           func session(session: WCSession, didReceiveMessage message: [String : AnyObject], replyHandler: ([String : AnyObject]) -> Void) {
               let message = message as NSDictionary;
               let value = message.valueForKey("value") as! Int;
       
               print("received value" + String(value))
           }
    ```
3. You can import `WatchManager.js` and use these methods to setup the WCSession and start sending/receiving data:
    ```
    let WatchManager = require('./WatchManager.js');

    // initialize the session
    WatchManager.activate();

    // send JSON (this turns into an NSDictionary)
    WatchManager.sendMessage({some:'data'});

    // subscribe to incoming message events
    var listener = WatchManager.addMessageListener(msg => {
      console.log(msg);
    });

    // unsubscribe
    WatchManager.removeMessageListener(listener); // alternatively: listener.remove();
    ```

## Known Issues
- This module doesn't currently provide additional events/messages for WCSession state.

