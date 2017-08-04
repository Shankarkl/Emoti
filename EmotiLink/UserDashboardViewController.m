
/***************************************************************
 Page name:UserDashboardViewController.m
 Created By:Zeenath
 Created Date:14/7/16
 Description:Dashboard to show the user information implementation file
 ***************************************************************/

#import "UserDashboardViewController.h"
#import "AppDelegate.h"
#import "paymentInfoViewController.h"
#import "ProviderSearchFirstPage.h"
#import "JoinSessionViewController.h"
#import "GlobalFunction.h"
#import "MyProvidersViewController.h"
#import <Google/Analytics.h>
#import "ProviderMarketPlaceViewController.h"
#import "TopRankingListViewController.h"


#define appdelegate (AppDelegate *)[[UIApplication sharedApplication]delegate]

@interface UserDashboardViewController ()

@end

@implementation UserDashboardViewController
int availabileTimeSec = 0;
int availabileTimeMin = 0;
int availabileTimeHour=0;


//Called when the view controller is first time loaded to memory
- (void)viewDidLoad {
    
    
    _searchProviderBtn.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    // you probably want to center it
    _searchProviderBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    [_searchProviderBtn setTitle: @"Search\nProviders" forState: UIControlStateNormal];
    
    _MyAppointmentsBtn.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    // you probably want to center it
    _MyAppointmentsBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    [_MyAppointmentsBtn setTitle: @"My\nAppointments" forState: UIControlStateNormal];
    
    
    
    _onlineDetailsStore = [[appdelegate usersDetails] valueForKey:@"nextScheduledAppointment"];
    
    
    
    // Do any additional setup after loading the view.
    //self.profileImage.layer.cornerRadius = self.profileImage.frame.size.width / 2;
    //self.profileImage.clipsToBounds = YES;
    
    //  Added by:Nalina
    //  Added Date:2016-12-08.
    //  Description:Service call to get the availabilities.
    availabilityArray = [[NSMutableArray alloc] init];
    availabilityId= [[NSMutableArray alloc] init];
    
    /************** Call availability data service ******************/
    AppDelegate *app= (AppDelegate *)[[UIApplication sharedApplication]delegate];
    
    app.screenState=nil;
    [super viewDidLoad];
    
    /*UIImageView *bgImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"background-dashboard.png"]];
     bgImageView.frame = self.view.bounds;
     bgImageView.contentMode = UIViewContentModeScaleAspectFit;
     bgImageView.clipsToBounds = YES;
     [_backgroundView addSubview:bgImageView];
     [_backgroundView sendSubviewToBack:bgImageView];*/
    
    UIImage *backgroundImage = [UIImage imageNamed:@"background-dashboard.png"];
    UIImageView *backgroundImageView=[[UIImageView alloc]initWithFrame:self.view.frame];
    backgroundImageView.frame = self.view.bounds;
    backgroundImageView.contentMode = UIViewContentModeScaleAspectFit;
    backgroundImageView.clipsToBounds = YES;
    backgroundImageView.image=backgroundImage;
    [self.view insertSubview:backgroundImageView atIndex:0];
    
    /*NSString *securityQuestionUrl=[app.serviceURL stringByAppendingString:@"api/Availability/Availability"];
     [self startLoadingIndicator];
     [[GlobalFunction sharedInstance] getServerResponseAfterLogin:securityQuestionUrl method:@"GET" param:nil withCallback:^(NSInteger statusCode, NSDictionary *response, NSError *error)
     {
     NSDictionary *actualData;
     
     if (statusCode==200) {
     [self stopLoadingIndicator];
     
     NSMutableArray *responseArray = [[NSMutableArray alloc] initWithObjects:response, nil];
     NSMutableArray *sortedArray =[responseArray objectAtIndex:0];
     @autoreleasepool {
     
     for(int i=0;i<sortedArray.count;i++) {
     actualData=[sortedArray objectAtIndex:i];
     NSString *availableList=[actualData objectForKey:@"availabilityType"];
     NSString *availableID=[actualData objectForKey:@"id"];
     
     [availabilityArray addObject:availableList];
     [availabilityId addObject:availableID];
     }
     }
     app.availabilityArray=availabilityArray;
     app.availabilityId=availabilityId;
     
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
     }];
     
     [_alert addAction:okbutton];
     [self presentViewController:_alert animated:YES completion: nil];
     [self stopLoadingIndicator];
     }
     }];*/
    
    /* app.screenState=nil;
     [super viewDidLoad];
     UIImageView *bgImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"background-dashboard.png"]];
     bgImageView.frame = self.backgroundView.bounds;
     [_backgroundView addSubview:bgImageView];
     [_backgroundView sendSubviewToBack:bgImageView];*/
    
}




