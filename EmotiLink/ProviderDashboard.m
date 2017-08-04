
/***************************************************************
 Page name:ProviderDashboard.m
 Created By:Zeenath
 Created Date:18/7/16
 Description:Dashboard to show the provider information implementation file
 ***************************************************************/

#import "ProviderDashboard.h"
#import "ProviderDashboardCellTableViewCell.h"
#import "GlobalFunction.h"
#import "JoinSessionViewController.h"
#import "ScheduledAppointmentsViewController.h"
#import "FeedbackPopupSceneViewController.h"
#import "OnlineAvailabilityPopupViewController.h"
#import "AppDelegate.h"
#import "BankingInfoViewController.h"
#import "RateViewController.h"
#import "AvailabilityViewController.h"
#import "pageviewViewController.h"
#import <Google/Analytics.h>


#define appdelegate (AppDelegate *)[[UIApplication sharedApplication]delegate]
@interface ProviderDashboard ()<onlineavailpopupViewControllerDelegate>
{
    UIImage *bindimage;
}

@end


@implementation ProviderDashboard
- (void)dataFromController:(NSString *)data
{
    NSLog(@"DATARESPONSE%@",data);
    if([data isEqualToString:@"200"]){
        [_availabilityToggleBtn setImage:[UIImage imageNamed:@"available.png"] forState:UIControlStateNormal];
        _setAvailabilityText.text=@"I am available";
    }
    //bindimage = data;
    //profilePicImage.image = data;
}

int availabilityTimeSec = 0;
int availabilityTimeMin = 0;
int availabilityTimeHour=0;

//Called when the view controller is first time loaded to memory
- (void)viewDidLoad {
    UIImage *backgroundImage = [UIImage imageNamed:@"background-dashboard.png"];
    UIImageView *backgroundImageView=[[UIImageView alloc]initWithFrame:self.view.frame];
    backgroundImageView.frame = self.view.bounds;
    backgroundImageView.contentMode = UIViewContentModeScaleAspectFit;
    backgroundImageView.clipsToBounds = YES;
    backgroundImageView.image=backgroundImage;
    
    [self.view insertSubview:backgroundImageView atIndex:0];
    
    [super viewDidLoad];
    
    self.profileImage.layer.cornerRadius = self.profileImage.frame.size.width / 2;
    self.profileImage.clipsToBounds = YES;
    [self setBorder:_availableView];
    myBool=YES;
    availableTimeDict=[[NSMutableDictionary alloc]init];
    
    //Added by: Zeenath
    //Added Date: 18/08/2016
    //Discription: Bind the providers datas
    
    pickerArray = [[NSArray alloc]initWithObjects:@"Half an hour",
                   @"One hour",@"One & half hour",@"Two hours",@"Two & half hours",@"Three hours",@"Three & half hours", nil];
    
    UITapGestureRecognizer *singleFingerTap =
    [[UITapGestureRecognizer alloc] initWithTarget:self
                                            action:@selector(SetAvailableOn:)];
    [self.iAmAvailableView addGestureRecognizer:singleFingerTap];
    
    
    UITapGestureRecognizer *available =
    [[UITapGestureRecognizer alloc] initWithTarget:self
                                            action:@selector(availablePicker:)];
    [self.availableView addGestureRecognizer:available];
    
    UITapGestureRecognizer *singleFingerTapJoinSession =
    [[UITapGestureRecognizer alloc] initWithTarget:self
                                            action:@selector(handleSingleTapJoinSession:)];
    [self.joinSessionView addGestureRecognizer:singleFingerTapJoinSession];
    
    UITapGestureRecognizer *singleFingerTapscheduledAppointments =
    [[UITapGestureRecognizer alloc] initWithTarget:self
                                            action:@selector(handleSingleTapJoinSessionscheduledAppointments:)];
    [self.scheduledAppointmentsView addGestureRecognizer:singleFingerTapscheduledAppointments];
    
    
    availabilityArray = [[NSMutableArray alloc] init];
    availabilityId= [[NSMutableArray alloc] init];
    
    
    AppDelegate *app=(AppDelegate *)[[UIApplication sharedApplication]delegate];
    app.screenState=nil;
}

