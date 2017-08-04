//
//  LimitedMonthAvailablityViewController.m
//  EmotiLink
//
//  Created by Starsoft on 2017-03-23.
//  Copyright © 2017 Stark. All rights reserved.
//

#import "LimitedMonthAvailablityViewController.h"
#import "GlobalFunction.h"
#import "AppDelegate.h"
#import <Google/Analytics.h>
#import "weekendTimeSlotViewController.h"

@interface LimitedMonthAvailablityViewController ()

@end

@implementation LimitedMonthAvailablityViewController
@synthesize availableData, isWeekend, isTimeSlotChange;

- (void)viewDidLoad {
    
    _cancelBtbVw.frame = CGRectMake(30, 270, 120, 50);
    _saveBtnVw.frame = CGRectMake(170, 270, 120, 50);
    _dumyTxtVw.hidden = YES;
    
    UIButton *cancelBtn = (UIButton *) [self.view viewWithTag:20];
    
    cancelBtn.layer.borderColor = [UIColor colorWithRed:246.0/255.0 green:108.0/255.0 blue:118.0/255.0 alpha:1].CGColor;
    
    UIButton *addsessionBtn = (UIButton *) [self.view viewWithTag:13];
    
    addsessionBtn.layer.borderColor = [UIColor colorWithRed:246.0/255.0 green:108.0/255.0 blue:118.0/255.0 alpha:1].CGColor;
    
    
    
    //Added by Manohar
    //Added on 05/04/2017
    //Description: To add border radius
    
    [self setBorderColor:1];
    [self setBorderColor:2];
    [self setBorderColor:3];
    [self setBorderColor:4];
    [self setBorderColor:5];
    [self setBorderColor:6];
    [self setBorderColor:7];
    [self setBorderColor:8];
    [self setBorderColor:9];
    [self setBorderColor:10];
    [self setBorderColor:11];
    [self setBorderColor:12];
   // [self setBorderColor:13];
    [self setBorderColor:14];
    [self setBorderColor:15];
    
    myBooljanValue=NO;
    myBoolfebValue=NO;
    myBoolmarValue=NO;
    myBoolaprValue=NO;
    myBoolmayValue=NO;
    myBooljunValue=NO;
    myBooljulValue=NO;
    myBoolaugValue=NO;
    myBoolsepValue=NO;
    myBooloctValue=NO;
    myBoolnovValue=NO;
    myBooldecValue=NO;
    
    timeDict=[[NSMutableDictionary alloc]init];
    
    _addSessionView.hidden=YES;
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy"];
    yearString = [formatter stringFromDate:[NSDate date]];
    
    UIImage *backgroundImage = [UIImage imageNamed:@"06. Appointment Confirmation.png"];
    UIImageView *backgroundImageView=[[UIImageView alloc]initWithFrame:self.view.frame];
    backgroundImageView.image=backgroundImage;
    [self.view insertSubview:backgroundImageView atIndex:0];
    
    monthly= [[NSMutableArray alloc] init];
    
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UITapGestureRecognizer *singleFingerTap =
    [[UITapGestureRecognizer alloc] initWithTarget:self
                                            action:@selector(handleSingleTapped:)];
    [self.pickerBackView addGestureRecognizer:singleFingerTap];
    
    //First Fromtime
    [self.fromTimeTxt addTarget:self action:@selector(firstfromTimeClick:) forControlEvents:UIControlEventEditingDidBegin];

    //First Totime
     [self.toTimeTxt addTarget:self action:@selector(firstToTimeClick:) forControlEvents:UIControlEventEditingDidBegin];
    //Second Fromtime
     [self.secondFromTime addTarget:self action:@selector(secondFromTimeClick:) forControlEvents:UIControlEventEditingDidBegin];
    
    //Second Totime
    [self.secondToTime addTarget:self action:@selector(secondToTimeClick:) forControlEvents:UIControlEventEditingDidBegin];
    
    
    //Discription: Prepopulate the data to the input fields by taking GET service call response
    
    if ([[availableData objectForKey:@"fsStartTime"] isEqual:[NSNull null]]) {
        _fromTimeTxt.text= @"";
    }else{
        
        NSString *hourString=[self Convert24FormatTo12Format:[availableData objectForKey:@"fsStartTime"]];
        _fromTimeTxt.text= hourString;
    }
    
    if ([[availableData objectForKey:@"fsEndTime"] isEqual:[NSNull null]]) {
        _toTimeTxt.text=@"";
    }else{
        NSString *hourString=[self Convert24FormatTo12Format:[availableData objectForKey:@"fsEndTime"]];
        _toTimeTxt.text= hourString;
    }
    
    if ([[availableData objectForKey:@"ssStartTime"] isEqual:[NSNull null]]) {
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
    }
    
    /*if ([[availableData objectForKey:@"tsEndTime"] isEqual:[NSNull null]]) {
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
     //_availableTxt.text=[availablepickerArray objectAtIndex:i];
     //availableID=[availablepickerIDArray objectAtIndex:i];
     }
     }
     }*/
}


