/***************************************************************
 Page name: UserProfileViewController.h
 Created By:Nalina
 Created Date:04/07/16
 Description: user profile view decalaration of methods and properties file
 ***************************************************************/

#import <UIKit/UIKit.h>

@interface UserProfileViewController : UIViewController <UITextFieldDelegate, UINavigationControllerDelegate,UIImagePickerControllerDelegate>
{
    NSString *dateOfBirth;
    CGPoint svos;
    NSMutableDictionary *userProfileData;
    NSString *imagePath;
}

//Declaration of global methods and variables
@property (strong, nonatomic) IBOutlet UIImageView *userProfilePicture;
@property (strong, nonatomic) UIAlertController *alert;
@property (strong, nonatomic) UIView *loadingView;
@property (weak, nonatomic) IBOutlet UIView *backgroundUserProfileView;

@property (strong, nonatomic) IBOutlet UIView *firstNameView;
- (IBAction)Firstnamerroricon:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *firstNameIcon;
@property (strong, nonatomic) IBOutlet UITextField *firstNameTxt;
@property (strong, nonatomic) IBOutlet UIButton *firstNameError;
- (IBAction)firstNameErrorClose:(id)sender;



@property (strong, nonatomic) IBOutlet UIView *lastNameView;
@property (strong, nonatomic) IBOutlet UIImageView *lastNameIcon;
@property (strong, nonatomic) IBOutlet UITextField *lastNameTxt;
@property (strong, nonatomic) IBOutlet UIButton *lastNameError;
- (IBAction)lastNameErrorClose:(id)sender;

@property (strong, nonatomic) IBOutlet UIView *emailView;
@property (strong, nonatomic) IBOutlet UIImageView *emailIcon;
@property (strong, nonatomic) IBOutlet UITextField *emailTxt;
@property (strong, nonatomic) IBOutlet UIButton *emailError;
- (IBAction)emailErrorClose:(id)sender;


@property (strong, nonatomic) IBOutlet UIDatePicker *datePickerView;
@property (strong, nonatomic) IBOutlet UIView *datePickerBackView;
@property (strong, nonatomic) IBOutlet UIView *datePickerBtnView;
@property (strong, nonatomic) IBOutlet UIView *dateOfBirthView;
@property (strong, nonatomic) IBOutlet UIImageView *dateOfBirthIcon;
@property (strong, nonatomic) IBOutlet UITextField *dateOfBirthTxt;
@property (strong, nonatomic) IBOutlet UIButton *dateOfBirthError;
- (IBAction)dateOfBirthErrorClick:(id)sender;
- (IBAction)datePickerBtn:(id)sender;
- (IBAction)setDateClick:(id)sender;
- (IBAction)cancelDateClick:(id)sender;

@property (strong, nonatomic) IBOutlet UITextField *phoneNumberTxt;
@property (strong, nonatomic) IBOutlet UIButton *phoneNumberError;
@property (weak, nonatomic) IBOutlet UIButton *phoneerror;


- (IBAction)submitClick:(id)sender;
- (IBAction)cancelClick:(id)sender;
@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic) IBOutlet UIView *photoPopUpView;
- (IBAction)cancelPhotoPopupClick:(id)sender;
- (IBAction)photoUploadClick:(id)sender;
- (IBAction)galleryClick:(id)sender;
- (IBAction)cameraClick:(id)sender;
- (IBAction)backArrowClick:(id)sender;
- (IBAction)imgClick:(id)sender;



- (IBAction)dateTxtfieldClick:(id)sender;


@end