//called each time when the view is appeared
-(void)viewDidAppear:(BOOL)animated{
    _joinSessionView.backgroundColor=[UIColor grayColor];
    [_joinSessionView setUserInteractionEnabled:NO];
    //Added by: Nalina
    //Added Date: 25/08/2016
    //Discription: Set online availability
    
    if (self.tabBarController.selectedIndex==3) {
        [_callBackView setHidden:NO];
    }else{
        [_callBackView setHidden:YES];
    }
    
    [[[[self.tabBarController tabBar]items]objectAtIndex:1]setEnabled:TRUE];
    [[[[self.tabBarController tabBar]items]objectAtIndex:2]setEnabled:TRUE];
    [[[[self.tabBarController tabBar]items]objectAtIndex:3]setEnabled:TRUE];
    NSLog(@"providerstatus %@",[[appdelegate usersDetails] valueForKey:@"providerStatus"]);
    if([[[appdelegate usersDetails] valueForKey:@"providerStatus"] isEqual:[NSNull null]] || [[[appdelegate usersDetails ]valueForKey:@"providerStatus"] isEqual:nil])
    {
        [_availabilityToggleBtn setImage:[UIImage imageNamed:@"not-available.png"] forState:UIControlStateNormal];
        _setAvailabilityText.text=@"I am unavailable";
        
    }else{
        
        NSDictionary *appointments=[[appdelegate usersDetails] valueForKey:@"providerStatus"];
         NSLog(@"providerstatusupdated %@",[appointments valueForKey:@"isAvailbilityUpdated"]);
        if([[appointments valueForKey:@"availableFrom"] isEqual:[NSNull null]]||[[appointments valueForKey:@"availableTill"] isEqual:[NSNull null]]||[[appointments valueForKey:@"availableTill"] isEqualToString:@"notAvailable"]||[[appointments valueForKey:@"availableFrom"] isEqualToString:@"notAvailable"]){
            
            [_availabilityToggleBtn setImage:[UIImage imageNamed:@"not-available.png"] forState:UIControlStateNormal];
            _setAvailabilityText.text=@"I am unavailable";
        }else{
            
            NSString *startTimeString = [[GlobalFunction sharedInstance]Convert24FormatTo12Format:[appointments valueForKey:@"availableFrom"]];
            NSString *endTimeString = [[GlobalFunction sharedInstance]Convert24FormatTo12Format:[appointments valueForKey:@"availableTill"]];
            
            NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
            [formatter setDateFormat:@"hh:mm a"];
            //NSString *nowTimeString = [formatter stringFromDate:[NSDate date]];
            
            int startTime   = [self minutesSinceMidnight:[formatter dateFromString:startTimeString]];
            int endTime  = [self minutesSinceMidnight:[formatter dateFromString:endTimeString]];
            int nowTime     = [self minutesSinceMidnight:[formatter dateFromString:[formatter stringFromDate:[NSDate date]]]];;
            
            if (startTime <= nowTime && nowTime <= endTime)
            {
                [_availabilityToggleBtn setImage:[UIImage imageNamed:@"available.png"] forState:UIControlStateNormal];
                _setAvailabilityText.text=@"I am available";
                
            }
            else {
                [_availabilityToggleBtn setImage:[UIImage imageNamed:@"not-available.png"] forState:UIControlStateNormal];
                _setAvailabilityText.text=@"I am unavailable";
                
            }
            if (endTime-nowTime<=30&&endTime-nowTime>0) {
                [self StartTimer];
            }
        }
    }
    
    
    
    //Added by: Zeenath
    //Added Date: 20/08/2016
    //Discription: Different fonts for the same label
    
    NSString *userName=[[appdelegate usersDetails]valueForKey:@"userName"];
    _nameLabel.text = [@"Hello, " stringByAppendingString:userName];
    
    
    /*  UIFont *font1 = [UIFont fontWithName:@"CenturyGothic" size:16];
     NSDictionary *arialDict = [NSDictionary dictionaryWithObject: font1 forKey:NSFontAttributeName];
     NSMutableAttributedString *aAttrString1 = [[NSMutableAttributedString alloc] initWithString:@"Hello, " attributes: arialDict];
     
     UIFont *font2 = [UIFont fontWithName:@"CenturyGothic-Bold" size:16];
     NSDictionary *arialDict2 = [NSDictionary dictionaryWithObject: font2 forKey:NSFontAttributeName];
     NSMutableAttributedString *aAttrString2 = [[NSMutableAttributedString alloc] initWithString:userName attributes: arialDict2];
     
     
     [aAttrString1 appendAttributedString:aAttrString2];
     _nameLabel.attributedText = aAttrString1;
     
     
     
     NSString *name=[[appdelegate usersDetails]valueForKey:@"profilePicPath"];
     NSString *imagename=[[appdelegate imageURL] stringByAppendingString:name];
     
     dispatch_queue_t imagequeue =dispatch_queue_create("imageDownloader", nil);
     dispatch_async(imagequeue, ^{
     
     //download iamge
     NSData *imageData = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:imagename]];
     UIImage *image = [[UIImage alloc] initWithData:imageData];
     dispatch_async(dispatch_get_main_queue(), ^{
     
     
     
     if (image==NULL) {
     UIImage *image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"upload-profile" ofType:@"png"]];
     _profileImage.image  = image;
     }
     else{
     _profileImage.image  = image;
     }
     
     
     
     
     });
     
     
     });*/
    
    
    
    //Added by: zeenath
    //Added Date: 20/08/2016
    //Discription: to show  the popup if the required information is not fiiled and disable tabs
    NSDictionary *providerStatus=[[appdelegate usersDetails]valueForKey:@"providerStatus"];
    
    
    if([[providerStatus valueForKey:@"isBankInfoUpdated"] isEqualToNumber:[NSNumber numberWithInt:0]] && [[providerStatus valueForKey:@"isRateUpdated"] isEqualToNumber:[NSNumber numberWithInt:0]] &&  [[providerStatus valueForKey:@"isAvailbilityUpdated"] isEqualToNumber:[NSNumber numberWithInt:0]])
    {
        // tabBarController set to true just to check flow
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:
                                    @"ProviderStoryboard" bundle:nil];
        RateViewController *viewcontrol=[storyboard instantiateViewControllerWithIdentifier:@"Rateview"];
        viewcontrol.pagename=@"firsttime";
        [self presentViewController:viewcontrol animated:NO completion:nil];
        
        /*_firstUserBackPage.hidden=NO;
        [[[[self.tabBarController tabBar]items]objectAtIndex:1]setEnabled:TRUE];
        [[[[self.tabBarController tabBar]items]objectAtIndex:2]setEnabled:TRUE];
        [[[[self.tabBarController tabBar]items]objectAtIndex:3]setEnabled:TRUE];*/
        
    }else if([[providerStatus valueForKey:@"isRateUpdated"] isEqualToNumber:[NSNumber numberWithInt:0]]){
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:
                                    @"ProviderStoryboard" bundle:nil];
        RateViewController *viewcontrol=[storyboard instantiateViewControllerWithIdentifier:@"Rateview"];
         viewcontrol.pagename=@"firsttime";
        [self presentViewController:viewcontrol animated:NO completion:nil];
    }else if([[providerStatus valueForKey:@"isBankInfoUpdated"] isEqualToNumber:[NSNumber numberWithInt:0]]){
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:
                                    @"ProviderStoryboard" bundle:nil];
        RateViewController *viewcontrol=[storyboard instantiateViewControllerWithIdentifier:@"Banking"];
        viewcontrol.pagename=@"firsttime";
        [self presentViewController:viewcontrol animated:NO completion:nil];
    }else if([[providerStatus valueForKey:@"isAvailbilityUpdated"] isEqualToNumber:[NSNumber numberWithInt:0]]){
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:
                                    @"ProviderStoryboard" bundle:nil];
        RateViewController *viewcontrol=[storyboard instantiateViewControllerWithIdentifier:@"Availability"];
        viewcontrol.pagename=@"firsttime";
        [self presentViewController:viewcontrol animated:NO completion:nil];
    }else{
        
        //Added by: nalina
        //Added Date: 23/09/2016
        //Discription: Display count of session approval in badge count, service call to get the count of session approval
        _firstUserBackPage.hidden=YES;
        [self startLoadingIndicator];
        AppDelegate *app= (AppDelegate *)[[UIApplication sharedApplication]delegate];
        
        /*NSString *getProviderUrl=[[appdelegate serviceURL] stringByAppendingString:@"api/Appointments/AppointmentWaitingApproval"];
        NSLog(@"globalgetprovider %@",getProviderUrl);
        [[GlobalFunction sharedInstance] getServerResponseAfterLogin:getProviderUrl method:@"GET" param:nil withCallback:^(NSInteger statusCode, NSDictionary *response, NSError *error)
         {
             if (statusCode==200||statusCode==404) {
                 sessionApprovalCount=[response mutableCopy];
                 // [self stopLoadingIndicator];
                 if (sessionApprovalCount.count>0) {
                     NSString *badgeCount=[NSString stringWithFormat:@"%lu", (unsigned long)sessionApprovalCount.count] ;
                     [[[[self.tabBarController tabBar]items]objectAtIndex:2]setBadgeValue:badgeCount];
                 }
                 else{
                     [[[[self.tabBarController tabBar]items]objectAtIndex:2]setBadgeValue:nil];
                 }
                 
                 
                 //Added by: nalina
                 //Added Date: 20/08/2016
                 //Discription: Bind the schedule table
             }else{
                 NSDictionary *messagearray=[response objectForKey:@"modelState"];
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
         }];*/
        
        /*
         //Added by: zeenath
         //Added Date: 20/08/2016
         //Discription: get the payment due details
         NSString *dueUrl=[app.serviceURL stringByAppendingString:@"/api/Provider/DueAmount"];
         
         [[GlobalFunction sharedInstance] getServerResponseAfterLogin:dueUrl method:@"GET" param:nil withCallback:^(NSInteger statusCode, NSDictionary *response, NSError *error)
         {
         if (statusCode==200) {
         
         NSString *Sessions=[response valueForKey:@"numberOfSessions"];
         NSNumber *value=[NSNumber numberWithInteger:[Sessions integerValue]];
         _noOfSessionsLabel.text=[value stringValue];
         _totalBilledLabel.text=[response objectForKey:@"totalBilledCurrency"];
         _totalDepositedLabel.text=[response objectForKey:@"totalDepositedCurrency"];
         
         
         
         }
         
         else{
         
         NSDictionary *messagearray=[response objectForKey:@"modelState"];
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
         [[[[self.tabBarController tabBar]items]objectAtIndex:1]setEnabled:TRUE];
         [[[[self.tabBarController tabBar]items]objectAtIndex:2]setEnabled:TRUE];
         [[[[self.tabBarController tabBar]items]objectAtIndex:3]setEnabled:TRUE];
         
         }
         
         }];*/
        
    }
    
    AppDelegate *app= (AppDelegate *)[[UIApplication sharedApplication]delegate];
    NSString *scheduleUrl=[app.serviceURL stringByAppendingString:@"/api/Appointments/TodaysScheduledAppointments"];
    
    [[GlobalFunction sharedInstance] getServerResponseAfterLogin:scheduleUrl method:@"GET" param:nil withCallback:^(NSInteger statusCode, NSDictionary *responses, NSError *error)
     {
         //NSLog(@"globalresponschedule %@",response);
         [[[[self.tabBarController tabBar]items]objectAtIndex:1]setEnabled:TRUE];
         [[[[self.tabBarController tabBar]items]objectAtIndex:2]setEnabled:TRUE];
         [[[[self.tabBarController tabBar]items]objectAtIndex:3]setEnabled:TRUE];
         
         self.pageViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"pageViewController"];
         self.pageViewController.dataSource = self;
         pageviewViewController *startingViewController = [self viewControllerAtIndex:0];
         viewControllers = @[startingViewController];
         
         [self addChildViewController:_pageViewController];
         [_dashboardMainView addSubview:_pageViewController.view];
         
         [self.pageViewController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
         [self.pageViewController didMoveToParentViewController:self];
         
         self.pageViewController.view.frame = CGRectMake(0, _dashboardMainView.frame.size.height-80, self.view.frame.size.width, self.view.frame.size.height);
         
         //scheduleAppointment=nil;
         if (statusCode==200) {
             NSLog(@"ResponseCOUNT%lu",responses.count);
             scheduledArray=[responses mutableCopy];
             _scheduleTable.hidden=NO;
             [self stopLoadingIndicator];
             [_scheduleTable reloadData];
             _noscheduleLabel.hidden=YES;
             contentdict=[scheduledArray mutableCopy];
             scheduleAppointment=[scheduledArray objectAtIndex:0];
             app.todaysSchedules=scheduleAppointment;
             starttimeOfFirstSchedule=[scheduleAppointment objectForKey:@"scheduledStartTime"];
             //NSLog(@"globalresponsescheduledappointment %@",scheduleAppointment);
             NSString *date1=[scheduleAppointment objectForKey:@"appointmentDate"];
             NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
             [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss"];
             NSDate *dateFromString = [[NSDate alloc] init];
             dateFromString = [dateFormatter dateFromString:date1];
             NSCalendar *cal=[NSCalendar currentCalendar];
             
             NSLog(@"SLIDERCOUNT%lu",scheduledArray.count);
             
             for (int i=0; i< scheduledArray.count; i++) {
                 
                 pageviewViewController *startingViewController = [self viewControllerAtIndex:i+1];
                 viewControllers = @[startingViewController];
                 
             }
             
             
             
             if([scheduleAppointment isEqual:nil] || (scheduleAppointment.count==0))
             {
                 _noappointmentLbl.hidden=NO;
                 //_noappointmentLbl.text=@"You have no appointments Today.";
                 _appointmentLabel.text=@"You have no appointments Today.";
                 //_AppointmentTextLbl.text=@"You have no appointments Today.";
                 _ApointmentUserName.hidden=YES;
                 _AppointmentOfferedAmount.hidden=YES;
                 _AppointmentTime.hidden=YES;
                 _AppointmentProfileImageView.hidden=YES;
                 //_appointmentLabel.hidden=YES;
                 _AppointmentTextLbl.hidden=NO;
                 
             }
             else{
                 _noappointmentLbl.hidden=YES;
                 _AppointmentTextLbl.hidden=YES;
                 _ApointmentUserName.hidden=NO;
                 _AppointmentOfferedAmount.hidden=NO;
                 _AppointmentTime.hidden=NO;
                 _AppointmentProfileImageView.hidden=NO;
                 _appointmentLabel.hidden=NO;
                 _ApointmentUserName.text=[scheduleAppointment objectForKey:@"clientFirstName"];
                 _AppointmentOfferedAmount.text=[scheduleAppointment objectForKey:@"offeredAmountCurrency"];
                 _AppointmentTime.text=[scheduleAppointment objectForKey:@"scheduledStartTime"];
                 //_AppointmentProfileImageView.image=[scheduleAppointment objectForKey:@"clientProfilePicPath"];
                 if ([cal isDateInToday:dateFromString]==1) {
                     _appointmentLabel.text=[NSString stringWithFormat:@"%@ %@",@"You have an appointment Today at ",[[GlobalFunction sharedInstance]Convert24FormatTo12Format:[scheduleAppointment objectForKey:@"scheduledStartTime"]]];
                 }else if ([cal isDateInTomorrow:dateFromString]==1) {
                     _appointmentLabel.text=[NSString stringWithFormat:@"%@ %@",@"You have an appointment Tomorrow at ",[[GlobalFunction sharedInstance]Convert24FormatTo12Format:[scheduleAppointment objectForKey:@"scheduledStartTime"]]];
                 }else{
                     _appointmentLabel.text=[NSString stringWithFormat:@"%@ %@",@"You have an appointment ",[scheduleAppointment objectForKey:@"appointmentTimeSting"]];
                 }
                 
                 
                 //Added by: Nalina
                 //Added Date: 29/08/2016
                 //Discription: Check next schedule details to enable join session
                 
                 
                 NSString *startTimeString = [[GlobalFunction sharedInstance]Convert24FormatTo12Format:[scheduleAppointment valueForKey:@"scheduledStartTime"]];
                 
                 NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
                 [formatter setDateFormat:@"hh:mm a"];
                 
                 int startTime   = [self minutesSinceMidnight:[formatter dateFromString:startTimeString]];
                 int nowTime     = [self minutesSinceMidnight:[formatter dateFromString:[formatter stringFromDate:[NSDate date]]]];;
                 
                 if (startTime-nowTime<=30) { //&&startTime-nowTime>0
                     findClick=@"enableJoinsession";
                      [_joinSessionView setUserInteractionEnabled:YES];
                     [self StartTimer];
                 }
                 appointmentID=[scheduleAppointment objectForKey:@"appointmentID"];
             }
             
             
         }else{
             _joinSessionView.backgroundColor=[UIColor grayColor];
              [_joinSessionView setUserInteractionEnabled:NO];
             self.tabBarController.tabBar.hidden = NO;
             self.navigationItem.hidesBackButton = NO;
             //_appointmentLabel.text=[NSString stringWithFormat:@"%@ ",@"You have no appointments Today "];
             NSString *date1=[scheduleAppointment objectForKey:@"appointmentDate"];
             NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
             [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss"];
             NSDate *dateFromString = [[NSDate alloc] init];
             dateFromString = [dateFormatter dateFromString:date1];
             NSCalendar *cal=[NSCalendar currentCalendar];
             
             if([scheduleAppointment isEqual:nil] || (scheduleAppointment.count==0))
             {
                 _noappointmentLbl.hidden=NO;
                 //_noappointmentLbl.text=@"You have no appointments Today.";
                 _appointmentLabel.text=@"You have no appointments Today.";
                 //_AppointmentTextLbl.text=@"You have no appointments Today.";
                 _ApointmentUserName.hidden=YES;
                 _AppointmentOfferedAmount.hidden=YES;
                 _AppointmentTime.hidden=YES;
                 _AppointmentProfileImageView.hidden=YES;
                 //_appointmentLabel.hidden=YES;
                 _AppointmentTextLbl.hidden=NO;
             }
             else{
                 _noappointmentLbl.hidden=YES;
                 NSLog(@"globalresponsescheduled2 %lu",scheduledArray.count);
                 _AppointmentTextLbl.hidden=YES;
                 _ApointmentUserName.hidden=NO;
                 _AppointmentOfferedAmount.hidden=NO;
                 _AppointmentTime.hidden=NO;
                 _AppointmentProfileImageView.hidden=NO;
                 _appointmentLabel.hidden=NO;
                 _ApointmentUserName.text=[scheduleAppointment objectForKey:@"clientFirstName"];
                 _AppointmentOfferedAmount.text=[scheduleAppointment objectForKey:@"offeredAmountCurrency"];
                 _AppointmentTime.text=[scheduleAppointment objectForKey:@"scheduledStartTime"];
                 //_AppointmentProfileImageView.image=[scheduleAppointment objectForKey:@"clientProfilePicPath"];
                 if ([cal isDateInToday:dateFromString]==1) {
                     _appointmentLabel.text=[NSString stringWithFormat:@"%@ %@ %@ %@",@"You have an appointment Today at ",[[GlobalFunction sharedInstance]Convert24FormatTo12Format:[scheduleAppointment objectForKey:@"scheduledStartTime"]],@"with",[scheduleAppointment objectForKey:@"clientFirstName"]];
                 }else if ([cal isDateInTomorrow:dateFromString]==1) {
                     _appointmentLabel.text=[NSString stringWithFormat:@"%@ %@ %@ %@",@"You have an appointment Tomorrow at ",[[GlobalFunction sharedInstance]Convert24FormatTo12Format:[scheduleAppointment objectForKey:@"scheduledStartTime"]],@"with",[scheduleAppointment objectForKey:@"clientFirstName"]];
                 }else{
                     _appointmentLabel.text=[NSString stringWithFormat:@"%@ %@ %@ %@",@"You have an appointment on",[scheduleAppointment objectForKey:@"appointmentTimeSting"],@"with",[scheduleAppointment objectForKey:@"clientFirstName"]];
                 }
                 
                 
                 //Added by: Nalina
                 //Added Date: 29/08/2016
                 //Discription: Check next schedule details to enable join session
                 
                 
                 NSString *startTimeString = [[GlobalFunction sharedInstance]Convert24FormatTo12Format:[scheduleAppointment valueForKey:@"scheduledStartTime"]];
                 
                 NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
                 [formatter setDateFormat:@"hh:mm a"];
                 
                 int startTime   = [self minutesSinceMidnight:[formatter dateFromString:startTimeString]];
                 int nowTime     = [self minutesSinceMidnight:[formatter dateFromString:[formatter stringFromDate:[NSDate date]]]];;
                 
                 if (startTime-nowTime<=30) { //&&startTime-nowTime>0
                     findClick=@"enableJoinsession";
                     [_joinSessionView setUserInteractionEnabled:YES];
                     
                     [self StartTimer];
                     
                 }
                 appointmentID=[scheduleAppointment objectForKey:@"appointmentID"];
             }
             
             if(statusCode==404){
                 
                 //_noappointmentLbl.text=@"You have no appointments Today.";
                 NSString *date1=[scheduleAppointment objectForKey:@"appointmentDate"];
                 NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
                 [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss"];
                 NSDate *dateFromString = [[NSDate alloc] init];
                 dateFromString = [dateFormatter dateFromString:date1];
                 NSCalendar *cal=[NSCalendar currentCalendar];
                 
                 if([scheduleAppointment isEqual:nil] || (scheduleAppointment.count==0))
                 {
                     _noappointmentLbl.hidden=NO;
                     //_noappointmentLbl.text=@"You have no appointments Today.";
                     _appointmentLabel.text=@"You have no appointments Today.";
                     //_AppointmentTextLbl.text=@"You have no appointments Today.";
                     _ApointmentUserName.hidden=YES;
                     _AppointmentOfferedAmount.hidden=YES;
                     _AppointmentTime.hidden=YES;
                     _AppointmentProfileImageView.hidden=YES;
                     //_appointmentLabel.hidden=YES;
                     _AppointmentTextLbl.hidden=NO;
                 }
                 else{
                     
                     _noappointmentLbl.hidden=YES;
                     NSLog(@"globalresponsescheduled3 %@",scheduleAppointment);
                     _AppointmentTextLbl.hidden=YES;
                     _ApointmentUserName.hidden=NO;
                     _AppointmentOfferedAmount.hidden=NO;
                     _AppointmentTime.hidden=NO;
                     _AppointmentProfileImageView.hidden=NO;
                     _appointmentLabel.hidden=NO;
                     _ApointmentUserName.text=[scheduleAppointment objectForKey:@"clientFirstName"];
                     _AppointmentOfferedAmount.text=[scheduleAppointment objectForKey:@"offeredAmountCurrency"];
                     _AppointmentTime.text=[scheduleAppointment objectForKey:@"scheduledStartTime"];
                     //_AppointmentProfileImageView.image=[scheduleAppointment objectForKey:@"clientProfilePicPath"];
                     if ([cal isDateInToday:dateFromString]==1) {
                         _appointmentLabel.text=[NSString stringWithFormat:@"%@ %@ %@ %@",@"You have an appointment Today at ",[[GlobalFunction sharedInstance]Convert24FormatTo12Format:[scheduleAppointment objectForKey:@"scheduledStartTime"]],@"with",[scheduleAppointment objectForKey:@"clientFirstName"]];
                     }else if ([cal isDateInTomorrow:dateFromString]==1) {
                         _appointmentLabel.text=[NSString stringWithFormat:@"%@ %@ %@ %@",@"You have an appointment Tomorrow at ",[[GlobalFunction sharedInstance]Convert24FormatTo12Format:[scheduleAppointment objectForKey:@"scheduledStartTime"]],@"with",[scheduleAppointment objectForKey:@"clientFirstName"]];
                     }else{
                         _appointmentLabel.text=[NSString stringWithFormat:@"%@ %@ %@ %@",@"You have an appointment on",[scheduleAppointment objectForKey:@"appointmentTimeSting"],@"with",[scheduleAppointment objectForKey:@"clientFirstName"]];
                     }
                     
                     
                     //Added by: Nalina
                     //Added Date: 29/08/2016
                     //Discription: Check next schedule details to enable join session
                     
                     
                     NSString *startTimeString = [[GlobalFunction sharedInstance]Convert24FormatTo12Format:[scheduleAppointment valueForKey:@"scheduledStartTime"]];
                     
                     NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
                     [formatter setDateFormat:@"hh:mm a"];
                     
                     int startTime   = [self minutesSinceMidnight:[formatter dateFromString:startTimeString]];
                     int nowTime     = [self minutesSinceMidnight:[formatter dateFromString:[formatter stringFromDate:[NSDate date]]]];;
                     
                     if (startTime-nowTime<=30) { //&&startTime-nowTime>0
                         findClick=@"enableJoinsession";
                         [_joinSessionView setUserInteractionEnabled:YES];
                         [self StartTimer];
                     }
                     appointmentID=[scheduleAppointment objectForKey:@"appointmentID"];
                 }
                 
                 
                 [self stopLoadingIndicator];
                 _noscheduleLabel.hidden=NO;
                 _scheduleTable.hidden=YES;
             }else{
                 [self stopLoadingIndicator];
             }
             
         }
     }];
    
}

//called each time when the view appears
-(void)viewWillAppear:(BOOL)animated{
    self.tabBarController.tabBar.hidden = NO;
    self.tabBarController.delegate = (id)self;
    
    [[self navigationController] setNavigationBarHidden:YES animated:YES];
    
    NSDictionary *providerStatus=[[appdelegate usersDetails]valueForKey:@"providerStatus"];
    
    //Added by: Zeenath
    //Added Date: 29/08/2016
    //Discription: Hide and show the popup to fillin the basic information if user logs in for the first time
    if([[providerStatus valueForKey:@"isBankInfoUpdated"] isEqualToNumber:[NSNumber numberWithInt:0]] || [[providerStatus valueForKey:@"isRateUpdated"] isEqualToNumber:[NSNumber numberWithInt:0]] ||  [[providerStatus valueForKey:@"isAvailbilityUpdated"] isEqualToNumber:[NSNumber numberWithInt:0]])
    {
        // set true just check the flow By bhargava
        _firstUserBackPage.hidden=NO;
        [[[[self.tabBarController tabBar]items]objectAtIndex:1]setEnabled:TRUE];
        [[[[self.tabBarController tabBar]items]objectAtIndex:2]setEnabled:TRUE];
        [[[[self.tabBarController tabBar]items]objectAtIndex:3]setEnabled:TRUE];
    }
    else{
        _firstUserBackPage.hidden=YES;
        [[[[self.tabBarController tabBar]items]objectAtIndex:1]setEnabled:TRUE];
        [[[[self.tabBarController tabBar]items]objectAtIndex:2]setEnabled:TRUE];
        [[[[self.tabBarController tabBar]items]objectAtIndex:3]setEnabled:TRUE];
        
    }
    
    id<GAITracker> tracker = [[GAI sharedInstance] defaultTracker];
    [tracker set:kGAIScreenName value:@"ProviderDashboard"];
    [tracker send:[[GAIDictionaryBuilder createScreenView] build]];
}

//Added by: Zeenath
//Added Date: 29/08/2016
//Discription: To navigate to join session and schduled appointment screens
- (void)handleSingleTapJoinSession:(UITapGestureRecognizer *)recognizer {
    AppDelegate *app= (AppDelegate *)[[UIApplication sharedApplication]delegate];
    
    UIColor *backgroundColor=[UIColor  colorWithRed:(246/255.0) green:(108/255.0) blue:(115/255.0) alpha:1];
    
    if ([_joinSessionView.backgroundColor isEqual:backgroundColor]) {
        app.screenStatus=@"";
        app.screenState=@"ProviderDashboard";
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:
                                    @"GeneralStoryboard" bundle:nil];
        JoinSessionViewController *viewcontrol=[storyboard instantiateViewControllerWithIdentifier:@"JoinSession"];
        viewcontrol.appointmentID=appointmentID;
        [self presentViewController:viewcontrol animated:NO completion:nil];
        
    }
    
}

- (void)handleSingleTapJoinSessionscheduledAppointments:(UITapGestureRecognizer *)recognizer {
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:
                                @"GeneralStoryboard" bundle:nil];
    
    [self presentViewController:[storyboard instantiateViewControllerWithIdentifier:@"ScheduledAppointments"] animated:NO completion:nil];
    
    /*UIStoryboard *storyboard = [UIStoryboard storyboardWithName:
                                @"ProviderStoryboard" bundle:nil];
    RateViewController *viewcontrol=[storyboard instantiateViewControllerWithIdentifier:@"Rateview"];
    viewcontrol.pagename=@"firsttime";
    [self presentViewController:viewcontrol animated:NO completion:nil];*/
    
    
}



