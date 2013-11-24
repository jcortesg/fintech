//
//  FRViewController.h
//  Fintech
//
//  Created by John A Torres B on 23/11/13.
//  Copyright (c) 2013 adminova. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <GoogleMaps/GoogleMaps.h>
#import "LDInterface.h"
#import "FRLoginViewController.h"


@interface FRViewController : UIViewController <GMSMapViewDelegate>
{
    LDInterface * api;
    NSArray *json;
    IBOutlet GMSMapView *googleMapsView;
}

@property (strong, nonatomic) IBOutlet UITextField *addressTextField;
@property (strong, nonatomic) IBOutlet UIButton *goButton;
@property (strong, nonatomic) IBOutlet UILabel *raduisText;


@end
