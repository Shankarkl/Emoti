
/***************************************************************
 Page name:ProviderSettingsViewController.h
 Created By:Nalina
 Created Date:19/6/16
 Description:Provider Settings declaration of methods and properties file
 ***************************************************************/


#import <UIKit/UIKit.h>

@interface ProviderSettingsViewController : UIViewController
@property (strong, nonatomic) UIAlertController *alert;
@property (strong, nonatomic) UIView *loadingView;
@property (strong, nonatomic) IBOutlet UIView *myProfileView;
@property (strong, nonatomic) IBOutlet UIView *sessionHistoryView;
@property (strong, nonatomic) IBOutlet UIView *cancelledAppointmentView;
@property (strong, nonatomic) IBOutlet UIView *myClientView;

@property (strong, nonatomic) IBOutlet UIView *aboutUsView;

@property (strong, nonatomic) IBOutlet UIView *faqView;

@property (strong, nonatomic) IBOutlet UIView *termsAndConditionView;
@property (weak, nonatomic) IBOutlet UILabel *AppshareView;
@property (weak, nonatomic) IBOutlet UIImageView *profilePicView;

@property (strong, nonatomic) IBOutlet UIView *logoutView;
- (IBAction)SesionHistoryBtn:(id)sender;
- (IBAction)myClientsBtn:(id)sender;
- (IBAction)AboutUsbtn:(id)sender;
- (IBAction)FAQsBtn:(id)sender;
- (IBAction)TermsBtn:(id)sender;
- (IBAction)LogoutBtn:(id)sender;
- (IBAction)AppshareBtn:(id)sender;

- (IBAction)AmountEarnedBtn:(id)sender;
@end
