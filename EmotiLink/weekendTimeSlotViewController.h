//
//  weekendTimeSlotViewController.h
//  EmotiLink
//
//  Created by Star on 4/24/17.
//  Copyright © 2017 Stark. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface weekendTimeSlotViewController : UIViewController
{
    NSString *clickedbutton;
    NSMutableArray *monthly;
    NSArray *dataSource;
    NSMutableDictionary *timeDict;
    NSString *yearString;
}

@property (weak, nonatomic) IBOutlet UIView *pickerBackView;
@property (weak, nonatomic) IBOutlet UIPickerView *pickerView;

@property (weak, nonatomic) IBOutlet UITextField *fromTimeTxt;

@property (weak, nonatomic) IBOutlet UITextField *secondFromTime;
@property (weak, nonatomic) IBOutlet UITextField *secondToTime;

@property (weak, nonatomic) IBOutlet UITextField *toTimeTxt;

@property (strong, nonatomic) UIAlertController *alert;
@property (strong, nonatomic) UIView *loadingView;
@property (nonatomic,assign) NSDictionary *availableData;
@property (nonatomic,assign) Boolean *isWeekend;
@property (nonatomic,assign) Boolean *isTimeSlotChange;
@property (nonatomic,assign) NSString *startDate;
@property (nonatomic,assign) NSString *endDate;
@property (weak, nonatomic) IBOutlet UITextField *dumyTxtVw;
- (IBAction)cancelButton:(id)sender;

- (IBAction)saveButton:(id)sender;
- (IBAction)backArrowClick:(id)sender;

@end
