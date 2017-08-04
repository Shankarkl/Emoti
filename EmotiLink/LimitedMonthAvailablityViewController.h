//
//  LimitedMonthAvailablityViewController.h
//  EmotiLink
//
//  Created by Starsoft on 2017-03-23.
//  Copyright © 2017 Stark. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LimitedMonthAvailablityViewController : UIViewController

{
    bool myBooljanValue;
    bool myBoolfebValue;
    bool myBoolmarValue;
    bool myBoolaprValue;
    bool myBoolmayValue;
    bool myBooljunValue;
    bool myBooljulValue;
    bool myBoolaugValue;
    bool myBoolsepValue;
    bool myBooloctValue;
    bool myBoolnovValue;
    bool myBooldecValue;
    
    int janValue;
    int febValue;
    int marValue;
    int aprValue;
    int mayValue;
    int junValue;
    int julValue;
    int augValue;
    int sepValue;
    int octValue;
    int novValue;
    int decValue;
    NSString *clickedbutton;
    NSMutableArray *monthly;
    NSArray *dataSource;
    NSMutableDictionary *timeDict;
    NSString *yearString ;
    
    
}


- (IBAction)JanClick:(id)sender;

- (IBAction)FebClick:(id)sender;

- (IBAction)MarClick:(id)sender;

- (IBAction)AprClick:(id)sender;

- (IBAction)MayClick:(id)sender;


- (IBAction)JunClick:(id)sender;

- (IBAction)JulClick:(id)sender;


- (IBAction)AugClick:(id)sender;

- (IBAction)SepClick:(id)sender;

- (IBAction)OctClick:(id)sender;

- (IBAction)NovClick:(id)sender;

- (IBAction)DecClick:(id)sender;

- (IBAction)addSession:(id)sender;

- (IBAction)cancelButton:(id)sender;

- (IBAction)saveButton:(id)sender;
- (IBAction)backArrowClick:(id)sender;

@property (weak, nonatomic) IBOutlet UIView *addSessionView;

@property (weak, nonatomic) IBOutlet UITextField *fromTimeTxt;

@property (weak, nonatomic) IBOutlet UIView *pickerBackView;
@property (weak, nonatomic) IBOutlet UIPickerView *pickerView;
@property (weak, nonatomic) IBOutlet UITextField *secondFromTime;
@property (weak, nonatomic) IBOutlet UITextField *secondToTime;

@property (weak, nonatomic) IBOutlet UITextField *toTimeTxt;

@property (strong, nonatomic) UIAlertController *alert;
@property (strong, nonatomic) UIView *loadingView;
@property (nonatomic,assign) NSDictionary *availableData;
@property (nonatomic,assign) Boolean *isWeekend;
@property (nonatomic,assign) Boolean *isTimeSlotChange;
@property (weak, nonatomic) IBOutlet UIButton *saveBtnVw;
@property (weak, nonatomic) IBOutlet UIButton *cancelBtbVw;
@property (weak, nonatomic) IBOutlet UITextField *dumyTxtVw;


@end
