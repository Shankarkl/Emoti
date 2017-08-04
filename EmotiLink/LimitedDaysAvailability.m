

/***************************************************************
 Page name:LimitedDaysAvailability.m
 Created By:ZEENATH
 Created Date:20-07-16
 Description:To select limited days and limited hours implementation file
 ***************************************************************/

#import "LimitedDaysAvailability.h"
#import "CKCalendarView.h"
#import <CoreGraphics/CoreGraphics.h>
#import <Google/Analytics.h>
#import <THCalendarDatePicker/THDatePickerViewController.h>
#import "GlobalFunction.h"
#import "AppDelegate.h"

@interface LimitedDaysAvailability ()<CKCalendarDelegate>

@property (nonatomic, retain) NSDate * curDate;
@property (nonatomic, retain) NSDateFormatter * formatter;

@end

@implementation LimitedDaysAvailability
@synthesize availableData, isWeekend, isTimeSlotChange;

//Called when the view controller is first time loaded to memory
- (void)viewDidLoad {
    
    
    _dumytxtfield.hidden = YES;
    
    UIButton *cancelBtn = (UIButton *) [self.view viewWithTag:21];
    
    cancelBtn.layer.borderColor = [UIColor colorWithRed:246.0/255.0 green:108.0/255.0 blue:118.0/255.0 alpha:1].CGColor;
    
    
    
    UIButton *addsessionBtn = (UIButton *) [self.view viewWithTag:10];
    
    addsessionBtn.layer.borderColor = [UIColor colorWithRed:246.0/255.0 green:108.0/255.0 blue:118.0/255.0 alpha:1].CGColor;
    
    _addSessionView.hidden = YES;
    
    
    UIImage *backgroundImage = [UIImage imageNamed:@"06. Appointment Confirmation.png"];
    UIImageView *backgroundImageView=[[UIImageView alloc]initWithFrame:self.view.frame];
    backgroundImageView.image=backgroundImage;
    [self.view insertSubview:backgroundImageView atIndex:0];
    
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _randomSelection = [[NSMutableArray alloc] init];
    [self setBorder:_timeFromView];
    [self setBorder:_timeToView];
    [self setBorder:_secondTimeFromView];
    [self setBorder:_secondTimeToView];
    [self setBorder:_thirdTimeFromView];
    [self setBorder:_thirdTimeToView];
    [self setBorder:_fourthTimeFromView];
    [self setBorder:_fourthTimeToView];
    [self setBorder:_fifthTimeFromView];
    [self setBorder:_fifthTimeToView];
    
    
    _timeFromText.delegate=self;
    _timeToText.delegate=self;
    _secondTimeFromText.delegate=self;
    _secondTimeToText.delegate=self;
    _thirdTimeFromText.delegate=self;
    _thirdTimeToText.delegate=self;
    _fourthTomeFromText.delegate=self;
    _fourthTimeToText.delegate=self;
    _fifthTimeFromText.delegate=self;
    _fifthTimeToText.delegate=self;
    timePickerArray = [[NSArray alloc]initWithObjects:@"12:00 AM",
                       @"12:30 AM",@"1:00 AM",@"1:30 AM",@"2:00 AM",@"2:30 AM",@"3:00 AM",@"3:30 AM",@"4:00 AM",@"4:30 AM",@"5:00 AM",@"5:30 AM",@"6:00 AM",@"6:30 AM",@"7:00 AM",@"7:30 AM",@"8:00 AM",@"8:30 AM",@"9:00 AM",@"9:30  AM",@"10:00 AM",@"10:30 AM",@"11:00 AM",@"11:30 AM",@"12:00 PM",@"12:30 PM",@"1:00 PM",@"1:30 PM",@"2:00 PM",@"2:30 PM",@"3:00 PM",@"3:30 PM",@"4:00 PM",@"4:30 PM",@"5:00 PM",@"5:30 PM",@"6:00 PM",@"6:30 PM",@"7:00 PM",@"7:30 PM",@"8:00 PM",@"8:30 PM",@"9:00 PM",@"9:30 PM",@"10:00 PM",@"10:30 PM",@"11:00 PM",@"11:30 PM", nil];
    self.curDate = [NSDate date];
    self.formatter = [[NSDateFormatter alloc] init];
    
    if([_screenStatus isEqualToString:@"LimitedHours"])
    {
        [_formatter setDateFormat:@"YYYY-MM-dd"];
    }else{
        [_formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    }
    count=0;
    self.selectedDates = [[NSMutableArray alloc]init];
    arrayTime=[[NSMutableArray alloc]init];
    prevMonth=0;
    prevYear=0;
    
    NSDateFormatter *yearFormatter = [[NSDateFormatter alloc] init];
    [yearFormatter setDateFormat:@"yyyy"];
    yearString = [yearFormatter stringFromDate:[NSDate date]];
    
    _addSessionView.hidden=YES;
    
    UITapGestureRecognizer *singleFingerTap =
    [[UITapGestureRecognizer alloc] initWithTarget:self
                                            action:@selector(handleSingleTapped:)];
    [self.pickerBackView addGestureRecognizer:singleFingerTap];
    
    [self.fromTimetxt addTarget:self action:@selector(monthClick:) forControlEvents:UIControlEventEditingDidBegin];
    
    [self.toTimeTxt addTarget:self action:@selector(ToTimeClick:) forControlEvents:UIControlEventEditingDidBegin];
    
    // Another session values
    
    [self.secondTimeFromText addTarget:self action:@selector(secondfromtmClick:) forControlEvents:UIControlEventEditingDidBegin];
    
    
    [self.secondTimeToText addTarget:self action:@selector(secondTotmClick:) forControlEvents:UIControlEventEditingDidBegin];
    
    
    //selectedDatesTxt
    UITapGestureRecognizer *selectedDatesFingerTap =
    [[UITapGestureRecognizer alloc] initWithTarget:self
                                            action:@selector(showCalendar:)];
    [self.selectedDatesTxt addGestureRecognizer:selectedDatesFingerTap];
    
    //Discription: Prepopulate the data to the input fields by taking GET service call response
    
    if ([[availableData objectForKey:@"fsStartTime"] isEqual:[NSNull null]]) {
        _fromTimetxt.text= @"";
    }else{
        
        NSString *hourString=[self Convert24FormatTo12Format:[availableData objectForKey:@"fsStartTime"]];
        _fromTimetxt.text= hourString;
    }
    
    if ([[availableData objectForKey:@"fsEndTime"] isEqual:[NSNull null]]) {
        _toTimeTxt.text=@"";
    }else{
        NSString *hourString=[self Convert24FormatTo12Format:[availableData objectForKey:@"fsEndTime"]];
        _toTimeTxt.text= hourString;
    }
    
    /*if ([[availableData objectForKey:@"ssStartTime"] isEqual:[NSNull null]]) {
     _secondFromTime.text=@"";
     }else{
     NSString *hourString=[self Convert24FormatTo12Format:[availableData objectForKey:@"ssStartTime"]];
     _secondFromTime.text= hourString;
     }
     
     if ([[availableData objectForKey:@"ssEndTime"] isEqual:[NSNull null]]) {
     _secondToTime.text=@"";
     }else{
     NSString *hourString=[self Convert24FormatTo12Format:[availableData objectForKey:@"ssEndTime"]];
     _secondToTime.text= hourString;
     }*/
    
    
}

// From Time Click event

- (void)monthClick:(UITapGestureRecognizer *)recognizer {
    [self resignSoftKeyboard];
    dataSource=[[NSArray alloc]initWithObjects:@"12:00 AM",
                @"12:30 AM",@"1:00 AM",@"1:30 AM",@"2:00 AM",@"2:30 AM",@"3:00 AM",@"3:30 AM",@"4:00 AM",@"4:30 AM",@"5:00 AM",@"5:30 AM",@"6:00 AM",@"6:30 AM",@"7:00 AM",@"7:30 AM",@"8:00 AM",@"8:30 AM",@"9:00 AM",@"9:30  AM",@"10:00 AM",@"10:30 AM",@"11:00 AM",@"11:30 AM",@"12:00 PM",@"12:30 PM",@"1:00 PM",@"1:30 PM",@"2:00 PM",@"2:30 PM",@"3:00 PM",@"3:30 PM",@"4:00 PM",@"4:30 PM",@"5:00 PM",@"5:30 PM",@"6:00 PM",@"6:30 PM",@"7:00 PM",@"7:30 PM",@"8:00 PM",@"8:30 PM",@"9:00 PM",@"9:30 PM",@"10:00 PM",@"10:30 PM",@"11:00 PM",@"11:30 PM", nil];
    [self.pickerView reloadAllComponents];
    _pickerBackView.hidden=NO;
    clickedbutton=@"Fromtime";
    [self setBorder:_pickerView];
    [_fromTimetxt setValue:[UIColor  colorWithRed:(112/255.0) green:(112/255.0) blue:(112/255.0) alpha:1] forKeyPath:@"_placeholderLabel.textColor"];
    _fromTimetxt.placeholder=@"";
}

-(void)ToTimeClick:(UITapGestureRecognizer *)recognizer {
    [self resignSoftKeyboard];
    dataSource=[[NSArray alloc]initWithObjects:@"12:00 AM",
                @"12:30 AM",@"1:00 AM",@"1:30 AM",@"2:00 AM",@"2:30 AM",@"3:00 AM",@"3:30 AM",@"4:00 AM",@"4:30 AM",@"5:00 AM",@"5:30 AM",@"6:00 AM",@"6:30 AM",@"7:00 AM",@"7:30 AM",@"8:00 AM",@"8:30 AM",@"9:00 AM",@"9:30  AM",@"10:00 AM",@"10:30 AM",@"11:00 AM",@"11:30 AM",@"12:00 PM",@"12:30 PM",@"1:00 PM",@"1:30 PM",@"2:00 PM",@"2:30 PM",@"3:00 PM",@"3:30 PM",@"4:00 PM",@"4:30 PM",@"5:00 PM",@"5:30 PM",@"6:00 PM",@"6:30 PM",@"7:00 PM",@"7:30 PM",@"8:00 PM",@"8:30 PM",@"9:00 PM",@"9:30 PM",@"10:00 PM",@"10:30 PM",@"11:00 PM",@"11:30 PM", nil];
    [self.pickerView reloadAllComponents];
    _pickerBackView.hidden=NO;
    clickedbutton=@"Totime";
    [_toTimeTxt setValue:[UIColor  colorWithRed:(112/255.0) green:(112/255.0) blue:(112/255.0) alpha:1] forKeyPath:@"_placeholderLabel.textColor"];
    _toTimeTxt.placeholder=@"";
    
}

// Add Another session click events

-(void)secondfromtmClick:(UITapGestureRecognizer *)recognizer {
    [self resignSoftKeyboard];
    dataSource=[[NSArray alloc]initWithObjects:@"12:00 AM",
                @"12:30 AM",@"1:00 AM",@"1:30 AM",@"2:00 AM",@"2:30 AM",@"3:00 AM",@"3:30 AM",@"4:00 AM",@"4:30 AM",@"5:00 AM",@"5:30 AM",@"6:00 AM",@"6:30 AM",@"7:00 AM",@"7:30 AM",@"8:00 AM",@"8:30 AM",@"9:00 AM",@"9:30  AM",@"10:00 AM",@"10:30 AM",@"11:00 AM",@"11:30 AM",@"12:00 PM",@"12:30 PM",@"1:00 PM",@"1:30 PM",@"2:00 PM",@"2:30 PM",@"3:00 PM",@"3:30 PM",@"4:00 PM",@"4:30 PM",@"5:00 PM",@"5:30 PM",@"6:00 PM",@"6:30 PM",@"7:00 PM",@"7:30 PM",@"8:00 PM",@"8:30 PM",@"9:00 PM",@"9:30 PM",@"10:00 PM",@"10:30 PM",@"11:00 PM",@"11:30 PM", nil];
    [self.pickerView reloadAllComponents];
    _pickerBackView.hidden=NO;
    clickedbutton=@"secondFromtime";
    [_toTimeTxt setValue:[UIColor  colorWithRed:(112/255.0) green:(112/255.0) blue:(112/255.0) alpha:1] forKeyPath:@"_placeholderLabel.textColor"];
    _toTimeTxt.placeholder=@"";
    
}


-(void)secondTotmClick:(UITapGestureRecognizer *)recognizer {
    [self resignSoftKeyboard];
    dataSource=[[NSArray alloc]initWithObjects:@"12:00 AM",
                @"12:30 AM",@"1:00 AM",@"1:30 AM",@"2:00 AM",@"2:30 AM",@"3:00 AM",@"3:30 AM",@"4:00 AM",@"4:30 AM",@"5:00 AM",@"5:30 AM",@"6:00 AM",@"6:30 AM",@"7:00 AM",@"7:30 AM",@"8:00 AM",@"8:30 AM",@"9:00 AM",@"9:30  AM",@"10:00 AM",@"10:30 AM",@"11:00 AM",@"11:30 AM",@"12:00 PM",@"12:30 PM",@"1:00 PM",@"1:30 PM",@"2:00 PM",@"2:30 PM",@"3:00 PM",@"3:30 PM",@"4:00 PM",@"4:30 PM",@"5:00 PM",@"5:30 PM",@"6:00 PM",@"6:30 PM",@"7:00 PM",@"7:30 PM",@"8:00 PM",@"8:30 PM",@"9:00 PM",@"9:30 PM",@"10:00 PM",@"10:30 PM",@"11:00 PM",@"11:30 PM", nil];
    [self.pickerView reloadAllComponents];
    _pickerBackView.hidden=NO;
    clickedbutton=@"secondTotime";
    [_toTimeTxt setValue:[UIColor  colorWithRed:(112/255.0) green:(112/255.0) blue:(112/255.0) alpha:1] forKeyPath:@"_placeholderLabel.textColor"];
    _toTimeTxt.placeholder=@"";
    
}

- (void)handleSingleTapped:(UITapGestureRecognizer *)recognizer {
    _pickerBackView.hidden=YES;
    [self.dumytxtfield becomeFirstResponder];
}

//called each time when the view is appeared
-(void)viewDidAppear:(BOOL)animated
{
    [self showCalendar];
    
    //  _datePicker.view.center=self.view.center;
    
}

//called each time when the view appears
-(void)viewWillAppear:(BOOL)animated
{
    
    id<GAITracker> tracker = [[GAI sharedInstance] defaultTracker];
    [tracker set:kGAIScreenName value:@"LimitedDaysAvailability"];
    [tracker send:[[GAIDictionaryBuilder createScreenView] build]];
    self.navigationController.navigationBar.tintColor = [UIColor colorWithRed:239.0/255.0 green:239.0/255.0 blue:239.0/255.0 alpha:1.0];
    
    /*
     if([_screenStatus isEqualToString:@"LimitedDays"]){
     _popupBackView.hidden=YES;
     }
     else{
     _popupBackView.hidden=NO;
     }
     */
    
    UITapGestureRecognizer *popupclick =
    [[UITapGestureRecognizer alloc] initWithTarget:self
                                            action:@selector(popupclick:)];
    [self.popupBackView addGestureRecognizer:popupclick];
    
    UITapGestureRecognizer *timeFromFirstclick =
    [[UITapGestureRecognizer alloc] initWithTarget:self
                                            action:@selector(timeFromFirstclick:)];
    [self.timeFromView addGestureRecognizer:timeFromFirstclick];
    
    UITapGestureRecognizer *timeFromSecondclick =
    [[UITapGestureRecognizer alloc] initWithTarget:self
                                            action:@selector(timeFromSecondclick:)];
    [self.secondTimeFromView addGestureRecognizer:timeFromSecondclick];
    
    UITapGestureRecognizer *timeFromThirdclick =
    [[UITapGestureRecognizer alloc] initWithTarget:self
                                            action:@selector(timeFromThirdclick:)];
    [self.thirdTimeFromView addGestureRecognizer:timeFromThirdclick];
    
    UITapGestureRecognizer *timeFromFourthclick =
    [[UITapGestureRecognizer alloc] initWithTarget:self
                                            action:@selector(timeFromFourthclick:)];
    [self.fourthTimeFromView addGestureRecognizer:timeFromFourthclick];
    
    UITapGestureRecognizer *timeFromFifthclick =
    [[UITapGestureRecognizer alloc] initWithTarget:self
                                            action:@selector(timeFromFifthclick:)];
    [self.fifthTimeFromView addGestureRecognizer:timeFromFifthclick];
    
    UITapGestureRecognizer *timeToclick =
    [[UITapGestureRecognizer alloc] initWithTarget:self
                                            action:@selector(timeToclick:)];
    [self.timeToView addGestureRecognizer:timeToclick];
    
    UITapGestureRecognizer *timeToSecondclick =
    [[UITapGestureRecognizer alloc] initWithTarget:self
                                            action:@selector(timeToSecondclick:)];
    [self.secondTimeToView addGestureRecognizer:timeToSecondclick];
    
    UITapGestureRecognizer *timeToThirdclick =
    [[UITapGestureRecognizer alloc] initWithTarget:self
                                            action:@selector(timeToThirdclick:)];
    [self.thirdTimeToView addGestureRecognizer:timeToThirdclick];
    
    UITapGestureRecognizer *timeToFourthclick =
    [[UITapGestureRecognizer alloc] initWithTarget:self
                                            action:@selector(timeToFourthclick:)];
    [self.fourthTimeToView addGestureRecognizer:timeToFourthclick];
    UITapGestureRecognizer *timeToFifthclick =
    [[UITapGestureRecognizer alloc] initWithTarget:self
                                            action:@selector(timeToFifthclick:)];
    [self.fifthTimeToView addGestureRecognizer:timeToFifthclick];
    
    
}

//Added bY:ZEENATH
//Added on:28-07-16
//Description:Called when the views are clicked
- (void)popupclick:(UITapGestureRecognizer *)recognizer {
    _popupBackView.hidden=YES;
    
}
- (void)timeFromFirstclick:(UITapGestureRecognizer *)recognizer {
    _timePickerView.hidden=NO;
    clickedButton=@"timeFrom";
}
- (void)timeFromSecondclick:(UITapGestureRecognizer *)recognizer {
    _timePickerView.hidden=NO;
    clickedButton=@"secondTimeFrom";
}
- (void)timeFromThirdclick:(UITapGestureRecognizer *)recognizer {
    _timePickerView.hidden=NO;
    clickedButton=@"thirdTimeFrom";
}
- (void)timeFromFourthclick:(UITapGestureRecognizer *)recognizer {
    _timePickerView.hidden=NO;
    clickedButton=@"fourthTimeFrom";
}
- (void)timeFromFifthclick:(UITapGestureRecognizer *)recognizer {
    _timePickerView.hidden=NO;
    clickedButton=@"fifthTimeFrom";
}

- (void)timeToclick:(UITapGestureRecognizer *)recognizer {
    _timePickerView.hidden=NO;
    clickedButton=@"timeTo";
}

- (void)timeToSecondclick:(UITapGestureRecognizer *)recognizer {
    _timePickerView.hidden=NO;
    clickedButton=@"secondTimeTo";
}

- (void)timeToThirdclick:(UITapGestureRecognizer *)recognizer {
    _timePickerView.hidden=NO;
    clickedButton=@"thirdTimeTo";
}

- (void)timeToFourthclick:(UITapGestureRecognizer *)recognizer {
    _timePickerView.hidden=NO;
    clickedButton=@"fourthTimeTo";
}

- (void)timeToFifthclick:(UITapGestureRecognizer *)recognizer {
    _timePickerView.hidden=NO;
    clickedButton=@"fifthTimeTo";
}


//Returns number of components in pickerview
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)thePickerView {
    
    return 1;//Or return whatever as you intend
}

