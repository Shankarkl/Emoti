
/***************************************************************
 Page name:UserDashboardViewController.h
 Created By:Zeenath
 Created Date:14/7/16
 Description:Dashboard to show the user information declaration file
 ***************************************************************/

#import <UIKit/UIKit.h>

@interface UserDashboardViewController : UIViewController<UITabBarControllerDelegate>{
    NSMutableArray *availabilityArray;
    NSMutableArray *availabilityId;
    NSTimer *availabileTimer;
    NSTimer *timer;
    NSNumber *appointmentID;
}


//Declaration of the global methods and variables
@property (strong, nonatomic) UIView *loadingView;
@property (strong, nonatomic) NSDictionary * providerDetails;
@property (strong, nonatomic) NSMutableDictionary *userAfterOnlineSessionDetails;
@property (strong, nonatomic) NSMutableDictionary *onlineDetailsStore;

@property (weak, nonatomic) IBOutlet UIImageView *profileImage;
@property (strong, nonatomic) UIAlertController *alert;
@property (weak, nonatomic) IBOutlet UIView *backgroundView;

@property (strong, nonatomic) IBOutlet UIView *emergencyBackView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *appointmentLabel;
@property (strong, nonatomic) IBOutlet UIView *firstuserBackPage;
@property (strong, nonatomic) IBOutlet UIButton *joinsessionButton;
@property (strong, nonatomic) IBOutlet UIView *joinsession;
- (IBAction)providerMarketPlaceClick:(id)sender;

- (IBAction)joinSessionClick:(id)sender;

- (IBAction)myAppointmentsClick:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *searchProviderBtn;
@property (weak, nonatomic) IBOutlet UIButton *MyAppointmentsBtn;

@end
