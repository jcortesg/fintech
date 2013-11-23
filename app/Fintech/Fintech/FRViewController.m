//
//  FRViewController.m
//  Fintech
//
//  Created by John A Torres B on 23/11/13.
//  Copyright (c) 2013 adminova. All rights reserved.
//

#import "FRViewController.h"
#import <QuartzCore/QuartzCore.h>


@interface FRViewController ()

@end

@implementation FRViewController 

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"YOLO";
	// Do any additional setup after loading the view, typically from a nib.
    // Create a GMSCameraPosition that tells the map to display the
    // coordinate -33.86,151.20 at zoom level 6.

    self.googleMapsView .myLocationEnabled = YES;
    self.googleMapsView .settings.myLocationButton = YES;
 
    
    //Whenever you need to check location
    CLLocation *myLocation =  self.googleMapsView.myLocation;
    NSLog(@"%f %f",myLocation.coordinate.latitude, myLocation.coordinate.longitude);
    
    //self.view =  self.googleMapsView;

    [self.googleMapsView  addObserver:self forKeyPath:@"myLocation" options:NSKeyValueObservingOptionNew context: nil];
}
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"myLocation"] && [object isKindOfClass:[GMSMapView class]])
    {
        
        GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:self.googleMapsView.myLocation.coordinate.latitude
                                                                longitude:self.googleMapsView.myLocation.coordinate.longitude
                                                                     zoom:14];
        [self.googleMapsView animateToCameraPosition:camera];
        [self.googleMapsView removeObserver:self forKeyPath:@"myLocation"];
        self.googleMapsView.layer.zPosition  = 0;

        
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
