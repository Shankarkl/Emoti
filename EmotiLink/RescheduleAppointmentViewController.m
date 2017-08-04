//
//  RescheduleAppointmentViewController.m
//  EmotiLink
//
//  Created by Kalpesh Mehta on 25/04/17.
//  Copyright © 2017 Stark. All rights reserved.
//

#import "RescheduleAppointmentViewController.h"
#import "CKCalendarView.h"
#import "AppDelegate.h"
#import "GlobalFunction.h"
#import "ToggleButton.h"
#import <THCalendarDatePicker/THDatePickerViewController.h>
@interface RescheduleAppointmentViewController ()<UIPageViewControllerDelegate>
@property (nonatomic, retain) NSDate * curDate;
@property (nonatomic, retain) NSDateFormatter * formatter;
@property(nonatomic, weak) CKCalendarView *calendar;

@property(nonatomic, strong) NSDateFormatter *dateFormatter;
@property(nonatomic, strong) NSDate *minimumDate;
@property(nonatomic, strong) NSArray *disabledDates;
@end

@implementation RescheduleAppointmentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"previouspAGE 1 = %@",_AppointmentIDValue);
  
    
    //_providerIDValue= [[NSMutableDictionary alloc]init];
    // Do any additional setup after loading the view.
    [self setBorderColor:2];
    
    self.curDate = [NSDate date];
    self.formatter = [[NSDateFormatter alloc] init];
    [_formatter setDateFormat:@"dd/MM/yyyy --- HH:mm"];
    [super viewDidLoad];
    
    UITapGestureRecognizer *singleFingerTap =
    [[UITapGestureRecognizer alloc] initWithTarget:self
                                            action:@selector(handleSingleTapped:)];
   // [_DateTxt addGestureRecognizer:singleFingerTap];
    [_DateTxt addTarget:self action:@selector(calenderClick:) forControlEvents:UIControlEventEditingDidBegin];
    [_SecondDateTxt addTarget:self action:@selector(calenderoneClick:) forControlEvents:UIControlEventEditingDidBegin];
    [_ThirdDateTxt addTarget:self action:@selector(calendertwoClick:) forControlEvents:UIControlEventEditingDidBegin];
   [_TimeTxt addTarget:self action:@selector(monthClick:) forControlEvents:UIControlEventEditingDidBegin];
     [_SecondTimeTxt addTarget:self action:@selector(monthsecondClick:) forControlEvents:UIControlEventEditingDidBegin];
     [_ThirdTimeTxt addTarget:self action:@selector(monthsthirdClick:) forControlEvents:UIControlEventEditingDidBegin];
}
//Loads each time when page loaded completely
-(void)viewDidAppear:(BOOL)animated
{
    //if ([_screenStatus isEqualToString:@"appointment"]) {
    [self showCalendar];
    //}
    AppDelegate *appdelegate=(AppDelegate *)[[UIApplication sharedApplication]delegate];
    NSString *userName=[[appdelegate usersDetails]valueForKey:@"userRole"];
    if (![userName isEqualToString:@"Provider"]){
        _SessionView.hidden=YES;
        _CancelClick.frame = CGRectMake(30, 182, 100, 50);
        _ConfirmClick.frame = CGRectMake(150, 182, 100, 50);
        NSLog(@"USER");
        
    }else{
        _SessionView.hidden=NO;
        _CancelClick.frame = CGRectMake(30, 515, 100, 50);
        _ConfirmClick.frame = CGRectMake(150, 515, 100, 50);
    }

    
    detectFirstTime=0;
    deselectItem=0;
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)ConfirmBtn:(id)sender {
     _paramArray=[[NSMutableArray alloc]init];
    NSString * mystring = _TimeTxt.text;
    NSArray * array = [mystring componentsSeparatedByString:@"-"];
    NSString * str1 = [array objectAtIndex:0]; //123
    NSString * str2 = [array objectAtIndex:1]; //456
    NSLog(@"string1%@",str1);
    NSString * str3=[self Convert12FormatTo24Format:str1];
    NSString * str4=[self Convert12FormatTo24Format:str2];
    NSLog(@"string1%@",str3);
  

    NSMutableDictionary *dict=[[NSMutableDictionary alloc]init];
    [dict setObject:  _AppointmentIDValue  forKey:@"appointmentsId"];
    [dict setObject:_DateTxt.text forKey:@"reScheduleDate"];
    [dict setObject:str3 forKey:@"reScheduleStartTime"];
    [dict setObject:str4 forKey:@"reScheduleEndTime"];
    NSLog(@"DICTIONARY%@",dict);
   
    [_paramArray addObject: dict];
    if(![_SecondDateTxt.text isEqualToString:@""]){
        NSString * mystring2 = _SecondTimeTxt.text;
        NSArray * array2 = [mystring2 componentsSeparatedByString:@"-"];
        NSString * str1two = [array2 objectAtIndex:0]; //123
        NSString * str2two = [array2 objectAtIndex:1]; //456
        NSLog(@"string2%@",str1two);
        NSString * str3two=[self Convert12FormatTo24Format:str1two];
        NSString * str4two=[self Convert12FormatTo24Format:str2two];
        NSLog(@"string2%@",str3two);
    NSMutableDictionary *dict1=[[NSMutableDictionary alloc]init];
    [dict1 setObject: _AppointmentIDValue forKey:@"appointmentsId"];
    [dict1 setObject:_SecondDateTxt.text forKey:@"reScheduleDate"];
    [dict1 setObject:str3two forKey:@"reScheduleStartTime"];
    [dict1 setObject:str4two forKey:@"reScheduleEndTime"];
    NSLog(@"DICTIONARY%@",dict1);
         [_paramArray addObject: dict1];
    }
     if(![_ThirdDateTxt.text isEqualToString:@""]){
         NSString * mystring3 = _SecondTimeTxt.text;
         NSArray * array3 = [mystring3 componentsSeparatedByString:@"-"];
         NSString * str1three = [array3 objectAtIndex:0]; //123
         NSString * str2three = [array3 objectAtIndex:1]; //456
         NSLog(@"string3%@",str1three);
         NSString * str3three=[self Convert12FormatTo24Format:str1three];
         NSString * str4three=[self Convert12FormatTo24Format:str2three];
         NSLog(@"string3%@",str3three);
         

    NSMutableDictionary *dict2=[[NSMutableDictionary alloc]init];
    [dict2 setObject: _AppointmentIDValue forKey:@"appointmentsId"];
    [dict2 setObject:_ThirdDateTxt.text forKey:@"reScheduleDate"];
    [dict2 setObject:str3three forKey:@"reScheduleStartTime"];
    [dict2 setObject:str4three forKey:@"reScheduleEndTime"];
    NSLog(@"DICTIONARY%@",dict2);
          [_paramArray addObject: dict2];
     }
    AppDelegate *appdelegate=(AppDelegate *)[[UIApplication sharedApplication]delegate];
    
        NSLog(@"parameters sent2%@",_paramArray);
        NSString *Url=[appdelegate.serviceURL stringByAppendingString:@"api/Appointments/RescheduleAppointment"];
    
        [[GlobalFunction sharedInstance]getServerResponseAfterLogin:Url method:@"POST" param:_paramArray withCallback:^(NSInteger statusCode, NSDictionary *response, NSError *error) {
            if(statusCode == 200)
            {
                NSLog(@"Reschedulr success");
[self.dummytxt becomeFirstResponder];
            [self resignSoftKeyBoard];
                 [self dismissViewControllerAnimated:YES completion:nil];
                if ([_delegate respondsToSelector:@selector(dataFromController:)])
                {
                    [_delegate dataFromController:@"200"];
                   
                }
                
                
        }else if(statusCode==404){
           
            _alert = [UIAlertController
                      alertControllerWithTitle:@""
                      message:[[GlobalFunction sharedInstance].arrayOfAlerts objectAtIndex:85]
                      preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction* okButton = [UIAlertAction
                                       actionWithTitle:@"OK"
                                       style:UIAlertActionStyleDefault
                                       handler:^(UIAlertAction * action) {
                                           [self.navigationController popViewControllerAnimated:YES];
                                       }];
            [_alert addAction:okButton];
            [self presentViewController:_alert animated:YES completion:nil];
            [self.dummytxt becomeFirstResponder];
            [self resignSoftKeyBoard];
            [_calendarBackView setHidden:YES];
            _pickerBackView.hidden=YES;
            _PickerView.hidden=YES;
            
        }else{
            NSString *message;
            
            if(statusCode==403||statusCode==503){
                
                message=[[GlobalFunction sharedInstance].arrayOfAlerts objectAtIndex:74];
                
            }else if(statusCode==401){
                
                message=[[GlobalFunction sharedInstance].arrayOfAlerts objectAtIndex:63];
                
            }else if(statusCode==400){
                
                message=@"You have already requested for the Reschedule of this appointment.";

            
            }else{
                NSDictionary *messagearray=[response objectForKey:@ "modelState"];
                NSArray *dictValues=[messagearray allValues];
                NSArray *msgarray=[dictValues objectAtIndex:0];
                message=[msgarray objectAtIndex:0];
                
            }
            
            _alert = [UIAlertController
                      alertControllerWithTitle:@""
                      message:message
                      preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction* okButton = [UIAlertAction
                                       actionWithTitle:@"OK"
                                       style:UIAlertActionStyleDefault
                                       handler:^(UIAlertAction * action) {
                                           
                                       }];
            [_alert addAction:okButton];
            [self presentViewController:_alert animated:YES completion:nil];
            [self.dummytxt becomeFirstResponder];
            [self resignSoftKeyBoard];
            [_calendarBackView setHidden:YES];
            _pickerBackView.hidden=YES;
            _PickerView.hidden=YES;
        }
         
         
        }];
    
    
}

- (IBAction)CancelBtn:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)Timedropbtn:(id)sender {
  
}

- (IBAction)DateDropbtn:(id)sender {
}

//Call the functionalities there in did load when click on calander icon
- (IBAction)calendarClick:(id)sender {
    [self viewDidAppear:YES];
}

//To set the orientation of the screen
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
    } else {
        return YES;
    }
}

