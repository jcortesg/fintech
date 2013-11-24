//
//  FRRowViewController.m
//  Fintech
//
//  Created by John A Torres B on 24/11/13.
//  Copyright (c) 2013 adminova. All rights reserved.
//

#import "FRRowViewController.h"

@interface FRRowViewController ()

@end

@implementation FRRowViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)cashNumber:(id)sender {
    self.caValueText.text = [NSString stringWithFormat:@"%0.0f",self.sliderCajeros.value];
}

- (IBAction)peopleValue:(id)sender {
     self.peopleValueText.text = [NSString stringWithFormat:@"%0.0f",self.rowslider.value];
}
@end
