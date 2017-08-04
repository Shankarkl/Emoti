/***************************************************************
 Page name:ChangePassword.h
 Created By:Nalina
 Created Date:29/6/16
 Description:Change password declaration of methods and properties file
 ***************************************************************/


#import <UIKit/UIKit.h>

@interface ChangePasswordViewController : UIViewController<UITextFieldDelegate>{
      CGPoint svos;
    NSString *apptoken;
}


//Declaration of global methods and variables
@property (strong, nonatomic) UIView *loadingView;

@property (strong, nonatomic) NSString *screenStatus;
@property (strong, nonatomic) UIAlertController *alertView;

@property (strong, nonatomic) IBOutlet UIView *oldPasswordView;
@property (strong, nonatomic) IBOutlet UIView *passwordView;

@property (strong, nonatomic) IBOutlet UIView *confirmPasswordView;
@property (strong, nonatomic) IBOutlet UIImageView *oldPasswordIcon;

@property (strong, nonatomic) IBOutlet UIImageView *passwordIcon;
@property (strong, nonatomic) IBOutlet UIImageView *confirmPasswordIcon;
@property (weak, nonatomic) IBOutlet UIView *backgroundChangePswView;

@property (strong, nonatomic) IBOutlet UITextField *oldPasswordTxt;

@property (strong, nonatomic) IBOutlet UITextField *passwordTxt;
@property (strong, nonatomic) IBOutlet UITextField *confirmPasswordTxt;
@property (strong, nonatomic) IBOutlet UIButton *oldPasswordClose;
- (IBAction)oldPasswordErrorClose:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *passwordError;
- (IBAction)passwordErrorClose:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *infoBtn;
- (IBAction)infoBtnClose:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *confirmPasswordError;
- (IBAction)confirmPasswordErrorClose:(id)sender;
- (IBAction)submitClick:(id)sender;
- (IBAction)cancelClick:(id)sender;
@property (strong, nonatomic) IBOutlet UIScrollView *scrollview;
@property (strong, nonatomic) IBOutlet UIView *backview;
- (IBAction)backArrowClick:(id)sender;
- (IBAction)oldPasswordTouch:(id)sender;
- (IBAction)oldPasswordTouchDown:(id)sender;
- (IBAction)newPasswordTouch:(id)sender;
- (IBAction)newPasswordDowntouch:(id)sender;
- (IBAction)confirmPasswordtouch:(id)sender;
- (IBAction)confirmPasswordtouchdown:(id)sender;

@property (strong, nonatomic) IBOutlet UIButton *oldErrorIcon;

@property (strong, nonatomic) IBOutlet UIButton *confirmErrorIcon;


@property (strong, nonatomic) IBOutlet UIButton *oldPasswordInfoIcon;

@property (strong, nonatomic) IBOutlet UIButton *changePasswordInfoIcon;

@property (strong, nonatomic) IBOutlet UIButton *confirmPasswordInfoIcon;

@end
