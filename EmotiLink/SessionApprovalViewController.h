/***************************************************************
 Page name: SessionApprovalViewController.h
 Created By:Nalina
 Created Date:08/07/16
 Description: session approval declaration file
 ***************************************************************/

#import <UIKit/UIKit.h>

@interface SessionApprovalViewController : UIViewController<UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate>
{
    NSMutableArray *sessionApprovalArray;
    NSString *toggleBtn;
    NSString *comment;
    NSDictionary * appointmentId;
    NSIndexPath *removeIndexPath;
}
@property (strong, nonatomic) UIView *loadingView;
@property (strong, nonatomic) UIAlertController *alert;
@property (strong, nonatomic) IBOutlet UITableView *sessionTableView;
@property (strong, nonatomic) IBOutlet UIButton *notAvailableBtn;
@property (strong, nonatomic) IBOutlet UIButton *notInterestedBtn;
@property (strong, nonatomic) IBOutlet UIButton *alredyScheduleBtn;
@property (strong, nonatomic) IBOutlet UITextField *reasonTxtField;
- (IBAction)cancelPopupClick:(id)sender;
- (IBAction)okPopupClick:(id)sender;

@property (strong, nonatomic) IBOutlet UIView *confirmationPopUpBackView;
- (IBAction)alredyScheduleClick:(id)sender;
- (IBAction)notInterestedClick:(id)sender;
- (IBAction)notAvailableClick:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *okBtn;
@property (strong, nonatomic) IBOutlet UIButton *doesntMeetRateBtn;
- (IBAction)doesntmeetRateClick:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *otherBtn;
- (IBAction)otherBtnClick:(id)sender;

@end
