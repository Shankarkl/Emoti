/***************************************************************
 Page name: ProviderMarketPlaceViewCell.h
 Created By: nalina
 Created Date:17/08/16
 Description: provider market place declaration file
 ***************************************************************/

#import <UIKit/UIKit.h>
#import "ToggleButton.h"

@interface ProviderMarketPlaceViewController : UIViewController<UITableViewDelegate, UITableViewDataSource>
{
    NSMutableDictionary *providerDetails;
}


- (IBAction)filterProvidersClick:(id)sender;
@property (strong, nonatomic) IBOutlet UITableView *providerTableView;
@property (weak, nonatomic) IBOutlet UIView *providerTableViewBackground;

@property (strong, nonatomic) UIAlertController *alert;
@property(nonatomic, strong)NSMutableArray *values;
@property(nonatomic, strong)NSString *ID;
@property(nonatomic, strong)NSMutableArray *providerDataArray;
@property (strong, nonatomic) UIView *loadingView;
@property (strong, nonatomic) UIAlertController *alertView;
- (IBAction)backArrowClick:(id)sender;

@end