// Dispose of any resources that can be recreated.
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


//Added by: nalina
//Added Date: 29/08/2016
//Discription: To set online availability
- (void)SetAvailableOn:(UITapGestureRecognizer *)recognizer {
    [self availabililityPopupOpen];
}

- (IBAction)setAvailablityClick:(id)sender {
    [self availabililityPopupOpen];
}

-(void)availabililityPopupOpen{
    //   GlobalFunction *globalValues=[[GlobalFunction alloc]init];
    
    if ([_setAvailabilityText.text isEqualToString:@"I am unavailable"]) {
        _backView.hidden=NO;
        _avialabilytyBackView.hidden=NO;
        _amountBackView.hidden=YES;
        _pickerView.hidden=YES;
    }else{
        
        // Added By:Nalina
        // Added Date:15/09/16
        // Description: offline set functionality
        
        _alert = [UIAlertController
                  alertControllerWithTitle:@""
                  message:[[GlobalFunction sharedInstance].arrayOfAlerts objectAtIndex:122]
                  preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* yesButton = [UIAlertAction
                                    actionWithTitle:@"Yes"
                                    style:UIAlertActionStyleDefault
                                    handler:^(UIAlertAction * action) {
                                        
                                        AppDelegate *app= (AppDelegate *)[[UIApplication sharedApplication]delegate];
                                        
                                        NSDate *date = [NSDate date];
                                        NSDateFormatter *timeformat = [[NSDateFormatter alloc] init];
                                        timeformat.dateFormat = @"HH:mm:ss";
                                        
                                        NSMutableDictionary *offlineSetData = [[NSMutableDictionary alloc] init];
                                        [offlineSetData setObject:[timeformat stringFromDate:date] forKey:@"offlineTime"];
                                        
                                        [self startLoadingIndicator];
                                        /************** Call set offline service ******************/
                                        NSString *setofflineUrl=[app.serviceURL stringByAppendingString:@"api/Provider/OfflineAvailability"];
                                        [[GlobalFunction sharedInstance] getServerResponseAfterLogin:setofflineUrl method:@"POST" param:offlineSetData withCallback:^(NSInteger statusCode, NSDictionary *response, NSError *error)
                                         {
                                             
                                             //  GlobalFunction *globalValues=[[GlobalFunction alloc]init];
                                             NSString *message;
                                             
                                             if (statusCode == 200)
                                             {
                                                 [self stopLoadingIndicator];
                                                 
                                                 [_availabilityToggleBtn setImage:[UIImage imageNamed:@"not-available.png"] forState:UIControlStateNormal];
                                                 _setAvailabilityText.text=@"I am unavailable";
                                                 findClick=@"setOffline";
                                                 
                                                 NSMutableDictionary *data=[[NSMutableDictionary alloc]initWithDictionary:[appdelegate usersDetails]];
                                                 
                                                 NSMutableDictionary *dataStatus = [[data valueForKey:@"providerStatus"] mutableCopy];
                                                 
                                                 [dataStatus setObject:@"notAvailable" forKey:@"availableFrom"];
                                                 [dataStatus setObject:@"notAvailable" forKey:@"availableTill"];
                                                 
                                                 
                                                 [app.usersDetails removeObjectForKey:@"providerStatus"];
                                                 [app.usersDetails setObject:dataStatus forKey:@"providerStatus"];
                                             }
                                             else {
                                                 
                                                 
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
                                                 [self presentViewController:_alert animated:YES completion: nil];
                                             }
                                             
                                         }];
                                        
                                    }];
        
        UIAlertAction* noButton = [UIAlertAction
                                   actionWithTitle:@"No"
                                   style:UIAlertActionStyleDefault
                                   handler:^(UIAlertAction * action) {
                                       //Handle your yes please button action here
                                   }];
        
        [_alert addAction:yesButton];
        [_alert addAction:noButton];
        [self presentViewController:_alert animated:YES completion:nil];    }
}

//Added by: Zeenath
//Added Date: 29/08/2016
//Discription: To show the availability popup
- (void)availablePicker:(UITapGestureRecognizer *)recognizer {
    _pickerView.hidden=NO;
}

//Returns number of components in pickerview
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)thePickerView {
    
    return 1;//Or return whatever as you intend
}

