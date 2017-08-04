/***************************************************************
 Page name: CancelledAppointmentTableViewCell.h
 Created By:Nalina
 Created Date:11/07/16
 Description:cancelled appointment table implementation file
 ***************************************************************/

#import <UIKit/UIKit.h>

@interface CancelledAppointmentTableViewCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UIImageView *profileImageView;

@property (strong, nonatomic) IBOutlet UILabel *dateTimeLabel;
@property (strong, nonatomic) IBOutlet UILabel *amountOfferedLabel;
@property (strong, nonatomic) IBOutlet UILabel *firstNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *lastNameLabel;
@property (strong, nonatomic) IBOutlet UIView *mainview;

@end
