/***************************************************************
 Page name: ProviderMarketPlaceTableViewCell.h
 Created By:Nalina
 Created Date:08/07/16
 Description: provider market place table declaration file
 ***************************************************************/

#import <UIKit/UIKit.h>

@interface ProviderMarketPlaceTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *firstNameLabel;

@property (strong, nonatomic) IBOutlet UILabel *ExpertiseLabel;
@property (strong, nonatomic) IBOutlet UIImageView *providerProfileImage;
@property (strong, nonatomic) IBOutlet UIButton *favoriteProviderIcon;
- (IBAction)favoriteProviderClick:(id)sender;
@property (strong, nonatomic) IBOutlet UIView *mainview;
@property (strong, nonatomic) IBOutlet UIButton *availableBtn;
@property (weak, nonatomic) IBOutlet UIView *availableView;

@property (strong, nonatomic) IBOutlet UIView *providerInfoCellView;

@property (weak, nonatomic) IBOutlet UILabel *rateLabel;

@end