//Returns number of rows in pickerview
- (NSInteger)pickerView:(UIPickerView *)thePickerView numberOfRowsInComponent:(NSInteger)component {
    
    return [timePickerArray count];
    
}


//Set the title for each rows in pickerview
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:
(NSInteger)row forComponent:(NSInteger)component{
    
    
    return [timePickerArray objectAtIndex:row];
    
}


//Called when a row in the pickerview is selected
- (void)pickerView:(UIPickerView *)thePickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    //[_timePickerView selectRow:0 inComponent:0 animated:YES];
    
    if([clickedbutton isEqualToString:@"Fromtime"])
    {
        
        [_fromTimetxt setText:[timePickerArray objectAtIndex:row]];
        [self.dumytxtfield becomeFirstResponder];
        
    }else if([clickedbutton isEqualToString:@"Totime"]){
        
        [_toTimeTxt setText:[timePickerArray objectAtIndex:row]];
        [self.dumytxtfield becomeFirstResponder];
        [self.dumytxtfield becomeFirstResponder];
        
    }else if([clickedbutton isEqualToString:@"secondFromtime"]){
        
        [_secondTimeFromText setText:[timePickerArray objectAtIndex:row]];
        [self.dumytxtfield becomeFirstResponder];
        
    }
    else if([clickedbutton isEqualToString:@"secondTotime"]){
        
        [_secondTimeToText setText:[timePickerArray objectAtIndex:row]];
        [self.dumytxtfield becomeFirstResponder];
        
    }
    
    
    
    
    _pickerBackView.hidden=YES;
    [self resignSoftKeyboard];
    
    
    /*    if([clickedButton isEqualToString:@"timeFrom"])
     {
     
     [_timeFromText setText:[timePickerArray objectAtIndex:row]];
     
     }
     else if([clickedButton isEqualToString:@"timeTo"])
     {
     [_timeToText setText:[timePickerArray objectAtIndex:row]];
     }
     else if([clickedButton isEqualToString:@"secondTimeFrom"])
     {
     [_secondTimeFromText setText:[timePickerArray objectAtIndex:row]];
     }
     else if([clickedButton isEqualToString:@"secondTimeTo"])
     {
     [_secondTimeToText setText:[timePickerArray objectAtIndex:row]];
     }
     else if([clickedButton isEqualToString:@"thirdTimeFrom"])
     {
     [_thirdTimeFromText setText:[timePickerArray objectAtIndex:row]];
     }
     else if([clickedButton isEqualToString:@"thirdTimeTo"])
     {
     [_thirdTimeToText setText:[timePickerArray objectAtIndex:row]];
     }
     else if([clickedButton isEqualToString:@"fourthTimeFrom"])
     {
     [_fourthTomeFromText setText:[timePickerArray objectAtIndex:row]];
     }
     else if([clickedButton isEqualToString:@"fourthTimeTo"])
     {
     [_fourthTimeToText setText:[timePickerArray objectAtIndex:row]];
     }
     else if([clickedButton isEqualToString:@"fifthTimeFrom"])
     {
     [_fifthTimeFromText setText:[timePickerArray objectAtIndex:row]];
     }
     else if([clickedButton isEqualToString:@"fifthTimeTo"])
     {
     [_fifthTimeToText setText:[timePickerArray objectAtIndex:row]];
     } */
    
    _timePickerView.hidden=YES;
    
}


