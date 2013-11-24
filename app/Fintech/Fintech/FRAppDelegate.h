//
//  FRAppDelegate.h
//  Fintech
//
//  Created by John A Torres B on 23/11/13.
//  Copyright (c) 2013 adminova. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <GoogleMaps/GoogleMaps.h>
#import <FacebookSDK/FacebookSDK.h>
#import "FRLoginViewController.h"



@interface FRAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) FBSession *session;
- (void) loginFB;

@end
