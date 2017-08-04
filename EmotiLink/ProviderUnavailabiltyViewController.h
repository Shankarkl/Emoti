//
//  ProviderUnavailabiltyViewController.h
//  EmotiLink
//
//  Created by Starsoft on 2017-04-19.
//  Copyright © 2017 Stark. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <THCalendarDatePicker/THDatePickerViewController.h>
@interface ProviderUnavailabiltyViewController : UIViewController <THDatePickerDelegate>
{
     NSMutableArray *arrayTime;
    int count;
    NSInteger prevMonth;
    NSInteger prevYear;
    NSString *clickedbutton;
    NSArray *dataSource;
}

@property (weak, nonatomic) IBOutlet UIView *calendarView;
@property (nonatomic, strong) THDatePickerViewController * datePicker;
@property (weak, nonatomic) IBOutlet UITextField *dateSeletTxt;
- (IBAction)cancel:(id)sender;
- (IBAction)Save:(id)sender;
- (IBAction)backArrowClick:(id)sender;


@property (weak, nonatomic) IBOutlet UIView *fulldayUnavilablitypopView;
@property (weak, nonatomic) IBOutlet UIButton *saveBtnClick;
@property (weak, nonatomic) IBOutlet UIButton *cancelBtnClick;
- (IBAction)fullDayUnavailablityNoBtn:(id)sender;
- (IBAction)fullDayUnavaliablityYesBtn:(id)sender;

- (IBAction)fullDayUnAvaailablityTimeBtn:(id)sender;
@property (weak, nonatomic) IBOutlet UIView *providerTimeAvailablitypop;
- (IBAction)providerTimeCancelBtn:(id)sender;
- (IBAction)providerTimeConfirmBtn:(id)sender;

@property (nonatomic, strong) NSMutableArray *selectedDates;
@property (strong, nonatomic) NSString *screenStatus;

@property (strong, nonatomic) UIAlertController *alertView;
@property (strong, nonatomic) UIView *loadingView;
@property (weak, nonatomic) IBOutlet UITextField *dumytextfield;

@property (weak, nonatomic) IBOutlet UITextField *timeToTxt;

@property (weak, nonatomic) IBOutlet UITextField *timeFromTxt;

@property (weak, nonatomic) IBOutlet UIView *pickerBackView;
@property (weak, nonatomic) IBOutlet UIPickerView *pickerView;
@end
