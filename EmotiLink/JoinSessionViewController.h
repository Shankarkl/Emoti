
/***************************************************************
 Page name:JoinSessionViewController.h
 Created By:Zeenath
 Created Date:22/7/16
 Description:To join the session declaration file
 ***************************************************************/

#import <UIKit/UIKit.h>

@interface JoinSessionViewController : UIViewController
{
    NSTimer *timer;
    NSString *CurrentDateTime;
    NSString *endTimeString;
    NSString *signalString;
    NSString *timeSpent;
    NSMutableDictionary *sessionDetails;
    int endTime;
    int nowTime;
    int timerAlertStatus;
    NSDateFormatter *timeTickFormatter;
}

//Declaration of global methods and variables
@property (strong, nonatomic)  NSString *joinString;
@property (strong, nonatomic) UIView *loadingView;
@property (strong, nonatomic) NSNumber *appointmentID;
@property (strong, nonatomic) NSString *joinSession;

@property (strong, nonatomic) UIAlertController *alert;
@property (weak, nonatomic) IBOutlet UIView *tokView;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (strong, nonatomic) IBOutlet UILabel *userName;
- (IBAction)cameraclick:(id)sender;
- (IBAction)volumeclick:(id)sender;
- (IBAction)cancelcallclick:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *publishAudioBtn;
- (IBAction)emergencyClick:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *emergenceButton;
@property (weak, nonatomic) IBOutlet UIButton *closeSessionButton;


- (IBAction)yesClick:(id)sender;
- (IBAction)noClick:(id)sender;

@property (weak, nonatomic) IBOutlet UILabel *popupHeading;
@property (weak, nonatomic) IBOutlet UILabel *popupText;
@property (weak, nonatomic) IBOutlet UIView *emergencyPopupMainView;

@end