//Appears each time when page loads
-(void)viewWillAppear:(BOOL)animated{
    //[[self navigationController] setNavigationBarHidden:YES animated:YES];
    
    id<GAITracker> tracker = [[GAI sharedInstance] defaultTracker];
    [tracker set:kGAIScreenName value:@"MonthlyAvailability"];
    [tracker send:[[GAIDictionaryBuilder createScreenView] build]];
}

-(void)firstfromTimeClick:(UITapGestureRecognizer *)recognizer {
    [self resignSoftKeyboard];
    dataSource=[[NSArray alloc]initWithObjects:@"12:00 AM",
                @"12:30 AM",@"1:00 AM",@"1:30 AM",@"2:00 AM",@"2:30 AM",@"3:00 AM",@"3:30 AM",@"4:00 AM",@"4:30 AM",@"5:00 AM",@"5:30 AM",@"6:00 AM",@"6:30 AM",@"7:00 AM",@"7:30 AM",@"8:00 AM",@"8:30 AM",@"9:00 AM",@"9:30  AM",@"10:00 AM",@"10:30 AM",@"11:00 AM",@"11:30 AM",@"12:00 PM",@"12:30 PM",@"1:00 PM",@"1:30 PM",@"2:00 PM",@"2:30 PM",@"3:00 PM",@"3:30 PM",@"4:00 PM",@"4:30 PM",@"5:00 PM",@"5:30 PM",@"6:00 PM",@"6:30 PM",@"7:00 PM",@"7:30 PM",@"8:00 PM",@"8:30 PM",@"9:00 PM",@"9:30 PM",@"10:00 PM",@"10:30 PM",@"11:00 PM",@"11:30 PM", nil];
    [self.pickerView reloadAllComponents];
    _pickerBackView.hidden=NO;
    clickedbutton=@"Firstfromtime";
    [self setBorder:_pickerView];
    [_fromTimeTxt setValue:[UIColor  colorWithRed:(112/255.0) green:(112/255.0) blue:(112/255.0) alpha:1] forKeyPath:@"_placeholderLabel.textColor"];
    _fromTimeTxt.placeholder=@"";
    
}

-(void)firstToTimeClick:(UITapGestureRecognizer *)recognizer {
    [self resignSoftKeyboard];
    dataSource=[[NSArray alloc]initWithObjects:@"12:00 AM",
                @"12:30 AM",@"1:00 AM",@"1:30 AM",@"2:00 AM",@"2:30 AM",@"3:00 AM",@"3:30 AM",@"4:00 AM",@"4:30 AM",@"5:00 AM",@"5:30 AM",@"6:00 AM",@"6:30 AM",@"7:00 AM",@"7:30 AM",@"8:00 AM",@"8:30 AM",@"9:00 AM",@"9:30  AM",@"10:00 AM",@"10:30 AM",@"11:00 AM",@"11:30 AM",@"12:00 PM",@"12:30 PM",@"1:00 PM",@"1:30 PM",@"2:00 PM",@"2:30 PM",@"3:00 PM",@"3:30 PM",@"4:00 PM",@"4:30 PM",@"5:00 PM",@"5:30 PM",@"6:00 PM",@"6:30 PM",@"7:00 PM",@"7:30 PM",@"8:00 PM",@"8:30 PM",@"9:00 PM",@"9:30 PM",@"10:00 PM",@"10:30 PM",@"11:00 PM",@"11:30 PM", nil];
    [self.pickerView reloadAllComponents];
    _pickerBackView.hidden=NO;
    clickedbutton=@"FirstTotime";
    [_toTimeTxt setValue:[UIColor  colorWithRed:(112/255.0) green:(112/255.0) blue:(112/255.0) alpha:1] forKeyPath:@"_placeholderLabel.textColor"];
    _toTimeTxt.placeholder=@"";
}

