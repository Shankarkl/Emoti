/***************************************************************
 Page name: MakeAnAppointmentViewController.m
 Created By:Nalina
 Created Date:2016-07-14
 Description:make an appointment view controller implementation Screen.
 ***************************************************************/


#import "MakeAnAppointmentViewController.h"
#import "MakeAnAppointmentTableViewCell.h"
#import "CKCalendarView.h"
#import "AppDelegate.h"
#import "GlobalFunction.h"
#import "ToggleButton.h"
#import "AppointmentConfirmationViewController.h"
#import <CoreGraphics/CoreGraphics.h>
#import <Google/Analytics.h>
#import <THCalendarDatePicker/THDatePickerViewController.h>

@interface MakeAnAppointmentViewController ()
@property (nonatomic, retain) NSDate * curDate;
@property (nonatomic, retain) NSDateFormatter * formatter;
@property(nonatomic, weak) CKCalendarView *calendar;

@property(nonatomic, strong) NSDateFormatter *dateFormatter;
@property(nonatomic, strong) NSDate *minimumDate;
@property(nonatomic, strong) NSArray *disabledDates;

@end

@implementation MakeAnAppointmentViewController

//Loads when page appears for the first time
- (void)viewDidLoad {
    estimation=@"1";
    NSLog(@"previouspAGE 1 = %@",_postScheduleDetails);
    
    [self setBorderColor:2];
    [self setBorderColor:1];
    
    appointmentListArray = [NSMutableArray array];
    sendAppointmentData=[NSMutableDictionary dictionary];
    sendAppointmentData=[_postScheduleDetails mutableCopy];
    
    NSLog(@"previouspAGE = %@",[sendAppointmentData objectForKey:@"providerID"] );
    
    self.curDate = [NSDate date];
    self.formatter = [[NSDateFormatter alloc] init];
    [_formatter setDateFormat:@"dd/MM/yyyy --- HH:mm"];
    [super viewDidLoad];
    
    UITapGestureRecognizer *singleFingerTap =
    [[UITapGestureRecognizer alloc] initWithTarget:self
                                            action:@selector(handleSingleTapped:)];
    UITapGestureRecognizer *singleFingertwoTap =
    [[UITapGestureRecognizer alloc] initWithTarget:self
                                            action:@selector(handleSingleTappednew:)];
   // [self.dateTxt addGestureRecognizer:singleFingerTap];
    [self.dateTxt addTarget:self action:@selector(calenderClick:) forControlEvents:UIControlEventEditingDidBegin];
      [self.Selectseconddate addGestureRecognizer:singleFingertwoTap];
    [self.timeTxt addTarget:self action:@selector(monthClick:) forControlEvents:UIControlEventEditingDidBegin];
    [self.secontimeTxt addTarget:self action:@selector(monthsecondClick:) forControlEvents:UIControlEventEditingDidBegin];
    
}


-(void) setBorderColor:(int)tagName{
    UIButton *cancelBtn = (UIButton *) [self.view viewWithTag:tagName];
    cancelBtn.layer.borderColor = [UIColor colorWithRed:246.0/255.0 green:108.0/255.0 blue:118.0/255.0 alpha:1].CGColor;
}

//Loads each time when page loaded completely
-(void)viewDidAppear:(BOOL)animated
{
    //if ([_screenStatus isEqualToString:@"appointment"]) {
    [self showCalendar];
    //}
    _postMakeAppointmentData=[NSMutableArray array];
    _postScheduleDetails=[NSMutableDictionary dictionary];
    
    detectFirstTime=0;
    deselectItem=0;
    [_appointmentTableView reloadData];
    self.appointmentTableView.delegate = self;
    
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

//Loads each time when page appears
-(void)viewWillAppear:(BOOL)animated
{
    id<GAITracker> tracker = [[GAI sharedInstance] defaultTracker];
    [tracker set:kGAIScreenName value:@"MakeAnAppointment"];
    [tracker send:[[GAIDictionaryBuilder createScreenView] build]];
}

//Return the number of section in table view
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

//Return the number of rows in table view
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return appointmentListArray.count;
}

