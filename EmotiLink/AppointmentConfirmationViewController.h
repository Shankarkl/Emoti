/***************************************************************
 Page name: AppointmentConfirmationViewController.h
 Created By: Nalina
 Created Date: 2016-07-20
 Description: Appointment Confirmation methods and functionality declaration file
 ***************************************************************/

#import <UIKit/UIKit.h>

@interface AppointmentConfirmationViewController : UIViewController<UITextFieldDelegate>

@property (strong, nonatomic) UIAlertController *alert;
@property(nonatomic,strong) NSMutableDictionary *postScheduleDetails;
@property(nonatomic,strong) NSMutableDictionary *nextpagedict;
@property (strong, nonatomic) UIView *loadingView;

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic) IBOutlet UILabel *userNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *providerNameLabel;

@property (strong, nonatomic) IBOutlet UILabel *timeFromLabel;
@property (strong, nonatomic) IBOutlet UILabel *timeToLabel;

@property (strong, nonatomic) IBOutlet UILabel *dateTimeLabel;

@property (strong, nonatomic) IBOutlet UIImageView *profileImageView;

@property (strong, nonatomic) IBOutlet UILabel *nameOfTheProviderLabel;
@property (strong, nonatomic) IBOutlet UILabel *expertiseLabel;
@property (strong, nonatomic) IBOutlet UILabel *sessionRateLabel;

@property (strong, nonatomic) IBOutlet UITextField *rateText;
@property (strong, nonatomic) IBOutlet UIButton *rateError;
@property (strong, nonatomic) IBOutlet UILabel *minuteLabel;
@property (weak, nonatomic) IBOutlet UILabel *EstimatedAmount;
- (IBAction)BackClick:(id)sender;

- (IBAction)cancelClick:(id)sender;

- (IBAction)confirmationClick:(id)sender;

@end
