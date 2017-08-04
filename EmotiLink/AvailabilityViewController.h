/***************************************************************
 Page name: AvailabilityViewController.h
 Created By:Nalina
 Created Date:19/07/16
 Description:Availability(Quick Start) methods declaration Screen.
 ***************************************************************/

#import <UIKit/UIKit.h>

@interface AvailabilityViewController : UIViewController<UITextViewDelegate,UITextFieldDelegate>
{
    NSArray *dataSource;
    NSArray *timePickerArray;
    NSString *clickedPicker;
    id availableID;
    NSString *firstTimefrom;
    NSString *firstTimeto;
    NSString *secTimefrom;
    NSString *secTimeto;
    NSString *thirdTimefrom;
    NSString *thirdTimeto;
    NSMutableDictionary *timeDict;
    bool Monthlybtn;
    int Monthlybval;
    bool Weeklybtn;
    int Weeklyval;
    bool Dailybtn;
    int Dailyval;
    bool Unavailblebtn;
    int Unavailbleal;
    bool isWeekend;
    bool isTimeSlotChanged;
}


@property (strong, nonatomic) IBOutlet UIView *availableView;
@property (nonatomic, retain) NSString *pagename;
@property (nonatomic,assign) NSMutableArray *availablepickerArray;
@property (nonatomic,assign) NSMutableArray *availablepickerIDArray;
@property (nonatomic,assign) NSDictionary *availableData;
@property (strong, nonatomic) UIAlertController *alert;
@property (strong, nonatomic) UIView *loadingView;
@property (strong, nonatomic) IBOutlet UITextField *availableTxt;
@property (strong, nonatomic) IBOutlet UIButton *availableError;
- (IBAction)availableClick:(id)sender;
- (IBAction)availableErrorClose:(id)sender;

@property (strong, nonatomic) IBOutlet UIView *timeFromFirstView;
@property (strong, nonatomic) IBOutlet UIView *timeToFirstView;
@property (strong, nonatomic) IBOutlet UITextField *timeFromFirstText;
@property (strong, nonatomic) IBOutlet UIButton *timeFromFirstError;
- (IBAction)timeFromFirstPickerClick:(id)sender;

- (IBAction)timeFromFirstErrorClose:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *weeklytextfield;

@property (strong, nonatomic) IBOutlet UITextField *timeToFirstTxt;

- (IBAction)timeTofirstPickerClick:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *timeToFirstError;
- (IBAction)timeToFirstErrorClose:(id)sender;
@property (strong, nonatomic) IBOutlet UIView *timeFromSecondView;
@property (strong, nonatomic) IBOutlet UIView *timeToSecondView;

@property (strong, nonatomic) IBOutlet UITextField *timeFromSecondTxt;
- (IBAction)timeFromSecondPickerClick:(id)sender;

@property (strong, nonatomic) IBOutlet UITextField *timeToSecondTxt;

- (IBAction)timeToSecondPickerClick:(id)sender;
@property (strong, nonatomic) IBOutlet UIView *timeFromThirdView;
@property (strong, nonatomic) IBOutlet UIView *timeToThirdView;
@property (strong, nonatomic) IBOutlet UITextField *timeFromThirdTxt;

- (IBAction)timeFromThirdPickerClick:(id)sender;
@property (strong, nonatomic) IBOutlet UITextField *timeToThirdTxt;
- (IBAction)timeToThirdPickerClick:(id)sender;

- (IBAction)cancelClick:(id)sender;

- (IBAction)saveClick:(id)sender;

- (IBAction)WeeklyBtnClick:(id)sender;

- (IBAction)monthlyBtnClick:(id)sender;
- (IBAction)DailyBtnClick:(id)sender;

- (IBAction)unavailableBtnClick:(id)sender;

@property (strong, nonatomic) IBOutlet UIView *pickerBackView;
@property (strong, nonatomic) IBOutlet UIPickerView *pickerView;
- (IBAction)backbtn:(id)sender;
- (IBAction)isWeekendCheckBoxClick:(id)sender;
- (IBAction)isTimeSlotChangeCheckBoxClick:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *isWeekendCheckBox;
@property (weak, nonatomic) IBOutlet UIButton *isTimeSlotChangeCheckBox;
@property (weak, nonatomic) IBOutlet UIButton *cancelBtn;
@property (weak, nonatomic) IBOutlet UIButton *Backbutton;

@property (weak, nonatomic) IBOutlet UIButton *nextBtn;

@end