//Return the data to display in table view and the table cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //  Added by:Nalina
    //  Added Date:2016-10-08.
    //  Description: Display data from the service in cell
    MakeAnAppointmentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"appointmentCell" forIndexPath:indexPath];
    
    NSDictionary *myJsonResponseIndividualElement = appointmentListArray[indexPath.row];
    cell.timeLabel.text=myJsonResponseIndividualElement[@"date"];
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    NSString *available=myJsonResponseIndividualElement[@"isAvailable"];
    
    if([available isEqual:[NSNumber numberWithInt:0]]){
        cell.backgroundColor=[UIColor  colorWithRed:(192/255.0) green:(192/255.0) blue:(192/255.0) alpha:1];
    }else{
        cell.backgroundColor=[UIColor  colorWithRed:(239/255.0) green:(239/255.0) blue:(239/255.0) alpha:1];
    }
    if ([_screenStatus isEqualToString:@"appointment"]) {
        
    }else{
        _screenStatus=@"appointment";
        _postScheduleDetails=nil;
        UIColor *cellColor=[UIColor  colorWithRed:(228/255.0) green:(109/255.0) blue:(175/255.0) alpha:1];
        if ([cell.backgroundColor isEqual:cellColor]) {
            cell.backgroundColor=[UIColor  colorWithRed:(239/255.0) green:(239/255.0) blue:(239/255.0) alpha:1];
        }
    }
    @autoreleasepool {
        
        for(int i=0;i<_postMakeAppointmentData.count;i++)
        {
            NSMutableDictionary *dict=[_postMakeAppointmentData objectAtIndex:i];
            if([myJsonResponseIndividualElement[@"date"] isEqualToString:[dict objectForKey:@"date"]])
            {
                cell.backgroundColor=[UIColor  colorWithRed:(228/255.0) green:(109/255.0) blue:(175/255.0) alpha:1];
            }else{
                cell.selected=false;
            }
            
        }
    }
    return cell;
}


//  Added by:Nalina
//  Added Date:2016-10-08.
//  Description: Returns the Deselected row when user clicks on perticular row

//  Commented by:Nalina
//  Commented Date:2016-19-09.
//  Description: To allow multiple selection now no need of deselcting row

/*-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath{
 
 NSDictionary *myJsonResponseIndividualElement = appointmentListArray[indexPath.row];
 NSString *available=myJsonResponseIndividualElement[@"isAvailable"];
 
 if([available isEqual:[NSNumber numberWithInt:1]]){
 MakeAnAppointmentTableViewCell *selectedCell = [tableView cellForRowAtIndexPath:indexPath];
 selectedCell.backgroundColor=[UIColor  colorWithRed:(239/255.0) green:(239/255.0) blue:(239/255.0) alpha:1];
 }
 }*/


