//
//  TopRankingListTableViewCell.h
//  EmotiLink
//
//  Created by Star on 4/18/17.
//  Copyright © 2017 Stark. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TopRankingListTableViewCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *firstNameLabel;

@property (strong, nonatomic) IBOutlet UILabel *ExpertiseLabel;
@property (strong, nonatomic) IBOutlet UIImageView *providerProfileImage;
@property (strong, nonatomic) IBOutlet UIButton *favoriteProviderIcon;
- (IBAction)favoriteProviderClick:(id)sender;
@property (strong, nonatomic) IBOutlet UIView *mainview;
@property (strong, nonatomic) IBOutlet UIButton *availableBtn;

@property (strong, nonatomic) IBOutlet UIView *providerInfoCellView;
@property (weak, nonatomic) IBOutlet UIView *availableBtnView;
@property (weak, nonatomic) IBOutlet UILabel *rateLabel;

@end
