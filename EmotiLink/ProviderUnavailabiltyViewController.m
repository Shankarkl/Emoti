//
//  ProviderUnavailabiltyViewController.m
//  EmotiLink
//
//  Created by Starsoft on 2017-04-19.
//  Copyright © 2017 Stark. All rights reserved.
//

#import "ProviderUnavailabiltyViewController.h"
#import <THCalendarDatePicker/THDatePickerViewController.h>
#import <CoreGraphics/CoreGraphics.h>
#import "CKCalendarView.h"
#import "GlobalFunction.h"
#import "AppDelegate.h"
#import <Google/Analytics.h>

@interface ProviderUnavailabiltyViewController ()

/*@property (nonatomic, retain) NSDate * curDate;
 @property (nonatomic, retain) NSDateFormatter * formatter;*/

@property (nonatomic, retain) NSDate * curDate;
@property (nonatomic, retain) NSDateFormatter * formatter;
@property(nonatomic, weak) CKCalendarView *calendar;

@property(nonatomic, strong) NSDateFormatter *dateFormatter;
@property(nonatomic, strong) NSDate *minimumDate;
@property(nonatomic, strong) NSArray *disabledDates;

@end

@implementation ProviderUnavailabiltyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setBorderColor:5];
    
    
    UIButton *UncancelBtn = (UIButton *) [self.view viewWithTag:7];
    UncancelBtn.layer.borderColor = [UIColor colorWithRed:246.0/255.0 green:108.0/255.0 blue:118.0/255.0 alpha:1].CGColor;
    
    UIButton *cancelBtn = (UIButton *) [self.view viewWithTag:10];
    cancelBtn.layer.borderColor = [UIColor colorWithRed:246.0/255.0 green:108.0/255.0 blue:118.0/255.0 alpha:1].CGColor;

    
    
    _dumytextfield.hidden = YES;
    // Do any additional setup after loading the view.
    UITapGestureRecognizer *singleFingerTap =
    [[UITapGestureRecognizer alloc] initWithTarget:self
                                            action:@selector(handleSingleTapped:)];
    [self.dateSeletTxt addGestureRecognizer:singleFingerTap];
    
    self.curDate = [NSDate date];
    //[self showCalendar];
    
    _fulldayUnavilablitypopView.hidden = YES;
    _providerTimeAvailablitypop.hidden = YES;
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
    
    _screenStatus=@"LimitedDays";
    
    
    
    
    
    [self.timeFromTxt addTarget:self action:@selector(monthClick:) forControlEvents:UIControlEventEditingDidBegin];
    
    [self.timeToTxt addTarget:self action:@selector(toTimeClick:) forControlEvents:UIControlEventEditingDidBegin];
    
    [self.timeFromTxt addTarget:self action:@selector(monthClick:) forControlEvents:UIControlEventEditingDidBegin];
    
    [self.timeToTxt addTarget:self action:@selector(toTimeClick:) forControlEvents:UIControlEventEditingDidBegin];
    
}



- (void)monthClick:(UITapGestureRecognizer *)recognizer {
    [self resignSoftKeyboard];
    dataSource=[[NSArray alloc]initWithObjects:@"12:00 AM",
                @"12:30 AM",@"1:00 AM",@"1:30 AM",@"2:00 AM",@"2:30 AM",@"3:00 AM",@"3:30 AM",@"4:00 AM",@"4:30 AM",@"5:00 AM",@"5:30 AM",@"6:00 AM",@"6:30 AM",@"7:00 AM",@"7:30 AM",@"8:00 AM",@"8:30 AM",@"9:00 AM",@"9:30  AM",@"10:00 AM",@"10:30 AM",@"11:00 AM",@"11:30 AM",@"12:00 PM",@"12:30 PM",@"1:00 PM",@"1:30 PM",@"2:00 PM",@"2:30 PM",@"3:00 PM",@"3:30 PM",@"4:00 PM",@"4:30 PM",@"5:00 PM",@"5:30 PM",@"6:00 PM",@"6:30 PM",@"7:00 PM",@"7:30 PM",@"8:00 PM",@"8:30 PM",@"9:00 PM",@"9:30 PM",@"10:00 PM",@"10:30 PM",@"11:00 PM",@"11:30 PM", nil];
    [self.pickerView reloadAllComponents];
    _pickerBackView.hidden=NO;
    clickedbutton=@"FromTime";
    [self setBorder:_pickerView];
    [_timeFromTxt setValue:[UIColor  colorWithRed:(112/255.0) green:(112/255.0) blue:(112/255.0) alpha:1] forKeyPath:@"_placeholderLabel.textColor"];
    _timeFromTxt.placeholder=@"";
    [self.dumytextfield becomeFirstResponder];
    [self resignSoftKeyboard];
}

