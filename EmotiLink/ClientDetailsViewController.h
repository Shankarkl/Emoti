/***************************************************************
 Page name: ClientDetailsViewController.h
 Created By: Nalina
 Created Date: 2016-09-13
 Description:Client details display declaration screen
 ***************************************************************/

#import <UIKit/UIKit.h>

@interface ClientDetailsViewController : UIViewController{
    NSString *toggleBtn;
    NSString *comment;
    NSString *imageIs;
}

@property (strong, nonatomic) IBOutlet UILabel *headingLabel;
@property (strong, nonatomic) IBOutlet UILabel *providerNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *userNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *fromTimeLabel;
@property (strong, nonatomic) IBOutlet UILabel *toTimeLabel;
@property (strong, nonatomic) IBOutlet UILabel *dateLabel;
@property (strong, nonatomic) IBOutlet UIImageView *userProfilePicture;
@property (strong, nonatomic) IBOutlet UILabel *userFirstLastnameLabel;
@property (strong, nonatomic) IBOutlet UILabel *offeredAmountLabel;
@property (strong, nonatomic) IBOutlet UIButton *cancelBtn;
@property (strong, nonatomic) IBOutlet UIButton *submitBtn;
@property (strong, nonatomic) NSMutableDictionary * detailsDict;
@property (strong, nonatomic) NSString *screenStatus;
@property (strong, nonatomic) IBOutlet UILabel *qualificationLbl;


@property (strong, nonatomic) UIView *loadingView;
@property (strong, nonatomic) UIAlertController *alert;
@property (strong, nonatomic) IBOutlet UIButton *notAvailableBtn;
@property (strong, nonatomic) IBOutlet UIButton *notInterestedBtn;
@property (strong, nonatomic) IBOutlet UIButton *alredyScheduleBtn;
@property (strong, nonatomic) IBOutlet UITextField *reasonTxtField;
@property (strong, nonatomic) IBOutlet UIView *confirmationPopUpBackView;
@property (strong, nonatomic) IBOutlet UIButton *doesntMeetRateBtn;
@property (strong, nonatomic) IBOutlet UIButton *otherBtn;
- (IBAction)pagebackClick:(id)sender;
@property (strong, nonatomic) IBOutlet UILabel *rateLabel;

@end
