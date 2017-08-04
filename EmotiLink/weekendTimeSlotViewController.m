//
//  weekendTimeSlotViewController.m
//  EmotiLink
//
//  Created by Star on 4/24/17.
//  Copyright © 2017 Stark. All rights reserved.
//

#import "weekendTimeSlotViewController.h"
#import "GlobalFunction.h"
#import "AppDelegate.h"
#import <Google/Analytics.h>


@interface weekendTimeSlotViewController ()

@end

@implementation weekendTimeSlotViewController
@synthesize availableData, isWeekend, isTimeSlotChange, startDate, endDate;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _dumyTxtVw.hidden = YES;
    
    UIButton *cancelBtn = (UIButton *) [self.view viewWithTag:2];
    
    cancelBtn.layer.borderColor = [UIColor colorWithRed:246.0/255.0 green:108.0/255.0 blue:118.0/255.0 alpha:1].CGColor;
    
    // Do any additional setup after loading the view.
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy"];
    yearString = [formatter stringFromDate:[NSDate date]];
    
    UIImage *backgroundImage = [UIImage imageNamed:@"06. Appointment Confirmation.png"];
    UIImageView *backgroundImageView=[[UIImageView alloc]initWithFrame:self.view.frame];
    backgroundImageView.image=backgroundImage;
    [self.view insertSubview:backgroundImageView atIndex:0];
    
    monthly= [[NSMutableArray alloc] init];
    
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
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    clickedbutton=@"totimesecond";
    [_secondToTime setValue:[UIColor  colorWithRed:(112/255.0) green:(112/255.0) blue:(112/255.0) alpha:1] forKeyPath:@"_placeholderLabel.textColor"];
    _secondToTime.placeholder=@"";
}


- (void)handleSingleTapped:(UITapGestureRecognizer *)recognizer {
    _pickerBackView.hidden=YES;
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
    }else if([clickedbutton isEqualToString:@"totimesecond"]){
        [_secondToTime setText:[dataSource objectAtIndex:row]];
          [self.dumyTxtVw becomeFirstResponder];
    }
    _pickerBackView.hidden=YES;
    [self resignSoftKeyboard];
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
    
    //SATURDAY SESSION
    availCompleteDict = [[NSMutableDictionary alloc] init];
    availDict = [[NSMutableDictionary alloc] init];
    
    [availDict setObject:[NSNumber numberWithInt:2] forKey:@"availabilityID"];
    [availDict setObject:startDate forKey:@"providerAvailableStartDate"];
    [availDict setObject:endDate forKey:@"providerAvailableEndDate"];
    [availDict setObject:[NSNumber numberWithBool:isWeekend] forKey:@"isWorkingWeekend"];
    [availDict setObject:[NSNumber numberWithBool:isTimeSlotChange] forKey:@"isPreferDifferentTimeSlot"];
    
    [availCompleteDict setObject:availDict forKey:@"providerAvailability"];
    
    array=[[NSMutableArray alloc]init];
    availTimingDict = [[NSMutableDictionary alloc] init];
    
    [availTimingDict setObject:[self Convert12FormatTo24Format:_fromTimeTxt.text] forKey:@"startTime"];
    [availTimingDict setObject:[self Convert12FormatTo24Format:_toTimeTxt.text] forKey:@"endTime"];
    [availTimingDict setObject:[NSNumber numberWithInt:4] forKey:@"sessionTypeConfigId"];
    [array addObject: availTimingDict];
    
    //SUNDAY SESSION
    if (![_secondFromTime.text isEqualToString:@""]) {
        availTimingDict = [[NSMutableDictionary alloc] init];
        [availTimingDict setObject:[self Convert12FormatTo24Format:_secondFromTime.text] forKey:@"startTime"];
        [availTimingDict setObject:[self Convert12FormatTo24Format:_secondToTime.text] forKey:@"endTime"];
        [availTimingDict setObject:[NSNumber numberWithInt:5] forKey:@"sessionTypeConfigId"];
        [array addObject: availTimingDict];
        
    }
    
    [availCompleteDict setObject:array forKey:@"providerAvailableTiming"];
    
    [availMainArray addObject: availCompleteDict];
    
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

//Discription: Set validation design to the input fields

-(void)SetValidationSettinds:(UITextField *)textField errorIcon:(UIButton *)errorBtn validationMessage:(NSString *)validationMessage viewField:(UIView *)viewIs{
    
    [textField setValue:[UIColor redColor] forKeyPath:@"_placeholderLabel.textColor"];
    textField.placeholder=validationMessage;
    //errorBtn.hidden=NO;
    //viewIs.layer.borderColor = [[UIColor redColor]CGColor];
    //viewIs.layer.borderWidth = 1.0f;
    
}


-(void) setBorderColor:(int)tagName{
    UIButton *cancelBtn = (UIButton *) [self.view viewWithTag:tagName];
    cancelBtn.layer.borderColor = [UIColor colorWithRed:246.0/255.0 green:108.0/255.0 blue:118.0/255.0 alpha:1].CGColor;
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

- (IBAction)backArrowClick:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