// Dispose of any resources that can be recreated.
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}



//  Added by:Zeenath
//  Added Date:2016-25-08.
//  Description:To set the border for the views with textfield.
-(void)setBorder:(UIView *)img
{
    
    img.layer.borderColor = [[UIColor colorWithRed:228.0/255.0 green:109.0/255.0 blue:175.0/255.0 alpha:1.0]CGColor];
    img.layer.borderWidth = 1.0f;
    
}

- (IBAction)addSessionClick:(id)sender {
    
    if(_addSessionView.hidden==NO){
        _addSessionView.hidden=YES;
        _cancelBtnVw.frame = CGRectMake(30, 650, 120, 50);
        _saveBtnVw.frame = CGRectMake(170, 650, 120, 50);
    }else{
        _addSessionView.hidden=NO;
        _cancelBtnVw.frame = CGRectMake(30, 780, 120, 50);
        _saveBtnVw.frame = CGRectMake(170, 780, 120, 50);
    }
    
}



//  Added by:Zeenath
//  Added Date:2016-25-08.
//  Description:To call the service to post limited available days.
- (IBAction)saveButtonClick:(id)sender {
    if([_fromTimetxt.text isEqualToString:@""]){
        [self SetValidationSettinds:_fromTimetxt errorIcon:nil validationMessage:[[GlobalFunction sharedInstance].arrayOfAlerts objectAtIndex:40] viewField:nil];
        return;
    }
    
    if([_toTimeTxt.text isEqualToString:@""]){
        [self SetValidationSettinds:_toTimeTxt errorIcon:nil validationMessage:[[GlobalFunction sharedInstance].arrayOfAlerts objectAtIndex:42] viewField:nil];
        return;
    }
    
    
    if ([[self convertTimeFormat:_fromTimetxt.text] compare:[self convertTimeFormat:_toTimeTxt.text]] == NSOrderedDescending || [[self convertTimeFormat:_fromTimetxt.text] compare:[self convertTimeFormat:_toTimeTxt.text]] == NSOrderedSame) {
        _fromTimetxt.text=@"";
        [self ShowAlert:[[GlobalFunction sharedInstance].arrayOfAlerts objectAtIndex:90]];
        return;
    }
    
    if(_addSessionView.hidden==NO){
        if (![_secondTimeFromText.text isEqualToString:@""]) {
            
            if ([[self convertTimeFormat:_fromTimetxt.text] compare:[self convertTimeFormat:_secondTimeFromText.text]] == NSOrderedDescending || [[self convertTimeFormat:_fromTimetxt.text] compare:[self convertTimeFormat:_secondTimeFromText.text]] == NSOrderedSame) {
                _secondTimeFromText.text=@"";
                [self ShowAlert:[[GlobalFunction sharedInstance].arrayOfAlerts objectAtIndex:91]];
                return;
            }
            
            if ([[self convertTimeFormat:_secondTimeFromText.text] compare:[self convertTimeFormat:_secondTimeToText.text]] == NSOrderedDescending || [[self convertTimeFormat:_secondTimeFromText.text] compare:[self convertTimeFormat:_secondTimeToText.text]] == NSOrderedSame) {
                _secondTimeToText.text=@"";
                [self ShowAlert:[[GlobalFunction sharedInstance].arrayOfAlerts objectAtIndex:92]];
                return;
            }
            
        }
    }
    
    /*if (![_timeFromThirdTxt.text isEqualToString:@""]) {
     
     if ([[self convertTimeFormat:_timeToSecondTxt.text] compare:[self convertTimeFormat:_timeFromThirdTxt.text]] == NSOrderedDescending || [[self convertTimeFormat:_timeToSecondTxt.text] compare:[self convertTimeFormat:_timeFromThirdTxt.text]] == NSOrderedSame) {
     _timeFromThirdTxt.text=@"";
     [self ShowAlert:[[GlobalFunction sharedInstance].arrayOfAlerts objectAtIndex:93]];
     return;
     }
     
     if ([[self convertTimeFormat:_timeFromThirdTxt.text] compare:[self convertTimeFormat:_timeToThirdTxt.text]] == NSOrderedDescending || [[self convertTimeFormat:_timeFromThirdTxt.text] compare:[self convertTimeFormat:_timeToThirdTxt.text]] == NSOrderedSame) {
     _timeToThirdTxt.text=@"";
     [self ShowAlert:[[GlobalFunction sharedInstance].arrayOfAlerts objectAtIndex:94]];
     return;
     }
     }*/
    
    [self startLoadingIndicator];
    [self ServiceCall];
}


