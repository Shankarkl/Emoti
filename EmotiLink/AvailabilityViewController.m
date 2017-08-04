/***************************************************************
 Page name: AvailabilityViewController.m
 Created By:Nalina
 Created Date:19/07/16
 Description:Availability(Quick Start) implementation Screen.
 ***************************************************************/

#import "AvailabilityViewController.h"
#import "GlobalFunction.h"
#include "LimitedDaysAvailability.h"
#include "LoginViewController.h"
#include "LimitedMonthAvailablityViewController.h"
#include "LimitedWeekAvailabilityViewController.h"
#include "ProviderUnavailabiltyViewController.h"
#import "AppDelegate.h"
#import <Google/Analytics.h>

@interface AvailabilityViewController ()

@end

@implementation AvailabilityViewController
@synthesize availablepickerArray,availablepickerIDArray,availableData;

//Loads when screen appears for the first time
- (void)viewDidLoad {
    
    UIButton *cancelBtn = (UIButton *) [self.view viewWithTag:5];
    cancelBtn.layer.borderColor = [UIColor colorWithRed:246.0/255.0 green:108.0/255.0 blue:118.0/255.0 alpha:1].CGColor;
    
    Monthlybtn = NO;
    Weeklybtn = NO;
    Dailybtn =  NO;
    Unavailblebtn = NO;
    isTimeSlotChanged=NO;
    isWeekend=NO;
    
    _weeklytextfield.layer.borderColor=[[UIColor colorWithRed:197/255.0f green:224/255.0f blue:224/255.0f alpha:1.0] CGColor];
    
    UIButton *Mnthly = (UIButton *) [self.view viewWithTag:1];
    Mnthly.layer.borderColor = [UIColor colorWithRed:197.0/255.0 green:224.0/255.0 blue:224.0/255.0 alpha:1].CGColor;
    
    UIButton *Weekly = (UIButton *) [self.view viewWithTag:2];
    Weekly.layer.borderColor = [UIColor colorWithRed:197.0/255.0 green:224.0/255.0 blue:224.0/255.0 alpha:1].CGColor;
    
    UIButton *Daily = (UIButton *) [self.view viewWithTag:3];
    Daily.layer.borderColor = [UIColor colorWithRed:197.0/255.0 green:224.0/255.0 blue:224.0/255.0 alpha:1].CGColor;
    
    UIButton *Unavailable = (UIButton *) [self.view viewWithTag:4];
    Unavailable.layer.borderColor = [UIColor colorWithRed:197.0/255.0 green:224.0/255.0 blue:224.0/255.0 alpha:1].CGColor;
    
    UIImage *backgroundImage = [UIImage imageNamed:@"06. Appointment Confirmation.png"];
    UIImageView *backgroundImageView=[[UIImageView alloc]initWithFrame:self.view.frame];
    backgroundImageView.image=backgroundImage;
    [self.view insertSubview:backgroundImageView atIndex:0];
    
    UITapGestureRecognizer *singleFingerTap =
    [[UITapGestureRecognizer alloc] initWithTarget:self
                                            action:@selector(closePickerView:)];
    [self.pickerBackView addGestureRecognizer:singleFingerTap];
    
    timeDict=[[NSMutableDictionary alloc]init];
    
    //to set monthly as default
    Monthlybtn = [self setButtonColorOnSelected:1 boolValue:Monthlybtn addDictValue:Monthlybval];
    
    //Added by: Nalina
    //Added Date: 6/08/2016
    //Discription: Prepopulate the data to the input fields by taking GET service call response
    if ([[availableData objectForKey:@"fsStartTime"] isEqual:[NSNull null]]) {
        _timeFromFirstText.text= @"";
    }else{
        NSString *hourString=[self Convert24FormatTo12Format:[availableData objectForKey:@"fsStartTime"]];
        _timeFromFirstText.text= hourString;
    }
    
    if ([[availableData objectForKey:@"fsEndTime"] isEqual:[NSNull null]]) {
        _timeToFirstTxt.text=@"";
    }else{
        NSString *hourString=[self Convert24FormatTo12Format:[availableData objectForKey:@"fsEndTime"]];
        _timeToFirstTxt.text= hourString;
    }
    
    if ([[availableData objectForKey:@"ssStartTime"] isEqual:[NSNull null]]) {
        _timeFromSecondTxt.text=@"";
    }else{
        NSString *hourString=[self Convert24FormatTo12Format:[availableData objectForKey:@"ssStartTime"]];
        _timeFromSecondTxt.text= hourString;
    }
    
    if ([[availableData objectForKey:@"ssEndTime"] isEqual:[NSNull null]]) {
        _timeToSecondTxt.text=@"";
    }else{
        NSString *hourString=[self Convert24FormatTo12Format:[availableData objectForKey:@"ssEndTime"]];
        _timeToSecondTxt.text= hourString;
    }
    
    if ([[availableData objectForKey:@"tsEndTime"] isEqual:[NSNull null]]) {
        _timeToThirdTxt.text=@"";
    }else{
        NSString *hourString=[self Convert24FormatTo12Format:[availableData objectForKey:@"tsEndTime"]];
        _timeToThirdTxt.text= hourString;
    }
    
    if ([[availableData objectForKey:@"tsStartTime"] isEqual:[NSNull null]]) {
        _timeFromThirdTxt.text=@"";
    }else{
        NSString *hourString=[self Convert24FormatTo12Format:[availableData objectForKey:@"tsStartTime"]];
        _timeFromThirdTxt.text= hourString;
    }
    
    @autoreleasepool {
        
        for(int i=0;i<availablepickerIDArray.count;i++) {
            if ([[availableData objectForKey:@"availabilityID"] isEqualToValue:[availablepickerIDArray objectAtIndex:i ]]) {
                _availableTxt.text=[availablepickerArray objectAtIndex:i];
                availableID=[availablepickerIDArray objectAtIndex:i];
            }
        }
    }
    dataSource = [[NSArray alloc] init];
    timePickerArray = [[NSArray alloc] init];
    
    //Added by: Nalina
    //Added Date: 26/08/2016
    //Discription: check available on and display time picker depends on that condition
    
    if ([_availableTxt.text isEqualToString:@"WeekDayNights"]) {
        timePickerArray = [[NSArray alloc]initWithObjects:@"6:00 PM",@"6:30 PM",@"7:00 PM",@"7:30 PM",@"8:00 PM",@"8:30 PM",@"9:00 PM",@"9:30 PM",@"10:00 PM",@"10:30 PM",@"11:00 PM",@"11:30 PM",@"12:00 AM",
                           @"12:30 AM",@"1:00 AM",@"1:30 AM",@"2:00 AM",@"2:30 AM",@"3:00 AM",@"3:30 AM",@"4:00 AM",@"4:30 AM",@"5:00 AM",@"5:30 AM", nil];
        
    }else if ([_availableTxt.text isEqualToString:@"AllDays24X7"]){
        timePickerArray = [[NSArray alloc]initWithObjects:@"12:00 AM",
                           @"12:30 AM",@"1:00 AM",@"1:30 AM",@"2:00 AM",@"2:30 AM",@"3:00 AM",@"3:30 AM",@"4:00 AM",@"4:30 AM",@"5:00 AM",@"5:30 AM",@"6:00 AM",@"6:30 AM",@"7:00 AM",@"7:30 AM",@"8:00 AM",@"8:30 AM",@"9:00 AM",@"9:30  AM",@"10:00 AM",@"10:30 AM",@"11:00 AM",@"11:30 AM",@"12:00 PM",@"12:30 PM",@"1:00 PM",@"1:30 PM",@"2:00 PM",@"2:30 PM",@"3:00 PM",@"3:30 PM",@"4:00 PM",@"4:30 PM",@"5:00 PM",@"5:30 PM",@"6:00 PM",@"6:30 PM",@"7:00 PM",@"7:30 PM",@"8:00 PM",@"8:30 PM",@"9:00 PM",@"9:30 PM",@"10:00 PM",@"10:30 PM",@"11:00 PM",@"11:30 PM", nil];
        
    }else if ([_availableTxt.text isEqualToString:@"WeekEnds"]||[_availableTxt.text isEqualToString:@"WeekDays"]){
        timePickerArray = [[NSArray alloc]initWithObjects:@"6:00 AM",@"6:30 AM",@"7:00 AM",@"7:30 AM",@"8:00 AM",@"8:30 AM",@"9:00 AM",@"9:30  AM",@"10:00 AM",@"10:30 AM",@"11:00 AM",@"11:30 AM",@"12:00 PM",@"12:30 PM",@"1:00 PM",@"1:30 PM",@"2:00 PM",@"2:30 PM",@"3:00 PM",@"3:30 PM",@"4:00 PM",@"4:30 PM",@"5:00 PM",@"5:30 PM",@"6:00 PM", nil];
    }else{
        timePickerArray = [[NSArray alloc]initWithObjects:@"6:00 AM",@"6:30 AM",@"7:00 AM",@"7:30 AM",@"8:00 AM",@"8:30 AM",@"9:00 AM",@"9:30  AM",@"10:00 AM",@"10:30 AM",@"11:00 AM",@"11:30 AM",@"12:00 PM",@"12:30 PM",@"1:00 PM",@"1:30 PM",@"2:00 PM",@"2:30 PM",@"3:00 PM",@"3:30 PM",@"4:00 PM",@"4:30 PM",@"5:00 PM",@"5:30 PM",@"6:00 PM", nil];
        
    }
    
    [super viewDidLoad];
}



