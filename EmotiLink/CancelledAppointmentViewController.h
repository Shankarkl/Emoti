/***************************************************************
 Page name: CancelledAppointmentViewController.h
 Created By:Nalina
 Created Date:11/07/16
 Description:cancelled appointment implementation file
 ***************************************************************/

#import <UIKit/UIKit.h>

@interface CancelledAppointmentViewController : UIViewController<UITableViewDelegate, UITableViewDataSource>
{
    NSMutableArray *cancelledAppointments;
}

@property (weak, nonatomic) IBOutlet UITableView *cancelledAppointmentsTable;

@property (strong, nonatomic) UIView *loadingView;
@property (strong, nonatomic) UIAlertController *alert;


@end
