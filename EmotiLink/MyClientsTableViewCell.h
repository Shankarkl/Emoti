/***************************************************************
 Page name: MyClientsTableViewCell.h
 Created By:Nalina
 Created Date:11/07/16
 Description:my clients table methods and declaration file
 ***************************************************************/

#import <UIKit/UIKit.h>
@protocol SwipeableCellDelegate <NSObject>
- (void)buttonOneActionForItemText:(NSString *)itemText;
- (void)buttonTwoActionForItemText:(NSString *)itemText;
@end

@interface MyClientsTableViewCell : UITableViewCell

@property (nonatomic, strong) NSString *itemText;
@property (nonatomic, weak) id <SwipeableCellDelegate> delegate;

@property (nonatomic, strong) UIPanGestureRecognizer *panRecognizer;
@property (nonatomic, assign) CGPoint panStartPoint;
@property (nonatomic, assign) CGFloat startingRightLayoutConstraintConstant;
@property (strong, nonatomic) IBOutlet UIView *mainContentView;
- (IBAction)cancelButton:(id)sender;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *contentViewRightConstraint;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *contentViewLeftConstraint;
@property (strong, nonatomic) IBOutlet UIButton *cancelBtn;
@property (strong, nonatomic) IBOutlet UIImageView *profileImageView;
@property (strong, nonatomic) IBOutlet UILabel *dateTimeLabel;

@property (strong, nonatomic) IBOutlet UILabel *firstnameLabel;

@property (strong, nonatomic) IBOutlet UILabel *numberOfSession;

@property (weak, nonatomic) IBOutlet UILabel *appointmentLabel;

@end
