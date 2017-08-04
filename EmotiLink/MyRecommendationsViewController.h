/***************************************************************
 Page name:MyRecommendationsViewController.h
 Created By:Nalina
 Created Date:12/07/16
 Description:my recommendation methods and implementation declaration file
 ***************************************************************/

#import <UIKit/UIKit.h>
#import "SWTableViewCell.h"

@interface MyRecommendationsViewController : UIViewController<UITextFieldDelegate,SWTableViewCellDelegate,UITableViewDelegate, UITableViewDataSource>
{
    NSMutableArray *recommendationArray;
    
}
@property (nonatomic, strong) NSMutableSet *cellsCurrentlyEditing;
@property (weak, nonatomic) IBOutlet UIView *recommendationBackgroundView;

@property (strong, nonatomic) UIView *loadingView;
- (IBAction)addMoreRecommendationClick:(id)sender;
@property (strong, nonatomic) IBOutlet UITableView *recommendationTable;
@property (strong, nonatomic) UIAlertController *alert;
- (IBAction)backbutton:(id)sender;

@end