-(void)secondFromTimeClick:(UITapGestureRecognizer *)recognizer {
    [self resignSoftKeyboard];
    dataSource=[[NSArray alloc]initWithObjects:@"12:00 AM",
                @"12:30 AM",@"1:00 AM",@"1:30 AM",@"2:00 AM",@"2:30 AM",@"3:00 AM",@"3:30 AM",@"4:00 AM",@"4:30 AM",@"5:00 AM",@"5:30 AM",@"6:00 AM",@"6:30 AM",@"7:00 AM",@"7:30 AM",@"8:00 AM",@"8:30 AM",@"9:00 AM",@"9:30  AM",@"10:00 AM",@"10:30 AM",@"11:00 AM",@"11:30 AM",@"12:00 PM",@"12:30 PM",@"1:00 PM",@"1:30 PM",@"2:00 PM",@"2:30 PM",@"3:00 PM",@"3:30 PM",@"4:00 PM",@"4:30 PM",@"5:00 PM",@"5:30 PM",@"6:00 PM",@"6:30 PM",@"7:00 PM",@"7:30 PM",@"8:00 PM",@"8:30 PM",@"9:00 PM",@"9:30 PM",@"10:00 PM",@"10:30 PM",@"11:00 PM",@"11:30 PM", nil];
    [self.pickerView reloadAllComponents];
    _pickerBackView.hidden=NO;
    clickedbutton=@"Secondfromtime";
    [_secondFromTime setValue:[UIColor  colorWithRed:(112/255.0) green:(112/255.0) blue:(112/255.0) alpha:1] forKeyPath:@"_placeholderLabel.textColor"];
    _secondFromTime.placeholder=@"";
}

-(void)secondToTimeClick:(UITapGestureRecognizer *)recognizer {
    [self resignSoftKeyboard];
    dataSource=[[NSArray alloc]initWithObjects:@"12:00 AM",
                @"12:30 AM",@"1:00 AM",@"1:30 AM",@"2:00 AM",@"2:30 AM",@"3:00 AM",@"3:30 AM",@"4:00 AM",@"4:30 AM",@"5:00 AM",@"5:30 AM",@"6:00 AM",@"6:30 AM",@"7:00 AM",@"7:30 AM",@"8:00 AM",@"8:30 AM",@"9:00 AM",@"9:30  AM",@"10:00 AM",@"10:30 AM",@"11:00 AM",@"11:30 AM",@"12:00 PM",@"12:30 PM",@"1:00 PM",@"1:30 PM",@"2:00 PM",@"2:30 PM",@"3:00 PM",@"3:30 PM",@"4:00 PM",@"4:30 PM",@"5:00 PM",@"5:30 PM",@"6:00 PM",@"6:30 PM",@"7:00 PM",@"7:30 PM",@"8:00 PM",@"8:30 PM",@"9:00 PM",@"9:30 PM",@"10:00 PM",@"10:30 PM",@"11:00 PM",@"11:30 PM", nil];
    [self.pickerView reloadAllComponents];
    _pickerBackView.hidden=NO;
    clickedbutton=@"Secondtotime";
    [_secondToTime setValue:[UIColor  colorWithRed:(112/255.0) green:(112/255.0) blue:(112/255.0) alpha:1] forKeyPath:@"_placeholderLabel.textColor"];
    _secondToTime.placeholder=@"";
}


- (void)handleSingleTapped:(UITapGestureRecognizer *)recognizer {
    _pickerBackView.hidden=YES;
    //[self resignSoftKeyboard];
    [self.dumyTxtVw becomeFirstResponder];
}

