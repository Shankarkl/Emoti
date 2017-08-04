//
//  RescheduleAppointmentViewController.h
//  EmotiLink
//
//  Created by Kalpesh Mehta on 25/04/17.
//  Copyright © 2017 Stark. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <THDatePickerViewController.h>
@protocol RescheduleViewControllerDelegate <NSObject>
@required
- (void)dataFromController:(NSString *)data;
@end
@interface RescheduleAppointmentViewController : UIViewController<THDatePickerDelegate>{
    int detectFirstTime;
    int deselectItem;
    int selectionCellView;
    NSMutableArray *dataSource;
    NSDate*Neededdate;
    NSMutableDictionary *datavalues;
     NSMutableArray *appointmentListArray;
    NSMutableDictionary *sendAppointmentData;
    NSString *starttime;
    NSString *endtime;
    NSString *str ;
    NSString *date;
    NSString *time;
    NSString *estimation ;
    NSString *provideridval;
    BOOL isAvail;
    NSMutableDictionary *datavalue;

}
@property (nonatomic, retain) NSString *data;
@property (nonatomic, retain) NSString *headerTxt;
@property (nonatomic, retain) NSMutableArray *paramArray;
@property (nonatomic, retain) NSMutableDictionary *providerIDValue;
@property (nonatomic, retain) NSString *AppointmentIDValue;
@property (nonatomic, weak) id<RescheduleViewControllerDelegate> delegate;
@property (nonatomic, strong) THDatePickerViewController * datePicker;
@property (strong, nonatomic) UIView *loadingView;


@property (weak, nonatomic) IBOutlet UIView *SessionView;
@property (strong, nonatomic) UIAlertController *alert;
@property (weak, nonatomic) IBOutlet UIView *pickerBackView;
@property (weak, nonatomic) IBOutlet UITextField *TimeTxt;
@property (weak, nonatomic) IBOutlet UITextField *DateTxt;
@property (weak, nonatomic) IBOutlet UITextField *SecondDateTxt;
@property (weak, nonatomic) IBOutlet UITextField *SecondTimeTxt;
@property (weak, nonatomic) IBOutlet UITextField *ThirdDateTxt;
@property (weak, nonatomic) IBOutlet UITextField *ThirdTimeTxt;
@property (weak, nonatomic) IBOutlet UIButton *ConfirmClick;

@property (weak, nonatomic) IBOutlet UIButton *CancelClick;
@property (weak, nonatomic) IBOutlet UIPickerView *PickerView;
- (IBAction)ConfirmBtn:(id)sender;
- (IBAction)CancelBtn:(id)sender;
- (IBAction)Timedropbtn:(id)sender;
- (IBAction)DateDropbtn:(id)sender;
@property (weak, nonatomic) IBOutlet UIView *calendarBackView;
- (IBAction)calendarClick:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *ThirdDateBtn;
- (IBAction)seconddateclick:(id)sender;
- (IBAction)thirddateclick:(id)sender;
- (IBAction)SecondDateBtn:(id)sender;
- (IBAction)SecondDateClick:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *dummytxt;
- (IBAction)FirstDateBtn:(id)sender;

@end
