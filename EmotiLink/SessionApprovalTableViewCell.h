/***************************************************************
 Page name: SessionApprovalTableViewCell.h
 Created By:Nalina
 Created Date:08/07/16
 Description: session approval table declaration file
 ***************************************************************/

#import <UIKit/UIKit.h>

@interface SessionApprovalTableViewCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UIImageView *profileImageView;


@property (strong, nonatomic) IBOutlet UILabel *firstName;
@property (strong, nonatomic) IBOutlet UILabel *lastName;
@property (strong, nonatomic) IBOutlet UILabel *dateAndTime;
@property (strong, nonatomic) IBOutlet UILabel *amountLabel;

@property (strong, nonatomic) IBOutlet UIButton *acceptBtn;

@property (strong, nonatomic) IBOutlet UIButton *rejectBtn;
@property (strong, nonatomic) IBOutlet UIView *mainview;

@end
