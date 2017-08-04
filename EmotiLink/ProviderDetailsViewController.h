/***************************************************************
 Page name: ProviderDetailsViewController.m
 Created By:Nalina
 Created Date:2016-07-13
 Description:Provider details view controller implementation Screen.
 ***************************************************************/

#import <UIKit/UIKit.h>

@interface ProviderDetailsViewController : UIViewController<UITableViewDelegate, UITableViewDataSource>
{
    NSMutableArray *recommendationArray;
    NSMutableDictionary *providerDetails;
    NSMutableArray *faqArray;
    NSMutableArray *providerInformationArray;
    NSInteger selectSectionValue;
    NSArray *viewControllers;
    NSMutableArray *scheduledArray;
    NSMutableDictionary *providerDict;
}
@property (weak, nonatomic) IBOutlet UIView *providerDetailsBackgroundView;
@property (strong, nonatomic) UIPageViewController *pageViewController;
@property(nonatomic, strong)NSDictionary *providerDataArray;
- (IBAction)seeAppointmentDetailsClick:(id)sender;

- (IBAction)pageBackClick:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *readMoreBtn;

@property (strong, nonatomic) IBOutlet UILabel *providerNameLabel;

@property (strong, nonatomic) IBOutlet UILabel *providerExpertiseLabel;
@property (strong, nonatomic) IBOutlet UILabel *aboutProvidersLabel;
@property (strong, nonatomic) IBOutlet UILabel *rateOfProviderLabel;
@property (strong, nonatomic) IBOutlet UIView *appointmentView;
@property (strong, nonatomic) IBOutlet UILabel *appointmentLabel;
@property (strong, nonatomic) UIView *loadingView;
@property (strong, nonatomic) UIAlertController *alertView;
- (IBAction)makeAnAppointmentClick:(id)sender;

@property (strong, nonatomic) IBOutlet UIImageView *providerProfileView;
@property (strong, nonatomic) IBOutlet UIView *tableContentsView;
@property (weak, nonatomic) IBOutlet UIButton *providerFavoriteButton;
@property (weak, nonatomic) IBOutlet UITableView *recommendarionTable;
@property (weak, nonatomic) IBOutlet UILabel *myRecommendationsLAbel;

@property (strong, nonatomic) NSString *providersID;
@property (strong, nonatomic) UIAlertController *alert;

@property (strong, nonatomic) IBOutlet UITextView *aboutProvider;

@property (strong, nonatomic) IBOutlet UIView *recommendationListView;

@property (strong, nonatomic) IBOutlet UIButton *makeAnAppointmentBtn;

@property (strong, nonatomic) IBOutlet UIButton *appointmentDetailsBtn;
@end
