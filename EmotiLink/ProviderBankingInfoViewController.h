//
//  ProviderBankingInfoViewController.h
//  EmotiLink
//
//  Created by Starsoft on 2017-03-09.
//  Copyright © 2017 Stark. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProviderBankingInfoViewController : UIViewController
- (IBAction)CancelBtn:(id)sender;

- (IBAction)SubmitBtn:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *instituteTxt;
@property (weak, nonatomic) IBOutlet UITextField *AccountNumberTxt;

@property (weak, nonatomic) IBOutlet UITextField *SwiftCodeTxt;

- (IBAction)backArrow:(id)sender;


@end
