/***************************************************************
 Page name:ProviderSignUpFirstViewController.h
 Created By:Zeenath
 Created Date:30/6/16
 Description: Provider sign-up declaration file
 ***************************************************************/

#import <UIKit/UIKit.h>

@interface ProviderSignUpFirstViewController : UIViewController<UITextFieldDelegate>

{
    NSString *clickedbutton;
    NSString *imagePath;

}

@property (strong, nonatomic) NSMutableArray * pickerArray;
@property (strong, nonatomic) UIAlertController *alert;
@property (strong, nonatomic) UIView *loadingView;
@property (weak, nonatomic) IBOutlet UIImageView *profilePicView;

@property (weak, nonatomic) IBOutlet UIView *providerFirstNameView;
@property (weak, nonatomic) IBOutlet UIView *providerLastNameView;
@property (weak, nonatomic) IBOutlet UIView *providerEmailView;
@property (weak, nonatomic) IBOutlet UIView *providerPhoneNumberView;
@property (weak, nonatomic) IBOutlet UIView *providerUsernameView;
@property (weak, nonatomic) IBOutlet UIView *providerStateView;
@property (weak, nonatomic) IBOutlet UIView *providerLicenceNumberView;
@property (weak, nonatomic) IBOutlet UIView *providerQualificationView;
@property (weak, nonatomic) IBOutlet UIView *providerDobView;
@property (weak, nonatomic) IBOutlet UIView *providerSSNView;

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UITextField *lastnameText;
@property (weak, nonatomic) IBOutlet UITextField *usernameText;

@property (weak, nonatomic) IBOutlet UITextField *firstnameText;

@property (weak, nonatomic) IBOutlet UITextField *emailText;
@property (weak, nonatomic) IBOutlet UITextField *phoneNumText;

@property (weak, nonatomic) IBOutlet UITextField *stateText;
@property (weak, nonatomic) IBOutlet UITextField *licenceText;
@property (weak, nonatomic) IBOutlet UITextField *qualificationText;
@property (weak, nonatomic) IBOutlet UITextField *dobText;
@property (weak, nonatomic) IBOutlet UITextField *SSNText;
@property (weak, nonatomic) IBOutlet UIButton *lastnameCloseButton;
    @property (weak, nonatomic) IBOutlet UIView *backgroundSignUpView;

@property (weak, nonatomic) IBOutlet UIButton *firstnameCloseButton;

@property (weak, nonatomic) IBOutlet UIButton *emailCloseButton;
@property (weak, nonatomic) IBOutlet UIButton *phoneNumberCloseButton;
@property (weak, nonatomic) IBOutlet UIButton *usernameCloseButton;

@property (weak, nonatomic) IBOutlet UIButton *stateCloseButton;
@property (weak, nonatomic) IBOutlet UIButton *licenceCloseButton;
@property (weak, nonatomic) IBOutlet UIButton *qualificationButton;
@property (weak, nonatomic) IBOutlet UIButton *SSNCloseButton;
@property (weak, nonatomic) IBOutlet UIButton *dobCloseButton;

@property (weak, nonatomic) IBOutlet UIImageView *firstNameIcon;
@property (weak, nonatomic) IBOutlet UIImageView *lastNameIcon;
@property (weak, nonatomic) IBOutlet UIImageView *emailIcon;
@property (weak, nonatomic) IBOutlet UIImageView *phoneNumberIcon;
@property (weak, nonatomic) IBOutlet UIImageView *userNameIcon;
@property (weak, nonatomic) IBOutlet UIImageView *stateIcon;
@property (weak, nonatomic) IBOutlet UIImageView *licenceIcon;
@property (weak, nonatomic) IBOutlet UIImageView *qualificationIcon;
@property (weak, nonatomic) IBOutlet UIImageView *SSNIcon;
@property (weak, nonatomic) IBOutlet UIImageView *dobIcon;

@property (weak, nonatomic) IBOutlet UIView *pickerBackView;

@property (strong, nonatomic) IBOutlet UIDatePicker *pickerView;

//Action Events for UIControls added by Zeenath
- (IBAction)backButtonAction:(id)sender;
- (IBAction)nextButtonAction:(id)sender;

@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;
@property (weak, nonatomic) IBOutlet UIView *datePickerButtonView;

@property (strong, nonatomic) IBOutlet UIButton *dobDropIcon;
- (IBAction)dobDropClick:(id)sender;

@property(nonatomic,strong) NSMutableDictionary *prepopulateData;

- (IBAction)backClick:(id)sender;

- (IBAction)cameraClick:(id)sender;
- (IBAction)setDateClick:(id)sender;
- (IBAction)cancelDateClick:(id)sender;
- (IBAction)dateofbirthClick:(id)sender;

@end
