/***************************************************************
 Page name: SearchedRecommendationsTableViewCell.h
 Created By:Nalina
 Created Date:2016-07-12
 Description: Searched recommendation method & property declaration Screen.
 ***************************************************************/

#import <UIKit/UIKit.h>

@interface SearchedRecommendationsTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *profileImageView;
@property (strong, nonatomic) IBOutlet UILabel *firstNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *lastNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *expertiseLabel;

@property (strong, nonatomic) IBOutlet UIButton *addRecommendationBtn;
@property (strong, nonatomic) IBOutlet UIView *mainview;
@property (weak, nonatomic) IBOutlet UILabel *rateLabel;

@end