//Returns number of rows in pickerview
- (NSInteger)pickerView:(UIPickerView *)thePickerView numberOfRowsInComponent:(NSInteger)component {
    
    return [pickerArray count];//Or, return as suitable for you...normally we use array for dynamic
}

//Set the number Of Sections for the TableView
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

//Set the title for each rows in pickerview
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:
(NSInteger)row forComponent:(NSInteger)component{
    return [pickerArray objectAtIndex:row];
}


//Called when a row in the pickerview is selected
- (void)pickerView:(UIPickerView *)thePickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    [_pickerView selectRow:0 inComponent:0 animated:YES];
    
    [_avialabilityText setText:[pickerArray objectAtIndex:row]];
    
    if ([[pickerArray objectAtIndex:row] isEqualToString:@"Half an hour"]) {
        checkAvailableTime=@"Half an hour";
        availableTimeDict=[self GetTimeSpan:30];
    }else if ([[pickerArray objectAtIndex:row] isEqualToString:@"One hour"]){
        checkAvailableTime=@"One hour";
        availableTimeDict=[self GetTimeSpan:60];
    }else if ([[pickerArray objectAtIndex:row] isEqualToString:@"One & half hour"]){
        availableTimeDict=[self GetTimeSpan:90];
    }else if ([[pickerArray objectAtIndex:row] isEqualToString:@"Two hours"]){
        availableTimeDict=[self GetTimeSpan:120];
    }else if ([[pickerArray objectAtIndex:row] isEqualToString:@"Two & half hours"]){
        availableTimeDict=[self GetTimeSpan:150];
    }else if ([[pickerArray objectAtIndex:row] isEqualToString:@"Three hours"]){
        availableTimeDict=[self GetTimeSpan:180];
    }else if ([[pickerArray objectAtIndex:row] isEqualToString:@"Three & half hours"]){
        availableTimeDict=[self GetTimeSpan:210];
    }
    _pickerView.hidden=YES;
    
}

