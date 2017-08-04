

/***************************************************************
 Page name:LimitedDaysAvailability.h
 Created By:ZEENATH
 Created Date:20-07-16
 Description:To select limited days and limited hours declaration file
 ***************************************************************/

#import <UIKit/UIKit.h>
#import <THCalendarDatePicker/THDatePickerViewController.h>

@interface LimitedDaysAvailability :  UIViewController<UITextFieldDelegate,THDatePickerDelegate>

{
    NSArray *dataSource;
    NSArray *timePickerArray;
    NSString *clickedButton;
    NSMutableArray *arrayTime;
    int count;
    NSInteger prevMonth;
    NSInteger prevYear;
    NSString *clickedbutton;
    NSString *yearString ;
    NSMutableArray *daily;

    
}


//Declaration of global methos and variables
-(void)getMonthYear:(NSString *)monthYear;
@property (strong, nonatomic) UIView *loadingView;
@property (strong, nonatomic) UIAlertController *alertView;
@property (nonatomic, strong) NSMutableArray *selectedDates;
@property (nonatomic, strong) THDatePickerViewController * datePicker;
@property (strong, nonatomic) NSString *screenStatus;
@property (strong, nonatomic) NSMutableArray * randomSelection;
@property (weak, nonatomic) IBOutlet UIView *calendarView;
@property (weak, nonatomic) IBOutlet UIView *timeFromView;
@property (weak, nonatomic) IBOutlet UIView *timeToView;
@property (weak, nonatomic) IBOutlet UIView *popupBackView;
@property (weak, nonatomic) IBOutlet UITextField *timeFromText;
@property (weak, nonatomic) IBOutlet UITextField *timeToText;
@property (weak, nonatomic) IBOutlet UIView *timeView;
@property (weak, nonatomic) IBOutlet UIPickerView *timePickerView;
@property (weak, nonatomic) IBOutlet UIView *timeSelectionView;
@property (weak, nonatomic) IBOutlet UIScrollView *contentScrollView;
@property (weak, nonatomic) IBOutlet UIView *timeScrollView;@property (weak, nonatomic) IBOutlet UIView *contentView;
@property (weak, nonatomic) IBOutlet UIView *secondTimeFromView;
@property (weak, nonatomic) IBOutlet UIView *secondTimeToView;
@property (weak, nonatomic) IBOutlet UITextField *secondTimeFromText;
@property (weak, nonatomic) IBOutlet UITextField *secondTimeToText;
@property (weak, nonatomic) IBOutlet UIView *secondTimeView;
@property (weak, nonatomic) IBOutlet UIView *thirdTimeView;
@property (weak, nonatomic) IBOutlet UIView *thirdTimeFromView;
@property (weak, nonatomic) IBOutlet UIView *thirdTimeToView;
@property (weak, nonatomic) IBOutlet UITextField *thirdTimeFromText;
@property (weak, nonatomic) IBOutlet UITextField *thirdTimeToText;
@property (weak, nonatomic) IBOutlet UIView *fourthTimeView;
@property (weak, nonatomic) IBOutlet UIView *fourthTimeFromView;
@property (weak, nonatomic) IBOutlet UIView *fourthTimeToView;
@property (weak, nonatomic) IBOutlet UITextField *fourthTomeFromText;
@property (weak, nonatomic) IBOutlet UITextField *fourthTimeToText;
@property (weak, nonatomic) IBOutlet UIView *fifthTimeView;
@property (weak, nonatomic) IBOutlet UIView *fifthTimeFromView;
@property (weak, nonatomic) IBOutlet UIView *fifthTimeToView;
@property (weak, nonatomic) IBOutlet UITextField *fifthTimeFromText;
@property (weak, nonatomic) IBOutlet UITextField *fifthTimeToText;

@property (weak, nonatomic) IBOutlet UIView *pickerBackView;
@property (weak, nonatomic) IBOutlet UIPickerView *pickerView;
@property (weak, nonatomic) IBOutlet UITextField *fromTimetxt;
@property (weak, nonatomic) IBOutlet UITextField *toTimeTxt;
@property (weak, nonatomic) IBOutlet UITextField *dateTxt;


@property (strong, nonatomic) UIAlertController *alert;

@property (nonatomic,assign) NSDictionary *availableData;
@property (nonatomic,assign) Boolean *isWeekend;
@property (nonatomic,assign) Boolean *isTimeSlotChange;

@property (weak, nonatomic) IBOutlet UIView *addSessionView;
- (IBAction)addSessionClick:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *selectedDatesTxt;
@property (weak, nonatomic) IBOutlet UIButton *cancelBtnVw;
@property (weak, nonatomic) IBOutlet UIButton *saveBtnVw;
@property (weak, nonatomic) IBOutlet UITextField *dumytxtfield;

@end
