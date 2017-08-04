/***************************************************************
 Page name: ProviderDetailsTableViewCell.h
 Created By:Nalina
 Created Date:2016-07-13
 Description:Provider details to display my recommendation list table creation Screen.
 ***************************************************************/

#import <UIKit/UIKit.h>

@interface ProviderDetailsTableViewCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UIImageView *providerProfileImage;
@property (strong, nonatomic) IBOutlet UILabel *expertiseInLabel;
@property (strong, nonatomic) IBOutlet UILabel *firstnameLabel;
@property (strong, nonatomic) IBOutlet UILabel *lastnameLabel;

@end
