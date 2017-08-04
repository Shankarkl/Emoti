/***************************************************************
 Page name: SessionHistoryViewController.h
 Created By:Nalina
 Created Date:11/07/16
 Description:my clients declaration file
 ***************************************************************/

#import <UIKit/UIKit.h>
//#include "listingFilterPopupViewController.h"
#import "SWTableViewCell.h"
@interface SessionHistoryViewController : UIViewController<UITableViewDataSource, UITableViewDelegate,SWTableViewCellDelegate, UITabBarControllerDelegate>

{
    NSIndexPath *perviouseIndexPathaf;
    NSMutableArray *sessionHistoryArray;
    NSMutableDictionary * providerId;
    NSString *urlValue;
    
}



@property (weak, nonatomic) IBOutlet UILabel *headerlbl;
@property (nonatomic, retain) NSString *ProviderId;
@property (nonatomic, retain) NSString *ClientId;
@property (nonatomic, retain) NSString *CreatedBy;
@property (weak, nonatomic) IBOutlet UIView *SessionFilterView;
@property (weak, nonatomic) IBOutlet UIButton *sessionHistoryView;
- (IBAction)CancelBtn:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *ScheduledApointments;
@property (weak, nonatomic) IBOutlet UIButton *SessionApproval;
@property (weak, nonatomic) IBOutlet UIButton *CancelAppointment;
@property (weak, nonatomic) IBOutlet UIButton *RejectAppointment;
- (IBAction)SessionHistoryBtn:(id)sender;
- (IBAction)ScheduleAppointmentBtn:(id)sender;
- (IBAction)sessionApprovalBtn:(id)sender;
- (IBAction)CancelAppointmentBtn:(id)sender;
- (IBAction)RejectAppointmentBtn:(id)sender;

@property (strong, nonatomic) UIView *loadingView;
@property (strong, nonatomic) UIAlertController *alert;
@property (weak, nonatomic) IBOutlet UITableView *sessionHistoryTable;
//@property(weak,nonatomic) NSString * userRole;
@property (strong, nonatomic) NSMutableDictionary * userRole;

- (IBAction)sessionHistoryFilter:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *Backbtn;
- (IBAction)RescheduleAppointment:(id)sender;

- (IBAction)backArrrowClick:(id)sender;
+ (instancetype)sharedInstance;
-(NSMutableArray*)ServiceCall :(UIButton *)thebutton url:(NSString *)url method:(NSString *)method param:(NSDictionary *)param;
@end