-(void)viewDidAppear:(BOOL)animated
{
    if ([_pagename isEqualToString:@"firsttime"]) {
        [_nextBtn setTitle:@"Next" forState:UIControlStateNormal];
        [_cancelBtn setTitle:@"Logout" forState:UIControlStateNormal];
        _Backbutton.hidden=YES;
    }else{
        [_nextBtn setTitle:@"Next" forState:UIControlStateNormal];
        [_cancelBtn setTitle:@"Cancel" forState:UIControlStateNormal];
        _Backbutton.hidden=NO;
        
        
    }
    
}

//Added by: Nalina
//Added Date: 23/08/2016
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


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)closePickerView:(UITapGestureRecognizer *)recognizer {
    _pickerBackView.hidden=YES;
}

//Added by: Nalina
//Added Date: 19/07/2016
//Discription: To set the default border to the input text fields
-(void)setBorder:(UIView *)view
{
    view.layer.borderColor = [[UIColor colorWithRed:228.0/255.0 green:109.0/255.0 blue:175.0/255.0 alpha:1.0]CGColor];
    view.layer.borderWidth = 1.0f;
}

//Appears each time when page loads
-(void)viewWillAppear:(BOOL)animated{
    [self setBorder:_availableView];
    [self setBorder:_timeFromFirstView];
    [self setBorder:_timeToFirstView];
    [self setBorder:_timeFromSecondView];
    [self setBorder:_timeToSecondView];
    [self setBorder:_timeFromThirdView];
    [self setBorder:_timeToThirdView];
    [[self navigationController] setNavigationBarHidden:YES animated:YES];
    
    id<GAITracker> tracker = [[GAI sharedInstance] defaultTracker];
    [tracker set:kGAIScreenName value:@"Availability"];
    [tracker send:[[GAIDictionaryBuilder createScreenView] build]];
    
    UITapGestureRecognizer *availableTap =
    [[UITapGestureRecognizer alloc] initWithTarget:self
                                            action:@selector(availableOnClick:)];
    [self.availableView addGestureRecognizer:availableTap];
    
    UITapGestureRecognizer *timefrom1Tap =
    [[UITapGestureRecognizer alloc] initWithTarget:self
                                            action:@selector(timeFrom1Click:)];
    [self.timeFromFirstView addGestureRecognizer:timefrom1Tap];
    
    UITapGestureRecognizer *timeto1Tap =
    [[UITapGestureRecognizer alloc] initWithTarget:self
                                            action:@selector(timeTo1Click:)];
    [self.timeToFirstView addGestureRecognizer:timeto1Tap];
    
    UITapGestureRecognizer *timefrom2Tap =
    [[UITapGestureRecognizer alloc] initWithTarget:self
                                            action:@selector(timeFrom2Click:)];
    [self.timeFromSecondView addGestureRecognizer:timefrom2Tap];
    
    UITapGestureRecognizer *timeto2Tap =
    [[UITapGestureRecognizer alloc] initWithTarget:self
                                            action:@selector(timeTo2Click:)];
    [self.timeToSecondView addGestureRecognizer:timeto2Tap];
    
    UITapGestureRecognizer *timefrom3Tap =
    [[UITapGestureRecognizer alloc] initWithTarget:self
                                            action:@selector(timeFrom3Click:)];
    [self.timeFromThirdView addGestureRecognizer:timefrom3Tap];
    
    UITapGestureRecognizer *timeto3Tap =
    [[UITapGestureRecognizer alloc] initWithTarget:self
                                            action:@selector(timeTo3Click:)];
    [self.timeToThirdView addGestureRecognizer:timeto3Tap];
}

