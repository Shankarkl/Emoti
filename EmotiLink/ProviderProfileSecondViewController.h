/***************************************************************
 Page name: ProviderProfileSecondViewController.h
 Created By: nalina
 Created Date:7/07/16
 Description: provider profile declaration file
 ***************************************************************/

#import <UIKit/UIKit.h>

@interface ProviderProfileSecondViewController : UIViewController<UITextFieldDelegate, UITextViewDelegate>{
    NSArray *pickerArray;
    NSString *clickedbutton;
    
}


@property (strong, nonatomic) UIView *loadingView;
@property (strong, nonatomic) UIAlertController *alertView;
@property (strong, nonatomic) NSMutableDictionary *userProfileData;
@property (strong, nonatomic) NSString *aboutUs;
@property (strong, nonatomic) NSString *gender;
- (IBAction)pageBackClick:(id)sender;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;


@property (weak, nonatomic) IBOutlet UIImageView *profilePicture;


@property (weak, nonatomic) IBOutlet UITextField *addressText;

@property (strong, nonatomic) IBOutlet UIView *addressView;
@property (strong, nonatomic) IBOutlet UIImageView *addressIcon;
@property (strong, nonatomic) IBOutlet UITextView *addressTxt;
@property (strong, nonatomic) IBOutlet UIButton *addressError;
- (IBAction)addressErrorClose:(id)sender;
@property (strong, nonatomic) IBOutlet UIView *licenceNumView;
@property (strong, nonatomic) IBOutlet UITextField *licenceNumTxt;
@property (strong, nonatomic) IBOutlet UIButton *licenceNumError;
@property (strong, nonatomic) IBOutlet UIImageView *licenceNumIcon;
- (IBAction)licenceErrorClose:(id)sender;
@property (strong, nonatomic) IBOutlet UIView *qualificationView;
@property (strong, nonatomic) IBOutlet UIImageView *qualificationIcon;
@property (strong, nonatomic) IBOutlet UITextField *qualificationTxt;
- (IBAction)qualificationPicker:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *qualificationError;
- (IBAction)qualificationErrorClose:(id)sender;
@property (strong, nonatomic) IBOutlet UIView *cityView;
@property (strong, nonatomic) IBOutlet UITextField *cityTxt;
@property (strong, nonatomic) IBOutlet UIButton *cityError;
- (IBAction)cityErrorClose:(id)sender;
@property (strong, nonatomic) IBOutlet UIImageView *cityIcon;

@property (strong, nonatomic) IBOutlet UIView *stateView;
@property (strong, nonatomic) IBOutlet UIImageView *stateIcon;
@property (strong, nonatomic) IBOutlet UITextField *stateTxt;
- (IBAction)statePicker:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *stateError;
- (IBAction)stateErrorClose:(id)sender;
@property (strong, nonatomic) IBOutlet UIView *zipCodeView;
@property (strong, nonatomic) IBOutlet UITextField *zipCodeTxt;
@property (strong, nonatomic) IBOutlet UIButton *zipCodeError;
@property (strong, nonatomic) IBOutlet UIImageView *zipCodeIcon;
- (IBAction)zipCodeErrorClose:(id)sender;
@property (strong, nonatomic) IBOutlet UIView *stateLicensureView;
@property (strong, nonatomic) IBOutlet UIImageView *stateLicensureIcon;

@property (strong, nonatomic) IBOutlet UITextField *stateLicensureTxt;
- (IBAction)stateLicensurePicker:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *stateLicensureError;
- (IBAction)stateLicensureErrorClose:(id)sender;


- (IBAction)backArrow:(id)sender;

- (IBAction)submitClick:(id)sender;
- (IBAction)CancelBtnClick:(id)sender;

@property (strong, nonatomic) IBOutlet UILabel *addressHintLbl;
@property (strong, nonatomic) IBOutlet UIView *pickerBackView;
@property (strong, nonatomic) IBOutlet UIPickerView *pickerView;
@property (strong, nonatomic) IBOutlet UITextField *userNameText;
@property (strong, nonatomic) IBOutlet UITextField *phoneNumberText;
@property (strong, nonatomic) IBOutlet UIButton *userNameErrorClose;
- (IBAction)userNameErrorClick:(id)sender;

@property (strong, nonatomic) IBOutlet UIImageView *userNameIcon;





@end
