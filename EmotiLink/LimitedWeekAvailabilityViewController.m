//
//  LimitedWeekAvailabilityViewController.m
//  EmotiLink
//
//  Created by Starsoft on 2017-03-23.
//  Copyright © 2017 Stark. All rights reserved.
//

#import "LimitedWeekAvailabilityViewController.h"
#import "GlobalFunction.h"
#import "AppDelegate.h"
#import <Google/Analytics.h>
#import "weekendTimeSlotViewController.h"

@interface LimitedWeekAvailabilityViewController ()

@end

@implementation LimitedWeekAvailabilityViewController
@synthesize isWeekend, isTimeSlotChange;

- (void)viewDidLoad {
    
    _dumyTxt.hidden = YES;
    
    [self setBorderColor:1];
    [self setBorderColor:2];
    [self setBorderColor:3];
    [self setBorderColor:4];
    [self setBorderColor:5];
    
    myBoolFirstWeekValue=NO;
    myBoolSecondWeekValue=NO;
    myBoolThirdWeekValue=NO;
    myBoolFourthWeekValue=NO;
    myBoolFifthWeekValue=NO;
    
    
    UIButton *cancelBtn = (UIButton *) [self.view viewWithTag:10];
    
    cancelBtn.layer.borderColor = [UIColor colorWithRed:246.0/255.0 green:108.0/255.0 blue:118.0/255.0 alpha:1].CGColor;
    
    UIButton *addsessionBtn = (UIButton *) [self.view viewWithTag:6];
    
    addsessionBtn.layer.borderColor = [UIColor colorWithRed:246.0/255.0 green:108.0/255.0 blue:118.0/255.0 alpha:1].CGColor;
    
    
    UITapGestureRecognizer *singleFingerTap =
    [[UITapGestureRecognizer alloc] initWithTarget:self
                                            action:@selector(handleSingleTapped:)];
    [self.pickerBackView addGestureRecognizer:singleFingerTap];
    
    
    [self.monthSelTxt addTarget:self action:@selector(monthClick:) forControlEvents:UIControlEventEditingDidBegin];
    
    [self.fromTimetxt addTarget:self action:@selector(fromTimeTxtRecog:) forControlEvents:UIControlEventEditingDidBegin];
    
    [self.toTimeTxt addTarget:self action:@selector(toTimeTxtRecog:) forControlEvents:UIControlEventEditingDidBegin];
    
    
    [self.secondFromtime addTarget:self action:@selector(secondFromtimeRecog:) forControlEvents:UIControlEventEditingDidBegin];
    
    
    [self.secondToTimeTX addTarget:self action:@selector(secondToTimeTXRecog:) forControlEvents:UIControlEventEditingDidBegin];
    
    
    UIImage *backgroundImage = [UIImage imageNamed:@"06. Appointment Confirmation.png"];
    UIImageView *backgroundImageView=[[UIImageView alloc]initWithFrame:self.view.frame];
    backgroundImageView.image=backgroundImage;
    [self.view insertSubview:backgroundImageView atIndex:0];
    
    _addSessionView.hidden=YES;
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy"];
    yearString = [formatter stringFromDate:[NSDate date]];
    weekly= [[NSMutableArray alloc] init];
    
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}



- (void)monthClick:(UITapGestureRecognizer *)recognizer {
    [self resignSoftKeyboard];
    dataSource=[[NSArray alloc]initWithObjects:@"JAN",
                @"FEB",@"MAR",@"APR",@"MAY",@"JUN",@"JUL",@"AUG",@"SEP",@"OCT",@"NOV",@"DEC", nil];
    [self.pickerView reloadAllComponents];
    _pickerBackView.hidden=NO;
    clickedbutton=@"MonthSel";
    [self setBorder:_pickerView];
    [_monthSelTxt setValue:[UIColor  colorWithRed:(112/255.0) green:(112/255.0) blue:(112/255.0) alpha:1] forKeyPath:@"_placeholderLabel.textColor"];
    _monthSelTxt.placeholder=@"";
    
}

