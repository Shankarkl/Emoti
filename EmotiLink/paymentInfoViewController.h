/***************************************************************
 Page name: paymentInfoViewController.h
 Created By: nalina
 Created Date:06/07/16
 Description: Banking info declaration file
 ***************************************************************/

#import <UIKit/UIKit.h>
@interface paymentInfoViewController : UIViewController<UITextViewDelegate,UITextFieldDelegate>
{

    NSMutableArray *YearArray;
    NSArray *dataSource;
}

@property (strong, nonatomic) UIAlertController *alert;
@property (strong, nonatomic) UIView *loadingView;
@property (strong, nonatomic) UIAlertController *alertView;
@property (strong, nonatomic) IBOutlet UIView *cardnumberView;
@property (strong, nonatomic) IBOutlet UIImageView *scancardView;
@property (strong, nonatomic) IBOutlet UIView *cardholdernameView;
@property (strong, nonatomic) IBOutlet UIView *monthpickerView;
@property (strong, nonatomic) IBOutlet UIView *yearpickerView;
@property (strong, nonatomic) IBOutlet UIView *ccvView;
@property (strong, nonatomic) IBOutlet UIView *zipcodeView;
@property (weak, nonatomic) IBOutlet UITextField *creditCardImage;

@property (strong, nonatomic) IBOutlet UIImageView *creditCardIcon;
@property (strong, nonatomic) IBOutlet UITextField *creditCardTxt;
@property (strong, nonatomic) IBOutlet UIButton *creditCardError;
- (IBAction)creditCardErrorClose:(id)sender;
@property (strong, nonatomic) IBOutlet UIImageView *cardHolderIcon;
@property (strong, nonatomic) IBOutlet UIButton *cardHolderError;
- (IBAction)cardHolderErrorClose:(id)sender;
@property (strong, nonatomic) IBOutlet UITextField *cardHolderTxt;
@property (strong, nonatomic) IBOutlet UITextField *zipcodeTxt;
@property (strong, nonatomic) IBOutlet UIButton *zipcodeError;
- (IBAction)zipcodeErrorClose:(id)sender;
@property (strong, nonatomic) IBOutlet UIImageView *zipcodeIcon;
- (IBAction)monthPickerClick:(id)sender;
@property (strong, nonatomic) IBOutlet UITextField *monthTxt;
- (IBAction)yearPickerClick:(id)sender;
@property (strong, nonatomic) IBOutlet UITextField *yearTxt;
@property (strong, nonatomic) IBOutlet UITextField *ccvTxt;
- (IBAction)cancelClick:(id)sender;
- (IBAction)submitClick:(id)sender;
@property (strong, nonatomic) IBOutlet UIView *validationMessageView;
@property (strong, nonatomic) IBOutlet UILabel *validationLabel;
@property (strong, nonatomic) IBOutlet UIView *pickerBackView;
@property (strong, nonatomic) IBOutlet UIPickerView *pickerView;
- (IBAction)backArrow:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *dumyTextfield;

@end