// Added By:Nalina
// Added Date:25/08/16
// Description: Get current time and added timespan

-(NSMutableDictionary *)GetTimeSpan:(float)timetoadd{
    NSString *CurrentTime;
    NSString *newTime;
    NSDate *date = [NSDate date];
    NSDateFormatter *timeformat = [[NSDateFormatter alloc] init];
    timeformat.dateFormat = @"HH:mm:ss";
    CurrentTime = [timeformat stringFromDate:date];
    
    float hoursToAdd = timetoadd;
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *components = [[NSDateComponents alloc] init];
    [components setMinute:hoursToAdd];
    NSDate *newDate= [calendar dateByAddingComponents:components toDate:date options:0];
    newTime = [timeformat stringFromDate:newDate];
    
    NSMutableDictionary *onlineAvailableData = [[NSMutableDictionary alloc] init];
    [onlineAvailableData setObject:CurrentTime forKey:@"startTime"];
    [onlineAvailableData setObject:newTime forKey:@"endTime"];
    
    return onlineAvailableData;
}

//Set the number Of rows in each section of tableview
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return scheduledArray.count;
}

// Added By:Zeenath
// Added Date:12/07/16
// Description: Data for each row in tableview
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    ProviderDashboardCellTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    
    // Modified By:Nalina
    // Modified Date:25/08/16
    // Description: Bind data for each row in tableview
    NSDictionary *myJsonResponseIndividualElement = scheduledArray[indexPath.row];
    
    NSString *name=[myJsonResponseIndividualElement[@"clientFirstName"] stringByAppendingString:@" "];
    cell.clientNameLabel.text= [name stringByAppendingString:myJsonResponseIndividualElement[@"clientLastName"]];
    
    NSString *dateIs;
    
    if ([myJsonResponseIndividualElement[@"appointmentDate"] isEqual:[NSNull null]]) {
        dateIs=@"";
    }else{
        
        NSString *getDate=myJsonResponseIndividualElement[@"appointmentDate"];
        
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss"];
        NSDate *dateFromString = [[NSDate alloc] init];
        dateFromString = [dateFormatter dateFromString:getDate];
        NSDateFormatter *format = [[NSDateFormatter alloc] init];
        format.dateFormat = @"dd MMM yyyy";
        dateIs=[format stringFromDate:dateFromString];
    }
    
    NSString *hourIs;
    if ([myJsonResponseIndividualElement[@"startTime"] isEqual:[NSNull null]]) {
        hourIs=@"";
    }else{
        hourIs =[[GlobalFunction sharedInstance]Convert24FormatTo12Format:myJsonResponseIndividualElement[@"scheduledStartTime"]];
    }
    
    NSString *dateTime= [NSString stringWithFormat: @"%@, %@", dateIs, hourIs];
    cell.dateTimeLabel.text=dateTime;
    
    return cell;
}


