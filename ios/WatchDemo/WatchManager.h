//
//  WatchManager.h
//  Metal
//
//  Created by cbuckley on 12/29/15.
//  Copyright © 2015 Facebook. All rights reserved.
//

#import "RCTBridgeModule.h"
#import <WatchConnectivity/WatchConnectivity.h>

@interface WatchManager : NSObject <RCTBridgeModule, WCSessionDelegate>
@end
