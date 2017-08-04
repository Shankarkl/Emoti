/***************************************************************
 Page name: SessionHistoryTableViewCell.h
 Created By:Nalina
 Created Date:11/07/16
 Description:my clients table declaration file
 ***************************************************************/

#import <UIKit/UIKit.h>
#import "SWTableViewCell.h"
@interface SessionHistoryTableViewCell : SWTableViewCell
@property (weak, nonatomic) IBOutlet UIView *CellView;

@property (strong, nonatomic) IBOutlet UIImageView *profileImageView;
@property (strong, nonatomic) IBOutlet UILabel *dateTimeLabel;
@property (strong, nonatomic) IBOutlet UILabel *amountLabel;
@property (strong, nonatomic) IBOutlet UILabel *firstname;
@property (strong, nonatomic) IBOutlet UILabel *lastname;
@property (strong, nonatomic) IBOutlet UIView *mainview;
@property (weak, nonatomic) IBOutlet UILabel *ExpertiseLbl;
@property (strong, nonatomic) IBOutlet UILabel *dayLabel;
@end
