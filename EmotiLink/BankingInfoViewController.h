/***************************************************************
 Page name: BankingInfoViewController.h
 Created By: nalina
 Created Date:06/07/16
 Description: Banking info declaration file
 ***************************************************************/

#import <UIKit/UIKit.h>

@interface BankingInfoViewController : UIViewController<UITextFieldDelegate>



@property (strong, nonatomic) UIActivityIndicatorView *spinner;
@property (strong, nonatomic) UIView *loadingView;
@property (strong, nonatomic) UIAlertController *alert;

@property (strong, nonatomic) UIAlertController *alertView;
@property (strong, nonatomic) IBOutlet UIView *accountnumberView;
@property (nonatomic, retain) NSString *pagename;
@property (strong, nonatomic) IBOutlet UIView *institutenumberView;
@property (strong, nonatomic) IBOutlet UIView *swiftcodeView;
@property (strong, nonatomic) IBOutlet UIImageView *accountnumberIcon;
@property (strong, nonatomic) IBOutlet UIButton *accountnumberError;
@property (strong, nonatomic) IBOutlet UITextField *accountnumberTxt;
- (IBAction)accountnumberErrorClose:(id)sender;
@property (strong, nonatomic) IBOutlet UITextField *institutenumberTxt;
@property (strong, nonatomic) IBOutlet UIImageView *institutenumberIcon;
@property (strong, nonatomic) IBOutlet UIButton *institutenumberError;
- (IBAction)institutenumberErrorClose:(id)sender;
@property (weak, nonatomic) IBOutlet UIView *backgroundBanking;

@property (strong, nonatomic) IBOutlet UITextField *swiftcodeTxt;
@property (strong, nonatomic) IBOutlet UIButton *swiftcodeError;
- (IBAction)swiftcodeErrorClose:(id)sender;
@property (strong, nonatomic) IBOutlet UIImageView *swiftcodeIcon;
- (IBAction)cancelClick:(id)sender;
- (IBAction)submitClick:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *institutionInfoIcon;
@property (weak, nonatomic) IBOutlet UIButton *swiftCodeInfoIcon;
- (IBAction)backArrowClick:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *CancelBtn;
@property (weak, nonatomic) IBOutlet UIButton *SubmitBtn;
@property (weak, nonatomic) IBOutlet UIButton *BackBtn;

@end