//Calendar date change functionality
- (void)localeDidChange {
    [self.calendar setLocale:[NSLocale currentLocale]];
}

//Disable the date if that is older than current date
- (BOOL)dateIsDisabled:(NSDate *)date {
    for (NSDate *disabledDate in self.disabledDates) {
        if ([disabledDate isEqualToDate:date]) {
            return YES;
        }
    }
    return NO;
}


-(void)showCalendar
{
    [_calendarBackView setHidden:NO];
    _pickerBackView.hidden=NO;
    _PickerView.hidden=YES;
     [self resignSoftKeyBoard];
    if(!self.datePicker)
        self.datePicker = [THDatePickerViewController datePicker];
    // create the string array
    NSArray *dateArray = @[@"01/12/2012", @"02/26/2017", @"02/27/2017", @"02/24/2006", @"03/19/2007", @"07/14/2011", @"08/17/2007", @"10/04/2007", @"10/31/2006", @"12/05/2012", @"12/06/2006", @"12/23/2008"];
    
    // create the date formatter with the correct format
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MM/dd/yyyy"];
    
    NSMutableArray *tempArray = [NSMutableArray array];
    
    // fast enumeration of the array
    for (NSString *dateString in dateArray) {
        NSDate *date = [formatter dateFromString:dateString];
        [tempArray addObject:date];
    }
    
    // sort the array of dates
    [tempArray sortUsingComparator:^NSComparisonResult(NSDate *date1, NSDate *date2) {
        // return date2 compare date1 for descending. Or reverse the call for ascending.
        return [date2 compare:date1];
    }];
    
    NSLog(@"tempArray %@", tempArray);
    
    [self.datePicker setDisablePerticularDates:tempArray];
    
    CGRect thisRect = _datePicker.view.frame;
    
    thisRect.origin.y = ((self.calendarBackView.frame.size.height-_datePicker.view.frame.size.height)/2);
    thisRect.origin.x = ((self.calendarBackView.frame.size.width-_datePicker.view.frame.size.width)/2);
    [_datePicker.view setFrame:thisRect];
    
    self.datePicker.date = self.curDate;
    
    self.datePicker.delegate = self;
    [self.datePicker setAllowClearDate:NO];
    [self.datePicker setClearAsToday:YES];
    [self.datePicker setAutoCloseOnSelectDate:YES];
    [self.datePicker setAllowSelectionOfSelectedDate:YES];
    [self.datePicker setDisableHistorySelection:YES];
    [self.datePicker setDisableFutureSelection:NO];
    [self.datePicker setSelectedBackgroundColor:[UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0]];
    [self.datePicker setDisableYearSwitch:TRUE];
    /*   [self.datePicker setCurrentDateColor:[UIColor colorWithRed:246/255.0 green:108/255.0 blue:100/255.0 alpha:1.0]];*/
    [self.datePicker setCurrentDateColor:[UIColor colorWithRed:200/255.0 green:121/255.0 blue:100/255.0 alpha:1.0]];
    
    [self.datePicker setAllowMultiDaySelection:YES];
    
    [self.datePicker setDateHasItemsCallback:^BOOL(NSDate *date) {
        int tmp = (arc4random() % 30)+1;
        if(tmp % 5 == 0)
            return YES;
        return NO;
    }];
    
    
    [self addChildViewController:_datePicker];
    [self.calendarBackView addSubview:_datePicker.view];
    [_datePicker didMoveToParentViewController:self];
}