- (void)fromTimeTxtRecog:(UITapGestureRecognizer *)recognizer {
    [self resignSoftKeyboard];
    dataSource=[[NSArray alloc]initWithObjects:@"12:00 AM",
                @"12:30 AM",@"1:00 AM",@"1:30 AM",@"2:00 AM",@"2:30 AM",@"3:00 AM",@"3:30 AM",@"4:00 AM",@"4:30 AM",@"5:00 AM",@"5:30 AM",@"6:00 AM",@"6:30 AM",@"7:00 AM",@"7:30 AM",@"8:00 AM",@"8:30 AM",@"9:00 AM",@"9:30  AM",@"10:00 AM",@"10:30 AM",@"11:00 AM",@"11:30 AM",@"12:00 PM",@"12:30 PM",@"1:00 PM",@"1:30 PM",@"2:00 PM",@"2:30 PM",@"3:00 PM",@"3:30 PM",@"4:00 PM",@"4:30 PM",@"5:00 PM",@"5:30 PM",@"6:00 PM",@"6:30 PM",@"7:00 PM",@"7:30 PM",@"8:00 PM",@"8:30 PM",@"9:00 PM",@"9:30 PM",@"10:00 PM",@"10:30 PM",@"11:00 PM",@"11:30 PM", nil];
    [self.pickerView reloadAllComponents];
    _pickerBackView.hidden=NO;
    clickedbutton=@"Firstfromtime";
    [self setBorder:_pickerView];
    [_fromTimetxt setValue:[UIColor  colorWithRed:(112/255.0) green:(112/255.0) blue:(112/255.0) alpha:1] forKeyPath:@"_placeholderLabel.textColor"];
    _fromTimetxt.placeholder=@"";
    
}

// ToTime Click event

- (void)toTimeTxtRecog:(UITapGestureRecognizer *)recognizer {
    [self resignSoftKeyboard];
    dataSource=[[NSArray alloc]initWithObjects:@"12:00 AM",
                @"12:30 AM",@"1:00 AM",@"1:30 AM",@"2:00 AM",@"2:30 AM",@"3:00 AM",@"3:30 AM",@"4:00 AM",@"4:30 AM",@"5:00 AM",@"5:30 AM",@"6:00 AM",@"6:30 AM",@"7:00 AM",@"7:30 AM",@"8:00 AM",@"8:30 AM",@"9:00 AM",@"9:30  AM",@"10:00 AM",@"10:30 AM",@"11:00 AM",@"11:30 AM",@"12:00 PM",@"12:30 PM",@"1:00 PM",@"1:30 PM",@"2:00 PM",@"2:30 PM",@"3:00 PM",@"3:30 PM",@"4:00 PM",@"4:30 PM",@"5:00 PM",@"5:30 PM",@"6:00 PM",@"6:30 PM",@"7:00 PM",@"7:30 PM",@"8:00 PM",@"8:30 PM",@"9:00 PM",@"9:30 PM",@"10:00 PM",@"10:30 PM",@"11:00 PM",@"11:30 PM", nil];
    [self.pickerView reloadAllComponents];
    _pickerBackView.hidden=NO;
    clickedbutton=@"FirstTotime";
    [_toTimeTxt setValue:[UIColor  colorWithRed:(112/255.0) green:(112/255.0) blue:(112/255.0) alpha:1] forKeyPath:@"_placeholderLabel.textColor"];
    _toTimeTxt.placeholder=@"";
    
}

// Second from time click event

- (void)secondFromtimeRecog:(UITapGestureRecognizer *)recognizer {
    [self resignSoftKeyboard];
    dataSource=[[NSArray alloc]initWithObjects:@"12:00 AM",
                @"12:30 AM",@"1:00 AM",@"1:30 AM",@"2:00 AM",@"2:30 AM",@"3:00 AM",@"3:30 AM",@"4:00 AM",@"4:30 AM",@"5:00 AM",@"5:30 AM",@"6:00 AM",@"6:30 AM",@"7:00 AM",@"7:30 AM",@"8:00 AM",@"8:30 AM",@"9:00 AM",@"9:30  AM",@"10:00 AM",@"10:30 AM",@"11:00 AM",@"11:30 AM",@"12:00 PM",@"12:30 PM",@"1:00 PM",@"1:30 PM",@"2:00 PM",@"2:30 PM",@"3:00 PM",@"3:30 PM",@"4:00 PM",@"4:30 PM",@"5:00 PM",@"5:30 PM",@"6:00 PM",@"6:30 PM",@"7:00 PM",@"7:30 PM",@"8:00 PM",@"8:30 PM",@"9:00 PM",@"9:30 PM",@"10:00 PM",@"10:30 PM",@"11:00 PM",@"11:30 PM", nil];
    [self.pickerView reloadAllComponents];
    _pickerBackView.hidden=NO;
    clickedbutton=@"SecondFromtime";
    [_secondFromtime setValue:[UIColor  colorWithRed:(112/255.0) green:(112/255.0) blue:(112/255.0) alpha:1] forKeyPath:@"_placeholderLabel.textColor"];
    _secondFromtime.placeholder=@"";
    
}

