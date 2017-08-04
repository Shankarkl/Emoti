/***************************************************************
 Page name:UserSignUpFirstViewController.h
 Created By:Nalina
 Created Date:30/6/16
 Description:User sign-up declaration of properties and methods file
 ***************************************************************/


#import <UIKit/UIKit.h>

@interface UserSignUpFirstViewController : UIViewController<UITextFieldDelegate>{
    CGPoint svos;
    NSString *imagePath;
    bool boolTermsCond;
    NSString *clickedbutton;
     bool myBool;
    NSString *clickedcheckboxbutton;
}

-(void) bindImage;

@property (strong, nonatomic) UIAlertController *alert;
@property (strong, nonatomic) UIView *loadingView;

@property (strong, nonatomic) IBOutlet UIView *firstnameView;
@property (strong, nonatomic) IBOutlet UIView *lastnameView;
@property (strong, nonatomic) IBOutlet UIView *emailView;
@property (strong, nonatomic) IBOutlet UIView *usernameView;
@property (strong, nonatomic) IBOutlet UIView *passwordView;
@property (strong, nonatomic) IBOutlet UIView *confirmPasswordView;
@property (weak, nonatomic) IBOutlet UIView *backgroundUserSignUpView;

- (IBAction)nextBtnClick:(id)sender;
- (IBAction)cancelBtnClick:(id)sender;

@property (strong, nonatomic) IBOutlet UIButton *firstnameError;
- (IBAction)firstnameErrorClose:(id)sender;
@property (strong, nonatomic) IBOutlet UIImageView *firstnameIcon;
@property (strong, nonatomic) IBOutlet UITextField *firstnameTxt;

@property (strong, nonatomic) IBOutlet UIImageView *lastnameIcon;
@property (strong, nonatomic) IBOutlet UITextField *lastnameTxt;
@property (strong, nonatomic) IBOutlet UIButton *lastnameError;
- (IBAction)lastnameErrorClose:(id)sender;

@property (strong, nonatomic) IBOutlet UIImageView *emailIcon;
@property (strong, nonatomic) IBOutlet UITextField *emailTxt;
@property (strong, nonatomic) IBOutlet UIButton *emailError;
- (IBAction)emailErrorClose:(id)sender;


@property (strong, nonatomic) IBOutlet UITextField *phoneNumTxt;
@property (strong, nonatomic) IBOutlet UIButton *phoneNumError;
- (IBAction)phoneNumErrorClose:(id)sender;


@property (strong, nonatomic) IBOutlet UIImageView *userIcon;
@property (strong, nonatomic) IBOutlet UITextField *userTxt;
@property (strong, nonatomic) IBOutlet UIButton *userError;
- (IBAction)userErrorClose:(id)sender;

@property (strong, nonatomic) IBOutlet UITextField *displaynameTxt;
@property (strong, nonatomic) IBOutlet UIButton *displaynameError;
- (IBAction)displaynameErrorClose:(id)sender;

@property (strong, nonatomic) IBOutlet UIImageView *passwordIcon;
@property (strong, nonatomic) IBOutlet UITextField *passwordTxt;
@property (strong, nonatomic) IBOutlet UIButton *passwordError;
- (IBAction)passwordErrorClose:(id)sender;

@property (strong, nonatomic) IBOutlet UIImageView *confirmPasswordIcon;
@property (strong, nonatomic) IBOutlet UITextField *confirmPasswordTxt;
@property (strong, nonatomic) IBOutlet UIButton *confirmPasswordError;
- (IBAction)confirmPasswordErrorClose:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *infoIcon;

- (IBAction)infoIconClick:(id)sender;

@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIButton *confirmInfo;
- (IBAction)ConfirminfoClick:(id)sender;

- (IBAction)backClick:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *eyeBtn;

- (IBAction)eyeBtnTouchDownClick:(id)sender;
@property (weak, nonatomic) IBOutlet UIImageView *profilePicImage;
+ (instancetype)sharedInstance;
-(void)bindImage :(UIImage *)theimage viewcontrol:(UIViewController *)viewcontroller;
- (IBAction)eyeBtnTouchupClick:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *eyeSecBtn;


- (IBAction)eyeSecBtnTouchUpClick:(id)sender;

- (IBAction)eyeSecBtnTouchDownClick:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *termConditionCheck;


@property (weak, nonatomic) IBOutlet UITextField *refferralcodeTxtField;
@property (weak, nonatomic) IBOutlet UIButton *applyReferralCode;


@property (weak, nonatomic) IBOutlet UILabel *iagreelbl;

@property (weak, nonatomic) IBOutlet UILabel *termAndCondlbl;

@property (weak, nonatomic) IBOutlet UIButton *signUpBtn;

- (IBAction)termandconditionBtnClick:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *termconditionBtnLbl;


@end