//Discription: call the web services to update the data

-(void)ServiceCall{
    AppDelegate *appdelegate= (AppDelegate *)[[UIApplication sharedApplication]delegate];
    NSString *availablityUrl=[appdelegate.serviceURL stringByAppendingString:@"api/Provider/ProviderAvailability"];
    
    //BELOW CODE TO CREATE
    NSMutableArray *availMainArray=[[NSMutableArray alloc]init];
    //MAIN DICTIONARY
    NSMutableDictionary *availCompleteDict = [[NSMutableDictionary alloc] init];
    NSMutableDictionary *availDict = [[NSMutableDictionary alloc] init];
    
    NSMutableArray *array=[[NSMutableArray alloc]init];
    NSMutableDictionary *availTimingDict = [[NSMutableDictionary alloc] init];
    
    for (NSDictionary *item in _selectedDates) {
        
        availCompleteDict = [[NSMutableDictionary alloc] init];
        availDict = [[NSMutableDictionary alloc] init];
        
        [availDict setObject:[NSNumber numberWithInt:7] forKey:@"availabilityID"];
        [availDict setObject:item forKey:@"providerAvailableStartDate"];
        [availDict setObject:item forKey:@"providerAvailableEndDate"];
        [availDict setObject:[NSNumber numberWithBool:isWeekend] forKey:@"isWorkingWeekend"];
        [availDict setObject:[NSNumber numberWithBool:isTimeSlotChange] forKey:@"isPreferDifferentTimeSlot"];
        
        [availCompleteDict setObject:availDict forKey:@"providerAvailability"];
        
        array=[[NSMutableArray alloc]init];
        availTimingDict = [[NSMutableDictionary alloc] init];
        
        [availTimingDict setObject:[self Convert12FormatTo24Format:_fromTimetxt.text] forKey:@"startTime"];
        [availTimingDict setObject:[self Convert12FormatTo24Format:_toTimeTxt.text] forKey:@"endTime"];
        [availTimingDict setObject:[NSNumber numberWithInt:1] forKey:@"sessionTypeConfigId"];
        [array addObject: availTimingDict];
        
        if(_addSessionView.hidden==NO) {
            
            availTimingDict = [[NSMutableDictionary alloc] init];
            [availTimingDict setObject:[self Convert12FormatTo24Format:_secondTimeFromText.text] forKey:@"startTime"];
            [availTimingDict setObject:[self Convert12FormatTo24Format:_secondTimeToText.text] forKey:@"endTime"];
            [availTimingDict setObject:[NSNumber numberWithInt:2] forKey:@"sessionTypeConfigId"];
            [array addObject: availTimingDict];
        }
        
        [availCompleteDict setObject:array forKey:@"providerAvailableTiming"];
        
        [availMainArray addObject: availCompleteDict];
    }
    
    /*[
     {
     "providerAvailability": {
     "availabilityID": 0,
     "providerAvailableStartDate": "2017-04-20T12:57:30.307Z",
     "providerAvailableEndDate": "2017-04-20T12:57:30.307Z",
     "isWorkingWeekend": true,
     "isPreferDifferentTimeSlot": true
     },
     "providerAvailableTiming": [
     {
     "startTime": "string",
     "endTime": "string",
     "sessionTypeConfigId": 0
     }
     ]
     }
     ]
     */
    
    /*[availDict setObject:availableID forKey:@"providerID"];
     [availDict setObject:availableData forKey:@"availiblityDate"];
     */
    
    [[GlobalFunction sharedInstance] getServerResponseAfterLogin:availablityUrl method:@"POST" param:availMainArray withCallback:^(NSInteger statusCode, NSDictionary *response, NSError *error)
     {
         //  GlobalFunction *globalValues=[[GlobalFunction alloc]init];
         if (statusCode==200) {
             
             NSMutableDictionary *data=[[NSMutableDictionary alloc]initWithDictionary:[appdelegate usersDetails]];
             
             NSMutableDictionary *dataStatus = [[data valueForKey:@"providerStatus"] mutableCopy];
             
             [dataStatus setObject:[NSNumber numberWithInt:1] forKey:@"isAvailbilityUpdated"];
             [appdelegate.usersDetails removeObjectForKey:@"providerStatus"];
             
             [appdelegate.usersDetails setObject:dataStatus forKey:@"providerStatus"];
             NSString *message=[[GlobalFunction sharedInstance].arrayOfAlerts objectAtIndex:73];
             
             _alert = [UIAlertController
                       alertControllerWithTitle:@""
                       message:message
                       preferredStyle:UIAlertControllerStyleAlert];
             
             UIAlertAction* okbutton = [UIAlertAction
                                        actionWithTitle:@"OK"
                                        style:UIAlertActionStyleDefault
                                        handler:^(UIAlertAction * action) {
                                            [self stopLoadingIndicator];
                                            
                                            //[self.navigationController popViewControllerAnimated:YES];
                                            [self dismissViewControllerAnimated:YES completion:nil];
                                            
                                        }];
             
             [_alert addAction:okbutton];
             [self presentViewController:_alert animated:YES completion: nil];
             
         }else  if(statusCode==403||statusCode==503||statusCode == 404){
             _alert = [UIAlertController
                       alertControllerWithTitle:@""
                       message:[[GlobalFunction sharedInstance].arrayOfAlerts objectAtIndex:74]
                       preferredStyle:UIAlertControllerStyleAlert];
             
             UIAlertAction* okbutton = [UIAlertAction
                                        actionWithTitle:@"OK"
                                        style:UIAlertActionStyleDefault
                                        handler:^(UIAlertAction * action) {
                                            [self stopLoadingIndicator];
                                        }];
             
             [_alert addAction:okbutton];
             [self presentViewController:_alert animated:YES completion: nil];
             
         }else if(statusCode==401){
             
             _alert = [UIAlertController
                       alertControllerWithTitle:@""
                       message:[[GlobalFunction sharedInstance].arrayOfAlerts objectAtIndex:63]
                       preferredStyle:UIAlertControllerStyleAlert];
             
             UIAlertAction* okbutton = [UIAlertAction
                                        actionWithTitle:@"OK"
                                        style:UIAlertActionStyleDefault
                                        handler:^(UIAlertAction * action) {
                                            [self stopLoadingIndicator];
                                        }];
             
             [_alert addAction:okbutton];
             [self presentViewController:_alert animated:YES completion: nil];
             
             
         }else{
             
             
             NSDictionary *messagearray=[response objectForKey:@ "modelState"];
             NSArray *dictValues=[messagearray allValues];
             NSArray *message=[dictValues objectAtIndex:0];
             
             
             _alert = [UIAlertController
                       alertControllerWithTitle:@""
                       message:[message objectAtIndex:0]
                       preferredStyle:UIAlertControllerStyleAlert];
             
             UIAlertAction* okbutton = [UIAlertAction
                                        actionWithTitle:@"OK"
                                        style:UIAlertActionStyleDefault
                                        handler:^(UIAlertAction * action) {
                                            [self stopLoadingIndicator];
                                        }];
             
             [_alert addAction:okbutton];
             [self presentViewController:_alert animated:YES completion: nil];
         }
     }];
}