- (void)toTimeClick:(UITapGestureRecognizer *)recognizer {
    [self resignSoftKeyboard];
    dataSource=[[NSArray alloc]initWithObjects:@"12:00 AM",
                @"12:30 AM",@"1:00 AM",@"1:30 AM",@"2:00 AM",@"2:30 AM",@"3:00 AM",@"3:30 AM",@"4:00 AM",@"4:30 AM",@"5:00 AM",@"5:30 AM",@"6:00 AM",@"6:30 AM",@"7:00 AM",@"7:30 AM",@"8:00 AM",@"8:30 AM",@"9:00 AM",@"9:30  AM",@"10:00 AM",@"10:30 AM",@"11:00 AM",@"11:30 AM",@"12:00 PM",@"12:30 PM",@"1:00 PM",@"1:30 PM",@"2:00 PM",@"2:30 PM",@"3:00 PM",@"3:30 PM",@"4:00 PM",@"4:30 PM",@"5:00 PM",@"5:30 PM",@"6:00 PM",@"6:30 PM",@"7:00 PM",@"7:30 PM",@"8:00 PM",@"8:30 PM",@"9:00 PM",@"9:30 PM",@"10:00 PM",@"10:30 PM",@"11:00 PM",@"11:30 PM", nil];
    [self.pickerView reloadAllComponents];
    _pickerBackView.hidden=NO;
    clickedbutton=@"totime";
    [_timeToTxt setValue:[UIColor  colorWithRed:(112/255.0) green:(112/255.0) blue:(112/255.0) alpha:1] forKeyPath:@"_placeholderLabel.textColor"];
    _timeToTxt.placeholder=@"";
    [self.dumytextfield becomeFirstResponder];
    [self resignSoftKeyboard];
}


- (void)handleSingleTapped:(UITapGestureRecognizer *)recognizer {
    [self.dumytextfield becomeFirstResponder];
    _calendarView.hidden=YES;
    [self resignSoftKeyboard];
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
    [tracker set:kGAIScreenName value:@"ProviderUnAvailability"];
    [tracker send:[[GAIDictionaryBuilder createScreenView] build]];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)cancel:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)Save:(id)sender {
    _fulldayUnavilablitypopView.hidden = NO;
    
}

- (IBAction)backArrowClick:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)showCalendar
{
    [_calendarView setHidden:NO];
    
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
    
    thisRect.origin.y =((self.calendarView.frame.size.height-_datePicker.view.frame.size.height)/2);
    thisRect.origin.x = ((self.calendarView.frame.size.width-_datePicker.view.frame.size.width)/2);
    
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
    
    /*   [self.datePicker setCurrentDateColor:[UIColor colorWithRed:246/255.0 green:108/255.0 blue:100/255.0 alpha:1.0]];*/
    [self.datePicker setCurrentDateColor:[UIColor colorWithRed:200/255.0 green:121/255.0 blue:100/255.0 alpha:1.0]];
    
    [self.datePicker setAllowMultiDaySelection:YES];
    [self.datePicker setDisableYearSwitch:TRUE];
    [self.datePicker setDateHasItemsCallback:^BOOL(NSDate *date) {
        int tmp = (arc4random() % 30)+1;
        if(tmp % 5 == 0)
            return YES;
        return NO;
    }];
    
    [self addChildViewController:_datePicker];
    [self.calendarView addSubview:_datePicker.view];
    [_datePicker didMoveToParentViewController:self];
    
    NSString *month= [_datePicker getMonthValue];
    
    NSString *monthString = [[month componentsSeparatedByString:@" "] objectAtIndex:0];
    NSString *yearString = [[month componentsSeparatedByString:@" "] objectAtIndex:1];
    
    NSDateFormatter* formatterMonth = [[NSDateFormatter alloc] init];
    [formatterMonth setDateFormat:@"MMM"];
    NSDate *aDate = [formatterMonth dateFromString:monthString];
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitMonth fromDate:aDate];
    [self callService:[components month]:[yearString integerValue]];
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
    
    /*_timeFromText.text=@"";
     _timeToText.text=@"";
     _secondTimeFromText.text=@"";
     _secondTimeToText.text=@"";
     _thirdTimeFromText.text=@"";
     _thirdTimeToText.text=@"";
     _fourthTomeFromText.text=@"";
     _fourthTimeToText.text=@"";
     _fifthTimeFromText.text=@"";
     _fifthTimeToText.text=@"";*/
    
    //if([_screenStatus isEqualToString:@"LimitedDays"]){
    
    //_popupBackView.hidden=YES;
    
    /*}
     else
     {
     _popupBackView.hidden=NO;
     [_contentScrollView setContentOffset:CGPointMake(_contentScrollView.frame.origin.x, -7) animated:YES];
     count=0;
     _timePickerView.hidden=YES;
     
     }*/
}

