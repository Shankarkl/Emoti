/***************************************************************
 Page name: RecommendationSearchViewController.h
 Created By:Nalina
 Created Date:2016-07-12
 Description: Recommendation search implementation Screen.
 ***************************************************************/

#import <UIKit/UIKit.h>

@interface RecommendationSearchViewController : UIViewController<UITextFieldDelegate>

- (IBAction)pageBackClick:(id)sender;
@property (strong, nonatomic) UIAlertController *alert;
@property (strong, nonatomic) UIView *loadingView;
@property (strong, nonatomic) IBOutlet UIView *nameView;

@property (strong, nonatomic) IBOutlet UITextField *nameTxt;
@property (strong, nonatomic) IBOutlet UIButton *nameError;

- (IBAction)nameErrorClose:(id)sender;
@property (strong, nonatomic) IBOutlet UIImageView *nameIcon;
@property (strong, nonatomic) IBOutlet UIView *emailView;
@property (strong, nonatomic) IBOutlet UITextField *emailTxt;

@property (strong, nonatomic) IBOutlet UIButton *emailError;

- (IBAction)emailErrorClose:(id)sender;
@property (strong, nonatomic) IBOutlet UIImageView *emailIcon;
- (IBAction)cancelClick:(id)sender;
- (IBAction)submitClick:(id)sender;

@end
