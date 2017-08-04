//
//  ProviderBankingPopupViewController.h
//  EmotiLink
//
//  Created by Star on 4/11/17.
//  Copyright © 2017 Stark. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProviderBankingPopupViewController : UIViewController
- (IBAction)NextBtn:(id)sender;
- (IBAction)LogoutBtn:(id)sender;
- (IBAction)BackBtn:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *AcoountTextField;
@property (weak, nonatomic) IBOutlet UITextField *institutionTxtfield;
@property (weak, nonatomic) IBOutlet UITextField *switchcodeTxtfield;

@end
