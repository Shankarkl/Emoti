//
//  SessionratepopupsceneViewController.h
//  EmotiLink
//
//  Created by Star on 4/11/17.
//  Copyright © 2017 Stark. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SessionratepopupsceneViewController : UIViewController

@property (strong, nonatomic) IBOutlet UILabel *rateLabel;


@property (strong, nonatomic) IBOutlet UILabel *enterRateLabel;


@property (strong, nonatomic) IBOutlet UITextField *enterRateTextField;

- (IBAction)logOutClick:(id)sender;

- (IBAction)backClick:(id)sender;

- (IBAction)submitClick:(id)sender;


@end
