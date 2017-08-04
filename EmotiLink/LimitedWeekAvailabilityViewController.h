//
//  LimitedWeekAvailabilityViewController.h
//  EmotiLink
//
//  Created by Starsoft on 2017-03-23.
//  Copyright © 2017 Stark. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LimitedWeekAvailabilityViewController : UIViewController
{
    bool myBoolFirstWeekValue;
    bool myBoolSecondWeekValue;
    bool myBoolThirdWeekValue;
    bool myBoolFourthWeekValue;
    bool myBoolFifthWeekValue;
    
    
    
    int FirstWeekValue;
    int SecondWeekValue;
    int ThirdWeekValue;
    int FourthWeekValue;
    int FifthWeekValue;
    NSString *clickedbutton;
    NSMutableArray *weekly;
    NSArray *dataSource;
    NSMutableDictionary *timeDict;
    NSString *yearString ;
    NSInteger weekOfYear;
}

- (IBAction)AddSessionClick:(id)sender;

- (IBAction)SaveClick:(id)sender;

- (IBAction)CancelClick:(id)sender;

- (IBAction)firstWeekClick:(id)sender;

- (IBAction)secondWeekClick:(id)sender;

- (IBAction)thirdWeekClick:(id)sender;

- (IBAction)fourthWeekClick:(id)sender;

- (IBAction)fifthWeekClick:(id)sender;

@property (weak, nonatomic) IBOutlet UIView *addSessionView;
@property (weak, nonatomic) IBOutlet UITextField *fromTimetxt;
@property (weak, nonatomic) IBOutlet UITextField *dumyTxt;

@property (weak, nonatomic) IBOutlet UITextField *toTimeTxt;
@property (weak, nonatomic) IBOutlet UITextField *secondFromtime;
@property (weak, nonatomic) IBOutlet UITextField *secondToTimeTX;

@property (weak, nonatomic) IBOutlet UIView *pickerBackView;
@property (weak, nonatomic) IBOutlet UIPickerView *pickerView;
@property (weak, nonatomic) IBOutlet UIButton *cancelBtbVw;

@property (strong, nonatomic) UIAlertController *alert;
@property (strong, nonatomic) UIView *loadingView;
@property (nonatomic,assign) Boolean *isWeekend;
@property (nonatomic,assign) Boolean *isTimeSlotChange;

- (IBAction)backArrowClick:(id)sender;

@property (weak, nonatomic) IBOutlet UITextField *monthSelTxt;
@property (weak, nonatomic) IBOutlet UIButton *fifthWeekButton;
@property (weak, nonatomic) IBOutlet UIButton *fifthWeekButtonArrow;
@property (weak, nonatomic) IBOutlet UIButton *cancelBtnVw;
@property (weak, nonatomic) IBOutlet UIView *saveBtnVw;

@property (weak, nonatomic) IBOutlet UIView *totalBtnView;
@property (weak, nonatomic) IBOutlet UIView *cancelsaveBtnVW;

@end