//Added by: Nalina
//Added Date: 19/07/2016
//Discription: pop's picker when we touch on available on input field and remove validation if any

- (void)availableOnClick:(UITapGestureRecognizer *)recognizer {
    clickedPicker=@"available";
    dataSource=availablepickerArray;
    [self.pickerView reloadAllComponents];
    _pickerBackView.hidden=NO;
    [self RemoveValidationSettings:_availableTxt errorIcon:_availableError HintText:@"I am available on" viewField:_availableView];
}

//Added by: Nalina
//Added Date: 19/07/2016
//Discription: pop's picker when we touch on session one from time input field and remove validation if any

- (void)timeFrom1Click:(UITapGestureRecognizer *)recognizer {
    clickedPicker=@"timeFromFirst";
    dataSource=timePickerArray;
    [self.pickerView reloadAllComponents];
    _pickerBackView.hidden=NO;
    [self RemoveValidationSettings:_timeFromFirstText errorIcon:_timeFromFirstError HintText:@"Time From" viewField:_timeFromFirstView];
}

//Added by: Nalina
//Added Date: 19/07/2016
//Discription: pop's picker when we touch on session one time to input field and remove validation if any

- (void)timeTo1Click:(UITapGestureRecognizer *)recognizer {
    clickedPicker=@"timeToFirst";
    dataSource=timePickerArray;
    [self.pickerView reloadAllComponents];
    _pickerBackView.hidden=NO;
    [self RemoveValidationSettings:_timeToFirstTxt errorIcon:_timeToFirstError HintText:@"Time To" viewField:_timeToFirstView];
}

//Added by: Nalina
//Added Date: 19/07/2016
//Discription: pop's picker when we touch on session two from time input field and remove validation if any

- (void)timeFrom2Click:(UITapGestureRecognizer *)recognizer {
    clickedPicker=@"timeFromSecond";
    dataSource=timePickerArray;
    [self.pickerView reloadAllComponents];
    _pickerBackView.hidden=NO;
}

//Added by: Nalina
//Added Date: 19/07/2016
//Discription: pop's picker when we touch on session two to time input field and remove validation if any

- (void)timeTo2Click:(UITapGestureRecognizer *)recognizer {
    clickedPicker=@"timeToSecond";
    dataSource=timePickerArray;
    [self.pickerView reloadAllComponents];
    _pickerBackView.hidden=NO;
}

//Added by: Nalina
//Added Date: 19/07/2016
//Discription: pop's picker when we touch on session three from time input field and remove validation if any

- (void)timeFrom3Click:(UITapGestureRecognizer *)recognizer {
    clickedPicker=@"timeFromThird";
    dataSource=timePickerArray;
    [self.pickerView reloadAllComponents];
    _pickerBackView.hidden=NO;
}

//Added by: Nalina
//Added Date: 19/07/2016
//Discription: pop's picker when we touch on session three from to input field and remove validation if any

- (void)timeTo3Click:(UITapGestureRecognizer *)recognizer {
    clickedPicker=@"timeToThird";
    dataSource=timePickerArray;
    [self.pickerView reloadAllComponents];
    _pickerBackView.hidden=NO;
}

//close the screen
-(void)goBack{
    [availablepickerIDArray removeAllObjects];
    [availablepickerArray removeAllObjects];
    [self.navigationController popViewControllerAnimated:YES];
}

//To return the number of components in a picker view
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)thePickerView {
    
    return 1;
}

