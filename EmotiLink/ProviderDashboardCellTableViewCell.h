/***************************************************************
 Page name:ProviderDashboardCellTableViewCell.h
 Created By:Zeenath
 Created Date:18/7/16
 Description:Tableview to show the daily appointments declaration file
 ***************************************************************/

#import <UIKit/UIKit.h>

@interface ProviderDashboardCellTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *dateTimeLabel;
@property (strong, nonatomic) IBOutlet UILabel *clientNameLabel;

@end