-(void)showsecondCalendar
{
    date=@"2";
    [_calendarBackView setHidden:NO];
    _pickerBackView.hidden=NO;
    _PickerView.hidden=YES;
    
    if(!self.datePicker)
        self.datePicker = [THDatePickerViewController datePicker];
    // create the string array
    NSArray *dateArray = @[@"01/12/2012", @"02/26/2017", @"02/27/2017", @"02/24/2006", @"03/19/2007", @"07/14/2011", @"08/17/2007", @"10/04/2007", @"10/31/2006", @"12/05/2012", @"12/06/2006", @"12/23/2008"];
    
    // create the date formatter with the correct format
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MM/dd/yyyy"];
    
    NSMutableArray *tempArray = [NSMutableArray array];
    
    // fast enumeration of the array
    for (NSString *dateString in dateArray) {
        NSDate *date = [formatter dateFromString:dateString];
        [tempArray addObject:date];
    }
    
    // sort the array of dates
    [tempArray sortUsingComparator:^NSComparisonResult(NSDate *date1, NSDate *date2) {
        // return date2 compare date1 for descending. Or reverse the call for ascending.
        return [date2 compare:date1];
    }];
    
    NSLog(@"tempArray %@", tempArray);
    
    [self.datePicker setDisablePerticularDates:tempArray];
    
    CGRect thisRect = _datePicker.view.frame;
    
    thisRect.origin.y = ((self.calendarBackView.frame.size.height-_datePicker.view.frame.size.height)/2);
    thisRect.origin.x = ((self.calendarBackView.frame.size.width-_datePicker.view.frame.size.width)/2);
    [_datePicker.view setFrame:thisRect];
    
    self.datePicker.date = self.curDate;
    
    self.datePicker.delegate = self;
    [self.datePicker setAllowClearDate:NO];
    [self.datePicker setClearAsToday:YES];
    [self.datePicker setAutoCloseOnSelectDate:YES];
    [self.datePicker setAllowSelectionOfSelectedDate:YES];
    [self.datePicker setDisableHistorySelection:YES];
    [self.datePicker setDisableFutureSelection:NO];
    [self.datePicker setSelectedBackgroundColor:[UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0]];
    [self.datePicker setDisableYearSwitch:TRUE];
    //  [self.datePicker setCurrentDateColor:[UIColor colorWithRed:246/255.0 green:108/255.0 blue:100/255.0 alpha:1.0]];
    [self.datePicker setCurrentDateColor:[UIColor colorWithRed:200/255.0 green:121/255.0 blue:100/255.0 alpha:1.0]];
    
    [self.datePicker setAllowMultiDaySelection:YES];
    
    [self.datePicker setDateHasItemsCallback:^BOOL(NSDate *date) {
        int tmp = (arc4random() % 30)+1;
        if(tmp % 5 == 0)
            return YES;
        return NO;
    }];
    
    
    [self addChildViewController:_datePicker];
    [self.calendarBackView addSubview:_datePicker.view];
    [_datePicker didMoveToParentViewController:self];
     [self resignSoftKeyBoard];
}