//To return the number of rows in a picker view
- (NSInteger)pickerView:(UIPickerView *)thePickerView numberOfRowsInComponent:(NSInteger)component {
    return dataSource.count;
}

//To return the data of rows in a picker view
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:
(NSInteger)row forComponent:(NSInteger)component{
    return [dataSource objectAtIndex:row];
}

//To return the data selected in picker view and display in respected fields
- (void)pickerView:(UIPickerView *)thePickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    [_pickerView selectRow:0 inComponent:0 animated:YES];
    
    if ([[dataSource objectAtIndex:row] isEqualToString:@"WeekDayNights"]) {
        timePickerArray = [[NSArray alloc]initWithObjects:@"6:00 PM",@"6:30 PM",@"7:00 PM",@"7:30 PM",@"8:00 PM",@"8:30 PM",@"9:00 PM",@"9:30 PM",@"10:00 PM",@"10:30 PM",@"11:00 PM",@"11:30 PM",@"12:00 AM",
                           @"12:30 AM",@"1:00 AM",@"1:30 AM",@"2:00 AM",@"2:30 AM",@"3:00 AM",@"3:30 AM",@"4:00 AM",@"4:30 AM",@"5:00 AM",@"5:30 AM", nil];
        
    }else if ([[dataSource objectAtIndex:row] isEqualToString:@"AllDays24X7"]){
        timePickerArray = [[NSArray alloc]initWithObjects:@"12:00 AM",
                           @"12:30 AM",@"1:00 AM",@"1:30 AM",@"2:00 AM",@"2:30 AM",@"3:00 AM",@"3:30 AM",@"4:00 AM",@"4:30 AM",@"5:00 AM",@"5:30 AM",@"6:00 AM",@"6:30 AM",@"7:00 AM",@"7:30 AM",@"8:00 AM",@"8:30 AM",@"9:00 AM",@"9:30  AM",@"10:00 AM",@"10:30 AM",@"11:00 AM",@"11:30 AM",@"12:00 PM",@"12:30 PM",@"1:00 PM",@"1:30 PM",@"2:00 PM",@"2:30 PM",@"3:00 PM",@"3:30 PM",@"4:00 PM",@"4:30 PM",@"5:00 PM",@"5:30 PM",@"6:00 PM",@"6:30 PM",@"7:00 PM",@"7:30 PM",@"8:00 PM",@"8:30 PM",@"9:00 PM",@"9:30 PM",@"10:00 PM",@"10:30 PM",@"11:00 PM",@"11:30 PM", nil];
        
    }else if ([[dataSource objectAtIndex:row] isEqualToString:@"WeekEnds"]||[[dataSource objectAtIndex:row] isEqualToString:@"WeekDays"]){
        timePickerArray = [[NSArray alloc]initWithObjects:@"6:00 AM",@"6:30 AM",@"7:00 AM",@"7:30 AM",@"8:00 AM",@"8:30 AM",@"9:00 AM",@"9:30  AM",@"10:00 AM",@"10:30 AM",@"11:00 AM",@"11:30 AM",@"12:00 PM",@"12:30 PM",@"1:00 PM",@"1:30 PM",@"2:00 PM",@"2:30 PM",@"3:00 PM",@"3:30 PM",@"4:00 PM",@"4:30 PM",@"5:00 PM",@"5:30 PM",@"6:00 PM", nil];
    }
    
    if([clickedPicker isEqual:@"available"]){
        [_availableTxt setText:[dataSource objectAtIndex:row]];
        availableID=[availablepickerIDArray objectAtIndex:row];
    }else if([clickedPicker isEqual:@"timeFromFirst"]){
        [_timeFromFirstText setText:[dataSource objectAtIndex:row]];
    }else if([clickedPicker isEqual:@"timeToFirst"]){
        [_timeToFirstTxt setText:[dataSource objectAtIndex:row]];
    }else if([clickedPicker isEqual:@"timeFromSecond"]){
        [_timeFromSecondTxt setText:[dataSource objectAtIndex:row]];
    }else if([clickedPicker isEqual:@"timeToSecond"]){
        [_timeToSecondTxt setText:[dataSource objectAtIndex:row]];
    }else if([clickedPicker isEqual:@"timeFromThird"]){
        [_timeFromThirdTxt setText:[dataSource objectAtIndex:row]];
    }else if([clickedPicker isEqual:@"timeToThird"]){
        [_timeToThirdTxt setText:[dataSource objectAtIndex:row]];
    }
    _pickerBackView.hidden=YES;
}

//Added by: Nalina
//Added Date: 19/07/2016
//Discription: Remove validation design functionality

-(void)RemoveValidationSettings:(UITextField *)textField errorIcon:(UIButton *)errorBtn HintText:(NSString *)hintTextMessage viewField:(UIView *)view{
    [textField setValue:[UIColor  colorWithRed:(112/255.0) green:(112/255.0) blue:(112/255.0) alpha:1] forKeyPath:@"_placeholderLabel.textColor"];
    textField.placeholder=hintTextMessage;
    errorBtn.hidden=YES;
    [self setBorder:view];
}

//Added by: Nalina
//Added Date: 19/07/2016
//Discription: Remove validation of input fields

-(void)RemoveValidation:(UITextField *)theTextField{
    if([theTextField isEqual: _availableTxt]){
        [self RemoveValidationSettings:_availableTxt errorIcon:_availableError HintText:@"I am available on" viewField:_availableView];
    }else
        if([theTextField isEqual: _timeFromFirstText]){
            [self RemoveValidationSettings:_timeFromFirstText errorIcon:_timeFromFirstError HintText:@"Time From" viewField:_timeFromFirstView];
            
        }else  if([theTextField isEqual: _timeToFirstTxt]){
            [self RemoveValidationSettings:_timeToFirstTxt errorIcon:_timeToFirstError HintText:@"Time To" viewField:_timeToFirstView];
        }
    
}

