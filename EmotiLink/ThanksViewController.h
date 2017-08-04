
/***************************************************************
 Page name: ThanksViewController.h
 Created By:Zeenath
 Created Date:13/7/16
 Description:Thank you declaration file
 ***************************************************************/

#import <UIKit/UIKit.h>

@interface ThanksViewController : UIViewController

//Declaration of global methods and variables
@property (strong, nonatomic) NSString *screenStatus;
@property (weak, nonatomic) IBOutlet UILabel *titleText;

@property (weak, nonatomic) IBOutlet UILabel *signingupLabel;
@property (weak, nonatomic) IBOutlet UILabel *reviewLabel;
@property (weak, nonatomic) IBOutlet UILabel *allowUsLabel;
@property (weak, nonatomic) IBOutlet UILabel *updateViaEmailLabel;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;
@property (weak, nonatomic) IBOutlet UILabel *scheduleConfirmationText;
@property (weak, nonatomic) IBOutlet UILabel *loginAndContinueLabel;

@end