-(void)showthirdCalendar
{
    date=@"3";
    [_calendarBackView setHidden:NO];
    _pickerBackView.hidden=NO;
    _PickerView.hidden=YES;
    
    if(!self.datePicker)
        self.datePicker = [THDatePickerViewController datePicker];
    // create the string array
    NSArray *dateArray = @[@"01/12/2012", @"02/26/2017", @"02/27/2017", @"02/24/2006", @"03/19/2007", @"07/14/2011", @"08/17/2007", @"10/04/2007", @"10/31/2006", @"12/05/2012", @"12/06/2006", @"12/23/2008"];
    
    // create the date formatter with the correct format
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MM/dd/yyyy"];
    
    NSMutableArray *tempArray = [NSMutableArray array];
    
    // fast enumeration of the array
    for (NSString *dateString in dateArray) {
        NSDate *date = [formatter dateFromString:dateString];
        [tempArray addObject:date];
    }
    
    // sort the array of dates
    [tempArray sortUsingComparator:^NSComparisonResult(NSDate *date1, NSDate *date2) {
        // return date2 compare date1 for descending. Or reverse the call for ascending.
        return [date2 compare:date1];
    }];
    
    NSLog(@"tempArray %@", tempArray);
    
    [self.datePicker setDisablePerticularDates:tempArray];
    
    CGRect thisRect = _datePicker.view.frame;
    
    thisRect.origin.y = ((self.calendarBackView.frame.size.height-_datePicker.view.frame.size.height)/2);
    thisRect.origin.x = ((self.calendarBackView.frame.size.width-_datePicker.view.frame.size.width)/2);
    [_datePicker.view setFrame:thisRect];
    
    self.datePicker.date = self.curDate;
    
    self.datePicker.delegate = self;
    [self.datePicker setAllowClearDate:NO];
    [self.datePicker setClearAsToday:YES];
    [self.datePicker setAutoCloseOnSelectDate:YES];
    [self.datePicker setAllowSelectionOfSelectedDate:YES];
    [self.datePicker setDisableHistorySelection:YES];
    [self.datePicker setDisableFutureSelection:NO];
    [self.datePicker setSelectedBackgroundColor:[UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0]];
    [self.datePicker setDisableYearSwitch:TRUE];
    //[self.datePicker setCurrentDateColor:[UIColor colorWithRed:246/255.0 green:108/255.0 blue:100/255.0 alpha:1.0]];
    [self.datePicker setCurrentDateColor:[UIColor colorWithRed:200/255.0 green:121/255.0 blue:100/255.0 alpha:1.0]];
    
    [self.datePicker setAllowMultiDaySelection:YES];
    
    [self.datePicker setDateHasItemsCallback:^BOOL(NSDate *date) {
        int tmp = (arc4random() % 30)+1;
        if(tmp % 5 == 0)
            return YES;
        return NO;
    }];
    
    
    [self addChildViewController:_datePicker];
    [self.calendarBackView addSubview:_datePicker.view];
    [_datePicker didMoveToParentViewController:self];
     [self resignSoftKeyBoard];
}


