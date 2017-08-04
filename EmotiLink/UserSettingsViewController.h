/***************************************************************
 Page name: UserSettingsViewController.h
 Created By:Nalina
 Created Date:20/07/16
 Description: usersettings decalaration of methods and properties file
 ***************************************************************/


#import <UIKit/UIKit.h>

@interface UserSettingsViewController : UIViewController<UIAlertViewDelegate>
@property (strong, nonatomic) UIView *loadingView;
@property (strong, nonatomic) UIAlertController *alert;
@property (strong, nonatomic) IBOutlet UIView *editProfileView;
@property (strong, nonatomic) IBOutlet UIView *changePasswordView;
@property (strong, nonatomic) IBOutlet UIView *paymentInfoView;
@property (strong, nonatomic) IBOutlet UIView *aboutUsView;
@property (strong, nonatomic) IBOutlet UIView *faqView;
@property (strong, nonatomic) IBOutlet UIView *termsAndConditionView;
@property (strong, nonatomic) IBOutlet UIView *logoutView;
@property (weak, nonatomic) IBOutlet UIView *userSettingsBgView;
- (IBAction)aboutUsbtn:(id)sender;
- (IBAction)FAQbtn:(id)sender;
- (IBAction)TermandconditionBtn:(id)sender;
- (IBAction)changePasswordBtn:(id)sender;
- (IBAction)logoutBtn:(id)sender;
- (IBAction)appshareBtn:(id)sender;
- (IBAction)backArrowClick:(id)sender;
@property (weak, nonatomic) IBOutlet UIImageView *profilePicImage;

@end
