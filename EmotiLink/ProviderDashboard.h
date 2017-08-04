
/***************************************************************
 Page name:ProviderDashboard.h
 Created By:Zeenath
 Created Date:18/7/16
 Description:Dashboard to show the provider information declaration file
 ***************************************************************/

#import <UIKit/UIKit.h>

@interface ProviderDashboard : UIViewController<UITabBarControllerDelegate,UIActionSheetDelegate,UIPageViewControllerDelegate>{
    //int tabSelected;
     NSArray *pickerArray;
     bool myBool;
    NSMutableArray *availabilityArray;
    NSMutableArray *availabilityId;
    NSDictionary *availableData;
    NSMutableArray *scheduledArray;
    NSMutableDictionary *availableTimeDict;
    NSMutableDictionary *responseDict;
    NSString *starttimeOfFirstSchedule;
    NSTimer *availabilityTimer;
    NSString *checkAvailableTime;
    NSString *findClick;
    NSMutableDictionary *scheduleAppointment;
     NSMutableDictionary * contentdict;
    NSNumber *appointmentID;
    NSMutableArray *sessionApprovalCount;
    NSArray *viewControllers;

        //vibha shankar
}
@property (strong, nonatomic) UIPageViewController *pageViewController;


@property (strong, nonatomic) NSMutableArray *contentarray;
@property (strong, nonatomic) UIView *loadingView;
@property (strong, nonatomic) UIAlertController *alert;
@property (weak, nonatomic) IBOutlet UITextField *avialabilityText;
@property (weak, nonatomic) IBOutlet UIImageView *profileImage;
@property (weak, nonatomic) IBOutlet UIView *availableView;
@property (weak, nonatomic) IBOutlet UIView *amountBackView;
@property (weak, nonatomic) IBOutlet UIView *avialabilytyBackView;
@property (weak, nonatomic) IBOutlet UIPickerView *pickerView;
@property (weak, nonatomic) IBOutlet UIView *backView;
@property (weak, nonatomic) IBOutlet UIView *iAmAvailableView;
@property (weak, nonatomic) IBOutlet UIButton *availabilityToggleBtn;
@property (weak, nonatomic) IBOutlet UIView *joinSessionView;
@property (weak, nonatomic) IBOutlet UIView *scheduledAppointmentsView;
@property (strong, nonatomic) IBOutlet UIView *callBackView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *appointmentLabel;
@property (strong, nonatomic) IBOutlet UIView *firstUserBackPage;
@property (weak, nonatomic) IBOutlet UILabel *noOfSessionsLabel;
@property (weak, nonatomic) IBOutlet UILabel *totalBilledLabel;
@property (weak, nonatomic) IBOutlet UILabel *totalDepositedLabel;
@property (strong, nonatomic) IBOutlet UITableView *scheduleTable;
@property (strong, nonatomic) IBOutlet UILabel *noscheduleLabel;
@property (strong, nonatomic) IBOutlet UILabel *setAvailabilityText;
- (IBAction)ScheduledAppointments:(id)sender;
- (IBAction)JointSessionBtn:(id)sender;
- (IBAction)AvialableBtn:(id)sender;

- (IBAction)leftsliderButtonClick:(id)sender;
- (IBAction)rightsliderButtonClick:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *ApointmentUserName;
@property (weak, nonatomic) IBOutlet UILabel *AppointmentOfferedAmount;
@property (weak, nonatomic) IBOutlet UIImageView *AppointmentProfileImageView;
@property (weak, nonatomic) IBOutlet UILabel *AppointmentTime;
@property (weak, nonatomic) IBOutlet UILabel *AppointmentTextLbl;
@property (weak, nonatomic) IBOutlet UILabel *noappointmentLbl;

@property (weak, nonatomic) IBOutlet UIView *dashboardMainView;

@end
