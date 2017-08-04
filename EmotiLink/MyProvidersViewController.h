/***************************************************************
 Page name: MyProvidersViewController.h
 Created By:Nalina
 Created Date:12/07/16
 Description:my provider methods and implementation declaration file
 ***************************************************************/

#import <UIKit/UIKit.h>
#import "ToggleButton.h"

@interface MyProvidersViewController : UIViewController<UITextFieldDelegate,UITableViewDelegate, UITableViewDataSource>
{
    NSMutableArray *myProvidersArray;
    NSMutableArray *myProvidersAllDataArray;
    NSMutableDictionary *providerDetails;
}
- (IBAction)pageBackClick:(id)sender;
@property (strong, nonatomic) UIView *loadingView;
@property (strong, nonatomic) UIAlertController *alert;
@property (strong, nonatomic) NSString *screenStatus;
@property (weak, nonatomic) IBOutlet UIView *myProviderViewBackground;

- (IBAction)searchIconClick:(id)sender;
@property (strong, nonatomic) IBOutlet UIView *searchView;
- (IBAction)closeSearchBarClick:(id)sender;
@property (strong, nonatomic) IBOutlet UITextField *searchTxt;
@property (strong, nonatomic) IBOutlet UITableView *providerTable;
@property (strong, nonatomic) IBOutlet UIButton *pageBackBtn;
@property(nonatomic, strong)NSMutableArray *values;
- (IBAction)backArrowClick:(id)sender;

@end