//  Added by:Nalina
//  Added Date:2016-10-08.
//  Description:Called whenever a table cell is clicked.


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // GlobalFunction *globalValues=[[GlobalFunction alloc]init];
    
    NSDictionary *myJsonResponseIndividualElement = appointmentListArray[indexPath.row];
    NSString *available=myJsonResponseIndividualElement[@"isAvailable"];
    
    if([available isEqual:[NSNumber numberWithInt:1]]){
        
        UIColor *cellColor=[UIColor  colorWithRed:(228/255.0) green:(109/255.0) blue:(175/255.0) alpha:1];
        NSString *endTimeCheck;
        MakeAnAppointmentTableViewCell *selectedCell = [tableView cellForRowAtIndexPath:indexPath];
        
        if ([selectedCell.backgroundColor isEqual:cellColor]) {
            @autoreleasepool {
                
                for(int i=0;i<_postMakeAppointmentData.count;i++)
                {
                    if(_postMakeAppointmentData.count>0){
                        NSMutableDictionary *dict=[_postMakeAppointmentData objectAtIndex:i];
                        if([myJsonResponseIndividualElement[@"startTime"] isEqualToString:[dict objectForKey:@"scheduledStartTime"]])
                        {
                            if(i==_postMakeAppointmentData.count-1){
                                [_postMakeAppointmentData removeObject:dict];
                                selectedCell.backgroundColor=[UIColor  colorWithRed:(239/255.0) green:(239/255.0) blue:(239/255.0) alpha:1];
                                deselectItem=1;
                                return;
                            }else{
                                
                                _alert = [UIAlertController
                                          alertControllerWithTitle:@""
                                          message:[[GlobalFunction sharedInstance].arrayOfAlerts objectAtIndex:126]
                                          preferredStyle:UIAlertControllerStyleAlert];
                                
                                UIAlertAction* yesButton = [UIAlertAction
                                                            actionWithTitle:@"OK"
                                                            style:UIAlertActionStyleDefault
                                                            handler:^(UIAlertAction * action) {
                                                                
                                                            }];
                                
                                [_alert addAction:yesButton];
                                [self presentViewController:_alert animated:YES completion:nil];
                                return;
                            }
                            /*  for(int k=i;k<_postMakeAppointmentData.count;k++)
                             
                             {
                             // MakeAnAppointmentTableViewCell *selectCell = [tableView cellForRowAtIndexPath:[_postMakeAppointmentData objectAtIndex:k]];
                             // NSLog(@"selectedCell data=%@",selectedCell);
                             // selectCell.backgroundColor=[UIColor  colorWithRed:(239/255.0) green:(239/255.0) blue:(239/255.0) alpha:1];
                             [_postMakeAppointmentData removeObject:[_postMakeAppointmentData objectAtIndex:k]];
                             
                             }
                             
                             return;*/
                        }
                    }
                }
            }
        }else{
            if(detectFirstTime!=1){
                detectFirstTime=1;
                endTimeCheck =myJsonResponseIndividualElement[@"startTime"];
            }else if(deselectItem==1){
                if(_postMakeAppointmentData.count<=0){
                    detectFirstTime=1;
                    endTimeCheck =myJsonResponseIndividualElement[@"startTime"];
                }else{
                    endTimeCheck =[[_postMakeAppointmentData objectAtIndex:_postMakeAppointmentData.count-1] objectForKey:@"scheduledEndTime"];
                }
            }else{
                endTimeCheck =[_postScheduleDetails valueForKey:@"scheduledEndTime"];
            }
            
            if ([endTimeCheck isEqual:myJsonResponseIndividualElement[@"startTime"]]) {
                deselectItem=0;
                _postScheduleDetails=[[NSMutableDictionary alloc]init];
                selectedCell.backgroundColor=[UIColor  colorWithRed:(228/255.0) green:(109/255.0) blue:(175/255.0) alpha:1];
                
                [_postScheduleDetails setObject: myJsonResponseIndividualElement[@"startTime"]forKey:@"scheduledStartTime"];
                [_postScheduleDetails setObject:myJsonResponseIndividualElement[@"endTime"]forKey:@"scheduledEndTime"];
                [_postScheduleDetails setObject:myJsonResponseIndividualElement[@"isAvailable"] forKey:@"isAvailabile"];
                [_postScheduleDetails setObject:myJsonResponseIndividualElement[@"date"] forKey:@"date"];
                
                [_postMakeAppointmentData addObject:_postScheduleDetails];
                
            }
            
        }
        
    }else{
        _alert = [UIAlertController
                  alertControllerWithTitle:@""
                  message:[[GlobalFunction sharedInstance].arrayOfAlerts objectAtIndex:107]
                  preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* okButton = [UIAlertAction
                                   actionWithTitle:@"OK"
                                   style:UIAlertActionStyleDefault
                                   handler:^(UIAlertAction * action) {
                                   }];
        [_alert addAction:okButton];
        [self presentViewController:_alert animated:YES completion:nil];
        
    }
    [_appointmentTableView deselectRowAtIndexPath:indexPath animated:YES];
    
}


