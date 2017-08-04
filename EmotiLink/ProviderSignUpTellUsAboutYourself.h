

/***************************************************************
 Page name:ProviderSignUpTellUsAboutYourself.h
 Created By:ZEENATH
 Created Date:11-07-16
 Description:Information about the provider declaration file
 ***************************************************************/

#import <UIKit/UIKit.h>

@interface ProviderSignUpTellUsAboutYourself : UIViewController<UITextViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
{
    bool myBool;
    bool boolConsenttoTreat;
    bool boolTermsCond;
    NSString *clickedbutton;
    UIImage *profileImage;
    NSString *documentPath;
    NSString *termsConditions;
    NSMutableDictionary *providerDocument;
    NSString *docPath;
}

//Declare global methods and variables
@property (strong, nonatomic) UIView *loadingView;
@property (strong, nonatomic) NSMutableDictionary * providerDetails;
@property (strong, nonatomic) UIAlertController *alert;
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet UIButton *checkboxButton;
@property (weak, nonatomic) IBOutlet UIView *cameraBackView;
@property (strong, nonatomic) IBOutlet UIButton *errorClose;


@property (strong, nonatomic) IBOutlet UIButton *consentToTreat;


@property (strong, nonatomic) IBOutlet UIButton *applyReferralCode;

@property (strong, nonatomic) IBOutlet UITextField *applyReferralCodeText;
@property (strong, nonatomic) IBOutlet UIButton *termConditionCheck;

- (IBAction)consentToTreatClick:(id)sender;

- (IBAction)applyReferralCode:(id)sender;
- (IBAction)termsAndConditionsClick:(id)sender;

- (IBAction)nextClick:(id)sender;

- (IBAction)backClick:(id)sender;

- (IBAction)backArrowClick:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *iagreechkbox;

@property (weak, nonatomic) IBOutlet UILabel *iAgreeTxt;
@property (weak, nonatomic) IBOutlet UILabel *termAndconditionTxt;

- (IBAction)termsAndConditionLable:(id)sender;

@end

//test