//Return number of section in picker
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)thePickerView {
    return 1;
}

//Return the number of rows count to display in picker
- (NSInteger)pickerView:(UIPickerView *)thePickerView numberOfRowsInComponent:(NSInteger)component {
    return dataSource.count;
}

//Return the data to display in picker
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:
(NSInteger)row forComponent:(NSInteger)component{
    return [dataSource objectAtIndex:row];
}

//Returns selected picker data
- (void)pickerView:(UIPickerView *)thePickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    [_pickerView selectRow:0 inComponent:0 animated:YES];
    if([clickedbutton isEqualToString:@"Firstfromtime"])
    {
        [_fromTimeTxt setText:[dataSource objectAtIndex:row]];
         [self.dumyTxtVw becomeFirstResponder];
    }else if([clickedbutton isEqualToString:@"FirstTotime"]){
         [_toTimeTxt setText:[dataSource objectAtIndex:row]];
        [self.dumyTxtVw becomeFirstResponder];
    }else if([clickedbutton isEqualToString:@"Secondfromtime"]){
        [_secondFromTime setText:[dataSource objectAtIndex:row]];
        [self.dumyTxtVw becomeFirstResponder];
    }else if([clickedbutton isEqualToString:@"Secondtotime"]){
         [_secondToTime setText:[dataSource objectAtIndex:row]];
        [self.dumyTxtVw becomeFirstResponder];
    }
    _pickerBackView.hidden=YES;
    [self resignSoftKeyboard];
}





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)JanClick:(id)sender {
    
    myBooljanValue=[self setButtonColorOnSelected:1 boolValue:myBooljanValue fromDate:[@"01/01/" stringByAppendingString:yearString] toDate:[@"01/31/" stringByAppendingString:yearString]];
}

- (IBAction)FebClick:(id)sender {
    
    myBoolfebValue=[self setButtonColorOnSelected:2 boolValue:myBoolfebValue fromDate:[@"02/01/" stringByAppendingString:yearString] toDate:[@"02/28/" stringByAppendingString:yearString]];
}

- (IBAction)MarClick:(id)sender {
    
    myBoolmarValue=[self setButtonColorOnSelected:3 boolValue:myBoolmarValue  fromDate:[@"03/01/" stringByAppendingString:yearString] toDate:[@"03/31/" stringByAppendingString:yearString]];
}

- (IBAction)AprClick:(id)sender {
    myBoolaprValue=[self setButtonColorOnSelected:4 boolValue:myBoolaprValue fromDate:[@"04/01/" stringByAppendingString:yearString] toDate:[@"04/30/" stringByAppendingString:yearString]];
}

- (IBAction)MayClick:(id)sender {
    myBoolmayValue=[self setButtonColorOnSelected:5 boolValue:myBoolmayValue fromDate:[@"05/01" stringByAppendingString:yearString] toDate:[@"05/31/" stringByAppendingString:yearString]];
}

- (IBAction)JunClick:(id)sender {
    myBooljunValue=[self setButtonColorOnSelected:6 boolValue:myBooljunValue fromDate:[@"06/01/" stringByAppendingString:yearString] toDate:[@"06/30/" stringByAppendingString:yearString]];
}

- (IBAction)JulClick:(id)sender {
    myBooljulValue=[self setButtonColorOnSelected:7 boolValue:myBooljulValue fromDate:[@"07/01/" stringByAppendingString:yearString] toDate:[@"07/31/" stringByAppendingString:yearString]];
}

- (IBAction)AugClick:(id)sender {
    myBoolaugValue=[self setButtonColorOnSelected:8 boolValue:myBoolaugValue fromDate:[@"08/01/" stringByAppendingString:yearString] toDate:[@"08/31/" stringByAppendingString:yearString]];
}

- (IBAction)SepClick:(id)sender {
    myBoolsepValue=[self setButtonColorOnSelected:9 boolValue:myBoolsepValue fromDate:[@"09/01/" stringByAppendingString:yearString] toDate:[@"09/30/" stringByAppendingString:yearString]];
}