//close the screen on click of back icon
- (IBAction)backbtn:(id)sender {
    //[availablepickerIDArray removeAllObjects];
    //[availablepickerArray removeAllObjects];
    //[self.navigationController popViewControllerAnimated:YES];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)isWeekendCheckBoxClick:(id)sender {
    
    if((Monthlybtn==YES)||(Weeklybtn==YES))
    {
        if (isWeekend==NO) {
            
            [_isWeekendCheckBox setImage:[UIImage imageNamed:@"check.png"] forState:UIControlStateNormal];
            isWeekend=YES;
        }
        else if(isWeekend==YES)
        {
            [_isWeekendCheckBox setImage:[UIImage imageNamed:@"uncheck.png"] forState:UIControlStateNormal];
            isWeekend=NO;
            [_isTimeSlotChangeCheckBox setImage:[UIImage imageNamed:@"uncheck.png"] forState:UIControlStateNormal];
            isTimeSlotChanged=NO;
            
        }
    }else{
        [_isWeekendCheckBox setImage:[UIImage imageNamed:@"uncheck.png"] forState:UIControlStateNormal];
        isWeekend=NO;
        [_isTimeSlotChangeCheckBox setImage:[UIImage imageNamed:@"uncheck.png"] forState:UIControlStateNormal];
        isTimeSlotChanged=NO;
    }
}

- (IBAction)isTimeSlotChangeCheckBoxClick:(id)sender {
    if(isWeekend==YES)
    {
        if (isTimeSlotChanged==NO) {
            
            [_isTimeSlotChangeCheckBox setImage:[UIImage imageNamed:@"check.png"] forState:UIControlStateNormal];
            isTimeSlotChanged=YES;
        }
        else if(isTimeSlotChanged==YES)
        {
            [_isTimeSlotChangeCheckBox setImage:[UIImage imageNamed:@"uncheck.png"] forState:UIControlStateNormal];
            isTimeSlotChanged=NO;
            
        }
    }else  {
        [_isTimeSlotChangeCheckBox setImage:[UIImage imageNamed:@"uncheck.png"] forState:UIControlStateNormal];
        isTimeSlotChanged=NO;
        
    }
}

//Available on picker click to pop the picker view
- (IBAction)availableClick:(id)sender {
    clickedPicker=@"available";
    dataSource=availablepickerArray;
    [self.pickerView reloadAllComponents];
    _pickerBackView.hidden=NO;
    [self RemoveValidationSettings:_availableTxt errorIcon:_availableError HintText:@"I am available on" viewField:_availableView];
    
}

//Available on picker error button click to close the picker view
- (IBAction)availableErrorClose:(id)sender {
    [self RemoveValidationSettings:_availableTxt errorIcon:_availableError HintText:@"I am available on" viewField:_availableView];
}

//session one from time picker click to pop the picker view
- (IBAction)timeFromFirstPickerClick:(id)sender {
    clickedPicker=@"timeFromFirst";
    dataSource=timePickerArray;
    [self.pickerView reloadAllComponents];
    _pickerBackView.hidden=NO;
    [self RemoveValidationSettings:_timeFromFirstText errorIcon:_timeFromFirstError HintText:@"Time From" viewField:_timeFromFirstView];
}

//session one from time picker error click to pop the picker view
- (IBAction)timeFromFirstErrorClose:(id)sender {
    [self RemoveValidationSettings:_timeFromFirstText errorIcon:_timeFromFirstError HintText:@"Time From" viewField:_timeFromFirstView];
}

//session one to time picker click to pop the picker view
- (IBAction)timeTofirstPickerClick:(id)sender {
    clickedPicker=@"timeToFirst";
    dataSource=timePickerArray;
    [self.pickerView reloadAllComponents];
    _pickerBackView.hidden=NO;
    [self RemoveValidationSettings:_timeToFirstTxt errorIcon:_timeToFirstError HintText:@"Time To" viewField:_timeToFirstView];
}

//session one to time picker error click to pop the picker view
- (IBAction)timeToFirstErrorClose:(id)sender {
    [self RemoveValidationSettings:_timeToFirstTxt errorIcon:_timeToFirstError HintText:@"Time To" viewField:_timeToFirstView];
}

//session two from time picker click to pop the picker view
- (IBAction)timeFromSecondPickerClick:(id)sender {
    clickedPicker=@"timeFromSecond";
    dataSource=timePickerArray;
    [self.pickerView reloadAllComponents];
    _pickerBackView.hidden=NO;
}

//session two to time picker click to pop the picker view
- (IBAction)timeToSecondPickerClick:(id)sender {
    clickedPicker=@"timeToSecond";
    dataSource=timePickerArray;
    [self.pickerView reloadAllComponents];
    _pickerBackView.hidden=NO;
}

//session three from time picker click to pop the picker view
- (IBAction)timeFromThirdPickerClick:(id)sender {
    clickedPicker=@"timeFromThird";
    dataSource=timePickerArray;
    [self.pickerView reloadAllComponents];
    _pickerBackView.hidden=NO;
}

//session three to time picker click to pop the picker view
- (IBAction)timeToThirdPickerClick:(id)sender {
    clickedPicker=@"timeToThird";
    dataSource=timePickerArray;
    [self.pickerView reloadAllComponents];
    _pickerBackView.hidden=NO;
}