- (void)datePickerDonePressed:(THDatePickerViewController *)datePicker {
    self.curDate = datePicker.date;
    [self dismissSemiModalView];
}

- (void)datePickerCancelPressed:(THDatePickerViewController *)datePicker {
    [self dismissSemiModalView];
}

//Date picker to get the selected date
- (void)datePicker:(THDatePickerViewController *)datePicker selectedDate:(NSDate *)selectedDate {
    
    _calendarBackView.hidden=YES;
    _pickerBackView.hidden=YES;
    [self.dummytxt becomeFirstResponder];
    [self resignSoftKeyBoard];
    AppDelegate *appdelegate= (AppDelegate *)[[UIApplication sharedApplication]delegate];
    //   GlobalFunction *globalValues=[[GlobalFunction alloc]init];
    
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    format.dateFormat = @"MM-dd-yyyy";
    
    NSDate *currentTime=[NSDate date];
    NSDateFormatter *timeformat = [[NSDateFormatter alloc] init];
    timeformat.dateFormat = @"HH:mm";
    
    NSDateFormatter *dayformat = [[NSDateFormatter alloc] init];
    dayformat.dateFormat =@"EEE, dd MMM yyyy";
    
   // [sendAppointmentData setObject:[format stringFromDate:selectedDate] forKey:@"Date"];
    if([date isEqualToString:@"2"]){
        _SecondDateTxt.text=[dayformat stringFromDate:selectedDate];
    }else if([date isEqualToString:@"3"]){
        _ThirdDateTxt.text=[dayformat stringFromDate:selectedDate];

    }else {
         _DateTxt.text=[dayformat stringFromDate:selectedDate];
    }
    
    //[self.dummytxt becomeFirstResponder];
   // [self resignSoftKeyBoard];
    
    NSString *availableUrl=[appdelegate.serviceURL stringByAppendingString:@"api/Availability/ProviderAvailability"];
    NSMutableDictionary *availableData = [[NSMutableDictionary alloc] init];
    [availableData setObject:[_providerIDValue objectForKey:@"providerID"] forKey:@"providerID"];
     //[availableData setObject: [rescheduleData objectForKey:@"reScheduleDate"] forKey:@"reScheduleDate"];
    [availableData setObject:[NSString stringWithFormat:@"%@ %@",[format stringFromDate:selectedDate],[timeformat stringFromDate:currentTime]] forKey:@"availiblityDate"];
    NSLog(@"datasenttoservice%@",availableData);
    [self startLoadingIndicator];
    [[GlobalFunction sharedInstance] getServerResponseAfterLogin:availableUrl method:@"POST" param:availableData withCallback:^(NSInteger statusCode, NSDictionary *response, NSError *error)
     {
         if (statusCode==200) {
             appointmentListArray=[response mutableCopy];
             [self.dummytxt becomeFirstResponder];
             [self resignSoftKeyBoard];
             dataSource=[[NSMutableArray alloc]init];
             
             for(int i=0;i<appointmentListArray.count;i++)
             {
                 starttime=[[appointmentListArray objectAtIndex: i] objectForKey:@"startTime"];
                 endtime=[[appointmentListArray objectAtIndex: i] objectForKey:@"endTime"];
                 isAvail =[[appointmentListArray objectAtIndex: i] objectForKey:@"isAvailable"];
                 
                 str = [@[[self Convert24FormatTo12Format:[[appointmentListArray objectAtIndex: i] objectForKey:@"startTime"]], [self Convert24FormatTo12Format:[[appointmentListArray objectAtIndex: i] objectForKey:@"endTime"]]] componentsJoinedByString:@"-"];
                 NSLog(@"STRINGTIME%@",str);
                 [dataSource addObject: str];
                
             }
             
             
             [self.PickerView reloadAllComponents];
             //_appointmentTableView.hidden=NO;
             //[_appointmentTableView reloadData];
             [_calendarBackView setHidden:YES];
             _pickerBackView.hidden=YES;
             _PickerView.hidden=YES;
             
              [self stopLoadingIndicator];
         }else if(statusCode==404){
            
             [self stopLoadingIndicator];
             _alert = [UIAlertController
                       alertControllerWithTitle:@""
                       message:[[GlobalFunction sharedInstance].arrayOfAlerts objectAtIndex:86]
                       preferredStyle:UIAlertControllerStyleAlert];
             
             UIAlertAction* okButton = [UIAlertAction
                                        actionWithTitle:@"OK"
                                        style:UIAlertActionStyleDefault
                                        handler:^(UIAlertAction * action) {
                                            // [self.navigationController popViewControllerAnimated:YES];
                                        }];
             [_alert addAction:okButton];
             [self presentViewController:_alert animated:YES completion:nil];
             _calendarBackView.hidden=YES;
             _pickerBackView.hidden=YES;
             [self.dummytxt becomeFirstResponder];
             [self resignSoftKeyBoard];
             
         }else{
              [self stopLoadingIndicator];
             NSString *message;
             
             if(statusCode==403||statusCode==503){
                 
                 message=[[GlobalFunction sharedInstance].arrayOfAlerts objectAtIndex:74];
                 
             }else if(statusCode==401){
                 
                 message=[[GlobalFunction sharedInstance].arrayOfAlerts objectAtIndex:63];
                 
             }else{
                 NSDictionary *messagearray=[response objectForKey:@ "modelState"];
                 NSArray *dictValues=[messagearray allValues];
                 NSArray *msgarray=[dictValues objectAtIndex:0];
                 message=[msgarray objectAtIndex:0];
                 
             }
             
             _alert = [UIAlertController
                       alertControllerWithTitle:@""
                       message:message
                       preferredStyle:UIAlertControllerStyleAlert];
             
             UIAlertAction* okButton = [UIAlertAction
                                        actionWithTitle:@"OK"
                                        style:UIAlertActionStyleDefault
                                        handler:^(UIAlertAction * action) {
                                           
                                        }];
             [_alert addAction:okButton];
             [self presentViewController:_alert animated:YES completion:nil];
         }
         
     }];

    //Added by: Nalina
    //Added Date: 20/08/2016
    //Discription: Get appointment list service call
    
    
}

