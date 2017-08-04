/***************************************************************
 Page name: RecommendationStaticViewController.h
 Created By:Nalina
 Created Date:2016-07-19
 Description: Invite provider method & property declaration Screen.
 ***************************************************************/

#import <UIKit/UIKit.h>

@interface RecommendationStaticViewController : UIViewController<UITextFieldDelegate>

- (IBAction)ProviderInviteClick:(id)sender;
@property (strong, nonatomic) IBOutlet UIView *emailView;
@property (strong, nonatomic) IBOutlet UIImageView *emailIcon;
@property (strong, nonatomic) IBOutlet UIImageView *emailError;
@property (strong, nonatomic) IBOutlet UITextField *emailTxt;
@property (strong, nonatomic) UIAlertController *alert;
@property (strong, nonatomic) UIView *loadingView;
- (IBAction)emailErrorClose:(id)sender;
- (IBAction)backClick:(id)sender;

- (IBAction)saveClick:(id)sender;

- (IBAction)pageBackClick:(id)sender;
@property (strong, nonatomic) NSString *emailContent;

@property (weak, nonatomic) IBOutlet UIButton *emailErrorBtn;


@end