- (IBAction)OctClick:(id)sender {
    myBooloctValue=[self setButtonColorOnSelected:10 boolValue:myBooloctValue fromDate:[@"10/01/" stringByAppendingString:yearString] toDate:[@"10/31/" stringByAppendingString:yearString]];
}

- (IBAction)NovClick:(id)sender {
    myBoolnovValue=[self setButtonColorOnSelected:11 boolValue:myBoolnovValue fromDate:[@"11/01/" stringByAppendingString:yearString] toDate:[@"11/30/" stringByAppendingString:yearString]];
}

- (IBAction)DecClick:(id)sender {
    myBooldecValue=[self setButtonColorOnSelected:12 boolValue:myBooldecValue fromDate:[@"12/01/" stringByAppendingString:yearString] toDate:[@"12/31/" stringByAppendingString:yearString]];
}

- (IBAction)addSession:(id)sender {
    if(_addSessionView.hidden==NO){
        _addSessionView.hidden=YES;
        _cancelBtbVw.frame = CGRectMake(30, 270, 120, 50);
        _saveBtnVw.frame = CGRectMake(170, 270, 120, 50);
    }else{
        _addSessionView.hidden=NO;
        _cancelBtbVw.frame = CGRectMake(30, 385, 120, 50);
        _saveBtnVw.frame = CGRectMake(170, 385, 120, 50);
    }
}

