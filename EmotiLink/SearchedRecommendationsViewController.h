/***************************************************************
 Page name: SearchedRecommendationsViewController.h
 Created By:Nalina
 Created Date:2016-07-12
 Description: Searched recommendation declaration Screen.
 ***************************************************************/

#import <UIKit/UIKit.h>

@interface SearchedRecommendationsViewController : UIViewController<UITableViewDelegate, UITableViewDataSource>

@property(nonatomic, strong)NSMutableArray *searchedRecommendationArray;
@property (strong, nonatomic) UIView *loadingView;

- (IBAction)PageBackClick:(id)sender;
@property (strong, nonatomic) IBOutlet UITableView *searchedRecommendationTable;
@property (strong, nonatomic) UIAlertController *alert;

- (IBAction)filterClick:(id)sender;

@property (strong, nonatomic) IBOutlet UIImageView *profileImageView;

@end
