

/***************************************************************
 Page name:  ProviderSignUpSecondViewController.h
 Created By: Zeenath
 Created Date:01/07/16
 Description: Provider SignUp decalaration file
 ***************************************************************/

#import <UIKit/UIKit.h>

@interface ProviderSignUpSecondViewController : UIViewController<UITextViewDelegate,UITextFieldDelegate>

{
    
        NSArray *pickerArray;
        NSString *clickedbutton;
        CGPoint svos;
    

}
@property (strong, nonatomic) NSMutableArray * pickerArray;
@property (strong, nonatomic) NSMutableDictionary * providerDetails;
@property (strong, nonatomic) UIAlertController *alert;
@property (weak, nonatomic) IBOutlet UIView *addressView;
@property (weak, nonatomic) IBOutlet UIView *cityView;
@property (weak, nonatomic) IBOutlet UIView *stateView;
@property (weak, nonatomic) IBOutlet UIView *zipcodeView;
@property (weak, nonatomic) IBOutlet UIView *usernameView;
@property (weak, nonatomic) IBOutlet UIView *passwordView;
@property (weak, nonatomic) IBOutlet UIView *confirmPasswordView;
@property (weak, nonatomic) IBOutlet UIView *mainViewBackground;

@property (weak, nonatomic) IBOutlet UITextField *AddressTextField;



@property (weak, nonatomic) IBOutlet UITextView *addressTextView;
@property (weak, nonatomic) IBOutlet UITextField *cityTextField;
@property (weak, nonatomic) IBOutlet UITextField *stateTextField;
@property (weak, nonatomic) IBOutlet UITextField *zipcodeTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UITextField *confirmPasswordTextField;
@property (weak, nonatomic) IBOutlet UITextField *usernameTextField;
    @property (weak, nonatomic) IBOutlet UIView *backgroundSecondView;

@property (weak, nonatomic) IBOutlet UIButton *addressCloseButton;
@property (weak, nonatomic) IBOutlet UIButton *cityCloseButton;
@property (weak, nonatomic) IBOutlet UIButton *stateCloseButton;
@property (weak, nonatomic) IBOutlet UIButton *zipcodeCloseButton;
@property (weak, nonatomic) IBOutlet UIButton *usernameCloseButton;
@property (weak, nonatomic) IBOutlet UIButton *passwordCloseButton;
@property (weak, nonatomic) IBOutlet UIButton *confirmPasswordCloseButton;

@property (weak, nonatomic) IBOutlet UIImageView *addressIcon;
@property (weak, nonatomic) IBOutlet UIImageView *cityIcon;
@property (weak, nonatomic) IBOutlet UIImageView *stateIcon;
@property (weak, nonatomic) IBOutlet UIImageView *zipcodeIcon;
@property (weak, nonatomic) IBOutlet UIImageView *usernameIcon;
@property (weak, nonatomic) IBOutlet UIImageView *passwordIcon;
@property (weak, nonatomic) IBOutlet UIImageView *confirmPasswordIcon;

@property (weak, nonatomic) IBOutlet UIView *loadingView;
@property (weak, nonatomic) IBOutlet UIView *pickerBackView;
@property (strong, nonatomic) IBOutlet UIPickerView *pickerView;
@property (weak, nonatomic) IBOutlet UIButton *InfoIcon;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
- (IBAction)PasswordInfoIcon:(id)sender;

@property (strong, nonatomic) IBOutlet UIButton *confirmPassWordInfoIcon;

@property (strong, nonatomic) IBOutlet UIButton *stateDropIcon;

- (IBAction)stateDropClick:(id)sender;

- (IBAction)backClick:(id)sender;
- (IBAction)nextClick:(id)sender;

- (IBAction)confirmPassowrdInfoClick:(id)sender;

- (IBAction)backArrowClick:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *eyeIconBtn;
- (IBAction)eyeBtnTouchUpClick:(id)sender;
- (IBAction)eyeBtnDownClick:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *eyeIconSecondBtn;
- (IBAction)eyeIconSecTouchUp:(id)sender;
- (IBAction)eyeIconTouchDown:(id)sender;

@end