//  Added by:Zeenath
//  Added Date:2016-25-08.
//  Description:To present the alert view.
- (UIViewController*) topMostController {
    UIViewController *topController = [UIApplication sharedApplication].keyWindow.rootViewController;
    
    while (topController.presentedViewController) {
        topController = topController.presentedViewController;
    }
    
    return topController;
}

//  Added by:Zeenath
//  Added Date:2016-25-08.
//  Description:called when the cancel button is clicked.

- (IBAction)cancelButtonClick:(id)sender {
    //[self.navigationController popViewControllerAnimated:YES];
    [self dismissViewControllerAnimated:YES completion:nil];
}


#pragma mark -
#pragma mark - CKCalendarDelegate


//  Added by:Zeenath
//  Added Date:2016-25-08.
//  Description:called when the back button is clicked.
- (IBAction)backClick:(id)sender {
    //[self.navigationController popViewControllerAnimated:YES];
    [self dismissViewControllerAnimated:YES completion:nil];
}


//  Added by:Zeenath
//  Added Date:2016-25-08.
//  Description:called when the dropdown arrow buttons are clicked.
- (IBAction)timeFromDropdownClick:(id)sender {
    clickedButton=@"timeFrom";
    
    _timePickerView.hidden=NO;
}
- (IBAction)timeToDropdownClick:(id)sender {
    clickedButton=@"timeTo";
    _timePickerView.hidden=NO;
}