-(int) minutesSinceMidnight:(NSDate *)date
{
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond fromDate:date];
    return 60 * (int)[components hour] + (int)[components minute];
}

//called each time when the view is appeared
-(void)viewDidAppear:(BOOL)animated{
    AppDelegate *app= (AppDelegate *)[[UIApplication sharedApplication]delegate];
    
    //_onlineDetailsStore = [[appdelegate usersDetails] valueForKey:@"nextScheduledAppointment"];
    
    [[appdelegate usersDetails] setObject:_onlineDetailsStore  forKey:@"nextScheduledAppointment"];
    
    NSLog(@"Online Details %@",[appdelegate usersDetails]);
    
    if (self.tabBarController.selectedIndex==3) {
        [_emergencyBackView setHidden:NO];
    }else{
        [_emergencyBackView setHidden:YES];
    }
    
    //Added by: Zeenath
    //Added Date: 18/08/2016
    //Discription: Bind the user datas
    if([[[appdelegate usersDetails] valueForKey:@"nextScheduledAppointment"] isEqual:[NSNull null]] || [[[appdelegate usersDetails] valueForKey:@"nextScheduledAppointment"] isEqual:nil])
    {
        _appointmentLabel.text=@"You have no appointments yet!";
        _joinsessionButton.backgroundColor=[UIColor  colorWithRed:(246/255.0) green:(108/255.0) blue:(115/255.0) alpha:1];
        [_joinsessionButton setEnabled:YES];
        [_joinsessionButton setTitle:@"Start Now" forState:UIControlStateNormal];
    }
    else{
        
        if ([[appdelegate screenStatus] isEqualToString:@"fromJoinsession"]) {
            
            _joinsessionButton.backgroundColor=[UIColor colorWithRed:(246/255.0) green:(108/255.0) blue:(115/255.0) alpha:1];
            [_joinsessionButton setEnabled:YES];
            
            [_joinsessionButton setTitle:@"Join Session" forState:UIControlStateNormal];
            _appointmentLabel.text=@"Your appointment in progress!";
        }
        else{
            _joinsessionButton.backgroundColor=[UIColor grayColor];
            [_joinsessionButton setTitle:@"Join Session" forState:UIControlStateNormal];
            
            NSDictionary *appointments=[[appdelegate usersDetails] valueForKey:@"nextScheduledAppointment"];
            _appointmentLabel.text=[appointments valueForKey:@"appointment"];
            [_joinsessionButton setEnabled:NO];
            
            app.todaysSchedules=[[appdelegate usersDetails] valueForKey:@"nextScheduledAppointment"];
            appointmentID=[appointments valueForKey:@"appointmentID"];
            NSString *startTimeString = [[GlobalFunction sharedInstance]Convert24FormatTo12Format:[appointments valueForKey:@"scheduledStartTime"]];
            
            NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
            [formatter setDateFormat:@"hh:mm a"];
            
            int startTime  = [self minutesSinceMidnight:[formatter dateFromString:startTimeString]];
            int nowTime     = [self minutesSinceMidnight:[formatter dateFromString:[formatter stringFromDate:[NSDate date]]]];;
            
            if (startTime-nowTime<=30) {
                [self StartTimer];
            }
            
            if (startTime-nowTime<=5) {
                _joinsessionButton.backgroundColor=[UIColor colorWithRed:(246/255.0) green:(108/255.0) blue:(115/255.0) alpha:1];
                [_joinsessionButton setEnabled:YES];
            }
        }
    }
    
    NSString *userName=[[appdelegate usersDetails]valueForKey:@"displayName"];
    _nameLabel.text = [NSString stringWithFormat:@"%@%@%@", @"Hi ", userName, @"!"];
    
    //Added by: Zeenath
    //Added Date: 20/08/2016
    //Discription: Different fonts for the same label, name
    
    /*NSString *userName=[[appdelegate usersDetails]valueForKey:@"displayName"];
     
     UIFont *font1 = [UIFont fontWithName:@"CenturyGothic" size:16];
     NSDictionary *arialDict = [NSDictionary dictionaryWithObject: font1 forKey:NSFontAttributeName];
     NSMutableAttributedString *aAttrString1 = [[NSMutableAttributedString alloc] initWithString:@"Hello, " attributes: arialDict];
     
     UIFont *font2 = [UIFont fontWithName:@"CenturyGothic-Bold" size:16];
     NSDictionary *arialDict2 = [NSDictionary dictionaryWithObject: font2 forKey:NSFontAttributeName];
     NSMutableAttributedString *aAttrString2 = [[NSMutableAttributedString alloc] initWithString:userName attributes: arialDict2];
     
     
     [aAttrString1 appendAttributedString:aAttrString2];
     _nameLabel.attributedText = aAttrString1;
     
     NSString *name=[[appdelegate usersDetails]valueForKey:@"profilePicPath"];
     NSString *imagename=[[appdelegate imageURL] stringByAppendingString:name];
     
     @autoreleasepool {
     
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
     
     });
     }*/
    
}

