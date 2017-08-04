/***************************************************************
 Page name: MakeAnAppointmentViewController.h
 Created By:Nalina
 Created Date:2016-07-14
 Description:make an appointment view controller declaration Screen.
 ***************************************************************/

#import <UIKit/UIKit.h>
#import <THDatePickerViewController.h>

@interface MakeAnAppointmentViewController : UIViewController <UITableViewDelegate, UITableViewDataSource,THDatePickerDelegate>
{
    NSMutableArray *appointmentListArray;
    int detectFirstTime;
    int deselectItem;
    int selectionCellView;
    NSMutableDictionary *sendAppointmentData;
    //NSMutableArray *selectedRows;
    NSMutableArray *dataSource;
    NSString *starttime;
    NSString *endtime;
    NSString *str ;
    NSString *estimation ;
    NSString *secondTime;
    NSString *secondDate;
    BOOL isAvail;
    NSMutableDictionary *datavalue;

}

@property (nonatomic, strong) THDatePickerViewController * datePicker;
- (IBAction)pageBackClick:(id)sender;
- (IBAction)calendarClick:(id)sender;
@property (strong, nonatomic) IBOutlet UITableView *appointmentTableView ;
@property (weak, nonatomic) IBOutlet UIView *calendarBackView;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (strong, nonatomic) UIView *loadingView;
@property (strong, nonatomic) UIAlertController *alert;
@property (strong, nonatomic) NSMutableDictionary * postScheduleDetails;
@property (strong, nonatomic) NSMutableDictionary * postSchedulearray;
@property (strong, nonatomic) NSString * screenStatus;
@property (strong, nonatomic) NSMutableArray * postMakeAppointmentData;
- (IBAction)addaseesion:(id)sender;
@property (weak, nonatomic) IBOutlet UIView *addSessionView;
@property (weak, nonatomic) IBOutlet UIButton *AddsessionBtnView;

@property (strong, nonatomic) IBOutlet UIView *pickerBackView;
@property (strong, nonatomic) IBOutlet UIPickerView *pickerView;
@property (weak, nonatomic) IBOutlet UITextField *dateTxt;
@property (weak, nonatomic) IBOutlet UITextField *timeTxt;
@property (weak, nonatomic) IBOutlet UIView *totalBtnView;
@property (weak, nonatomic) IBOutlet UITextField *Selectseconddate;
@property (weak, nonatomic) IBOutlet UILabel *SelectSecondTime;
@property (weak, nonatomic) IBOutlet UITextField *secontimeTxt;
@property (weak, nonatomic) IBOutlet UIButton *canclview;
@property (weak, nonatomic) IBOutlet UIButton *confirmview;
@property (weak, nonatomic) IBOutlet UITextField *AddsessionTxt;
@property (weak, nonatomic) IBOutlet UITextField *dummytxt;
- (IBAction)DatebtnClick:(id)sender;
- (IBAction)DateTxt:(id)sender;

@end