//  Added by:Zeenath
//  Added Date:2016-24-07.
//  Description:Function To make the image view rounded.
-(void)setBorder:(UIView *)img
{
    
    img.layer.borderColor = [[UIColor colorWithRed:228.0/255.0 green:109.0/255.0 blue:175.0/255.0 alpha:1.0]CGColor];
    img.layer.borderWidth = 1.0f;
    
}


//  Added by:Zeenath
//  Added Date:2016-24-07.
//  Description:Function To show the emergency call popup when emergency tab is clicked.
-(void) tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
{
    if(tabBarController.selectedIndex==3){
        [_callBackView setHidden:NO];
        
        
    }else{
        [_callBackView setHidden:YES];
    }
    
}

//  Added by:Zeenath
//  Added Date:2016-24-07.
//  Description:Function To show the transactions information.
- (IBAction)dollarButtonClick:(id)sender {
    [[self navigationController] setNavigationBarHidden:YES animated:YES];
    _backView.hidden=NO;
    _amountBackView.hidden=NO;
    _avialabilytyBackView.hidden=YES;
    _pickerView.hidden=YES;
}
- (IBAction)amountOKClick:(id)sender {
    _backView.hidden=YES;
}


//  Added by:Nalina
//  Added Date:2016-28-08.
//  Description:Function To convert the time to 24 hour.
-(NSDate *)convertTimeFormat:(NSString *)time{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"hh:mm a"];
    NSDate *amPmDate = [formatter dateFromString:time];
    [formatter setDateFormat:@"HH:mm"];
    return amPmDate;
}


//  Added by:Nalina
//  Added Date:2016-28-08.
//  Description:Function To convert the time to 12 hour.
-(NSString *)Convert24FormatTo12Format:(NSString *)time{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"HH:mm:ss"];
    
    NSDate *amPmDate = [formatter dateFromString:time];
    [formatter setDateFormat:@"hh:mm a"];
    
    NSString *HourString = [formatter stringFromDate:amPmDate];
    return HourString;
}


//  Added by:Nalina
//  Added Date:2016-28-08.
//  Description:Function To set the availability.
- (IBAction)availabilityOKClick:(id)sender {
    
    _avialabilytyBackView.hidden=YES;
    
    if ([_avialabilityText.text isEqualToString:@"Half an hour"]) {
        checkAvailableTime=@"Half an hour";
        availableTimeDict=[self GetTimeSpan:30];
    }
    
    if([[scheduleAppointment objectForKey:@"scheduledStartTime"] isEqual:[NSNull null]]||[[scheduleAppointment objectForKey:@"scheduledStartTime"] isEqual:[NSNull null]])
    {
        [self availabilitySetServiceCall];
    }
    else{
        NSString *startTimeString = [[GlobalFunction sharedInstance]Convert24FormatTo12Format:[availableTimeDict objectForKey:@"startTime"]];
        
        NSString *endTimeString = [[GlobalFunction sharedInstance]Convert24FormatTo12Format:[availableTimeDict objectForKey:@"endTime"]];
        
        NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
        [formatter setDateFormat:@"hh:mm a"];
        
        //  NSDictionary *appointments=[[appdelegate usersDetails] valueForKey:@"providerStatus"];
        NSString *sessionStartTime = [[GlobalFunction sharedInstance]Convert24FormatTo12Format:[scheduleAppointment objectForKey:@"scheduledStartTime"]];
        
        NSString *sessionEndTime = [[GlobalFunction sharedInstance]Convert24FormatTo12Format:[scheduleAppointment objectForKey:@"scheduledEndTime"]];
        
        
        int startTime   = [self minutesSinceMidnight:[formatter dateFromString:startTimeString]];
        int endTime  = [self minutesSinceMidnight:[formatter dateFromString:endTimeString]];
        int sessionStart = [self minutesSinceMidnight:[formatter dateFromString:sessionStartTime]];
        int sessionEnd = [self minutesSinceMidnight:[formatter dateFromString:sessionEndTime]];;
        
        NSString *message=[NSString stringWithFormat:@"%@ %@ %@",@"You have scheduled an appointment at ",sessionStartTime,@". Please cancel that appointment to set as available"];
        
        if (startTime <= sessionStart && sessionStart <= endTime)
        {
            [_availabilityToggleBtn setImage:[UIImage imageNamed:@"not-available.png"] forState:UIControlStateNormal];
            _setAvailabilityText.text=@"I am unavailable";
            
            _alert = [UIAlertController
                      alertControllerWithTitle:@"CONFIRM"
                      message:message
                      preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction* okButton = [UIAlertAction
                                       actionWithTitle:@"OK"
                                       style:UIAlertActionStyleDefault
                                       handler:^(UIAlertAction * action) {
                                           //Handle your yes please button action here
                                       }];
            [_alert addAction:okButton];
            [self presentViewController:_alert animated:YES completion:nil];
        }else if(startTime <= sessionEnd && sessionEnd <= endTime){
            [_availabilityToggleBtn setImage:[UIImage imageNamed:@"not-available.png"] forState:UIControlStateNormal];
            _setAvailabilityText.text=@"I am unavailable";
            
            _alert = [UIAlertController
                      alertControllerWithTitle:@"CONFIRM"
                      message:message
                      preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction* okButton = [UIAlertAction
                                       actionWithTitle:@"OK"
                                       style:UIAlertActionStyleDefault
                                       handler:^(UIAlertAction * action) {
                                           //Handle your yes please button action here
                                       }];
            [_alert addAction:okButton];
            [self presentViewController:_alert animated:YES completion:nil];
            
        }
        else {
            [self availabilitySetServiceCall];
        }
        
    }
    
    _backView.hidden=YES;
    
}

-(int) minutesSinceMidnight:(NSDate *)date
{
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond fromDate:date];
    return 60 * (int)[components hour] + (int)[components minute];
}

//  Added by:Zeenth
//  Added Date:2016-28-07.
//  Description:Function To hide the availability popup.
- (IBAction)availabilityCancelClick:(id)sender {
    _backView.hidden=YES;
}

//  Added by:Zeenth
//  Added Date:2016-28-07.
//  Description:Function To show the availability picker.
- (IBAction)availabilityDropdownClick:(id)sender {
    _pickerView.hidden=NO;
}


//  Added by:Zeenth
//  Added Date:2016-28-07.
//  Description:Function To make the emergency call.
- (IBAction)callYesClick:(id)sender {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"tel:911"]];
}


