/***************************************************************
 Page name: SessionSummaryViewController.h
 Created By:Nalina
 Created Date:2016-07-14
 Description:Session summary methods and functionality declaration Screen.
 ***************************************************************/

#import <UIKit/UIKit.h>

@interface SessionSummaryViewController : UIViewController{
    NSDictionary *appointmentDetails;
    NSMutableDictionary *providerDetails;
}
@property (strong, nonatomic) IBOutlet UIImageView *profile;
@property (strong, nonatomic) IBOutlet UILabel *patientName;
@property (strong, nonatomic) IBOutlet UIImageView *providerProfileImage;
@property (strong, nonatomic) IBOutlet UILabel *providerName;
@property (strong, nonatomic) IBOutlet UILabel *expertiseLabel;
@property (strong, nonatomic) IBOutlet UILabel *timeLabel;
@property (strong, nonatomic) IBOutlet UILabel *costLabel;
@property (strong, nonatomic) IBOutlet UILabel *username;
- (IBAction)makeAnAppointmentClick:(id)sender;

- (IBAction)homeClick:(id)sender;
@property (strong, nonatomic) NSMutableDictionary * details;
@property (strong, nonatomic) NSMutableDictionary * sessionDetails;
@property (strong, nonatomic) NSString * totalSessionTime;

@property (strong, nonatomic) IBOutlet UIButton *homeBtn;
@property (strong, nonatomic) IBOutlet UIView *makeAnAppointmentView;
@property (strong, nonatomic) IBOutlet UIButton *userHomeBtn;
@property (strong, nonatomic) IBOutlet UIButton *providerHomeBtn;

@end
