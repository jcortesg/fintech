//
//  FRRegistroViewController.m
//  Fintech
//
//  Created by John A Torres B on 23/11/13.
//  Copyright (c) 2013 adminova. All rights reserved.
//

#import "FRRegistroViewController.h"

@interface FRRegistroViewController ()

@end

@implementation FRRegistroViewController

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
- (IBAction)registerButton:(id)sender {
    if(self.userTextField.text.length == 0 ||
       self.passtextField.text.length == 0 ||
       self.emailTextfield.text.length == 0) {
        UIAlertView *alertView = [[UIAlertView alloc]
                                  initWithTitle:@"Advertencia"
                                  message:@"Llena todos los campos"
                                  delegate:nil
                                  cancelButtonTitle:@"OK"
                                  otherButtonTitles:nil];
        [alertView show];
        
    } else {
        [self dismissViewControllerAnimated:YES completion:nil];
    }

}
- (IBAction)onFacebookLogin:(id)sender {
   [self dismissViewControllerAnimated:YES completion:nil];
}


@end