- (void)monthClick:(UITapGestureRecognizer *)recognizer {
    time=@"1";
    [self resignSoftKeyBoard];
    /*dataSource=[[NSArray alloc]initWithObjects:@"12:00 AM - 12:30 AM",
                @"12:30 AM - 1:00 AM",@"1:00 AM - 1:30 AM",@"1:30 AM -  2:00 AM",@"2:00 AM - 2:30 AM",@"2:30 AM - 3:00 AM",@"3:00 AM - 3:30 AM",@"3:30 AM - 4:00 AM",@"4:00 AM - 4:30 AM",@"4:30 AM - 5:00 AM",@"5:00 AM - 5:30 AM",@"5:30 AM - 6:00 AM",@"6:00 AM -6:30 AM",@"6:30 AM - 7:00 AM",@"7:00 AM - 7:30 AM",@"7:30 AM - 8:00 AM",@"8:00 AM - 8:30 AM",@"8:30 AM - 9:00AM",@"9:00 AM - 9:30 AM",@"9:30  AM - 10:00 AM",@"10:00 AM -10:30 AM",@"10:30 AM - 11:00 AM",@"11:00 AM -11:30AM",@"11:30 AM - 12:00 PM",@"12:00 PM - 12:30 PM",@"12:30 PM  - 1:00 PM",@"1:00 PM - 1:30 PM",@"1:30 PM  - 2:00 PM",@"2:00 PM  - 2:30 PM",@"2:30 PM - 3:00 PM",@"3:00 PM - 3:30 PM",@"3:30 PM  - 4:00 PM",@"4:00 PM  - 4:30 PM",@"4:30 PM  - 5:00 PM",@"5:00 PM  - 5:30 PM",@"5:30 PM - 6:00 PM",@"6:00 PM - 6:30 PM",@"6:30 PM - 7:00 PM",@"7:00 PM - 7:30 PM",@"7:30 PM - 8:00 PM",@"8:00 PM - 8:30 PM",@"8:30 PM - 9:00 PM",@"9:00 PM - 9:30 PM",@"9:30 PM  - 10:00 PM",@"10:00 PM - 10:30 PM",@"10:30 PM - 11:00 PM",@"11:00 PM - 11:30 PM",@"11:30 PM - 12:00 AM", nil];
    [self.PickerView reloadAllComponents];*/
    _pickerBackView.hidden=NO;
    _calendarBackView.hidden=YES;
    _PickerView.hidden=NO;
    
    //[self setBorder:_monthpickerView];
    [_TimeTxt setValue:[UIColor  colorWithRed:(112/255.0) green:(112/255.0) blue:(112/255.0) alpha:1] forKeyPath:@"_placeholderLabel.textColor"];
    _TimeTxt.placeholder=@"";
}