//Close the screen on click of cancel button
- (IBAction)cancelClick:(id)sender {
    if ([_pagename isEqualToString:@"firsttime"]) {
        AppDelegate *appdelegate=(AppDelegate *)[[UIApplication sharedApplication]delegate];
        
        _alert = [UIAlertController
                  alertControllerWithTitle:@""
                  message:[[GlobalFunction sharedInstance].arrayOfAlerts objectAtIndex:52]
                  preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* yesButton = [UIAlertAction
                                    actionWithTitle:@"Yes"
                                    style:UIAlertActionStyleDefault
                                    handler:^(UIAlertAction * action) {
                                        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
                                        LoginViewController *vc=[storyboard instantiateViewControllerWithIdentifier:@"LoginScreen"];
                                        [self presentViewController:vc animated:YES completion:nil];
                                       // [self dismissViewControllerAnimated:YES completion:nil];
                                       /*[[[[[self presentingViewController]presentingViewController]presentingViewController]presentingViewController]dismissViewControllerAnimated:YES completion:nil];*/
                                        appdelegate.accessToken=nil;
                                        appdelegate.usersDetails=nil;
                                        appdelegate.availabilityArray=nil;
                                        appdelegate.availabilityId=nil;
                                        appdelegate.availableData=nil;
                                    appdelegate.screenStatus=@"";                                       /*LoginViewController *vc=[self.storyboard instantiateViewControllerWithIdentifier:@"LoginScreen"];
                                         vc.screenStatus=@"providerSignupSuccess";
                                         [self presentViewController:vc animated:YES completion:nil];
                                         [self dismissViewControllerAnimated:YES completion:nil];*/
                                    }];
        
        UIAlertAction* noButton = [UIAlertAction
                                   actionWithTitle:@"No"
                                   style:UIAlertActionStyleDefault
                                   handler:^(UIAlertAction * action) {
                                       //Handle your yes please button action here
                                   }];
        
        [_alert addAction:yesButton];
        [_alert addAction:noButton];
        [self presentViewController:_alert animated:YES completion:nil];
    }else{
        [availablepickerIDArray removeAllObjects];
        [availablepickerArray removeAllObjects];
        //[self.navigationController popViewControllerAnimated:YES];
        [self dismissViewControllerAnimated:YES completion:nil];
    }

    
}

//Added by: Nalina
//Added Date: 23/08/2016
//Discription: Convert time format to validate the time input fields

-(NSDate *)convertTimeFormat:(NSString *)time{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"hh:mm a"];
    NSDate *amPmDate = [formatter dateFromString:time];
    [formatter setDateFormat:@"HH:mm"];
    return amPmDate;
}


//Added by: Nalina
//Added Date: 23/08/2016
//Discription: On click of submit button validate the time input fields

- (IBAction)saveClick:(id)sender {
    //  GlobalFunction *globalValues=[[GlobalFunction alloc]init];
    NSLog(@"Clicked");
    
    if(Monthlybtn == YES)
    {
        LimitedMonthAvailablityViewController *vc=[self.storyboard instantiateViewControllerWithIdentifier:@"LimitedMonthAvailablity"];
        vc.isWeekend=isWeekend;
        vc.isTimeSlotChange=isTimeSlotChanged;
        
        [self presentViewController:vc animated:YES completion:nil];
    }
    
    if(Weeklybtn == YES)
    {
        LimitedWeekAvailabilityViewController *vc=[self.storyboard instantiateViewControllerWithIdentifier:@"LimitedWeekAvailability"];
        vc.isWeekend=isWeekend;
        vc.isTimeSlotChange=isTimeSlotChanged;
        [self presentViewController:vc animated:YES completion:nil];
    }
    
    if(Dailybtn == YES)
    {
        LimitedDaysAvailability *vc=[self.storyboard instantiateViewControllerWithIdentifier:@"LimitedDaysAvailability"];
        vc.isWeekend=isWeekend;
        vc.isTimeSlotChange=isTimeSlotChanged;
        [self presentViewController:vc animated:YES completion:nil];
    }
    
    if(Unavailblebtn == YES)
    {
        ProviderUnavailabiltyViewController *vc=[self.storyboard instantiateViewControllerWithIdentifier:@"providerUnavailablity"];
        [self presentViewController:vc animated:YES completion:nil];
    }
    
    
    /*
     if([_availableTxt.text isEqualToString:@""]){
     [self SetValidationSettinds:_availableTxt errorIcon:_availableError validationMessage:[[GlobalFunction sharedInstance].arrayOfAlerts objectAtIndex:40] viewField:_availableView];
     return;
     }
     
     if([_timeFromFirstText.text isEqualToString:@""]){
     [self SetValidationSettinds:_timeFromFirstText errorIcon:_timeFromFirstError validationMessage:[[GlobalFunction sharedInstance].arrayOfAlerts objectAtIndex:41] viewField:_timeFromFirstView];
     return;
     }
     
     if([_timeToFirstTxt.text isEqualToString:@""]){
     [self SetValidationSettinds:_timeToFirstTxt errorIcon:_timeToFirstError validationMessage:[[GlobalFunction sharedInstance].arrayOfAlerts objectAtIndex:42] viewField:_timeToFirstView];
     return;
     }
     
     
     if ([[self convertTimeFormat:_timeFromFirstText.text] compare:[self convertTimeFormat:_timeToFirstTxt.text]] == NSOrderedDescending || [[self convertTimeFormat:_timeFromFirstText.text] compare:[self convertTimeFormat:_timeToFirstTxt.text]] == NSOrderedSame) {
     _timeFromFirstText.text=@"";
     [self ShowAlert:[[GlobalFunction sharedInstance].arrayOfAlerts objectAtIndex:90]];
     return;
     }
     
     if (![_timeFromSecondTxt.text isEqualToString:@""]) {
     
     if ([[self convertTimeFormat:_timeToFirstTxt.text] compare:[self convertTimeFormat:_timeFromSecondTxt.text]] == NSOrderedDescending || [[self convertTimeFormat:_timeToFirstTxt.text] compare:[self convertTimeFormat:_timeFromSecondTxt.text]] == NSOrderedSame) {
     _timeFromSecondTxt.text=@"";
     [self ShowAlert:[[GlobalFunction sharedInstance].arrayOfAlerts objectAtIndex:91]];
     return;
     }
     
     if ([[self convertTimeFormat:_timeFromSecondTxt.text] compare:[self convertTimeFormat:_timeToSecondTxt.text]] == NSOrderedDescending || [[self convertTimeFormat:_timeFromSecondTxt.text] compare:[self convertTimeFormat:_timeToSecondTxt.text]] == NSOrderedSame) {
     _timeToSecondTxt.text=@"";
     [self ShowAlert:[[GlobalFunction sharedInstance].arrayOfAlerts objectAtIndex:92]];
     return;
     }
     
     }
     
     if (![_timeFromThirdTxt.text isEqualToString:@""]) {
     
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
     }
     
     [timeDict setObject:[self Convert12FormatTo24Format:_timeFromFirstText.text] forKeyedSubscript:@"firstTimeFrom"];
     [timeDict setObject:[self Convert12FormatTo24Format:_timeToFirstTxt.text] forKeyedSubscript:@"firstTimeto"];
     [timeDict setObject:[self Convert12FormatTo24Format:_timeFromSecondTxt.text] forKeyedSubscript:@"secTimefrom"];
     [timeDict setObject:[self Convert12FormatTo24Format:_timeToSecondTxt.text] forKeyedSubscript:@"secTimeto"];
     [timeDict setObject:[self Convert12FormatTo24Format:_timeFromThirdTxt.text] forKeyedSubscript:@"thirdTimefrom"];
     [timeDict setObject:[self Convert12FormatTo24Format:_timeToThirdTxt.text] forKeyedSubscript:@"thirdTimeto"];
     
     [self startLoadingIndicator];
     [self ServiceCall:timeDict];
     */
}

