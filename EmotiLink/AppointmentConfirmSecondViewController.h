//
//  AppointmentConfirmSecondViewController.h
//  EmotiLink
//
//  Created by Star on 4/27/17.
//  Copyright © 2017 Stark. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppointmentConfirmSecondViewController : UIViewController
@property(nonatomic,strong) NSMutableDictionary *providerDetails;
@property(nonatomic,strong) NSMutableDictionary *details;
@property (weak, nonatomic) IBOutlet UILabel *ThankyouLBL;
@property (weak, nonatomic) IBOutlet UILabel *yourappointmentlbl;

@property (weak, nonatomic) IBOutlet UIButton *homebtn;
@property (weak, nonatomic) IBOutlet UIButton *bookanotherbtn;
- (IBAction)bookbtn:(id)sender;
- (IBAction)homebtn:(id)sender;

@end