// Second ToTime Click event
- (void)secondToTimeTXRecog:(UITapGestureRecognizer *)recognizer {
    [self resignSoftKeyboard];
    dataSource=[[NSArray alloc]initWithObjects:@"12:00 AM",
                @"12:30 AM",@"1:00 AM",@"1:30 AM",@"2:00 AM",@"2:30 AM",@"3:00 AM",@"3:30 AM",@"4:00 AM",@"4:30 AM",@"5:00 AM",@"5:30 AM",@"6:00 AM",@"6:30 AM",@"7:00 AM",@"7:30 AM",@"8:00 AM",@"8:30 AM",@"9:00 AM",@"9:30  AM",@"10:00 AM",@"10:30 AM",@"11:00 AM",@"11:30 AM",@"12:00 PM",@"12:30 PM",@"1:00 PM",@"1:30 PM",@"2:00 PM",@"2:30 PM",@"3:00 PM",@"3:30 PM",@"4:00 PM",@"4:30 PM",@"5:00 PM",@"5:30 PM",@"6:00 PM",@"6:30 PM",@"7:00 PM",@"7:30 PM",@"8:00 PM",@"8:30 PM",@"9:00 PM",@"9:30 PM",@"10:00 PM",@"10:30 PM",@"11:00 PM",@"11:30 PM", nil];
    
    [self.pickerView reloadAllComponents];
    _pickerBackView.hidden=NO;
    clickedbutton=@"SecondTotime";
    [_secondToTimeTX setValue:[UIColor  colorWithRed:(112/255.0) green:(112/255.0) blue:(112/255.0) alpha:1] forKeyPath:@"_placeholderLabel.textColor"];
    _secondToTimeTX.placeholder=@"";
    
}

