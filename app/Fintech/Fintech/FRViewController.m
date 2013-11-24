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
    self.title = @"Tu ubicación";
	// Do any additional setup after loading the view, typically from a nib.
    // Create a GMSCameraPosition that tells the map to display the
    // coordinate -33.86,151.20 at zoom level 6.
    FRAppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    [appDelegate loginFB];
    googleMapsView.myLocationEnabled = YES;
    googleMapsView.settings.myLocationButton = YES;
    googleMapsView.delegate = self;
    
    api = [[LDInterface alloc] init];
 
    
    //Whenever you need to check location
    CLLocation *myLocation =  googleMapsView.myLocation;
    NSLog(@"%f %f",myLocation.coordinate.latitude, myLocation.coordinate.longitude);
    
    //self.view =  self.googleMapsView;

    self.goButton.layer.borderWidth = 1;
    self.goButton.layer.borderColor = [UIColor greenColor].CGColor;

    [googleMapsView  addObserver:self forKeyPath:@"myLocation" options:NSKeyValueObservingOptionNew context: nil];
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"oficinas" ofType:@"json"];
    
    
    //création d'un string avec le contenu du JSON
    NSString *myJSON = [[NSString alloc] initWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:NULL];
    NSError *error;
    json = [NSJSONSerialization JSONObjectWithData:[myJSON dataUsingEncoding:NSUTF8StringEncoding] options:kNilOptions error:&error];
    
 
    
    
  
}
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"myLocation"] && [object isKindOfClass:[GMSMapView class]])
    {
        
        GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:googleMapsView.myLocation.coordinate.latitude
                                                                longitude:googleMapsView.myLocation.coordinate.longitude
                                                                     zoom:14];
        [googleMapsView animateToCameraPosition:camera];
        [googleMapsView removeObserver:self forKeyPath:@"myLocation"];

        for (NSDictionary *object in json) {
            double longitude = [[object objectForKey:@"long"] doubleValue];
            double latitude  = [[object objectForKey:@"lat"] doubleValue];
            GMSMarker *marker = [GMSMarker markerWithPosition:CLLocationCoordinate2DMake(latitude, longitude)];
            marker.icon = [UIImage imageNamed:@"mar3.png"];
            marker.title = @"Sydney";
            marker.snippet = @"Australia";
            marker.map = googleMapsView;
            
        }
//        GMSMutablePath *path = [GMSMutablePath path];
//        [path addLatitude:-33.866 longitude:151.195]; // Sydney
//        [path addLatitude:-18.142 longitude:178.431]; // Fiji
//        [path addLatitude:21.291 longitude:-157.821]; // Hawaii
//        [path addLatitude:37.423 longitude:-122.091]; // Mountain View
//        
//        GMSPolyline *polyline = [GMSPolyline polylineWithPath:path];
//        polyline.strokeColor = [UIColor blueColor];
//        polyline.strokeWidth = 5.f;
//        polyline.map = googleMapsView;;

        
    }
}
-(void)mapView:(GMSMapView *)mapView didChangeCameraPosition:(GMSCameraPosition *)position
{
    NSLog(@"gato");
    NSMutableDictionary * params = [[NSMutableDictionary alloc] init];
    CGPoint point = mapView.center;
    CLLocationCoordinate2D coord = [googleMapsView.projection coordinateForPoint:point];
    [params setObject:[NSString stringWithFormat:@"%f,%f",coord.latitude,coord.longitude] forKey:@"latlng"];
    [params setObject:@"false" forKey:@"sensor"];
    [api setDelegate:self];
    [api setCallback:@selector(onReceivedData:)];
    [api getReverseGeo:params];
    [self upDateRadius];
    
    
}
-(void) onReceivedData:(NSDictionary *)dict {
    
    if ([[dict objectForKey:@"status"] isEqualToString:@"OK"]) {
        
        NSArray * results = [dict objectForKey:@"results"] ;
        
        if(results.count !=0) {
            NSDictionary * dicItem = [results objectAtIndex:0];
            NSString * completeAddress = [dicItem objectForKey:@"formatted_address"];
            NSString * partAddress = [[completeAddress componentsSeparatedByString:@","] objectAtIndex:0];
            [UIView animateWithDuration:1.0
                             animations:^{
                                 self.addressTextField.alpha = 0.0f;
                                 self.addressTextField.text = partAddress;
                                 self.addressTextField.alpha = 1.0f;
                             }];
            
        }
        
    }
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)onGoAction:(id)sender {

    
}
- (void) upDateRadius
{
    CLLocationCoordinate2D bottomLeftCoord =
    googleMapsView.projection.visibleRegion.nearLeft;
    CLLocationCoordinate2D bottomRightCoord =
    googleMapsView.projection.visibleRegion.nearRight;
    double distanceMetres = getDistanceMetresBetweenLocationCoordinates(bottomLeftCoord,
                                                                        bottomRightCoord)/1000;
    self.raduisText.text = [NSString stringWithFormat:@"%0.2f km de rango",distanceMetres];


}
double getDistanceMetresBetweenLocationCoordinates(
                                                   CLLocationCoordinate2D coord1,
                                                   CLLocationCoordinate2D coord2)
{
    CLLocation* location1 =
    [[CLLocation alloc]
     initWithLatitude: coord1.latitude
     longitude: coord1.longitude];
    CLLocation* location2 =
    [[CLLocation alloc]
     initWithLatitude: coord2.latitude
     longitude: coord2.longitude];
    
    return [location1 distanceFromLocation: location2];
}
- (IBAction)showThefile:(id)sender {
}
@end
