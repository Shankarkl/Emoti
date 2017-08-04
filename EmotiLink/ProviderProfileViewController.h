/***************************************************************
 Page name: ProviderProfileViewController.m
 Created By: nalina
 Created Date:7/07/16
 Description: provider profile implementation file
 ***************************************************************/

#import <UIKit/UIKit.h>

@interface ProviderProfileViewController : UIViewController<UITextViewDelegate,UITextFieldDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate>
{
    NSArray *dataSource;
    NSString *dateOfBirth;
    NSString *providerImage;
    NSString *userName;
    NSString *name;
    NSMutableDictionary *providerInfo;
    CGPoint svos;
    NSString *imagePath;
    NSString *phoneNumberVal;
    NSString *lastNameVal;
    NSString *userNameVal;
    
}



@property (weak, nonatomic) IBOutlet UIView *pickerBackView;
@property (weak, nonatomic) IBOutlet UIPickerView *pickerView;

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@property (strong, nonatomic) UIView *loadingView;
@property (strong, nonatomic) UIAlertController *alertView;
- (IBAction)pageBackClick:(id)sender;
@property (strong, nonatomic) IBOutlet UIImageView *profilePicView;
@property (strong, nonatomic) IBOutlet UIView *firstnameView;
@property (strong, nonatomic) IBOutlet UITextField *firstnameTxt;
@property (strong, nonatomic) IBOutlet UIButton *firstnameError;
- (IBAction)firstnameErrorClose:(id)sender;
@property (strong, nonatomic) IBOutlet UIImageView *firstnameIcon;
@property (strong, nonatomic) IBOutlet UIView *lastnameView;
@property (strong, nonatomic) IBOutlet UIImageView *lastnameIcon;
@property (strong, nonatomic) IBOutlet UITextField *lastnameTxt;
@property (strong, nonatomic) IBOutlet UIButton *lastnameError;
- (IBAction)lastnameErrorClose:(id)sender;
@property (strong, nonatomic) IBOutlet UIView *emailView;
@property (strong, nonatomic) IBOutlet UITextField *emailTxt;
@property (strong, nonatomic) IBOutlet UIImageView *emailIcon;
@property (strong, nonatomic) IBOutlet UIButton *emailError;

@property (strong, nonatomic) IBOutlet UIView *genderView;
@property (strong, nonatomic) IBOutlet UITextField *genderTxt;
- (IBAction)genderPickerClick:(id)sender;
@property (strong, nonatomic) IBOutlet UIView *dateOfBirthView;
@property (strong, nonatomic) IBOutlet UITextField *dateOfBirthTxt;
- (IBAction)dateOfBirthPicker:(id)sender;


// newly added
@property (weak, nonatomic) IBOutlet UITextField *qualifications;

@property (weak, nonatomic) IBOutlet UITextField *licence;

@property (weak, nonatomic) IBOutlet UITextField *ssn;

@property (strong, nonatomic) IBOutlet UIView *licenceView;
@property (strong, nonatomic) IBOutlet UIView *qualificationsView;
@property (strong, nonatomic) IBOutlet UIView *ssnView;

@property (strong, nonatomic) IBOutlet UIImageView *qualificationIcon;
@property (strong, nonatomic) IBOutlet UIButton *qualificationError;

@property (strong, nonatomic) IBOutlet UIImageView *licenceIcon;
@property (strong, nonatomic) IBOutlet UIButton *licenceError;

@property (strong, nonatomic) IBOutlet UIImageView *ssnIcon;
@property (strong, nonatomic) IBOutlet UIButton *ssnError;
@property (strong, nonatomic) IBOutlet UIButton *dobError;
@property (strong, nonatomic) IBOutlet UIImageView *dobIcon;



- (IBAction)cancelClick:(id)sender;
- (IBAction)nextClick:(id)sender;
@property (strong, nonatomic) IBOutlet UIView *datePickerBackView;
@property (strong, nonatomic) IBOutlet UIDatePicker *datePicker;
- (IBAction)setDateClick:(id)sender;
- (IBAction)cancelDateClick:(id)sender;
@property (strong, nonatomic) IBOutlet UIView *datePickerButtonBackView;

@property (strong, nonatomic) IBOutlet UIView *photoPopupView;
- (IBAction)photoPopUpCancel:(id)sender;
- (IBAction)uploadPhotoClick:(id)sender;
@property (strong, nonatomic) IBOutlet UIPickerView *genderPicker;
- (IBAction)galleryClick:(id)sender;
- (IBAction)cameraClick:(id)sender;

@property (strong, nonatomic) IBOutlet UIView *aboutYourselfView;
@property (strong, nonatomic) IBOutlet UIImageView *aboutYourSelfIcon;
@property (strong, nonatomic) IBOutlet UITextView *aboutYourselfText;
@property (strong, nonatomic) IBOutlet UIButton *aboutYourselfError;

- (IBAction)aboutYourselfErrorClose:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *backClick;
- (IBAction)backIconClick:(id)sender;

@property (weak, nonatomic) IBOutlet UITextField *dumyTxtVw;

//  Added by:Zeenath
//  Added Date:2016-02-09.
//  Description:To resign the textview keyboard.

- (BOOL) textView: (UITextView*) textView
shouldChangeTextInRange: (NSRange) range
  replacementText: (NSString*) text;


@end
