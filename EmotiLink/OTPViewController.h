//
//  OTPViewController.h
//  EmotiLink
//
//  Created by Star on 3/27/17.
//  Copyright © 2017 Stark. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OTPViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *OTPtxt;
- (IBAction)SubmitClick:(id)sender;
@property (strong, nonatomic) UIView *loadingView;
@property (strong, nonatomic) UIAlertController *alert;
@property(nonatomic, retain)NSString *secondLabelText;
@property(nonatomic, retain)NSString *emailLabelText;
- (IBAction)cancelBtnClick:(id)sender;

@end