- (IBAction)cancelButton:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)saveButton:(id)sender {
    
    if([_fromTimeTxt.text isEqualToString:@""]){
        [self SetValidationSettinds:_fromTimeTxt errorIcon:nil validationMessage:[[GlobalFunction sharedInstance].arrayOfAlerts objectAtIndex:40] viewField:nil];
        return;
    }
    
    if([_toTimeTxt.text isEqualToString:@""]){
        [self SetValidationSettinds:_toTimeTxt errorIcon:nil validationMessage:[[GlobalFunction sharedInstance].arrayOfAlerts objectAtIndex:42] viewField:nil];
        return;
    }
    
    
    if ([[self convertTimeFormat:_fromTimeTxt.text] compare:[self convertTimeFormat:_toTimeTxt.text]] == NSOrderedDescending || [[self convertTimeFormat:_fromTimeTxt.text] compare:[self convertTimeFormat:_toTimeTxt.text]] == NSOrderedSame) {
        _fromTimeTxt.text=@"";
        [self ShowAlert:[[GlobalFunction sharedInstance].arrayOfAlerts objectAtIndex:90]];
        return;
    }
    
    if(_addSessionView.hidden==NO){
        if (![_secondFromTime.text isEqualToString:@""]) {
            
            if ([[self convertTimeFormat:_fromTimeTxt.text] compare:[self convertTimeFormat:_secondFromTime.text]] == NSOrderedDescending || [[self convertTimeFormat:_fromTimeTxt.text] compare:[self convertTimeFormat:_secondFromTime.text]] == NSOrderedSame) {
                _secondFromTime.text=@"";
                [self ShowAlert:[[GlobalFunction sharedInstance].arrayOfAlerts objectAtIndex:91]];
                return;
            }
            
            if ([[self convertTimeFormat:_secondFromTime.text] compare:[self convertTimeFormat:_secondToTime.text]] == NSOrderedDescending || [[self convertTimeFormat:_secondFromTime.text] compare:[self convertTimeFormat:_secondToTime.text]] == NSOrderedSame) {
                _secondToTime.text=@"";
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
    
    [timeDict setObject:[self Convert12FormatTo24Format:_fromTimeTxt.text] forKeyedSubscript:@"firstTimeFrom"];
    [timeDict setObject:[self Convert12FormatTo24Format:_toTimeTxt.text] forKeyedSubscript:@"firstTimeto"];
    [timeDict setObject:[self Convert12FormatTo24Format:_secondFromTime.text] forKeyedSubscript:@"secTimefrom"];
    [timeDict setObject:[self Convert12FormatTo24Format:_secondToTime.text] forKeyedSubscript:@"secTimeto"];
    /*[timeDict setObject:[self Convert12FormatTo24Format:_timeFromThirdTxt.text] forKeyedSubscript:@"thirdTimefrom"];
     [timeDict setObject:[self Convert12FormatTo24Format:_timeToThirdTxt.text] forKeyedSubscript:@"thirdTimeto"];*/
    
    [self startLoadingIndicator];
    [self ServiceCall:timeDict];
    
}

//Discription: call the web services to update the data

-(void)ServiceCall:(NSDictionary *)timedict{
    AppDelegate *appdelegate= (AppDelegate *)[[UIApplication sharedApplication]delegate];
    NSString *availablityUrl=[appdelegate.serviceURL stringByAppendingString:@"api/Provider/ProviderAvailability"];
    
    //BELOW CODE TO CREATE
    NSMutableArray *availMainArray=[[NSMutableArray alloc]init];
    //MAIN DICTIONARY
    NSMutableDictionary *availCompleteDict = [[NSMutableDictionary alloc] init];
    NSMutableDictionary *availDict = [[NSMutableDictionary alloc] init];
    
    NSMutableArray *array=[[NSMutableArray alloc]init];
    NSMutableDictionary *availTimingDict = [[NSMutableDictionary alloc] init];
    
    for (NSDictionary *item in monthly) {
        
        availCompleteDict = [[NSMutableDictionary alloc] init];
        availDict = [[NSMutableDictionary alloc] init];
        
        [availDict setObject:[NSNumber numberWithInt:5] forKey:@"availabilityID"];
        [availDict setObject:[item objectForKey:@"StartDate"] forKey:@"providerAvailableStartDate"];
        [availDict setObject:[item objectForKey:@"EndDate"]  forKey:@"providerAvailableEndDate"];
        [availDict setObject:[NSNumber numberWithBool:isWeekend] forKey:@"isWorkingWeekend"];
        [availDict setObject:[NSNumber numberWithBool:isTimeSlotChange] forKey:@"isPreferDifferentTimeSlot"];
        
        [availCompleteDict setObject:availDict forKey:@"providerAvailability"];
        
        array=[[NSMutableArray alloc]init];
        availTimingDict = [[NSMutableDictionary alloc] init];
        
        [availTimingDict setObject:[self Convert12FormatTo24Format:_fromTimeTxt.text] forKey:@"startTime"];
        [availTimingDict setObject:[self Convert12FormatTo24Format:_toTimeTxt.text] forKey:@"endTime"];
        [availTimingDict setObject:[NSNumber numberWithInt:1] forKey:@"sessionTypeConfigId"];
        [array addObject: availTimingDict];
        
        if(_addSessionView.hidden==NO){
            
            availTimingDict = [[NSMutableDictionary alloc] init];
            [availTimingDict setObject:[self Convert12FormatTo24Format:_secondFromTime.text] forKey:@"startTime"];
            [availTimingDict setObject:[self Convert12FormatTo24Format:_secondToTime.text] forKey:@"endTime"];
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
                                            
                                            if(isTimeSlotChange){
                                                weekendTimeSlotViewController *vc=[self.storyboard instantiateViewControllerWithIdentifier:@"weekendTimeSlot"];
                                                
                                                vc.isWeekend=isWeekend;
                                                vc.isTimeSlotChange=isTimeSlotChange;
                                                // vc.emailLabelText = [response objectForKey:@"email"];
                                                [self presentViewController:vc animated:YES completion:nil];
                                            }else{
                                                //[self.navigationController popViewControllerAnimated:YES];
                                                [self dismissViewControllerAnimated:YES completion:nil];
                                            }
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
             
             
         }else if(statusCode==400){
             
             _alert = [UIAlertController
                       alertControllerWithTitle:@""
                       message:[response objectForKey:@ "message"]
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

//Discription: Set validation design to the input fields

-(void)SetValidationSettinds:(UITextField *)textField errorIcon:(UIButton *)errorBtn validationMessage:(NSString *)validationMessage viewField:(UIView *)viewIs{
    
    [textField setValue:[UIColor redColor] forKeyPath:@"_placeholderLabel.textColor"];
    textField.placeholder=validationMessage;
    //errorBtn.hidden=NO;
    //viewIs.layer.borderColor = [[UIColor redColor]CGColor];
    //viewIs.layer.borderWidth = 1.0f;
    
}

- (IBAction)backArrowClick:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void) setBorderColor:(int)tagName{
    UIButton *cancelBtn = (UIButton *) [self.view viewWithTag:tagName];
    cancelBtn.layer.borderColor = [UIColor colorWithRed:118.0/255.0 green:183.0/255.0 blue:189.0/255.0 alpha:1].CGColor;
}

-(bool) setButtonColorOnSelected:(int)tagName boolValue:(bool)boolValue fromDate:(NSString*)fromDate toDate:(NSString*)toDate {
    
    
    UIButton *expertiseBtn = (UIButton *) [self.view viewWithTag:tagName];
    NSMutableDictionary *monthSelValue=[[NSMutableDictionary alloc] init];
    
    if(boolValue==NO){
        expertiseBtn.layer.backgroundColor = [UIColor colorWithRed:118.0/255.0 green:183.0/255.0 blue:189.0/255.0 alpha:1].CGColor;
        [expertiseBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
        UIImage *image = [UIImage imageNamed: @"rightMark.png"];
        //cancelBtn.image=image;
        [expertiseBtn setImage:image forState:UIControlStateNormal];
        
        [monthSelValue setObject:fromDate forKey:@"StartDate"];
        [monthSelValue setObject:toDate forKey:@"EndDate"];
        [monthly addObject: monthSelValue];
        
        return YES;
    }else{
        expertiseBtn.layer.backgroundColor = [UIColor whiteColor].CGColor;
        [expertiseBtn setTitleColor:[UIColor colorWithRed:118.0/255.0 green:183.0/255.0 blue:189.0/255.0 alpha:1] forState:UIControlStateNormal];
        
        UIImage *image = [UIImage imageNamed: @"plusIcon.png"];
        
        [expertiseBtn setImage:image forState:UIControlStateNormal];
        
        [monthSelValue setObject:fromDate forKey:@"StartDate"];
        [monthSelValue setObject:toDate forKey:@"EndDate"];
        [monthly removeObject: monthSelValue];
        
        // [monthly removeObject: [NSNumber numberWithInt: addDictValue]];
        
        return NO;
        
    }
}

//Discription: Convert time format to validate the time input fields

-(NSDate *)convertTimeFormat:(NSString *)time{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"hh:mm a"];
    NSDate *amPmDate = [formatter dateFromString:time];
    [formatter setDateFormat:@"HH:mm"];
    return amPmDate;
}


-(void)resignSoftKeyboard{
    [_fromTimeTxt resignFirstResponder];
    [_toTimeTxt resignFirstResponder];
    [_secondFromTime resignFirstResponder];
    [_secondToTime resignFirstResponder];
    [_dumyTxtVw resignFirstResponder];
}

-(void)setBorder:(UIView *)img
{
    
    img.layer.borderColor = [[UIColor colorWithRed:228.0/255.0 green:109.0/255.0 blue:175.0/255.0 alpha:1.0]CGColor];
    img.layer.borderWidth = 1.0f;
    
}

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

//  Added by:Zeenath
//  Added Date:25/08/2016
//  Description:To stop the activity indicator.

-(void)stopLoadingIndicator
{
    
    _loadingView.hidden=YES;
}

//Discription: Remove validation design functionality

-(void)RemoveValidationSettings:(UITextField *)textField errorIcon:(UIButton *)errorBtn HintText:(NSString *)hintTextMessage viewField:(UIView *)view{
    [textField setValue:[UIColor  colorWithRed:(112/255.0) green:(112/255.0) blue:(112/255.0) alpha:1] forKeyPath:@"_placeholderLabel.textColor"];
    textField.placeholder=hintTextMessage;
    //errorBtn.hidden=YES;
    //[self setBorder:view];
}

//Discription: Remove validation of input fields

-(void)RemoveValidation:(UITextField *)theTextField{
    
    if([theTextField isEqual: _fromTimeTxt]){
        [self RemoveValidationSettings:_fromTimeTxt errorIcon:nil HintText:@"Time From" viewField:nil];
        
    }else  if([theTextField isEqual: _toTimeTxt]){
        [self RemoveValidationSettings:_toTimeTxt errorIcon:nil HintText:@"Time To" viewField:nil];
    }
    
}


@end
