/***************************************************************
 Page name:ForgotUserNameViewController.h
 Created By:Nalina
 Created Date:30/6/16
 Description:Forgot user name declaration of methods and properties file
 ***************************************************************/

#import <UIKit/UIKit.h>

@interface ForgotUserNameViewController : UIViewController<UITextFieldDelegate>

@property (strong, nonatomic) UIView *loadingView;



@property(nonatomic, retain)NSString *emailLabelText;
@property (strong, nonatomic) IBOutlet UIImageView *emailIcon;
@property (strong, nonatomic) IBOutlet UIView *emailView;
@property (strong, nonatomic) IBOutlet UIImageView *emailErrorClose;
@property (strong, nonatomic) IBOutlet UITextField *emailTxt;
- (IBAction)emailCloseBtn:(id)sender;



@property (weak, nonatomic) IBOutlet UITextField *phoneTxt;
@property (weak, nonatomic) IBOutlet UIImageView *PhoneError;
@property(nonatomic, retain)NSString *secondLabelText;


@property (weak, nonatomic) IBOutlet UIButton *phoneErrorBtn;

- (IBAction)submitClick:(id)sender;
- (IBAction)cancelClick:(id)sender;
@property (weak, nonatomic) IBOutlet UIView *backgroundUserNameView;
@property (strong, nonatomic) UIAlertController *alert;
- (IBAction)backArrowClick:(id)sender;

@end