//  Added by:Zeenath
//  Added Date:2016-25-08.
//  Description:called when the select button in the popup is clicked.
- (IBAction)selectButtonClick:(id)sender {
    // GlobalFunction *globalValues=[[GlobalFunction alloc]init];
    
    if([_timeFromText.text isEqualToString:@""] || [_timeToText.text isEqualToString:@""] ){
        _alertView = [UIAlertController
                      alertControllerWithTitle:@""
                      message:[[GlobalFunction sharedInstance].arrayOfAlerts objectAtIndex:106]
                      preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* okButton = [UIAlertAction
                                   actionWithTitle:@"OK"
                                   style:UIAlertActionStyleDefault
                                   handler:^(UIAlertAction * action) {
                                       
                                       //[self.navigationController popViewControllerAnimated:YES];
                                   }];
        [_alertView addAction:okButton];
        UIViewController *top = [self topMostController];
        [top presentViewController:_alertView animated:YES completion: nil];
        return;
    }
    
    else{
        NSMutableDictionary *dict=[[NSMutableDictionary alloc]init];
        
        NSDateFormatter *format = [[NSDateFormatter alloc] init];
        format.dateFormat = @"MM-dd-yyyy";
        
        NSDateFormatter *dtformat = [[NSDateFormatter alloc] init];
        dtformat.dateFormat = @"MM-dd-yyyy hh:mm a";
        
        
        
        
        
        if(![_timeFromText.text isEqualToString:@""] || ![_timeToText.text isEqualToString:@""])
        {
            if(![_timeFromText.text isEqualToString:@""] && ![_timeToText.text isEqualToString:@""])
            {
                if ([[self convertTimeFormat:_timeFromText.text] compare:[self convertTimeFormat:_timeToText.text]] == NSOrderedDescending || [[self convertTimeFormat:_timeFromText.text] compare:[self convertTimeFormat:_timeToText.text]] == NSOrderedSame) {
                    _timeFromText.text=@"";
                    [self ShowAlert:[[GlobalFunction sharedInstance].arrayOfAlerts objectAtIndex:90]];
                    _popupBackView.hidden=NO;
                    return;
                    
                }
                else
                {
                    
                    
                    dict=[[NSMutableDictionary alloc]init];
                    //[dict setObject:[format stringFromDate:[_selectedDates objectAtIndex:_selectedDates.count-1]]  forKey:@"endTime"];
                    [dict setObject:[NSString stringWithFormat:@"%@",[NSString stringWithFormat:@"%@ %@",[_selectedDates objectAtIndex:_selectedDates.count-1],[[GlobalFunction sharedInstance]Convert12FormatTo24Format:_timeFromText.text]]] forKey:@"startTime"];
                    [dict setObject:[NSString stringWithFormat:@"%@",[NSString stringWithFormat:@"%@ %@",[_selectedDates objectAtIndex:_selectedDates.count-1],[[GlobalFunction sharedInstance]Convert12FormatTo24Format:_timeToText.text]]] forKey:@"endTime"];
                    
                    
                    [dict setObject:@"false" forKey:@"isWholeDay"];
                    [arrayTime addObject:dict];
                    _popupBackView.hidden=YES;
                }
            }
            else{
                [self ShowAlert:[[GlobalFunction sharedInstance].arrayOfAlerts objectAtIndex:106]];
                _popupBackView.hidden=NO;
            }
        }
        if(![_secondTimeFromText.text isEqualToString:@""] || ![_secondTimeToText.text isEqualToString:@""])
        {
            
            if(![_secondTimeFromText.text isEqualToString:@""] && ![_secondTimeToText.text isEqualToString:@""])
            {
                if ([[self convertTimeFormat:_secondTimeFromText.text] compare:[self convertTimeFormat:_secondTimeToText.text]] == NSOrderedDescending || [[self convertTimeFormat:_secondTimeFromText.text] compare:[self convertTimeFormat:_secondTimeToText.text]] == NSOrderedSame) {
                    _secondTimeFromText.text=@"";
                    [self ShowAlert:[[GlobalFunction sharedInstance].arrayOfAlerts objectAtIndex:92]];
                    _popupBackView.hidden=NO;
                    return;
                }
                else  if ([[self convertTimeFormat:_timeToText.text] compare:[self convertTimeFormat:_secondTimeFromText.text]] == NSOrderedDescending ) {
                    _secondTimeFromText.text=@"";
                    [self ShowAlert:[[GlobalFunction sharedInstance].arrayOfAlerts objectAtIndex:91]];
                    _popupBackView.hidden=NO;
                    return;
                }
                else{
                    dict=[[NSMutableDictionary alloc]init];
                    //[dict setObject:[format stringFromDate:[_selectedDates objectAtIndex:_selectedDates.count-1]]  forKey:@"endTime"];
                    [dict setObject:[NSString stringWithFormat:@"%@",[NSString stringWithFormat:@"%@ %@",[_selectedDates objectAtIndex:_selectedDates.count-1],[[GlobalFunction sharedInstance]Convert12FormatTo24Format:_secondTimeFromText.text]]] forKey:@"startTime"];
                    [dict setObject:[NSString stringWithFormat:@"%@",[NSString stringWithFormat:@"%@ %@",[_selectedDates objectAtIndex:_selectedDates.count-1],[[GlobalFunction sharedInstance]Convert12FormatTo24Format:_secondTimeToText.text]]] forKey:@"endTime"];
                    
                    [dict setObject:@"false" forKey:@"isWholeDay"];
                    [arrayTime addObject:dict];
                    _popupBackView.hidden=YES;
                }
                
            }
            else{
                [self ShowAlert:[[GlobalFunction sharedInstance].arrayOfAlerts objectAtIndex:106]];
                _popupBackView.hidden=NO;
            }
            
            
        }
        if(![_thirdTimeFromText.text isEqualToString:@""] || ![_thirdTimeToText.text isEqualToString:@""])
        {
            
            if(![_thirdTimeFromText.text isEqualToString:@""] && ![_thirdTimeToText.text isEqualToString:@""])
            {
                if ([[self convertTimeFormat:_thirdTimeFromText.text] compare:[self convertTimeFormat:_thirdTimeToText.text]] == NSOrderedDescending || [[self convertTimeFormat:_thirdTimeFromText.text] compare:[self convertTimeFormat:_thirdTimeToText.text]] == NSOrderedSame) {
                    _thirdTimeFromText.text=@"";
                    [self ShowAlert:[[GlobalFunction sharedInstance].arrayOfAlerts objectAtIndex:94]];
                    _popupBackView.hidden=NO;
                    return;
                }
                else  if ([[self convertTimeFormat:_secondTimeToText.text] compare:[self convertTimeFormat:_thirdTimeFromText.text]] == NSOrderedDescending ) {
                    _thirdTimeFromText.text=@"";
                    [self ShowAlert:[[GlobalFunction sharedInstance].arrayOfAlerts objectAtIndex:93]];
                    _popupBackView.hidden=NO;
                    return;
                }
                else{
                    dict=[[NSMutableDictionary alloc]init];
                    //[dict setObject:[format stringFromDate:[_selectedDates objectAtIndex:_selectedDates.count-1]]  forKey:@"endTime"];
                    [dict setObject:[NSString stringWithFormat:@"%@",[NSString stringWithFormat:@"%@ %@",[_selectedDates objectAtIndex:_selectedDates.count-1],[[GlobalFunction sharedInstance]Convert12FormatTo24Format:_thirdTimeFromText.text]]] forKey:@"startTime"];
                    [dict setObject:[NSString stringWithFormat:@"%@",[NSString stringWithFormat:@"%@ %@",[_selectedDates objectAtIndex:_selectedDates.count-1],[[GlobalFunction sharedInstance]Convert12FormatTo24Format:_thirdTimeToText.text]]] forKey:@"endTime"];
                    
                    [dict setObject:@"false" forKey:@"isWholeDay"];
                    [arrayTime addObject:dict];
                    _popupBackView.hidden=YES;
                }
                
            }
            else{
                [self ShowAlert:[[GlobalFunction sharedInstance].arrayOfAlerts objectAtIndex:106]];
                _popupBackView.hidden=NO;
            }
        }
        if(![_fourthTomeFromText.text isEqualToString:@""] || ![_fourthTimeToText.text isEqualToString:@""])
        {
            if(![_fourthTomeFromText.text isEqualToString:@""] && ![_fourthTimeToText.text isEqualToString:@""])
            {
                if ([[self convertTimeFormat:_fourthTomeFromText.text] compare:[self convertTimeFormat:_fourthTimeToText.text]] == NSOrderedDescending ) {
                    _fourthTomeFromText.text=@"";
                    [self ShowAlert:[[GlobalFunction sharedInstance].arrayOfAlerts objectAtIndex:108]];
                    _popupBackView.hidden=NO;
                    return;
                }
                else  if ([[self convertTimeFormat:_thirdTimeToText.text] compare:[self convertTimeFormat:_fourthTomeFromText.text]] == NSOrderedDescending ) {
                    _fourthTomeFromText.text=@"";
                    [self ShowAlert:[[GlobalFunction sharedInstance].arrayOfAlerts objectAtIndex:110]];
                    _popupBackView.hidden=NO;
                    return;
                }
                else{
                    dict=[[NSMutableDictionary alloc]init];
                    //[dict setObject:[format stringFromDate:[_selectedDates objectAtIndex:_selectedDates.count-1]]  forKey:@"endTime"];
                    [dict setObject:[NSString stringWithFormat:@"%@",[NSString stringWithFormat:@"%@ %@",[_selectedDates objectAtIndex:_selectedDates.count-1],[[GlobalFunction sharedInstance]Convert12FormatTo24Format:_fourthTomeFromText.text]]] forKey:@"startTime"];
                    [dict setObject:[NSString stringWithFormat:@"%@",[NSString stringWithFormat:@"%@ %@",[_selectedDates objectAtIndex:_selectedDates.count-1],[[GlobalFunction sharedInstance]Convert12FormatTo24Format:_fourthTimeToText.text]]] forKey:@"endTime"];
                    
                    [dict setObject:@"false" forKey:@"isWholeDay"];
                    [arrayTime addObject:dict];
                    _popupBackView.hidden=YES;
                }
            }
            else{
                [self ShowAlert:[[GlobalFunction sharedInstance].arrayOfAlerts objectAtIndex:106]];
                _popupBackView.hidden=NO;
            }
            
            
            
        }
        if(![_fifthTimeFromText.text isEqualToString:@""] || ![_fifthTimeToText.text isEqualToString:@""])
        {
            if(![_fifthTimeFromText.text isEqualToString:@""] && ![_fifthTimeToText.text isEqualToString:@""])
            {
                if ([[self convertTimeFormat:_fifthTimeFromText.text] compare:[self convertTimeFormat:_fifthTimeToText.text]] == NSOrderedDescending ) {
                    _fifthTimeFromText.text=@"";
                    [self ShowAlert:[[GlobalFunction sharedInstance].arrayOfAlerts objectAtIndex:109]];
                    _popupBackView.hidden=NO;
                    return;
                }
                else  if ([[self convertTimeFormat:_fourthTimeToText.text] compare:[self convertTimeFormat:_fifthTimeFromText.text]] == NSOrderedDescending || [[self convertTimeFormat:_fourthTimeToText.text] compare:[self convertTimeFormat:_fifthTimeFromText.text]] == NSOrderedSame) {
                    _fifthTimeFromText.text=@"";
                    [self ShowAlert:[[GlobalFunction sharedInstance].arrayOfAlerts objectAtIndex:111]];
                    _popupBackView.hidden=NO;
                    return;
                }
                else{
                    dict=[[NSMutableDictionary alloc]init];
                    //[dict setObject:[format stringFromDate:[_selectedDates objectAtIndex:_selectedDates.count-1]]  forKey:@"endTime"];
                    [dict setObject:[NSString stringWithFormat:@"%@",[NSString stringWithFormat:@"%@ %@",[_selectedDates objectAtIndex:_selectedDates.count-1],[[GlobalFunction sharedInstance]Convert12FormatTo24Format:_fifthTimeFromText.text]]] forKey:@"startTime"];
                    [dict setObject:[NSString stringWithFormat:@"%@",[NSString stringWithFormat:@"%@ %@",[_selectedDates objectAtIndex:_selectedDates.count-1],[[GlobalFunction sharedInstance]Convert12FormatTo24Format:_fifthTimeToText.text]]] forKey:@"endTime"];
                    
                    [dict setObject:@"false" forKey:@"isWholeDay"];
                    [arrayTime addObject:dict];
                    _popupBackView.hidden=YES;
                }
            }
            else{
                [self ShowAlert:[[GlobalFunction sharedInstance].arrayOfAlerts objectAtIndex:106]];
                _popupBackView.hidden=NO;
            }
            
        }
        
        // arrayTime=array;
        
    }
}


//  Added by:Zeenath
//  Added Date:2016-30-08.
//  Description:To show the alert.

-(void)ShowAlert:(NSString *)message{
    _alertView = [UIAlertController
                  alertControllerWithTitle:@""
                  message:message
                  preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* okButton = [UIAlertAction
                               actionWithTitle:@"OK"
                               style:UIAlertActionStyleDefault
                               handler:^(UIAlertAction * action) {
                                   [self stopLoadingIndicator];
                               }];
    [_alertView addAction:okButton];
    [self presentViewController:_alertView animated:YES completion: nil];
}

//  Added by:Zeenath
//  Added Date:2016-25-08.
//  Description:called when the more button in the popup is clicked.
- (IBAction)moreButtonClick:(id)sender {
    // GlobalFunction *globalValues=[[GlobalFunction alloc]init];
    
    if((![_timeFromText.text isEqualToString:@""] || ![_timeToText.text isEqualToString:@""]) && count==0)
    {
        _secondTimeView.hidden=NO;
        [_contentScrollView setContentOffset:CGPointMake(_contentScrollView.frame.origin.x, 50) animated:YES];
        if(count==0)
        {
            count++;
        }
        return;
    }
    else{
        if (count==0)
        {
            [self ShowAlert:[[GlobalFunction sharedInstance].arrayOfAlerts objectAtIndex:106]];
            return;
        }
    }
    
    
    if(((![_secondTimeFromText.text isEqualToString:@""] || ![_secondTimeToText.text isEqualToString:@""])) && count==1)
    {
        
        _thirdTimeView.hidden=NO;
        [_contentScrollView setContentOffset:CGPointMake(_contentScrollView.frame.origin.x, 90) animated:YES];
        
        count++;
        return;
        
    }
    else{
        if(count==1)
        {
            [self ShowAlert:[[GlobalFunction sharedInstance].arrayOfAlerts objectAtIndex:106]];
            return;
        }
    }
    
    
    if((![_thirdTimeFromText.text isEqualToString:@""] || ![_thirdTimeToText.text isEqualToString:@""]) && count==2)
    {
        
        _fourthTimeView.hidden=NO;
        [_contentScrollView setContentOffset:CGPointMake(_contentScrollView.frame.origin.x, 130) animated:YES];
        count++;
        return;
    }
    else
    {
        if(count==2)
        {
            [self ShowAlert:[[GlobalFunction sharedInstance].arrayOfAlerts objectAtIndex:106]];
            return;
        }
    }
    
    if((![_fourthTomeFromText.text isEqualToString:@""] || ![_fourthTimeToText.text isEqualToString:@""]) && count==3)
    {
        
        _fifthTimeView.hidden=NO;
        [_contentScrollView setContentOffset:CGPointMake(_contentScrollView.frame.origin.x, 170) animated:YES];
        count++;
        return;
    }
    else
    {
        if(count==3)
        {
            [self ShowAlert:[[GlobalFunction sharedInstance].arrayOfAlerts objectAtIndex:106]];
            return;
        }
    }
    
    if(count>=4){
        [self ShowAlert:[[GlobalFunction sharedInstance].arrayOfAlerts objectAtIndex:118]];
        return;
    }
}


//  Added by:Zeenath
//  Added Date:2016-25-08.
//  Description:to resign the keyboard.
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

//  Added by:Zeenath
//  Added Date:2016-25-08.
//  Description:called when the dropdown arrow buttons are clicked.
- (IBAction)secondTimeFromDropdownClick:(id)sender {
    
    clickedButton=@"secondTimeFrom";
    
    _timePickerView.hidden=NO;
}
- (IBAction)secondTimeToDropdownClick:(id)sender {
    
    clickedButton=@"secondTimeTo";
    
    _timePickerView.hidden=NO;
}
- (IBAction)thirdTimeFromDropdownClick:(id)sender {
    clickedButton=@"thirdTimeFrom";
    
    _timePickerView.hidden=NO;
}

- (IBAction)thirdTimeToDropdownClick:(id)sender {
    clickedButton=@"thirdTimeTo";
    
    _timePickerView.hidden=NO;
}
- (IBAction)fourthTimeFromDropdownClick:(id)sender {
    
    clickedButton=@"fourthTimeFrom";
    
    _timePickerView.hidden=NO;
    
}

- (IBAction)fourthTimeToDropdown:(id)sender {
    
    clickedButton=@"fourthTimeTo";
    
    _timePickerView.hidden=NO;
}
- (IBAction)fifthTimeFromDropdownClick:(id)sender {
    clickedButton=@"fifthTimeFrom";
    
    _timePickerView.hidden=NO;
}
- (IBAction)fifthTimeToDropdownClick:(id)sender {
    clickedButton=@"fifthTimeTo";
    
    _timePickerView.hidden=NO;
}

//Added by: Zeenath
//Added Date: 23/08/2016
//Discription: for showing custom calandar control
-(void)showCalendar
{
    if(!self.datePicker)
        self.datePicker = [THDatePickerViewController datePicker];
    
    CGRect thisRect = _datePicker.view.frame;
    
    //modify required frame parameter (.origin.x/y, .size.width/height)
    
    thisRect.origin.y = self.selectedDatesTxt.frame.origin.y;
    //((self.calendarView.frame.size.height-_datePicker.view.frame.size.height)/2);
    thisRect.origin.x = ((self.calendarView.frame.size.width-_datePicker.view.frame.size.width)/2);
    thisRect.size.height=self.calendarView.frame.size.height;
    thisRect.size.width=self.calendarView.frame.size.width;
    
    //set modified frame to object
    [_datePicker.view setFrame:thisRect];
    
    
    
    
    
    self.datePicker.date = self.curDate;
    
    
    //_datePicker.view = CGRectMake((calendarView.size.width - view.frame.size.width) / 2.0,(calendarView.size.height - view.frame.size.height) / 2.0,view.frame.size.width, semiViewHeight);
    /*   self.datePicker.delegate = self;
     [self.datePicker setAllowClearDate:NO];
     [self.datePicker setClearAsToday:YES];
     [self.datePicker setAutoCloseOnSelectDate:NO];
     [self.datePicker setAllowSelectionOfSelectedDate:YES];
     [self.datePicker setDisableHistorySelection:YES];
     [self.datePicker setDisableFutureSelection:NO];
     [self.datePicker setSelectedBackgroundColor:[UIColor colorWithRed:228/255.0 green:109/255.0 blue:175/255.0 alpha:1.0]];
     [self.datePicker setCurrentDateColor:[UIColor colorWithRed:200/255.0 green:121/255.0 blue:100/255.0 alpha:1.0]];
     
     [self.datePicker setAllowMultiDaySelection:YES];*/
    [self.datePicker setDisableYearSwitch:TRUE];
    
    
    self.datePicker.date = self.curDate;
    
    self.datePicker.delegate = self;
    [self.datePicker setAllowClearDate:NO];
    [self.datePicker setClearAsToday:YES];
    [self.datePicker setAutoCloseOnSelectDate:YES];
    [self.datePicker setAllowSelectionOfSelectedDate:YES];
    [self.datePicker setDisableHistorySelection:YES];
    [self.datePicker setDisableFutureSelection:NO];
    [self.datePicker setSelectedBackgroundColor:[UIColor colorWithRed:250/255.0 green:131/255.0 blue:137/255.0 alpha:1.0]];
    
    /*   [self.datePicker setCurrentDateColor:[UIColor colorWithRed:246/255.0 green:108/255.0 blue:100/255.0 alpha:1.0]];*/
    [self.datePicker setCurrentDateColor:[UIColor colorWithRed:200/255.0 green:121/255.0 blue:100/255.0 alpha:1.0]];
    
    [self.datePicker setAllowMultiDaySelection:YES];
    [self.datePicker setDateHasItemsCallback:^BOOL(NSDate *date) {
        int tmp = (arc4random() % 30)+1;
        if(tmp % 5 == 0)
            return YES;
        return NO;
    }];
    
    
    _calendarView.hidden=NO;
    
    [self addChildViewController:_datePicker];
    [self.calendarView addSubview:_datePicker.view];
    [_datePicker didMoveToParentViewController:self];
    
    NSString *month= [_datePicker getMonthValue];
    
    NSString *monthString = [[month componentsSeparatedByString:@" "] objectAtIndex:0];
    NSString *yearString = [[month componentsSeparatedByString:@" "] objectAtIndex:1];
    
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MMM"];
    NSDate *aDate = [formatter dateFromString:monthString];
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitMonth fromDate:aDate];
    
    [self callService:[components month]:[yearString integerValue]];
    
}

/*
 - (void)datePickerDonePressed:(THDatePickerViewController *)datePicker {
 self.curDate = datePicker.date;
 [self dismissSemiModalView];
 }
 
 - (void)datePickerCancelPressed:(THDatePickerViewController *)datePicker {
 [self dismissSemiModalView];
 }*/

//  Added by:Zeenath
//  Added Date:2016-23-08.
//  Description:called when the date is selected from the calendar.
- (void)datePicker:(THDatePickerViewController *)datePicker selectedDate:(NSDate *)selectedDate {
    
    if([_screenStatus isEqualToString:@"LimitedDays"])
    {
        if ([self.selectedDates containsObject:selectedDate]) {
            [self.selectedDates removeObject:selectedDate];
        } else {
            [self.selectedDates addObject:selectedDate];
        }
    }
    else{
        if ([self.selectedDates containsObject:[_formatter stringFromDate:selectedDate]]) {
            //  [self.selectedDates removeObject:[_formatter stringFromDate:selectedDate]];
        } else {
            [self.selectedDates addObject:[_formatter stringFromDate:selectedDate]];
        }
    }
    
    _timeFromText.text=@"";
    _timeToText.text=@"";
    _secondTimeFromText.text=@"";
    _secondTimeToText.text=@"";
    _thirdTimeFromText.text=@"";
    _thirdTimeToText.text=@"";
    _fourthTomeFromText.text=@"";
    _fourthTimeToText.text=@"";
    _fifthTimeFromText.text=@"";
    _fifthTimeToText.text=@"";
    _secondTimeView.hidden=YES;
    _thirdTimeView.hidden=YES;
    _fourthTimeView.hidden=YES;
    _fifthTimeView.hidden=YES;
    if([_screenStatus isEqualToString:@"LimitedDays"]){
        
        _popupBackView.hidden=YES;
    }
    else
    {
        _popupBackView.hidden=NO;
        [_contentScrollView setContentOffset:CGPointMake(_contentScrollView.frame.origin.x, -7) animated:YES];
        count=0;
        _timePickerView.hidden=YES;
        
    }
    
}

//  Added by:Zeenath
//  Added Date:2016-25-08.
//  Description:called when the date is deselected from the calendar.
- (void)datePicker:(THDatePickerViewController *)datePicker deselectedDate:(NSDate *)selectedDate {
    
    //if([_screenStatus isEqualToString:@"LimitedDays"])
    //{
    if ([self.selectedDates containsObject:selectedDate])
    {
        [self.selectedDates removeObject:selectedDate];
    }
    /* }
     else
     {
     if ([self.selectedDates containsObject:[_formatter stringFromDate:selectedDate]]) {
     [self.selectedDates removeObject:[_formatter stringFromDate:selectedDate]];
     }
     }*/
    
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    [format setDateFormat:@"YYYY-MM-dd"];
    //  NSDate *now = [NSDate date];
    NSString *nsstr = [format stringFromDate:selectedDate];
    @autoreleasepool {
        for(int i=0; i <= arrayTime.count-1 ; i++){
            
            if(arrayTime.count>0){
                NSMutableDictionary *dict=[arrayTime objectAtIndex:i];
                NSString *date=[dict objectForKey:@"startTime"];
                NSString *dateString = [[date componentsSeparatedByString:@"T"] objectAtIndex:0];
                dateString = [[dateString componentsSeparatedByString:@" "] objectAtIndex:0];
                
                if([nsstr isEqualToString:dateString])
                {
                    [arrayTime removeObject:dict];
                    
                    i--;
                }
            }else{
                return;
            }
            
            
        }
    }
}


//  Added by:Zeenath
//  Added Date:2016-25-08.
//  Description:called when the month is changed in the calendar.
-(void)datePicker:(THDatePickerViewController *)datePicker changedMonth:(NSInteger)month year:(NSInteger)year
{
    
    if(prevMonth==0){
        prevMonth=month;
    }
    
    if(prevYear==0){
        prevYear=year;
    }
    
    if(prevYear!=year){
        prevYear=year;
    }
    
    if(prevMonth!=month){
        prevMonth=month;
        [self callService:month :year];
    }
    
}

//Added by: Zeenath
//Added Date: 23/08/2016
//Discription: for calling service to send limited days and limited hours
-(void)callService :(NSInteger)month :(NSInteger)year
{
    
    //    GlobalFunction *globalValues=[[GlobalFunction alloc]init];
    AppDelegate *appdelegate=(AppDelegate *)[[UIApplication sharedApplication]delegate];
    NSString *Url=[appdelegate.serviceURL stringByAppendingFormat:@"api/Provider/CustomAvailability?month=%ld&year=%ld",(long)month,(long)year];
    NSMutableArray *array= [[NSMutableArray alloc]init];
    [self startLoadingIndicator];
    [[GlobalFunction sharedInstance]getServerResponseAfterLogin:Url method:@"GET" param:nil withCallback:^(NSInteger statusCode, NSDictionary *response, NSError *error) {
        
        
        if(statusCode == 200 || statusCode==404)
        {
            [self stopLoadingIndicator];
            if(response != nil)
            {
                NSMutableArray *arr= [response mutableCopy];
                @autoreleasepool {
                    
                    for(int i=0;i<arr.count;i++)
                    {
                        NSMutableDictionary *dict=[[arr objectAtIndex:i] mutableCopy];
                        
                        if (([[dict objectForKey:@"isWholeDay"] isEqual:[NSNumber numberWithInt:1]] && [_screenStatus isEqualToString:@"LimitedDays"]) || ([[dict objectForKey:@"isWholeDay"] isEqual:[NSNumber numberWithInt:0]] && [_screenStatus isEqualToString:@"LimitedHours"])) {
                            
                            NSDateFormatter *formatr=[[NSDateFormatter alloc]init];
                            [formatr setDateFormat:@"yyyy-MM-dd"];
                            
                            
                            [array addObject:[formatr dateFromString:[[[dict objectForKey:@"startTime"] componentsSeparatedByString:@"T"] objectAtIndex:0]]];
                            [dict removeObjectForKey:@"day"];
                            [arrayTime addObject:dict];
                        }
                        
                    }
                }
                // if([_screenStatus isEqualToString:@"LimitedDays"]){
                
                [self.datePicker setSelectedDates:array];
                _selectedDates=array;
            }
        }
        else{
            NSString *message;
            
            if(statusCode==403||statusCode==503){
                
                message=[[GlobalFunction sharedInstance].arrayOfAlerts objectAtIndex:74];
                
            }else if(statusCode==401){
                
                message=[[GlobalFunction sharedInstance].arrayOfAlerts objectAtIndex:63];
                
            }else{
                
                NSDictionary *messagearray=[response objectForKey:@ "modelState"];
                NSArray *dictValues=[messagearray allValues];
                NSArray *array=[dictValues objectAtIndex:0];
                message=[array objectAtIndex:0];
            }
            
            _alertView = [UIAlertController
                          alertControllerWithTitle:@""
                          message:message
                          preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction* okButton = [UIAlertAction
                                       actionWithTitle:@"OK"
                                       style:UIAlertActionStyleDefault
                                       handler:^(UIAlertAction * action) {
                                           
                                           [self.navigationController popViewControllerAnimated:YES];
                                           
                                       }];
            [_alertView addAction:okButton];
            UIViewController *top = [self topMostController];
            [top presentViewController:_alertView animated:YES completion: nil];
            [self stopLoadingIndicator];
        }
        
    }];
    
    
    
}

//  Added by:Zeenath
//  Added Date:2016-25-08.
//  Description:convert the time format to 24hour format.
-(NSDate *)convertTimeFormat:(NSString *)time{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"hh:mm a"];
    NSDate *amPmDate = [formatter dateFromString:time];
    [formatter setDateFormat:@"HH:mm"];
    return amPmDate;
}


//  Added by:Zeenath
//  Added Date:2016-24-08.
//  Description:To start the activity indicator.
-(void)startLoadingIndicator
{
    
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGFloat screenWidth = screenRect.size.width;
    CGFloat screenHeight = screenRect.size.height;
    _loadingView= [[UIView alloc] initWithFrame: CGRectMake ( 0, 20, screenWidth, screenHeight)];
    _loadingView.backgroundColor = [UIColor colorWithRed:0.0/255.0 green:0.0/255.0 blue:0.0/255.0 alpha:0.25];
    [self.view addSubview:_loadingView];
    UIActivityIndicatorView *spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    spinner.color=[UIColor whiteColor];
    [self.loadingView addSubview:spinner];
    [self.loadingView bringSubviewToFront:spinner];
    spinner.hidesWhenStopped = YES;
    spinner.center = self.loadingView.center;
    
    [spinner startAnimating];
    
}



-(void)resignSoftKeyboard{
    [_fromTimetxt resignFirstResponder];
    [_toTimeTxt resignFirstResponder];
    [_secondTimeFromText resignFirstResponder];
    [_secondTimeToText resignFirstResponder];
    [_dumytxtfield resignFirstResponder];
    
}

//  Added by:Zeenath
//  Added Date:2016-24-08.
//  Description:To stop the activity indicator.

-(void)stopLoadingIndicator
{
    _loadingView.hidden=YES;
}

//Discription: To convert 24 hour format time into 12 hour format

-(NSString *)Convert24FormatTo12Format:(NSString *)time{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"HH:mm:ss"];
    
    NSDate *amPmDate = [formatter dateFromString:time];
    [formatter setDateFormat:@"hh:mm a"];
    
    NSString *HourString = [formatter stringFromDate:amPmDate];
    return HourString;
}

//Added by: Nalina
//Added Date: 23/08/2016
//Discription: To convert 12 hour format time into 24 hour format

-(NSString *)Convert12FormatTo24Format:(NSString *)time{
    NSString *HourString;
    if (![time isEqualToString:@""]) {
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"hh:mm a"];
        NSDate *amPmDate = [formatter dateFromString:time];
        [formatter setDateFormat:@"HH:mm"];
        HourString = [formatter stringFromDate:amPmDate];
    }else{
        HourString = @"";
    }
    
    return HourString;
}

//Discription: Set validation design to the input fields

-(void)SetValidationSettinds:(UITextField *)textField errorIcon:(UIButton *)errorBtn validationMessage:(NSString *)validationMessage viewField:(UIView *)viewIs{
    
    [textField setValue:[UIColor redColor] forKeyPath:@"_placeholderLabel.textColor"];
    textField.placeholder=validationMessage;
    //errorBtn.hidden=NO;
    //viewIs.layer.borderColor = [[UIColor redColor]CGColor];
    //viewIs.layer.borderWidth = 1.0f;
    
}


@end