// Dispose of any resources that can be recreated.
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

//called each time when the view appears
-(void)viewWillAppear:(BOOL)animated
{
    self.tabBarController.tabBar.hidden = NO;
    self.navigationItem.hidesBackButton = NO;
    self.tabBarController.delegate = (id)self;
    [[self navigationController] setNavigationBarHidden:NO animated:YES];
    
    
    //Added by: Nalina
    //Added Date: 20/08/2016
    //Discription: Payment popup for the first user
    
    NSDictionary *userStatus=[[appdelegate usersDetails]valueForKey:@"userStatus"];
    
    if([[userStatus valueForKey:@"isPaymentInfoUpdated"] isEqualToNumber:[NSNumber numberWithInt:0]] )
    {
        _firstuserBackPage.hidden=NO;
        [[[[self.tabBarController tabBar]items]objectAtIndex:1]setEnabled:TRUE];
        [[[[self.tabBarController tabBar]items]objectAtIndex:2]setEnabled:TRUE];
        [[[[self.tabBarController tabBar]items]objectAtIndex:3]setEnabled:TRUE];
        
    }else{
        _firstuserBackPage.hidden=YES;
        [[[[self.tabBarController tabBar]items]objectAtIndex:1]setEnabled:TRUE];
        [[[[self.tabBarController tabBar]items]objectAtIndex:2]setEnabled:TRUE];
        [[[[self.tabBarController tabBar]items]objectAtIndex:3]setEnabled:TRUE];
    }
    
    id<GAITracker> tracker = [[GAI sharedInstance] defaultTracker];
    [tracker set:kGAIScreenName value:@"UserDashboard"];
    [tracker send:[[GAIDictionaryBuilder createScreenView] build]];
    
}


//Added by: Nalina
//Added Date: 20/08/2016
//Discription: Called when a tab item in the tab bar is clicked
-(void) tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
{
    if(tabBarController.selectedIndex==3){
        [_emergencyBackView setHidden:NO];
    }else{
        [_emergencyBackView setHidden:YES];
    }
    
}


