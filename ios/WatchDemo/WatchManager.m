
//
//  WatchManager.m
//  Metal
//
//  Created by cbuckley on 12/29/15.
//  Copyright © 2015 Facebook. All rights reserved.
//
#import "WatchManager.h"
#import "RCTAppState.h"
#import "RCTAssert.h"
#import "RCTBridge.h"
#import "RCTLog.h"
#import "RCTEventDispatcher.h"

@implementation WatchManager

RCT_EXPORT_MODULE();

@synthesize bridge = _bridge;

- (instancetype)init {
  self = [super init];
  if ( self ) {
    NSNotificationCenter *notificationCenter = [NSNotificationCenter defaultCenter];
    [notificationCenter addObserver:self selector:@selector(onWatchMessage:) name:@"onWatchMessage" object:nil];
  }

  return self;
}

- (void)dealloc {
  [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)dispatchAppEventWithName:(NSString *)name body:(NSDictionary *)body {
  [self.bridge.eventDispatcher sendAppEventWithName:name body:body];
}

- (void)onWatchMessage:(NSDictionary * )data {
  [self dispatchAppEventWithName:@"onWatchMessage" body:data];
}

RCT_EXPORT_METHOD(activate)
{
  if ([WCSession isSupported]) {
    WCSession *session = [WCSession defaultSession];
    session.delegate = self;
    [session activateSession];
  }
}

- (void)session:(nonnull WCSession *)session didReceiveMessage:(nonnull NSDictionary<NSString *,id> *)message replyHandler:(nonnull void (^)(NSDictionary<NSString *,id> * __nonnull)) replyHandler {
  RCTLog(@"Watch: Receieved msg %@", message);
  [self onWatchMessage:message];
}


RCT_EXPORT_METHOD(sendMessage:(NSDictionary *)message)
{
  RCTLog(@"Watch: Sending msg %@", message);
  [[WCSession defaultSession] sendMessage:message
      replyHandler:^(NSDictionary *reply) {
        //
      }
      errorHandler:^(NSError *error) {
        //
      }
   ];
}

@end