- (void)handleSingleTapped:(UITapGestureRecognizer *)recognizer {
    _pickerBackView.hidden=YES;
    [self.dumyTxt becomeFirstResponder];
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
    
    if([clickedbutton isEqualToString:@"MonthSel"])
    {
        [_monthSelTxt setText:[dataSource objectAtIndex:row]];
        [self.dumyTxt becomeFirstResponder];
        [self resignSoftKeyboard];
        NSDateFormatter* monNumformatter = [[NSDateFormatter alloc] init] ;
        [monNumformatter setDateFormat:@"MMM"];
        //NSDate *aDate = [monNumformatter dateFromString:_monthSelTxt.text];
        NSDateComponents *monNumComponents = [[NSCalendar currentCalendar] components:NSCalendarUnitMonth fromDate:[monNumformatter dateFromString:_monthSelTxt.text]];
        NSLog(@"Month: %li", (long)[monNumComponents month]);
        
        monNumformatter = [[NSDateFormatter alloc] init];
        [monNumformatter setDateFormat:@"YYYY-MM-dd"];
        
        NSString *dateStr = [@[yearString, [NSString stringWithFormat: @"%ld", (long)[monNumComponents month]], @"01"] componentsJoinedByString:@"-"];
        NSLog(@"dateStr: %@", dateStr);
        
        NSDate *date = [monNumformatter dateFromString:dateStr];
        
        //NSDate *today = [NSDate date];
        
        NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
        gregorian.firstWeekday = 1; // Sunday = 1, Saturday = 7
        
        NSDateComponents *dateComponents = [gregorian components:NSCalendarUnitWeekOfYear fromDate:date];
        
        weekOfYear = [dateComponents weekOfYear];
        NSLog(@"weekOfYear2: %li", weekOfYear);
        
        if([self weeksOfMonth:[dateComponents weekOfMonth] inYear:yearString ] > 4){
            _fifthWeekButton.hidden=NO;
            _fifthWeekButtonArrow.hidden=NO;
        }else{
            _fifthWeekButton.hidden=YES;
            _fifthWeekButtonArrow.hidden=YES;
        }
        
    }
    else if([clickedbutton isEqualToString:@"Firstfromtime"]){
        [_fromTimetxt setText:[dataSource objectAtIndex:row]];
        [self.dumyTxt becomeFirstResponder];
        [self.dumyTxt becomeFirstResponder];
    }
    else if([clickedbutton isEqualToString:@"FirstTotime"]){
        [_toTimeTxt setText:[dataSource objectAtIndex:row]];
        [self.dumyTxt becomeFirstResponder];
    }else if([clickedbutton isEqualToString:@"SecondFromtime"]){
        [_secondFromtime setText:[dataSource objectAtIndex:row]];
        [self.dumyTxt becomeFirstResponder];
    }else if([clickedbutton isEqualToString:@"SecondTotime"]){
        [_secondToTimeTX setText:[dataSource objectAtIndex:row]];
        [self.dumyTxt becomeFirstResponder];
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



- (IBAction)AddSessionClick:(id)sender {
    
    // _addSessionView.hidden=NO;
    
    
    if(_addSessionView.hidden==NO){
        _addSessionView.hidden=YES;
        // _cancelBtbVw.frame = CGRectMake(30, 270, 120, 50);
        // _saveBtnVw.frame = CGRectMake(170, 270, 120, 50);
        
        // _cancelsaveBtnVW.frame = CGRectMake(30, 505, 120, 50);
        // _cancelBtbVw.frame = CGRectMake(30, 480, 120, 50);
        
        
        _totalBtnView .frame = CGRectMake(30, 610, 260, 70);
        
    }else{
        _addSessionView.hidden=NO;
        
        // _cancelBtbVw.frame = CGRectMake(30, 385, 120, 50);
        //   _saveBtnVw.frame = CGRectMake(170, 385, 120, 50);
        
        _totalBtnView.frame = CGRectMake( 30, 800, 70, 260 );
        
    }
    
    
    /*  _availabilityFilterView.frame = CGRectMake(self.availabilityFilterView.frame.origin.x, 82, _availabilityFilterView.bounds.size.width,0);
     
     _expertiseView.frame = CGRectMake(self.expertiseView.frame.origin.x, 400, _expertiseView.bounds.size.width,_expertiseView.bounds.size.height);
     
     _searchButtton.frame = CGRectMake(self.searchButtton.frame.origin.x, 710,
     _searchButtton.bounds.size.width, _searchButtton.bounds.size.height);*/
    
    //_cancelBtnVw.frame = CGRectMake(320, 480, 50, 120);
    
    
    
}

- (IBAction)SaveClick:(id)sender {
    
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
        if (![_secondFromtime.text isEqualToString:@""]) {
            
            if ([[self convertTimeFormat:_fromTimetxt.text] compare:[self convertTimeFormat:_secondFromtime.text]] == NSOrderedDescending || [[self convertTimeFormat:_fromTimetxt.text] compare:[self convertTimeFormat:_secondFromtime.text]] == NSOrderedSame) {
                _secondFromtime.text=@"";
                [self ShowAlert:[[GlobalFunction sharedInstance].arrayOfAlerts objectAtIndex:91]];
                return;
            }
            
            if ([[self convertTimeFormat:_secondFromtime.text] compare:[self convertTimeFormat:_secondToTimeTX.text]] == NSOrderedDescending || [[self convertTimeFormat:_secondFromtime.text] compare:[self convertTimeFormat:_secondToTimeTX.text]] == NSOrderedSame) {
                _secondToTimeTX.text=@"";
                [self ShowAlert:[[GlobalFunction sharedInstance].arrayOfAlerts objectAtIndex:92]];
                return;
            }
            
        }
    }
    
    [self startLoadingIndicator];
    [self ServiceCall:timeDict];
}

- (IBAction)CancelClick:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)firstWeekClick:(id)sender {
    myBoolFirstWeekValue =[self setButtonColorOnSelected:1 boolValue:myBoolSecondWeekValue fromDate:[@"01/01/" stringByAppendingString:yearString] toDate:[@"01/31/" stringByAppendingString:yearString]];
}

- (IBAction)secondWeekClick:(id)sender {
    myBoolSecondWeekValue =[self setButtonColorOnSelected:2 boolValue:myBoolSecondWeekValue fromDate:[@"01/01/" stringByAppendingString:yearString] toDate:[@"01/31/" stringByAppendingString:yearString]];
}

- (IBAction)thirdWeekClick:(id)sender {
    myBoolThirdWeekValue =[self setButtonColorOnSelected:3 boolValue:myBoolThirdWeekValue fromDate:[@"01/01/" stringByAppendingString:yearString] toDate:[@"01/31/" stringByAppendingString:yearString]];
}