//Added by: Nalina
//Added Date: 20/08/2016
//Discription: Called to make a call to 911
- (IBAction)callYes:(id)sender {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"tel:911"]];
}

//Added by: Nalina
//Added Date: 20/08/2016
//Discription: Called to cancel the call
- (IBAction)callNo:(id)sender {
    [self.tabBarController setSelectedIndex:0];
    [_emergencyBackView setHidden:YES];
}


//Added by: Zeenath
//Added Date: 20/08/2016
//Discription: To navigate to the marketplace screen
- (IBAction)providerMarketPlaceClick:(id)sender {
    
    [self ServiceCall];
    
}


//  Added by:Nalina
//  Added Date:2016-12-08.
//  Description:Called when the join session button is clicked.

- (IBAction)joinSessionClick:(id)sender {
    
    UIColor *backgroundColor=[UIColor colorWithRed:(246/255.0) green:(108/255.0) blue:(115/255.0) alpha:1];
    AppDelegate *app= (AppDelegate *)[[UIApplication sharedApplication]delegate];
    
    NSLog(@"label text = %@",_joinsessionButton.titleLabel.text);
    
    if ([_joinsessionButton.titleLabel.text isEqualToString:@"Start Now"]) {
        
        [self ServiceCall];
        
    }else if([_joinsessionButton.titleLabel.text isEqualToString:@"Join Session"] && [_joinsessionButton.backgroundColor isEqual:backgroundColor]){
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:
                                    @"GeneralStoryboard" bundle:nil];
        JoinSessionViewController *viewcontrol=[storyboard instantiateViewControllerWithIdentifier:@"JoinSession"];
        viewcontrol.appointmentID=appointmentID;
        app.screenState=@"userDashboard";
        [self presentViewController:viewcontrol animated:NO completion:nil];
    }
    
}

- (IBAction)myAppointmentsClick:(id)sender {
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName: @"GeneralStoryboard" bundle:nil];
    
    [self presentViewController:[storyboard instantiateViewControllerWithIdentifier:@"ScheduledAppointments"] animated:NO completion:nil];
    
}

//Added by: Nalina
//Added Date: 20/08/2016
//Discription: To navigate to the my providers screen
- (IBAction)myprovidersClick:(id)sender {
    MyProvidersViewController *myprovider=[self.storyboard instantiateViewControllerWithIdentifier:@"myprovider"];
    myprovider.screenStatus=@"fromDashboard";
    [self.navigationController pushViewController:myprovider animated:YES];
}

//  Added by:Zeenath
//  Added Date:2016-08-08.
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
//  Added Date:2016-08-08.
//  Description:To stop the activity indicator.
-(void)stopLoadingIndicator
{
    _loadingView.hidden=YES;
}


- (IBAction)paymentInformationClick:(id)sender {
    paymentInfoViewController  *vc=[self.storyboard instantiateViewControllerWithIdentifier:@"paymentInfo"];
    [self.navigationController pushViewController:vc animated:YES];
}


//  Added by:Nalina
//  Added Date:2016-08-08.
//  Description:To start the timer.
-(void) StartTimer
{
    if(![availabileTimer isValid]){
        availabileTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timerTick:) userInfo:nil repeats:YES];
        [[NSRunLoop currentRunLoop] addTimer:availabileTimer forMode:NSDefaultRunLoopMode];
    }
}