- (void)monthsecondClick:(UITapGestureRecognizer *)recognizer {
    time=@"2";
    [self resignSoftKeyBoard];
    /*dataSource=[[NSArray alloc]initWithObjects:@"12:00 AM - 12:30 AM",
                @"12:30 AM - 1:00 AM",@"1:00 AM - 1:30 AM",@"1:30 AM -  2:00 AM",@"2:00 AM - 2:30 AM",@"2:30 AM - 3:00 AM",@"3:00 AM - 3:30 AM",@"3:30 AM - 4:00 AM",@"4:00 AM - 4:30 AM",@"4:30 AM - 5:00 AM",@"5:00 AM - 5:30 AM",@"5:30 AM - 6:00 AM",@"6:00 AM -6:30 AM",@"6:30 AM - 7:00 AM",@"7:00 AM - 7:30 AM",@"7:30 AM - 8:00 AM",@"8:00 AM - 8:30 AM",@"8:30 AM - 9:00AM",@"9:00 AM - 9:30 AM",@"9:30 AM - 10:00 AM",@"10:00 AM -10:30 AM",@"10:30 AM - 11:00 AM",@"11:00 AM -11:30AM",@"11:30 AM - 12:00 PM",@"12:00 PM - 12:30 PM",@"12:30 PM  - 1:00 PM",@"1:00 PM - 1:30 PM",@"1:30 PM  - 2:00 PM",@"2:00 PM  - 2:30 PM",@"2:30 PM - 3:00 PM",@"3:00 PM - 3:30 PM",@"3:30 PM  - 4:00 PM",@"4:00 PM  - 4:30 PM",@"4:30 PM  - 5:00 PM",@"5:00 PM  - 5:30 PM",@"5:30 PM - 6:00 PM",@"6:00 PM - 6:30 PM",@"6:30 PM - 7:00 PM",@"7:00 PM - 7:30 PM",@"7:30 PM - 8:00 PM",@"8:00 PM - 8:30 PM",@"8:30 PM - 9:00 PM",@"9:00 PM - 9:30 PM",@"9:30 PM  - 10:00 PM",@"10:00 PM - 10:30 PM",@"10:30 PM - 11:00 PM",@"11:00 PM - 11:30 PM",@"11:30 PM - 12:00 AM", nil];
    [self.PickerView reloadAllComponents];*/
    _pickerBackView.hidden=NO;
    _calendarBackView.hidden=YES;
    _PickerView.hidden=NO;
    
    //[self setBorder:_monthpickerView];
    [_SecondTimeTxt setValue:[UIColor  colorWithRed:(112/255.0) green:(112/255.0) blue:(112/255.0) alpha:1] forKeyPath:@"_placeholderLabel.textColor"];
    _SecondTimeTxt.placeholder=@"";
}

- (void)monthsthirdClick:(UITapGestureRecognizer *)recognizer {
    time=@"3";
    [self resignSoftKeyBoard];
   /* dataSource=[[NSArray alloc]initWithObjects:@"12:00 AM - 12:30 AM",
                @"12:30 AM - 1:00 AM",@"1:00 AM - 1:30 AM",@"1:30 AM -  2:00 AM",@"2:00 AM - 2:30 AM",@"2:30 AM - 3:00 AM",@"3:00 AM - 3:30 AM",@"3:30 AM - 4:00 AM",@"4:00 AM - 4:30 AM",@"4:30 AM - 5:00 AM",@"5:00 AM - 5:30 AM",@"5:30 AM - 6:00 AM",@"6:00 AM -6:30 AM",@"6:30 AM - 7:00 AM",@"7:00 AM - 7:30 AM",@"7:30 AM - 8:00 AM",@"8:00 AM - 8:30 AM",@"8:30 AM - 9:00AM",@"9:00 AM - 9:30 AM",@"9:30  AM - 10:00 AM",@"10:00 AM -10:30 AM",@"10:30 AM - 11:00 AM",@"11:00 AM -11:30AM",@"11:30 AM - 12:00 PM",@"12:00 PM - 12:30 PM",@"12:30 PM  - 1:00 PM",@"1:00 PM - 1:30 PM",@"1:30 PM  - 2:00 PM",@"2:00 PM  - 2:30 PM",@"2:30 PM - 3:00 PM",@"3:00 PM - 3:30 PM",@"3:30 PM  - 4:00 PM",@"4:00 PM  - 4:30 PM",@"4:30 PM  - 5:00 PM",@"5:00 PM  - 5:30 PM",@"5:30 PM - 6:00 PM",@"6:00 PM - 6:30 PM",@"6:30 PM - 7:00 PM",@"7:00 PM - 7:30 PM",@"7:30 PM - 8:00 PM",@"8:00 PM - 8:30 PM",@"8:30 PM - 9:00 PM",@"9:00 PM - 9:30 PM",@"9:30 PM  - 10:00 PM",@"10:00 PM - 10:30 PM",@"10:30 PM - 11:00 PM",@"11:00 PM - 11:30 PM",@"11:30 PM - 12:00 AM", nil];
    [self.PickerView reloadAllComponents];*/
    _pickerBackView.hidden=NO;
    _calendarBackView.hidden=YES;
    _PickerView.hidden=NO;
    
    //[self setBorder:_monthpickerView];
    [_ThirdTimeTxt setValue:[UIColor  colorWithRed:(112/255.0) green:(112/255.0) blue:(112/255.0) alpha:1] forKeyPath:@"_placeholderLabel.textColor"];
    _ThirdTimeTxt.placeholder=@"";
}