- (IBAction)WeeklyBtnClick:(id)sender {
    [self resetAllButtonColors];
    Weeklybtn = [self setButtonColorOnSelected:2 boolValue:Weeklybtn addDictValue:Weeklyval];
}

- (IBAction)monthlyBtnClick:(id)sender {
    [self resetAllButtonColors];
    Monthlybtn = [self setButtonColorOnSelected:1 boolValue:Monthlybtn addDictValue:Monthlybval];
}

- (IBAction)DailyBtnClick:(id)sender {
    isWeekend=NO;
    isTimeSlotChanged=NO;
    [_isWeekendCheckBox setImage:[UIImage imageNamed:@"uncheck.png"] forState:UIControlStateNormal];
    [_isTimeSlotChangeCheckBox setImage:[UIImage imageNamed:@"uncheck.png"] forState:UIControlStateNormal];
    

    [self resetAllButtonColors];
    Dailybtn = [self setButtonColorOnSelected:3 boolValue:Dailybtn addDictValue:Weeklyval];
}

- (IBAction)unavailableBtnClick:(id)sender {
    isWeekend=NO;
    isTimeSlotChanged=NO;
    [_isWeekendCheckBox setImage:[UIImage imageNamed:@"uncheck.png"] forState:UIControlStateNormal];
    [_isTimeSlotChangeCheckBox setImage:[UIImage imageNamed:@"uncheck.png"] forState:UIControlStateNormal];
    
    [self resetAllButtonColors];
    Unavailblebtn = [self setButtonColorOnSelected:4 boolValue:Unavailblebtn addDictValue:Unavailbleal];
}


//Added by: Nalina
//Added Date: 23/08/2016
//Discription: call the web services to update the data