//Event called every time the NSTimer ticks.
- (void)timerTick:(NSTimer *)timer
{
    AppDelegate *app= (AppDelegate *)[[UIApplication sharedApplication]delegate];
    
    availabileTimeSec++;
    if (availabileTimeSec == 60)
    {
        availabileTimeSec = 0;
        availabileTimeMin++;
    }
    
    if(availabileTimeMin==60)
    {
        availabileTimeMin=0;
        availabileTimeHour++;
    }
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"hh:mm a"];
    
    if([[[appdelegate usersDetails] valueForKey:@"nextScheduledAppointment"] isKindOfClass:[NSNull class]]){
        [self StopTimer];
        return;
    }
    
    if( [[formatter dateFromString:[[GlobalFunction sharedInstance]Convert24FormatTo12Format:[[[appdelegate usersDetails] valueForKey:@"nextScheduledAppointment"] valueForKey:@"scheduledStartTime"]]] timeIntervalSinceDate:[formatter dateFromString:[formatter stringFromDate:[NSDate date]]]]  <= 5 ) {
        
        _joinsessionButton.backgroundColor=[UIColor colorWithRed:(246/255.0) green:(108/255.0) blue:(115/255.0) alpha:1];
        [_joinsessionButton setTitle:@"Join Session" forState:UIControlStateNormal];
        //[self StopTimer];
        return;
    }
    
    if( [[formatter dateFromString:[[GlobalFunction sharedInstance]Convert24FormatTo12Format:[[[appdelegate usersDetails] valueForKey:@"nextScheduledAppointment"] valueForKey:@"scheduledStartTime"]]] timeIntervalSinceDate:[formatter dateFromString:[formatter stringFromDate:[NSDate date]]]]  <= 0 ) {
        
        _joinsessionButton.backgroundColor=[UIColor colorWithRed:(246/255.0) green:(108/255.0) blue:(115/255.0) alpha:1];
        [_joinsessionButton setTitle:@"Join Session" forState:UIControlStateNormal];
        [self StopTimer];
        return;
    }
    
    if ([app.accessToken isEqualToString:@""]) {
        [self StopTimer];
    }
}


//Call this to stop the timer event(could use as a 'Pause' or 'Reset')
- (void) StopTimer
{
    [availabileTimer invalidate];
    availabileTimeSec = 0;
    availabileTimeMin = 0;
    availabileTimeHour=0;
    
    NSString* timeNow = [NSString stringWithFormat:@"%02d:%02d:%02d", availabileTimeHour,availabileTimeMin, availabileTimeSec];
    
    
}
//call Ranking API
-(void)ServiceCall{
    
    [self startLoadingIndicator];
    AppDelegate *app= (AppDelegate *)[[UIApplication sharedApplication]delegate];
    
    NSString *getRankingUrl=[app.serviceURL stringByAppendingString:@"api/Admin/GetProviderRanking"];
    [[GlobalFunction sharedInstance] getServerResponseForUrl:getRankingUrl method:@"GET" param:nil withCallback:^(NSInteger statusCode, NSDictionary *response, NSError *error)
     {
         
         // GlobalFunction *globalValues=[[GlobalFunction alloc]init];
         NSString *message;
         
         if (statusCode == 200 || statusCode==400)
         {
             [self stopLoadingIndicator];
             UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"UserStoryboard" bundle:nil];
             
             TopRankingListViewController *vc=[storyboard instantiateViewControllerWithIdentifier:@"TopRankingList"];
             
             if(statusCode==200){
                 NSMutableArray *responseArray=[response mutableCopy];
                 vc.providerDataArray=responseArray;
             }
             
             [self presentViewController:vc animated:YES completion:nil];
             
         }else if(statusCode==404){
             
             _alert = [UIAlertController
                       alertControllerWithTitle:@""
                       message:[[GlobalFunction sharedInstance].arrayOfAlerts objectAtIndex:78]
                       preferredStyle:UIAlertControllerStyleAlert];
             
             UIAlertAction* okButton = [UIAlertAction
                                        actionWithTitle:@"OK"
                                        style:UIAlertActionStyleDefault
                                        handler:^(UIAlertAction * action) {
                                            [self stopLoadingIndicator];
                                        }];
             [_alert addAction:okButton];
             [self presentViewController:_alert animated:YES completion:nil];
             
         }else{
             
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
         }
     }];
    
}


@end
