//
//  FRLoginViewController.h
//  Fintech
//
//  Created by John A Torres B on 23/11/13.
//  Copyright (c) 2013 adminova. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FRAppDelegate.h"

@interface FRLoginViewController : UIViewController

@property (strong, nonatomic) IBOutlet UIButton *loginButton;
@property (strong, nonatomic) IBOutlet UITextField *userTextField;
@property (strong, nonatomic) IBOutlet UITextField *passwordTextField;
@end