- (IBAction)fullDayUnavailablityNoBtn:(id)sender {
    _fulldayUnavilablitypopView.hidden = YES;
}

- (IBAction)fullDayUnavaliablityYesBtn:(id)sender {
    //service Call
    _screenStatus=@"LimitedDays";
    [self postServiceCall];
    _fulldayUnavilablitypopView.hidden = YES;
}
- (IBAction)fullDayUnAvaailablityTimeBtn:(id)sender {
    
    _fulldayUnavilablitypopView.hidden = YES;
    _screenStatus=@"LimitedHours";
    _providerTimeAvailablitypop.hidden = NO;
    
}
- (IBAction)providerTimeCancelBtn:(id)sender {
    _screenStatus=@"LimitedDays";
    _providerTimeAvailablitypop.hidden = YES;
}

- (IBAction)providerTimeConfirmBtn:(id)sender {
    //Service call
    _screenStatus=@"LimitedHours";
    _providerTimeAvailablitypop.hidden = YES;
    
    if([_timeFromTxt.text isEqualToString:@""] || [_timeToTxt.text isEqualToString:@""] ){
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
        //UIViewController *top = [self topMostController];
        [self presentViewController:_alertView animated:YES completion: nil];
        return;
    }
    
    else{
        NSMutableDictionary *dict=[[NSMutableDictionary alloc]init];
        
        NSDateFormatter *format = [[NSDateFormatter alloc] init];
        format.dateFormat = @"MM-dd-yyyy";
        
        NSDateFormatter *dtformat = [[NSDateFormatter alloc] init];
        dtformat.dateFormat = @"MM-dd-yyyy hh:mm a";
        
        
        [_formatter setDateFormat:@"YYYY-MM-dd"];
        //[self.selectedDates addObject:];
        
        
        
        if(![_timeFromTxt.text isEqualToString:@""] || ![_timeToTxt.text isEqualToString:@""])
        {
            if(![_timeFromTxt.text isEqualToString:@""] && ![_timeToTxt.text isEqualToString:@""])
            {
                if ([[self convertTimeFormat:_timeFromTxt.text] compare:[self convertTimeFormat:_timeToTxt.text]] == NSOrderedDescending || [[self convertTimeFormat:_timeFromTxt.text] compare:[self convertTimeFormat:_timeToTxt.text]] == NSOrderedSame) {
                    _timeFromTxt.text=@"";
                    [self ShowAlert:[[GlobalFunction sharedInstance].arrayOfAlerts objectAtIndex:90]];
                    //_popupBackView.hidden=NO;
                    return;
                    
                }
                else
                {
                    
                    
                    dict=[[NSMutableDictionary alloc]init];
                    //[dict setObject:[format stringFromDate:[_selectedDates objectAtIndex:_selectedDates.count-1]]  forKey:@"endTime"];
                    [dict setObject:[NSString stringWithFormat:@"%@",[NSString stringWithFormat:@"%@ %@",[_formatter stringFromDate:[_selectedDates objectAtIndex:_selectedDates.count-1]],[[GlobalFunction sharedInstance]Convert12FormatTo24Format:_timeFromTxt.text]]] forKey:@"startTime"];
                    [dict setObject:[NSString stringWithFormat:@"%@",[NSString stringWithFormat:@"%@ %@",[_formatter stringFromDate:[_selectedDates objectAtIndex:_selectedDates.count-1]],[[GlobalFunction sharedInstance]Convert12FormatTo24Format:_timeToTxt.text]]] forKey:@"endTime"];
                    
                    
                    [dict setObject:@"false" forKey:@"isWholeDay"];
                    [arrayTime addObject:dict];
                    //_popupBackView.hidden=YES;
                }
            }
            else{
                [self ShowAlert:[[GlobalFunction sharedInstance].arrayOfAlerts objectAtIndex:106]];
                //_popupBackView.hidden=NO;
            }
        }
        
        // arrayTime=array;
        
    }
    
    [self postServiceCall];
    
}

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

