/***************************************************************
 Page name: MyRecommendationsTableViewCell.h
 Created By:Nalina
 Created Date:2016-07-12
 Description: Recommendation list table declaration Screen.
 ***************************************************************/

#import <UIKit/UIKit.h>
#import "SWTableViewCell.h"
@protocol SwipeableCellDelegate <NSObject>
- (void)buttonOneActionForItemText:(NSString *)itemText;
- (void)buttonTwoActionForItemText:(NSString *)itemText;
@end

@interface MyRecommendationsTableViewCell : SWTableViewCell
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
@property (strong, nonatomic) IBOutlet UILabel *expertiseLabel;

@property (strong, nonatomic) IBOutlet UILabel *firstnameLabel;

@property (strong, nonatomic) IBOutlet UILabel *lastnameLabel;
@property (weak, nonatomic) IBOutlet UILabel *rateLabel;
@end
