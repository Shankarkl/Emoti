/***************************************************************
 Page name: ScheduledAppointmentsViewController.h
 Created By:Nalina
 Created Date:11/07/16
 Description: scheduled appointment implementation file
 ***************************************************************/

#import <UIKit/UIKit.h>
#import "SWTableViewCell.h"
@interface ScheduledAppointmentsViewController : UIViewController<UITableViewDelegate,SWTableViewCellDelegate, UITableViewDataSource,UITextFieldDelegate>
{
    NSMutableArray *scheduledAppointmentArray;
     NSMutableArray *myProvidersAllDataArray;
}

@property (strong, nonatomic) UIView *loadingView;
@property (strong, nonatomic) UIAlertController *alert;
@property (nonatomic, strong) NSMutableSet *cellsCurrentlyEditing;
@property (strong, nonatomic) IBOutlet UITableView *scheduledTable;
@property (weak, nonatomic) IBOutlet UIView *searchView;
@property (weak, nonatomic) IBOutlet UITextField *searchText;
@property (weak, nonatomic) IBOutlet UIView *scheduleAppointmentView;

@property (weak, nonatomic) IBOutlet UIView *scheduledAppointmentsBackgroundView;
- (IBAction)backArrowClick:(id)sender;


@end
