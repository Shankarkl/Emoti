/***************************************************************
 Page name: ProfileSettingsViewController.h
 Created By: Nalina
 Created Date: 2016-07-20
 Description: Profile Setting method and functionality declaration file
 ***************************************************************/

#import <UIKit/UIKit.h>

@interface ProfileSettingsViewController : UIViewController{
    NSMutableArray *availabilityArray;
    NSMutableArray *availabilityId;
    NSDictionary *availableData;

}
- (IBAction)backclick:(id)sender;

@property (strong, nonatomic) UIAlertController *alert;
@property (strong, nonatomic) IBOutlet UIView *demographicInfoView;
@property (strong, nonatomic) IBOutlet UIView *practiceExpertiseView;
@property (strong, nonatomic) IBOutlet UIView *bankingInfoView;
@property (strong, nonatomic) IBOutlet UIView *availabilityView;
@property (strong, nonatomic) IBOutlet UIView *rateView;
@property (strong, nonatomic) IBOutlet UIView *myRecommendationView;
@property (strong, nonatomic) IBOutlet UIView *changePasswordView;
@property (strong, nonatomic) UIView *loadingView;
- (IBAction)ChangePasswordBtn:(id)sender;
@property (weak, nonatomic) IBOutlet UIImageView *profilePicImage;


@end
