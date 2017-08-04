/***************************************************************
 Page name: RateViewController.h
 Created By:Nalina
 Created Date:2016-07-19
 Description: Provider rate update implementation file
 ***************************************************************/

#import <UIKit/UIKit.h>

@interface RateViewController : UIViewController<UITextFieldDelegate>

@property (strong, nonatomic) UIAlertController *alert;
@property (strong, nonatomic) UIView *loadingView;
@property (strong, nonatomic) UIAlertController *alertView;
@property (nonatomic, retain) NSString *pagename;
@property (strong, nonatomic) IBOutlet UIView *rateView;
@property (strong, nonatomic) IBOutlet UITextField *rateTxt;
@property (strong, nonatomic) IBOutlet UIButton *rateError;
- (IBAction)rateErrorClose:(id)sender;
- (IBAction)cancelClick:(id)sender;

- (IBAction)saveClick:(id)sender;
    @property (weak, nonatomic) IBOutlet UIView *backgroundRateView;
- (IBAction)backbtn:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *Cancelbtn;
@property (weak, nonatomic) IBOutlet UIButton *SubmitBtn;
@property (weak, nonatomic) IBOutlet UIButton *backbutton;

@end
