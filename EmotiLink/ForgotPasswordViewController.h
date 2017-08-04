/***************************************************************
 Page name:Forgotpasswordviewcontroller.h
 Created By: zeenath
 Created Date:29/6/16
 Description:Forgot password declaring methods and properties file
 ***************************************************************/

#import <UIKit/UIKit.h>

@interface ForgotPasswordViewController : UIViewController<UITextFieldDelegate>
@property (strong, nonatomic) IBOutlet UIImageView *emailIcon;
@property (strong, nonatomic) UIView *loadingView;
@property (weak, nonatomic) IBOutlet UIView *OTPview;
@property (weak, nonatomic) IBOutlet UITextField *OTPTxt;
- (IBAction)OTPsubmit:(id)sender;
@property (strong, nonatomic) NSDictionary * userDetails;
@property (strong, nonatomic) IBOutlet UIImageView *emailErrorClose;
@property (strong, nonatomic) IBOutlet UITextField *emailTxt;
@property (strong, nonatomic) IBOutlet UIView *emailView;
@property(nonatomic, retain)NSString *secondLabelText;
@property(nonatomic, retain)NSString *emailLabelText;
- (IBAction)emailCloseBtn:(id)sender;
- (IBAction)submitClick:(id)sender;
- (IBAction)cancelClick:(id)sender;
- (IBAction)ConfirmClick:(id)sender;
- (IBAction)backArrowClick:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *emailCloseIcon;

@property (strong, nonatomic) UIAlertController *alert;
@end