- (void)handleSingleTapped:(UITapGestureRecognizer *)recognizer {
    _pickerBackView.hidden=NO;
    [self showCalendar];
    [self resignSoftKeyBoard];
    //[self viewDidAppear:YES];
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
    [_PickerView selectRow:0 inComponent:0 animated:YES];
    if([time isEqualToString:@"2"]){
         [appointmentListArray objectAtIndex:row];
         [_SecondTimeTxt setText:[dataSource objectAtIndex:row]];
        [self.dummytxt becomeFirstResponder];
        [self resignSoftKeyBoard];
        
    }else if ([time isEqualToString:@"3"]){
         [appointmentListArray objectAtIndex:row];
         [_ThirdTimeTxt setText:[dataSource objectAtIndex:row]];
        [self.dummytxt becomeFirstResponder];
        [self resignSoftKeyBoard];
    }else {
         [appointmentListArray objectAtIndex:row];
     [_TimeTxt setText:[dataSource objectAtIndex:row]];
        [self.dummytxt becomeFirstResponder];
        [self resignSoftKeyBoard];
    }
    _pickerBackView.hidden=YES;
    
    [self resignSoftKeyBoard];
}

//To hide all input fields keypad
-(void)resignSoftKeyBoard{
    [_DateTxt resignFirstResponder];
    [_TimeTxt resignFirstResponder];
    [_SecondDateTxt resignFirstResponder];
    [_SecondTimeTxt resignFirstResponder];
    [_ThirdDateTxt resignFirstResponder];
    [_ThirdTimeTxt resignFirstResponder];
    [_dummytxt resignFirstResponder];
}


-(NSString *)Convert12FormatTo24Format:(NSString *)timeS{
    NSString *HourString;
    if (![timeS isEqualToString:@""]) {
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"hh:mm a"];
        NSDate *amPmDate = [formatter dateFromString:timeS];
        [formatter setDateFormat:@"HH:mm"];
        HourString = [formatter stringFromDate:amPmDate];
    }else{
        HourString = @"";
    }
    
    return HourString;
}

-(void) setBorderColor:(int)tagName{
    UIButton *cancelBtn = (UIButton *) [self.view viewWithTag:tagName];
    cancelBtn.layer.borderColor = [UIColor colorWithRed:246.0/255.0 green:108.0/255.0 blue:118.0/255.0 alpha:1].CGColor;
}

- (IBAction)seconddateclick:(id)sender {
    date=@"2";
   [self showCalendar];
}

- (IBAction)thirddateclick:(id)sender {
    date=@"3";
[self showCalendar];
}

- (IBAction)SecondDateBtn:(id)sender {
    date=@"2";
     [self showCalendar];
}

- (IBAction)SecondDateClick:(id)sender {
    date=@"2";
    [self showCalendar];
}
- (IBAction)FirstDateBtn:(id)sender {
     [self showCalendar];
}
- (void)calenderClick:(UITapGestureRecognizer *)recognizer {
    [self showCalendar];
    [self resignSoftKeyBoard];
}
- (void)calenderoneClick:(UITapGestureRecognizer *)recognizer {
    [self showsecondCalendar];
    [self resignSoftKeyBoard];
    
}

- (void)calendertwoClick:(UITapGestureRecognizer *)recognizer {
    [self showthirdCalendar];
      [self resignSoftKeyBoard];
}

//Discription: To convert 24 hour format time into 12 hour format

-(NSString *)Convert24FormatTo12Format:(NSString *)timeR{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"HH:mm:ss"];
    
    NSDate *amPmDate = [formatter dateFromString:timeR];
    [formatter setDateFormat:@"hh:mm a"];
    
    NSString *HourString = [formatter stringFromDate:amPmDate];
    return HourString;
}

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
//  Added Date:2016-10-08.
//  Description:To stop the activity indicator.

-(void)stopLoadingIndicator
{
    _loadingView.hidden=YES;
}




@end
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


