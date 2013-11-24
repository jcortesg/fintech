//
//  FRRowViewController.h
//  Fintech
//
//  Created by John A Torres B on 24/11/13.
//  Copyright (c) 2013 adminova. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FRRowViewController : UIViewController 
@property (strong, nonatomic) IBOutlet UISlider *sliderCajeros;
@property (strong, nonatomic) IBOutlet UISlider *rowslider;
@property (strong, nonatomic) IBOutlet UILabel *caValueText;
@property (strong, nonatomic) IBOutlet UILabel *peopleValueText;

@end