-(void)ServiceCall:(NSDictionary *)timedict{
    AppDelegate *appdelegate= (AppDelegate *)[[UIApplication sharedApplication]delegate];
    NSString *availablityUrl=[appdelegate.serviceURL stringByAppendingString:@"api/Provider/ProviderAvailability"];
    
    NSMutableDictionary *availDict = [[NSMutableDictionary alloc] init];
    /* [availDict setObject:availableID forKey:@"availabilityID"];
     [availDict setObject:[timedict objectForKey:@"firstTimeFrom"] forKey:@"fsStartTime"];
     [availDict setObject:[timedict objectForKey:@"firstTimeto"] forKey:@"fsEndTime"];
     [availDict setObject:[timedict objectForKey:@"secTimefrom"] forKey:@"ssStartTime"];
     [availDict setObject:[timedict objectForKey:@"secTimeto"] forKey:@"ssEndTime"];
     [availDict setObject:[timedict objectForKey:@"thirdTimefrom"] forKey:@"tsStartTime"];
     [availDict setObject:[timedict objectForKey:@"thirdTimeto"] forKey:@"tsEndTime"]; */
    
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
    
    [availDict setObject:availableID forKey:@"providerID"];
    [availDict setObject:availableData forKey:@"availiblityDate"];
    
    
    
    [[GlobalFunction sharedInstance] getServerResponseAfterLogin:availablityUrl method:@"POST" param:availDict withCallback:^(NSInteger statusCode, NSDictionary *response, NSError *error)
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
                                            [self.navigationController popViewControllerAnimated:YES];
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

//Added by: Nalina
//Added Date: 19/07/2016
//Discription: Set validation design to the input fields

-(void)SetValidationSettinds:(UITextField *)textField errorIcon:(UIButton *)errorBtn validationMessage:(NSString *)validationMessage viewField:(UIView *)viewIs{
    
    [textField setValue:[UIColor redColor] forKeyPath:@"_placeholderLabel.textColor"];
    textField.placeholder=validationMessage;
    errorBtn.hidden=NO;
    viewIs.layer.borderColor = [[UIColor redColor]CGColor];
    viewIs.layer.borderWidth = 1.0f;
    
}

//Added by: zeenath
//Added Date: 25/08/2016
//Discription: validate for the data and redirect to the limited days screen

- (IBAction)limitedDaysClick:(id)sender {
    if(availableData == nil || [[availableData objectForKey:@"availiblityDate"] isEqual:[NSNull null]]){
        // GlobalFunction *globalValues=[[GlobalFunction alloc]init];
        
        [self ShowAlert:[[GlobalFunction sharedInstance].arrayOfAlerts objectAtIndex:120]];
    }else{
        LimitedDaysAvailability *vc=[self.storyboard instantiateViewControllerWithIdentifier:@"LimitedDaysAvailability"];
        vc.screenStatus=@"LimitedDays";
        [self.navigationController pushViewController:vc animated:YES];
    }
}

//Added by: zeenath
//Added Date: 25/08/2016
//Discription: validate for the data and redirect to the limited hours screen

- (IBAction)limitedHoursClick:(id)sender {
    if(availableData == nil || [[availableData objectForKey:@"availiblityDate"] isEqual:[NSNull null]])
    {
        //GlobalFunction *globalValues=[[GlobalFunction alloc]init];
        
        [self ShowAlert:[[GlobalFunction sharedInstance].arrayOfAlerts objectAtIndex:120]];
    }else{
        LimitedDaysAvailability *vc=[self.storyboard instantiateViewControllerWithIdentifier:@"LimitedDaysAvailability"];
        vc.screenStatus=@"LimitedHours";
        [self.navigationController pushViewController:vc animated:YES];
    }
}

//Added by: zeenath
//Added Date: 25/08/2016
//Discription: alert pop up

-(void)ShowAlert:(NSString *)message{
    _alert = [UIAlertController
              alertControllerWithTitle:@""
              message:message
              preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* okButton = [UIAlertAction
                               actionWithTitle:@"OK"
                               style:UIAlertActionStyleDefault
                               handler:^(UIAlertAction * action) {
                                   [self stopLoadingIndicator];
                               }];
    [_alert addAction:okButton];
    [self presentViewController:_alert animated:YES completion: nil];
}

//  Added by:Zeenath
//  Added Date:25/08/2016
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

-(bool) setButtonColorOnSelected:(int)tagName boolValue:(bool)boolValue addDictValue:(int)addDictValue {
    
    
    UIButton *expertiseBtn = (UIButton *) [self.view viewWithTag:tagName];
    
    if(boolValue==YES){
        expertiseBtn.layer.backgroundColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0  alpha:1].CGColor;
        
        [expertiseBtn setTitleColor:[UIColor colorWithRed:118.0/255.0 green:183.0/255.0 blue:189.0/255.0  alpha:1] forState:UIControlStateNormal];
        return NO;
    }else{
        expertiseBtn.layer.backgroundColor = [UIColor colorWithRed:118.0/255.0 green:183.0/255.0 blue:189.0/255.0 alpha:1].CGColor;
        [expertiseBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        return YES;
        
    }
}

-(void) resetAllButtonColors {
    
    Monthlybtn = NO;
    Weeklybtn = NO;
    Dailybtn =  NO;
    Unavailblebtn = NO;
    
    UIButton *expertiseBtn = (UIButton *) [self.view viewWithTag:1];
    expertiseBtn.layer.backgroundColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0  alpha:1].CGColor;
    [expertiseBtn setTitleColor:[UIColor colorWithRed:118.0/255.0 green:183.0/255.0 blue:189.0/255.0  alpha:1] forState:UIControlStateNormal];
    
    expertiseBtn = (UIButton *) [self.view viewWithTag:2];
    expertiseBtn.layer.backgroundColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0  alpha:1].CGColor;
    [expertiseBtn setTitleColor:[UIColor colorWithRed:118.0/255.0 green:183.0/255.0 blue:189.0/255.0  alpha:1] forState:UIControlStateNormal];
    
    expertiseBtn = (UIButton *) [self.view viewWithTag:3];
    expertiseBtn.layer.backgroundColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0  alpha:1].CGColor;
    [expertiseBtn setTitleColor:[UIColor colorWithRed:118.0/255.0 green:183.0/255.0 blue:189.0/255.0  alpha:1] forState:UIControlStateNormal];
    
    expertiseBtn = (UIButton *) [self.view viewWithTag:4];
    expertiseBtn.layer.backgroundColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0  alpha:1].CGColor;
    [expertiseBtn setTitleColor:[UIColor colorWithRed:118.0/255.0 green:183.0/255.0 blue:189.0/255.0  alpha:1] forState:UIControlStateNormal];
    
}

//  Added by:Zeenath
//  Added Date:25/08/2016
//  Description:To stop the activity indicator.

-(void)stopLoadingIndicator
{
    
    _loadingView.hidden=YES;
}

@end