-(void) postServiceCall{
    
    if([_screenStatus isEqualToString:@"LimitedDays"])
    {
        
        if (_selectedDates.count<=0) {
            [self ShowAlert:[[GlobalFunction sharedInstance].arrayOfAlerts objectAtIndex:105]];
        }
    }
    else{
        if (arrayTime.count<=0)
        {
            [self ShowAlert:[[GlobalFunction sharedInstance].arrayOfAlerts objectAtIndex:105]];
        }
    }
    
    NSMutableArray *array=[[NSMutableArray alloc]init];
    NSMutableDictionary *dict=[[NSMutableDictionary alloc]init];
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    format.dateFormat = @"MM-dd-yyyy HH:mm:ss";
    // NSString *mm= [format stringFromDate:[_selectedDates objectAtIndex:0]];
    // NSString *mm1= [format stringFromDate:[_selectedDates objectAtIndex:1]];
    @autoreleasepool {
        
        for(int i=0;i<_selectedDates.count;i++)
        {
            dict=[[NSMutableDictionary alloc]init];
            
            if([_screenStatus isEqualToString:@"LimitedDays"]){
                [dict setObject:[format stringFromDate:[_selectedDates objectAtIndex:i]]  forKey:@"startTime"];
                [dict setObject:[format stringFromDate:[_selectedDates objectAtIndex:i]]  forKey:@"endTime"];
                [dict setObject:@"true" forKey:@"isWholeDay"];
                [array addObject:dict];
                
            }
            else{
                array=arrayTime;
                
            }
        }
    }
    
    NSMutableDictionary *dictionary=[array mutableCopy];
    AppDelegate *appdelegate=(AppDelegate *)[[UIApplication sharedApplication]delegate];
    NSString *Url=[appdelegate.serviceURL stringByAppendingString:@"/api/Provider/CustomAvailability"];
    [self startLoadingIndicator];
    [[GlobalFunction sharedInstance]getServerResponseAfterLogin:Url method:@"POST" param:dictionary withCallback:^(NSInteger statusCode, NSDictionary *response, NSError *error) {
        if(statusCode == 200)
        {
            
            NSString *message=[[GlobalFunction sharedInstance].arrayOfAlerts objectAtIndex:102];
            
            _alertView = [UIAlertController
                          alertControllerWithTitle:@""
                          message:message
                          preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction* okButton = [UIAlertAction
                                       actionWithTitle:@"OK"
                                       style:UIAlertActionStyleDefault
                                       handler:^(UIAlertAction * action) {
                                           [self stopLoadingIndicator];
                                           //[self.navigationController popViewControllerAnimated:YES];
                                           [self dismissViewControllerAnimated:YES completion:nil];
                                       }];
            [_alertView addAction:okButton];
            //UIViewController *top = [self topMostController];
            [self presentViewController:_alertView animated:YES completion: nil];
        }
        else{
            NSString *message;
            
            if(statusCode==403||statusCode==503||statusCode == 404){
                
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
                                           [self stopLoadingIndicator];
                                           [self.navigationController popViewControllerAnimated:YES];
                                           
                                       }];
            [_alertView addAction:okButton];
            //UIViewController *top = [self topMostController];
            [self presentViewController:_alertView animated:YES completion: nil];
        }
        
    }];
    
    
}


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
    [_timeFromTxt resignFirstResponder];
    [_timeToTxt resignFirstResponder];
    [_dumytextfield resignFirstResponder];
    
}

//  Added by:Zeenath
//  Added Date:2016-24-08.
//  Description:To stop the activity indicator.

-(void)stopLoadingIndicator
{
    _loadingView.hidden=YES;
}

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
            //UIViewController *top = [self topMostController];
            [self presentViewController:_alertView animated:YES completion: nil];
        }
        
    }];
    
    
    
}

//Return number of section in picker
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)thePickerView {
    
    return 1;
}

//Return the number of rows count to display in picker
- (NSInteger)pickerView:(UIPickerView *)thePickerView numberOfRowsInComponent:(NSInteger)component {
    
    return dataSource.count;
    
}
-(void)setBorder:(UIView *)img
{
    
    img.layer.borderColor = [[UIColor colorWithRed:228.0/255.0 green:109.0/255.0 blue:175.0/255.0 alpha:1.0]CGColor];
    img.layer.borderWidth = 1.0f;
    
}



//Return the data to display in picker
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:
(NSInteger)row forComponent:(NSInteger)component{
    return [dataSource objectAtIndex:row];
    [self.dumytextfield becomeFirstResponder];
}

//Returns selected picker data
- (void)pickerView:(UIPickerView *)thePickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    [_pickerView selectRow:0 inComponent:0 animated:YES];
    
    
    if([clickedbutton isEqualToString:@"FromTime"])
    {
        [_timeFromTxt setText:[dataSource objectAtIndex:row]];
        [self.dumytextfield becomeFirstResponder];
        
    }
    
    else if([clickedbutton isEqualToString:@"totime"]){
        [_timeToTxt setText:[dataSource objectAtIndex:row]];
        [self.dumytextfield becomeFirstResponder];
    }
    
    _pickerBackView.hidden=YES;
    [self resignSoftKeyboard];
    
}

-(void) setBorderColor:(int)tagName{
    UIButton *cancelBtn = (UIButton *) [self.view viewWithTag:tagName];
    cancelBtn.layer.borderColor = [UIColor colorWithRed:246.0/255.0 green:108.0/255.0 blue:118.0/255.0 alpha:1].CGColor;
}


@end