//  Added by:Zeenth
//  Added Date:2016-28-07.
//  Description:Function To make the emergency call.
- (IBAction)callNoClick:(id)sender {
    [self.tabBarController setSelectedIndex:0];
    [_callBackView setHidden:YES];
}

//Added by: Zeenath
//Added Date: 28/07/2016
//Discription: To start the loading indicator
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


//Added by: Zeenath
//Added Date: 28/07/2016
//Discription: To stop the loading indicator
-(void)stopLoadingIndicator
{
    
    _loadingView.hidden=YES;
}


//Added by: Nalina
//Added Date: 28/07/2016
//Discription: To navigate to fill the banking information if user is a first time user
- (IBAction)bankingInfoClick:(id)sender {
    if([[[[appdelegate usersDetails]valueForKey:@"providerStatus"] valueForKey:@"isBankInfoUpdated"] isEqualToNumber:[NSNumber numberWithInt:1]])
    {
        // GlobalFunction *globalValues=[[GlobalFunction alloc]init];
        
        _alert = [UIAlertController
                  alertControllerWithTitle:@""
                  message:[[GlobalFunction sharedInstance].arrayOfAlerts objectAtIndex:119]
                  preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* yesButton = [UIAlertAction
                                    actionWithTitle:@"Yes"
                                    style:UIAlertActionStyleDefault
                                    handler:^(UIAlertAction * action) {
                                        BankingInfoViewController *vc=[self.storyboard instantiateViewControllerWithIdentifier:@"BankingInfo"];
                                        [self.navigationController pushViewController:vc animated:YES];
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
    }
    else{
        BankingInfoViewController *vc=[self.storyboard instantiateViewControllerWithIdentifier:@"BankingInfo"];
        [self.navigationController pushViewController:vc animated:YES];
    }
}


//Added by: Nalina
//Added Date: 28/07/2016
//Discription: To navigate to fill the availability if user is a first time user
- (IBAction)availabilityClick:(id)sender {
    
    if([[[[appdelegate usersDetails]valueForKey:@"providerStatus"] valueForKey:@"isAvailbilityUpdated"] isEqualToNumber:[NSNumber numberWithInt:1]])
    {
        //     GlobalFunction *globalValues=[[GlobalFunction alloc]init];
        
        _alert = [UIAlertController
                  alertControllerWithTitle:@""
                  message:[[GlobalFunction sharedInstance].arrayOfAlerts objectAtIndex:119]
                  preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* yesButton = [UIAlertAction
                                    actionWithTitle:@"Yes"
                                    style:UIAlertActionStyleDefault
                                    handler:^(UIAlertAction * action) {
                                        [self gotoSetAvailabilityPage];
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
    }
    else{
        [self gotoSetAvailabilityPage];
    }
    
}

//Added by: Nalina
//Added Date: 28/07/2016
//Discription:Service call To get the availability of the provider
-(void) gotoSetAvailabilityPage{
    AppDelegate *app= (AppDelegate *)[[UIApplication sharedApplication]delegate];
    
    /************** Call availability data service ******************/
    [self startLoadingIndicator];
    
    NSString *securityQuestionUrl=[app.serviceURL stringByAppendingString:@"api/Availability/Availability"];
    AvailabilityViewController *vc=[self.storyboard instantiateViewControllerWithIdentifier:@"Availability"];
    
    [[GlobalFunction sharedInstance] getServerResponseAfterLogin:securityQuestionUrl method:@"GET" param:nil withCallback:^(NSInteger statusCode, NSDictionary *response, NSError *error)
     {
         NSDictionary *actualData;
         
         if (statusCode==200) {
             NSMutableArray *responseArray = [[NSMutableArray alloc] initWithObjects:response, nil];
             NSMutableArray *sortedArray =[responseArray objectAtIndex:0];
             for(int i=0;i<sortedArray.count;i++) {
                 actualData=[sortedArray objectAtIndex:i];
                 NSString *availableList=[actualData objectForKey:@"availabilityType"];
                 NSString *availableID=[actualData objectForKey:@"id"];
                 
                 [availabilityArray addObject:availableList];
                 [availabilityId addObject:availableID];
             }
             vc.availablepickerArray=availabilityArray;
             vc.availablepickerIDArray=availabilityId;
             
             NSString *availableUrl=[app.serviceURL stringByAppendingString:@"api/Provider/ProviderAvailability"];
             
             [[GlobalFunction sharedInstance] getServerResponseAfterLogin:availableUrl method:@"GET" param:nil withCallback:^(NSInteger statusCode, NSDictionary *response, NSError *error)
              {
                  if (statusCode==200||statusCode==404) {
                      
                      availableData=response;
                      vc.availableData=availableData;
                      
                      
                      [self.navigationController pushViewController:vc animated:YES];
                      [self stopLoadingIndicator];
                  }else{
                      if(statusCode==403||statusCode==503){
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
                          [self stopLoadingIndicator];
                      }
                  }
              }];
             
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
             [self stopLoadingIndicator];
         }
     }];
}

//Added by: Nalina
//Added Date: 28/07/2016
//Discription: To navigate to fill the rate per hour if user is a first time user
- (IBAction)sessionrateClick:(id)sender {
    if([[[[appdelegate usersDetails]valueForKey:@"providerStatus"] valueForKey:@"isRateUpdated"] isEqualToNumber:[NSNumber numberWithInt:1]])
    {
        //GlobalFunction *globalValues=[[GlobalFunction alloc]init];
        
        _alert = [UIAlertController
                  alertControllerWithTitle:@""
                  message:[[GlobalFunction sharedInstance].arrayOfAlerts objectAtIndex:119]
                  preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* yesButton = [UIAlertAction
                                    actionWithTitle:@"Yes"
                                    style:UIAlertActionStyleDefault
                                    handler:^(UIAlertAction * action) {
                                        RateViewController *vc=[self.storyboard instantiateViewControllerWithIdentifier:@"RateView"];
                                        [self.navigationController pushViewController:vc animated:YES];
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
    }
    else{
        RateViewController *vc=[self.storyboard instantiateViewControllerWithIdentifier:@"RateView"];
        [self.navigationController pushViewController:vc animated:YES];
    }
}

// Added By:Nalina
// Added Date:25/08/16
// Description: online availability set functionality

- (void)availabilitySetServiceCall{
    
    AppDelegate *app= (AppDelegate *)[[UIApplication sharedApplication]delegate];
    [self startLoadingIndicator];
    /************** Set online available service ******************/
    NSString *onlineAvailableUrl=[app.serviceURL stringByAppendingString:@"api/Provider/OnlineAvailability"];
    [[GlobalFunction sharedInstance] getServerResponseAfterLogin:onlineAvailableUrl method:@"POST" param:availableTimeDict withCallback:^(NSInteger statusCode, NSDictionary *response, NSError *error)
     {
         
         //   GlobalFunction *globalValues=[[GlobalFunction alloc]init];
         NSString *message;
         
         if (statusCode == 200)
         {
             [self stopLoadingIndicator];
             
             [_availabilityToggleBtn setImage:[UIImage imageNamed:@"available.png"] forState:UIControlStateNormal];
             _setAvailabilityText.text=@"I am available";
             
             
             NSMutableDictionary *data=[[NSMutableDictionary alloc]initWithDictionary:[appdelegate usersDetails]];
             
             NSMutableDictionary *dataStatus = [[data valueForKey:@"providerStatus"] mutableCopy];
             
             [dataStatus setObject:[availableTimeDict objectForKey:@"startTime"] forKey:@"availableFrom"];
             [dataStatus setObject:[availableTimeDict objectForKey:@"endTime"] forKey:@"availableTill"];
             
             
             [app.usersDetails removeObjectForKey:@"providerStatus"];
             [app.usersDetails setObject:dataStatus forKey:@"providerStatus"];
             
             if ([checkAvailableTime isEqualToString:@"Half an hour"]) {
                 findClick=@"setOnlineAvailability";
                 [self StartTimer];
             }
             /*  message=[globalValues.arrayOfAlerts objectAtIndex:64];
              
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
              [self presentViewController:_alert animated:YES completion: nil];*/
             
         }
         else {
             
             
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
             [self presentViewController:_alert animated:YES completion: nil];
         }
         
     }];
    
}

//Added by: Nalina
//Added Date: 28/07/2016
//Discription: To start the timer
-(void) StartTimer
{
    if(![availabilityTimer isValid]){
        availabilityTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timerTick:) userInfo:nil repeats:YES];
        [[NSRunLoop currentRunLoop] addTimer:availabilityTimer forMode:NSDefaultRunLoopMode];
    }
}

//Event called every time the NSTimer ticks.
- (void)timerTick:(NSTimer *)timer
{
    AppDelegate *app= (AppDelegate *)[[UIApplication sharedApplication]delegate];
    
    availabilityTimeSec++;
    if (availabilityTimeSec == 60)
    {
        availabilityTimeSec = 0;
        availabilityTimeMin++;
    }
    
    if(availabilityTimeMin==60)
    {
        availabilityTimeMin=0;
        availabilityTimeHour++;
    }
    
    if ([findClick isEqualToString:@"setOnlineAvailability"]) {
        
        if ([[NSString stringWithFormat:@"%02d:%02d:%02d", availabilityTimeHour,availabilityTimeMin, availabilityTimeSec] isEqual:@"30:00:00"]) {
            [_availabilityToggleBtn setImage:[UIImage imageNamed:@"not-available.png"] forState:UIControlStateNormal];
            _setAvailabilityText.text=@"I am unavailable";
            [self StopTimer];
            return;
        }
    }else if([findClick isEqualToString:@"setOffline"]){
        [self StopTimer];
        return;
        
    }else if([findClick isEqualToString: @"enableJoinsession"]){
        NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
        [formatter setDateFormat:@"hh:mm a"];
        
        //to enable the button before 5 minutes of session starts
        if( [[formatter dateFromString:[[GlobalFunction sharedInstance]Convert24FormatTo12Format:[scheduleAppointment valueForKey:@"scheduledStartTime"]]] timeIntervalSinceDate:[formatter dateFromString:[formatter stringFromDate:[NSDate date]]]]  <= 5 ) {
            _joinSessionView.backgroundColor=[UIColor colorWithRed:(246/255.0) green:(108/255.0) blue:(115/255.0) alpha:1];
            //[self StopTimer];
            return;
        }
        
        //to enable the button and stop timer @ the time of session starts
        if( [[formatter dateFromString:[[GlobalFunction sharedInstance]Convert24FormatTo12Format:[scheduleAppointment valueForKey:@"scheduledStartTime"]]] timeIntervalSinceDate:[formatter dateFromString:[formatter stringFromDate:[NSDate date]]]]  <= 0 ) {
            _joinSessionView.backgroundColor=[UIColor  colorWithRed:(246/255.0) green:(108/255.0) blue:(115/255.0) alpha:1];
            [self StopTimer];
            return;
        }
    }
    else{
        
        if([[[[appdelegate usersDetails] valueForKey:@"providerStatus"] valueForKey:@"availableFrom"] isEqual:[NSNull null]]||[[[[appdelegate usersDetails] valueForKey:@"providerStatus"] valueForKey:@"availableTill"] isEqual:[NSNull null]]){
        }else{
            NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
            [formatter setDateFormat:@"hh:mm a"];
            
            if( [[formatter dateFromString:[[GlobalFunction sharedInstance]Convert24FormatTo12Format:[[[appdelegate usersDetails] valueForKey:@"providerStatus"] valueForKey:@"availableTill"]]] timeIntervalSinceDate:[formatter dateFromString:[formatter stringFromDate:[NSDate date]]]]  <= 0 ) {
                [_availabilityToggleBtn setImage:[UIImage imageNamed:@"not-available.png"] forState:UIControlStateNormal];
                _setAvailabilityText.text=@"I am unavailable";
                [self StopTimer];
                return;
            }
        }
    }
    
    if ([app.accessToken isEqualToString:@""]) {
        [self StopTimer];
    }
}

//Call this to stop the timer event(could use as a 'Pause' or 'Reset')
- (void) StopTimer
{
    
    [availabilityTimer invalidate];
    availabilityTimeSec = 0;
    availabilityTimeMin = 0;
    availabilityTimeHour=0;
    
    NSString* timeNow = [NSString stringWithFormat:@"%02d:%02d:%02d", availabilityTimeHour,availabilityTimeMin, availabilityTimeSec];
    
}

- (pageviewViewController *)viewControllerAtIndex:(NSUInteger)index
{
    NSLog(@"index%lu",scheduledArray.count);
    // Create a new view controller and pass suitable data.
    pageviewViewController *pageContentView = [self.storyboard instantiateViewControllerWithIdentifier:@"pageView"];
    pageContentView.contentLabel= scheduledArray;
    pageContentView.pageIndex = index;
    
    return pageContentView;
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController

{
    NSUInteger index = ((pageviewViewController*) viewController).pageIndex;
    NSUInteger lastrecord  = [scheduledArray count]-1;
    if ((index == 0) || (index == NSNotFound) || (scheduledArray.count == 0)) {
        return nil;
    }
    
    index--;
    
    return [self viewControllerAtIndex:index];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
    NSUInteger index = ((pageviewViewController*) viewController).pageIndex;
    
    if (index == NSNotFound)
    {
        return nil;
    }
    
    index++;
    if ((index == [scheduledArray count]) ||  (scheduledArray.count == 0))
    {
        return nil;
    }
    
    return [self viewControllerAtIndex:index];
}


- (NSInteger)presentationCountForPageViewController:(UIPageViewController *)pageViewController
{
    return [scheduledArray count];
}

- (NSInteger)presentationIndexForPageViewController:(UIPageViewController *)pageViewController
{
    
    return 0;
}


- (IBAction)AvialableBtn:(id)sender {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:
                                @"ProviderStoryboard" bundle:nil];
    OnlineAvailabilityPopupViewController *OnlineAvailController=[storyboard instantiateViewControllerWithIdentifier:@"OnlineAvailabilityPopup"];
    OnlineAvailController.delegate=self;
    self.modalPresentationStyle = UIModalPresentationFullScreen;
    
    OnlineAvailController.modalPresentationStyle = UIModalPresentationOverCurrentContext;
    
    [self presentViewController:OnlineAvailController animated:NO completion:nil];
    [self stopLoadingIndicator];
    
}

- (IBAction)leftsliderButtonClick:(id)sender {
}

- (IBAction)rightsliderButtonClick:(id)sender {
}
@end