- (IBAction)fourthWeekClick:(id)sender {
    myBoolFourthWeekValue =[self setButtonColorOnSelected:4 boolValue:myBoolFourthWeekValue fromDate:[@"01/01/" stringByAppendingString:yearString] toDate:[@"01/31/" stringByAppendingString:yearString]];
}

- (IBAction)fifthWeekClick:(id)sender {
    myBoolFifthWeekValue =[self setButtonColorOnSelected:5 boolValue:myBoolFifthWeekValue fromDate:[@"01/01/" stringByAppendingString:yearString] toDate:[@"01/31/" stringByAppendingString:yearString]];
}

-(void) setBorderColor:(int)tagName{
    UIButton *BtnVw = (UIButton *) [self.view viewWithTag:tagName];
    BtnVw.layer.borderColor = [UIColor colorWithRed:118.0/255.0 green:183.0/255.0 blue:189.0/255.0 alpha:1].CGColor;
}

-(bool) setButtonColorOnSelected:(int)tagName boolValue:(bool)boolValue  fromDate:(NSString*)fromDate toDate:(NSString*)toDate {
    
    UIButton *expertiseBtn = (UIButton *) [self.view viewWithTag:tagName];
    NSMutableDictionary *monthSelValue=[[NSMutableDictionary alloc] init];
    
    if(boolValue==NO){
        expertiseBtn.layer.backgroundColor = [UIColor colorWithRed:118.0/255.0 green:183.0/255.0 blue:189.0/255.0 alpha:1].CGColor;
        [expertiseBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
        UIImage *image = [UIImage imageNamed: @"rightMark.png"];
        //cancelBtn.image=image;
        [expertiseBtn setImage:image forState:UIControlStateNormal];
        
        [weekly addObject:[self getStartEndDateofWeek:(weekOfYear+tagName-1)]];
        
        /*[monthSelValue setObject:fromDate forKey:@"StartDate"];
         [monthSelValue setObject:toDate forKey:@"EndDate"];
         [weekly addObject: monthSelValue];*/
        
        return YES;
    }else{
        expertiseBtn.layer.backgroundColor = [UIColor whiteColor].CGColor;
        [expertiseBtn setTitleColor:[UIColor colorWithRed:118.0/255.0 green:183.0/255.0 blue:189.0/255.0 alpha:1] forState:UIControlStateNormal];
        
        UIImage *image = [UIImage imageNamed: @"plusIcon.png"];
        
        [expertiseBtn setImage:image forState:UIControlStateNormal];
        
        [weekly addObject:[self getStartEndDateofWeek:(weekOfYear+tagName-1)]];
        
        /*[monthSelValue setObject:fromDate forKey:@"StartDate"];
         [monthSelValue setObject:toDate forKey:@"EndDate"];
         [weekly removeObject: monthSelValue];*/
        
        return NO;
        
    }
    
}
-(void)setBorder:(UIView *)img
{
    
    img.layer.borderColor = [[UIColor colorWithRed:228.0/255.0 green:109.0/255.0 blue:175.0/255.0 alpha:1.0]CGColor];
    img.layer.borderWidth = 1.0f;
    
}

-(void)resignSoftKeyboard{
    [_monthSelTxt resignFirstResponder];
    [_fromTimetxt resignFirstResponder];
    [_toTimeTxt resignFirstResponder];
    [_secondFromtime resignFirstResponder];
    [_secondToTimeTX resignFirstResponder];
    [_dumyTxt resignFirstResponder];
    
}


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
    
    for (NSDictionary *item in weekly) {
        
        availCompleteDict = [[NSMutableDictionary alloc] init];
        availDict = [[NSMutableDictionary alloc] init];
        
        [availDict setObject:[NSNumber numberWithInt:6] forKey:@"availabilityID"];
        [availDict setObject:[item objectForKey:@"StartDate"] forKey:@"providerAvailableStartDate"];
        [availDict setObject:[item objectForKey:@"EndDate"]  forKey:@"providerAvailableEndDate"];
        [availDict setObject:[NSNumber numberWithBool:isWeekend] forKey:@"isWorkingWeekend"];
        [availDict setObject:[NSNumber numberWithBool:isTimeSlotChange] forKey:@"isPreferDifferentTimeSlot"];
        
        [availCompleteDict setObject:availDict forKey:@"providerAvailability"];
        
        array=[[NSMutableArray alloc]init];
        availTimingDict = [[NSMutableDictionary alloc] init];
        
        [availTimingDict setObject:[self Convert12FormatTo24Format:_fromTimetxt.text] forKey:@"startTime"];
        [availTimingDict setObject:[self Convert12FormatTo24Format:_toTimeTxt.text] forKey:@"endTime"];
        [availTimingDict setObject:[NSNumber numberWithInt:1] forKey:@"sessionTypeConfigId"];
        [array addObject: availTimingDict];
        
        if(_addSessionView.hidden==NO){
            
            availTimingDict = [[NSMutableDictionary alloc] init];
            [availTimingDict setObject:[self Convert12FormatTo24Format:_secondFromtime.text] forKey:@"startTime"];
            [availTimingDict setObject:[self Convert12FormatTo24Format:_secondToTimeTX.text] forKey:@"endTime"];
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
                                            if([NSNumber numberWithBool:isTimeSlotChange]){
                                                weekendTimeSlotViewController *vc=[self.storyboard instantiateViewControllerWithIdentifier:@"weekendTimeSlot"];
                                                
                                                vc.isWeekend=isWeekend;
                                                vc.isTimeSlotChange=isTimeSlotChange;
                                                // vc.emailLabelText = [response objectForKey:@"email"];
                                                [self presentViewController:vc animated:YES completion:nil];
                                            } else{
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


-(NSDate *)convertTimeFormat:(NSString *)time{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"hh:mm a"];
    NSDate *amPmDate = [formatter dateFromString:time];
    [formatter setDateFormat:@"HH:mm"];
    return amPmDate;
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


- (IBAction)backArrowClick:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

//Discription: Set validation design to the input fields

-(void)SetValidationSettinds:(UITextField *)textField errorIcon:(UIButton *)errorBtn validationMessage:(NSString *)validationMessage viewField:(UIView *)viewIs{
    
    [textField setValue:[UIColor redColor] forKeyPath:@"_placeholderLabel.textColor"];
    textField.placeholder=validationMessage;
    //errorBtn.hidden=NO;
    //viewIs.layer.borderColor = [[UIColor redColor]CGColor];
    //viewIs.layer.borderWidth = 1.0f;
}

-(NSMutableDictionary *)getStartEndDateofWeek:(NSInteger)intWeekofYear{
    NSCalendar *cal = [NSCalendar currentCalendar];
    
    NSMutableDictionary *weekSelValue=[[NSMutableDictionary alloc] init];
    
    // Start of week:
    NSDateComponents *comp = [[NSDateComponents alloc] init];
    comp.weekday = cal.firstWeekday;
    comp.weekOfYear = intWeekofYear; // <-- fill in your week number here
    comp.year = [[yearString stringByReplacingOccurrencesOfString:@" " withString:@""] integerValue]; ;    // <-- fill in your year here
    NSDate *startOfWeek = [cal dateFromComponents:comp];
    
    // Add 6 days:
    NSDate *endOfWeek = [cal dateByAddingUnit:NSCalendarUnitDay value:6 toDate:startOfWeek options:0];
    
    // Show results:
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateStyle = NSDateFormatterShortStyle;
    NSLog(@"%@", [fmt stringFromDate:startOfWeek]);
    NSLog(@"%@", [fmt stringFromDate:endOfWeek]);
    [weekSelValue setObject:[fmt stringFromDate:startOfWeek] forKey:@"StartDate"];
    [weekSelValue setObject:[fmt stringFromDate:endOfWeek] forKey:@"EndDate"];
    
    return weekSelValue;
}

- (NSInteger)weeksOfMonth:(int)month inYear:(int)year{
    NSString *dateString=[NSString stringWithFormat:@"%4d/%d/1",year,month];
    
    NSDateFormatter *dfMMddyyyy=[NSDateFormatter new];
    [dfMMddyyyy setDateFormat:@"yyyy/MM/dd"];
    NSDate *date=[dfMMddyyyy dateFromString:dateString];
    
    NSCalendar *calender = [NSCalendar currentCalendar];
    NSRange weekRange = [calender rangeOfUnit:NSCalendarUnitWeekOfYear inUnit:NSCalendarUnitMonth forDate:date];
    NSInteger weeksCount=weekRange.length;
    
    return weeksCount;
}

@end
