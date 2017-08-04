//
//  AmountEarnedViewController.h
//  EmotiLink
//
//  Created by Star on 3/14/17.
//  Copyright © 2017 Stark. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AmountEarnedViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *NoSessions;
@property (weak, nonatomic) IBOutlet UILabel *TotalBillbl;
@property (weak, nonatomic) IBOutlet UILabel *TotalDepositeLbl;
- (IBAction)CloseBtn:(id)sender;
- (IBAction)backbtn:(id)sender;

@end
