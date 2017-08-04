/***************************************************************
 Page name: MyClientsViewController.h
 Created By:Nalina
 Created Date:11/07/16
 Description:my clients method and properties declaration file
 ***************************************************************/

#import <UIKit/UIKit.h>

@interface MyClientsViewController : UIViewController<UITableViewDelegate, UITableViewDataSource>
{
    NSMutableArray *myclientsArray;
}

@property (nonatomic, strong) NSString *providerclients;
@property (nonatomic, strong) NSMutableSet *cellsCurrentlyEditing;
@property (strong, nonatomic) IBOutlet UITableView *scheduledTable;
@property (strong, nonatomic) UIAlertController *alert;
- (IBAction)backbtn:(id)sender;
@property (strong, nonatomic) UIView *loadingView;
@property (weak, nonatomic) IBOutlet UIButton *backArrowBtn;

@end