//Close the page on click of back icon
- (IBAction)pageBackClick:(id)sender {
    [_postMakeAppointmentData removeAllObjects];
    _postScheduleDetails=nil;
    //[self.navigationController popViewControllerAnimated:YES];
    [self dismissViewControllerAnimated:YES completion:nil];
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

//Close the screen on click of cancel button
- (IBAction)cancelClick:(id)sender {
    [_postMakeAppointmentData removeAllObjects];
    _postScheduleDetails=nil;
    //[self.navigationController popViewControllerAnimated:YES];
    [self dismissViewControllerAnimated:YES completion:nil];
}

//  Added by: Nalina
//  Added Date:2016-20-08.
//  Description: Submit click to book an appointment service call and validation

- (IBAction)submitClick:(id)sender {
    
    NSString * mystring = _timeTxt.text;
    NSArray * array = [mystring componentsSeparatedByString:@"-"];
    NSString * str1 = [array objectAtIndex:0];
    NSString * str2 = [array objectAtIndex:1];
    NSString * str3=[self Convert12FormatTo24Format:str1];
    NSString * str4=[self Convert12FormatTo24Format:str2];
    
    
    
    if ([estimation isEqualToString:@"2"]) {
        NSString * mystring2 = _AddsessionTxt.text;
        NSArray * array2 = [mystring2 componentsSeparatedByString:@"-"];
        NSString * string1 = [array2 objectAtIndex:0];
        str2 = [array2 objectAtIndex:1];
        NSString * string3=[self Convert12FormatTo24Format:string1];
        str4=[self Convert12FormatTo24Format:str2];
    }
    str = [@[str1,str2] componentsJoinedByString:@"-"];
    
    for(int i=0;i<appointmentListArray.count;i++)
    {
        
        NSString *available =[[appointmentListArray objectAtIndex: i] objectForKey:@"isAvailable"];
        
        //GlobalFunction *globalValues=[[GlobalFunction alloc]init];
        NSLog(@"CONFIRM%@", _dateTxt.text);
        
        //Validate if user selected date or not
        if (available!=nil&&![available isEqual:@""]) {
            
            _alert = [UIAlertController
                      alertControllerWithTitle:@""
                      message:[[GlobalFunction sharedInstance].arrayOfAlerts objectAtIndex:101]
                      preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction* yesButton = [UIAlertAction
                                        actionWithTitle:@"Yes"
                                        style:UIAlertActionStyleDefault
                                        handler:^(UIAlertAction * action) {
                                            //NSMutableDictionary *starttime=[_postMakeAppointmentData objectAtIndex:0];
                                            
                                            
                                            /* [sendAppointmentData setObject:[starttime valueForKey:@"scheduledStartTime"] forKey:@"scheduledStartTime"];
                                             [sendAppointmentData setObject:[endtime valueForKey:@"scheduledEndTime"]forKey:@"scheduledEndTime"];
                                             [sendAppointmentData setObject:_dateLabel.text forKey:@"scheduledDate"];
                                             [sendAppointmentData setObject:[starttime valueForKey:@"isAvailabile"]forKey:@"isAvailabile"];
                                             [sendAppointmentData setObject:totalMin forKey:@"totalTime"];*/
                                            
                                            
                                            [sendAppointmentData setObject:str3 forKey:@"startTime"];
                                            [sendAppointmentData setObject:str4 forKey:@"endTime"];
                                            [sendAppointmentData setValue:[NSNumber numberWithBool:[[appointmentListArray objectAtIndex: i] objectForKey:@"isAvailable"]]forKey:@"isAvailable"];
                                            [sendAppointmentData setObject:str forKey:@"time"];
                                            [sendAppointmentData setObject:estimation forKey:@"estimation"];
                                            
                                            
                                            NSLog(@"APPOINTCONFIRM%@",sendAppointmentData);
                                            AppointmentConfirmationViewController *vc=[self.storyboard instantiateViewControllerWithIdentifier:@"appointmentConfirm"];
                                            vc.postScheduleDetails=sendAppointmentData;
                                            [self presentViewController:vc animated:YES completion:nil];
                                            _screenStatus=@"";
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
            _alert = [UIAlertController
                      alertControllerWithTitle:@""
                      message:[[GlobalFunction sharedInstance].arrayOfAlerts objectAtIndex:100]
                      preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction* okButton = [UIAlertAction
                                       actionWithTitle:@"OK"
                                       style:UIAlertActionStyleDefault
                                       handler:^(UIAlertAction * action) {
                                       }];
            [_alert addAction:okButton];
            [self presentViewController:_alert animated:YES completion:nil];
        }
    }
    
}

//  Added by:Zeenath
//  Added Date:2016-10-08.
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
//  Added Date:2016-10-08.
//  Description:To stop the activity indicator.

-(void)stopLoadingIndicator
{
    _loadingView.hidden=YES;
}



//Added by: Zeenath
//Added Date: 23/08/2016
//Discription: for custom calandar control
-(void)showCalendar
{
     [self resignSoftKeyBoard];
    [_calendarBackView setHidden:NO];
    _pickerBackView.hidden=NO;
    _pickerView.hidden=YES;
    
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


-(void)shownewCalendar
{
    [_calendarBackView setHidden:NO];
    _pickerBackView.hidden=NO;
    _pickerView.hidden=YES;
    
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
    secondDate=@"secondDate";
    [self addChildViewController:_datePicker];
    [self.calendarBackView addSubview:_datePicker.view];
    [_datePicker didMoveToParentViewController:self];
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
    _pickerView.hidden=YES;
    
    
    AppDelegate *appdelegate= (AppDelegate *)[[UIApplication sharedApplication]delegate];
    //   GlobalFunction *globalValues=[[GlobalFunction alloc]init];
    
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    format.dateFormat = @"MM/dd/yyyy";
    
    NSDate *currentTime=[NSDate date];
    NSDateFormatter *timeformat = [[NSDateFormatter alloc] init];
    timeformat.dateFormat = @"HH:mm";
    
    NSDateFormatter *dayformat = [[NSDateFormatter alloc] init];
    dayformat.dateFormat = @"EEE, dd MMM yyyy";
    
    [sendAppointmentData setObject:[dayformat stringFromDate:selectedDate] forKey:@"Date"];
    if([secondDate isEqualToString:@"secondDate"]){;
        _Selectseconddate.text=[dayformat stringFromDate:selectedDate];
    }else{
        _dateTxt.text=[dayformat stringFromDate:selectedDate];
    }
    
    [self resignSoftKeyBoard];
    
    //Added by: Nalina
    //Added Date: 20/08/2016
    //Discription: Get appointment list service call
    
    NSString *availableUrl=[appdelegate.serviceURL stringByAppendingString:@"api/Availability/ProviderAvailability"];
    NSMutableDictionary *availableData = [[NSMutableDictionary alloc] init];
    [availableData setObject:[sendAppointmentData objectForKey:@"providerID"] forKey:@"providerID"];
    [availableData setObject:[NSString stringWithFormat:@"%@ %@",[format stringFromDate:selectedDate],[timeformat stringFromDate:currentTime]] forKey:@"availiblityDate"];
    NSLog(@"datasenttoservice%@",availableData);
    [self startLoadingIndicator];
    [[GlobalFunction sharedInstance] getServerResponseAfterLogin:availableUrl method:@"POST" param:availableData withCallback:^(NSInteger statusCode, NSDictionary *response, NSError *error)
     {
         if (statusCode==200) {
             appointmentListArray=[response mutableCopy];
             //_appointmentTableView.hidden=NO;
             //[_appointmentTableView reloadData];
            [self.dummytxt becomeFirstResponder];
             [self resignSoftKeyBoard];
             [_calendarBackView setHidden:YES];
             _pickerBackView.hidden=YES;
             _pickerView.hidden=YES;
             
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
             
             //dataSource=[response mutableCopy];
             [self.pickerView reloadAllComponents];
             
             [self stopLoadingIndicator];
             
         }else if(statusCode==404){
             _appointmentTableView.hidden=YES;
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
             [self.dummytxt becomeFirstResponder];
             [self resignSoftKeyBoard];
             [_calendarBackView setHidden:YES];
             _pickerBackView.hidden=YES;
             _pickerView.hidden=YES;
         }else{
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
                                            [self stopLoadingIndicator];
                                        }];
             [_alert addAction:okButton];
             [self presentViewController:_alert animated:YES completion:nil];
             [self.dummytxt becomeFirstResponder];
             [self resignSoftKeyBoard];
             [_calendarBackView setHidden:YES];
             _pickerBackView.hidden=YES;
             _pickerView.hidden=YES;
         }
         
     }];
    
}

- (void)calenderClick:(UITapGestureRecognizer *)recognizer {
    [self showCalendar];
}

- (void)monthClick:(UITapGestureRecognizer *)recognizer {
   
    /*dataSource=[[NSMutableArray alloc]initWithObjects:@"12:00 AM - 12:30 AM",
     @"12:30 AM - 1:00 AM",@"1:00 AM - 1:30 AM",@"1:30 AM -  2:00 AM",@"2:00 AM - 2:30 AM",@"2:30 AM - 3:00 AM",@"3:00 AM - 3:30 AM",@"3:30 AM - 4:00 AM",@"4:00 AM - 4:30 AM",@"4:30 AM - 5:00 AM",@"5:00 AM - 5:30 AM",@"5:30 AM - 6:00 AM",@"6:00 AM -6:30 AM",@"6:30 AM - 7:00 AM",@"7:00 AM - 7:30 AM",@"7:30 AM - 8:00 AM",@"8:00 AM - 8:30 AM",@"8:30 AM - 9:00AM",@"9:00 AM - 9:30 AM",@"9:30  AM - 10:00 AM",@"10:00 AM -10:30 AM",@"10:30 AM - 11:00 AM",@"11:00 AM -11:30AM",@"11:30 AM - 12:00 PM",@"12:00 PM - 12:30 PM",@"12:30 PM  - 1:00 PM",@"1:00 PM - 1:30 PM",@"1:30 PM  - 2:00 PM",@"2:00 PM  - 2:30 PM",@"2:30 PM - 3:00 PM",@"3:00 PM - 3:30 PM",@"3:30 PM  - 4:00 PM",@"4:00 PM  - 4:30 PM",@"4:30 PM  - 5:00 PM",@"5:00 PM  - 5:30 PM",@"5:30 PM - 6:00 PM",@"6:00 PM - 6:30 PM",@"6:30 PM - 7:00 PM",@"7:00 PM - 7:30 PM",@"7:30 PM - 8:00 PM",@"8:00 PM - 8:30 PM",@"8:30 PM - 9:00 PM",@"9:00 PM - 9:30 PM",@"9:30 PM  - 10:00 PM",@"10:00 PM - 10:30 PM",@"10:30 PM - 11:00 PM",@"11:00 PM - 11:30 PM",@"11:30 PM - 12:00 AM", nil];
     [self.pickerView reloadAllComponents];*/
    //[self.dummytxt becomeFirstResponder];
     [self resignSoftKeyBoard];
    _pickerBackView.hidden=NO;
    _calendarBackView.hidden=YES;
    _pickerView.hidden=NO;
    
    
    
    //[self setBorder:_monthpickerView];
    [_timeTxt setValue:[UIColor  colorWithRed:(112/255.0) green:(112/255.0) blue:(112/255.0) alpha:1] forKeyPath:@"_placeholderLabel.textColor"];
    _timeTxt.placeholder=@"";
}
- (void)monthsecondClick:(UITapGestureRecognizer *)recognizer {
    [self resignSoftKeyBoard];
    /*dataSource=[[NSMutableArray alloc]initWithObjects:@"12:00 AM - 12:30 AM",
     @"12:30 AM - 1:00 AM",@"1:00 AM - 1:30 AM",@"1:30 AM -  2:00 AM",@"2:00 AM - 2:30 AM",@"2:30 AM - 3:00 AM",@"3:00 AM - 3:30 AM",@"3:30 AM - 4:00 AM",@"4:00 AM - 4:30 AM",@"4:30 AM - 5:00 AM",@"5:00 AM - 5:30 AM",@"5:30 AM - 6:00 AM",@"6:00 AM -6:30 AM",@"6:30 AM - 7:00 AM",@"7:00 AM - 7:30 AM",@"7:30 AM - 8:00 AM",@"8:00 AM - 8:30 AM",@"8:30 AM - 9:00AM",@"9:00 AM - 9:30 AM",@"9:30  AM - 10:00 AM",@"10:00 AM -10:30 AM",@"10:30 AM - 11:00 AM",@"11:00 AM -11:30AM",@"11:30 AM - 12:00 PM",@"12:00 PM - 12:30 PM",@"12:30 PM  - 1:00 PM",@"1:00 PM - 1:30 PM",@"1:30 PM  - 2:00 PM",@"2:00 PM  - 2:30 PM",@"2:30 PM - 3:00 PM",@"3:00 PM - 3:30 PM",@"3:30 PM  - 4:00 PM",@"4:00 PM  - 4:30 PM",@"4:30 PM  - 5:00 PM",@"5:00 PM  - 5:30 PM",@"5:30 PM - 6:00 PM",@"6:00 PM - 6:30 PM",@"6:30 PM - 7:00 PM",@"7:00 PM - 7:30 PM",@"7:30 PM - 8:00 PM",@"8:00 PM - 8:30 PM",@"8:30 PM - 9:00 PM",@"9:00 PM - 9:30 PM",@"9:30 PM  - 10:00 PM",@"10:00 PM - 10:30 PM",@"10:30 PM - 11:00 PM",@"11:00 PM - 11:30 PM",@"11:30 PM - 12:00 AM", nil];
     [self.pickerView reloadAllComponents];*/
    [self.dummytxt becomeFirstResponder];
    //[self resignSoftKeyBoard];
    _pickerBackView.hidden=NO;
    _calendarBackView.hidden=YES;
    _pickerView.hidden=NO;
    
    secondTime=@"secondTime";
    
    
    //[self setBorder:_monthpickerView];
    [_secontimeTxt setValue:[UIColor  colorWithRed:(112/255.0) green:(112/255.0) blue:(112/255.0) alpha:1] forKeyPath:@"_placeholderLabel.textColor"];
    _secontimeTxt.placeholder=@"";
}


- (void)handleSingleTapped:(UITapGestureRecognizer *)recognizer {
    _pickerBackView.hidden=NO;
    //[self showCalendar];
    [self viewDidAppear:YES];
}

- (void)handleSingleTappednew:(UITapGestureRecognizer *)recognizer {
    _pickerBackView.hidden=NO;
    [self shownewCalendar];
    // [self viewDidAppear:YES];
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
    
    [_timeTxt setText:[dataSource objectAtIndex:row]];
    
    //NSArray *array = [_timeTxt.text componentsSeparatedByString:@" "];
    [appointmentListArray objectAtIndex:row];
    
    if((dataSource.count-1)>row){
        if([[_timeTxt.text componentsSeparatedByString:@"-"] objectAtIndex:1]==[[[dataSource objectAtIndex:row+1] componentsSeparatedByString:@"-"] objectAtIndex:0]){
            [_AddsessionTxt setText:[dataSource objectAtIndex:row+1]];
            [_AddsessionTxt setEnabled:false];
        }
    }
    
    /*if (![_AddsessionTxt.text isEqualToString:@""]) {
     [_AddsessionTxt setText:[dataSource objectAtIndex:row+1]];
     }*/
    
    _pickerBackView.hidden=YES;
    [self.dummytxt becomeFirstResponder];
    [self resignSoftKeyBoard];
}

//To hide all input fields keypad
-(void)resignSoftKeyBoard{
    [_dummytxt resignFirstResponder];
    [_dateTxt resignFirstResponder];
    [_timeTxt resignFirstResponder];
    [_AddsessionTxt resignFirstResponder];
    
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
- (IBAction)addaseesion:(id)sender {
    
    //[self shownewCalendar];
    
    if(!([_AddsessionTxt.text isEqualToString:@""])){
        estimation=@"2";
        _AddsessionBtnView.hidden=YES;
        _AddsessionTxt.hidden=NO;
    }else{
        _alert = [UIAlertController
                  alertControllerWithTitle:@""
                  message:[[GlobalFunction sharedInstance].arrayOfAlerts objectAtIndex:136]
                  preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* yesButton = [UIAlertAction
                                    actionWithTitle:@"OK"
                                    style:UIAlertActionStyleDefault
                                    handler:^(UIAlertAction * action) {
                                        
                                    }];
        
        [_alert addAction:yesButton];
        [self presentViewController:_alert animated:YES completion:nil];
        
    }
}

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

- (IBAction)DatebtnClick:(id)sender {
    NSLog(@"dateclicked");
    [self showCalendar];
}

- (IBAction)DateTxt:(id)sender {
    NSLog(@"dateclicked");
    [self showCalendar];

}
@end
