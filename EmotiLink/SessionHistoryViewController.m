/***************************************************************
 Page name: SessionHistoryViewController.m
 Created By:Nalina
 Created Date:11/07/16
 Description:my clients implementation file
 ***************************************************************/

#import "SessionHistoryViewController.h"
#import "SessionHistoryTableViewCell.h"
#import <Google/Analytics.h>
#include "GlobalFunction.h"
#include "AppDelegate.h"
#import "RescheduleAppointmentViewController.h"
#import "SessionDetailsViewController.h"
#include "SessionFilterpopupViewController.h"
#import "RejectAppointmentpopupViewController.h"
#import <HCSStarRatingView/HCSStarRatingView.h>


@interface SessionHistoryViewController ()<RescheduleViewControllerDelegate ,RejectViewControllerDelegate>{
    NSMutableDictionary *rescheduleData;
    NSMutableDictionary *details;
    NSString *appointmentID ;
    NSString *rescheduleappointmentID ;
    NSString*rate ;
    NSString*providerid ;
    NSDictionary *ResponseIndividualElement;
    NSArray *_sections;
    NSMutableArray *_testArray;
}
@property (nonatomic) BOOL useCustomCells;
@property (nonatomic, weak) UIRefreshControl *refreshControl;
@end

@implementation SessionHistoryViewController
- (void)dataFromController:(NSString *)data {
    if([data isEqualToString:@"200"]){
        
        NSLog(@"SUCCESSFUL");
        AppDelegate *appdelegate= (AppDelegate *)[[UIApplication sharedApplication]delegate];
        
        NSString *userName=[[appdelegate usersDetails]valueForKey:@"userRole"];
        
          if (![_headerlbl.text isEqualToString:@"Rescheduled Appointments"]){
        NSString *getUrl=[appdelegate.serviceURL stringByAppendingString:@"api/Appointments/AppointmentWaitingApproval"];
        
        [self ServiceCall:nil url:getUrl method:@"GET" param:nil];
         }else{
             NSString *getUrl=[appdelegate.serviceURL stringByAppendingString:@"api/Appointments/RescheduleAppointmentWaitingApproval"];
             
             [self ServiceCall:nil url:getUrl method:@"GET" param:nil];
         }
        
        /*SessionHistoryTableViewCell *cell = [_sessionHistoryTable dequeueReusableCellWithIdentifier:@"sessionHistoryCell" forIndexPath:indexPath];
         NSIndexPath *indexPath =[_sessionHistoryTable indexPathForCell:cell];
         [sessionHistoryArray removeObjectAtIndex:indexPath.row];
         [self.sessionHistoryTable reloadData];*/
    }
}
+ (instancetype)sharedInstance {
    static SessionHistoryViewController *_instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[SessionHistoryViewController alloc] init];
    });
    
    return _instance;
}
//Loads first time when page appears
- (void)viewDidLoad {
    
    [super viewDidLoad];
    /*if([[_userRole objectForKey:@"fromsetting"] isEqualToString:@"1"]){
     _Backbtn.hidden=NO;
     }else{
     _Backbtn.hidden=YES;
     }*/
    providerId= [[NSMutableDictionary alloc]init];
    // Setup refresh control for example app
    UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
    [refreshControl addTarget:self action:@selector(toggleCells:) forControlEvents:UIControlEventValueChanged];
    refreshControl.tintColor = [UIColor blueColor];
    
    self.refreshControl = refreshControl;
    
    
    _SessionFilterView.hidden=YES;
    //NSLog(@"Changed rating to %@",_userRole);
    UIImage *backgroundImage = [UIImage imageNamed:@"05. List-View.png"];
    UIImageView *backgroundImageView=[[UIImageView alloc]initWithFrame:self.view.frame];
    backgroundImageView.image=backgroundImage;
    [self.view insertSubview:backgroundImageView atIndex:0];
    
    //sessionHistoryArray=[[NSMutableArray alloc]initWithObjects:
    //@"Data 1 in array",@"Data 2 in array",@"Data 3 in array"
    //, nil];
    
    //sessionHistoryArray=[sessionHistoryArray mutableCopy];
    
    //Added by: Zeenath
    //Added Date: 20/08/2016
    //Discription: service call to get the list of scheduled appointments
    
    // GlobalFunction *globalValues=[[GlobalFunction alloc]init];
    
    //sessionHistoryTable.dataSource=self;
    //sessionHistoryTable.delegate=self;
    
    //_sessionHistoryArray = [[NSMutableArray alloc] init];
    
    
    //[_sessionHistoryTable reloadData];
    AppDelegate *appdelegate= (AppDelegate *)[[UIApplication sharedApplication]delegate];
    
    /*if((urlValue) ){
     urlValue=[appdelegate.serviceURL stringByAppendingString:@"api/Appointments/SessionHistory"];
     }*/
    
    //[urlValue isEqualToString:@""]
    /*if((urlValue==nil) ){
     urlValue=[appdelegate.serviceURL stringByAppendingString:@"api/Appointments/SessionHistory"];
     }*/
    
    //[[SessionHistoryViewController sharedInstance] ServiceCall:nil url:getUrl method:@"GET" param:nil];
    
    //[self ServiceCall:nil url:getUrl method:@"GET" param:nil];
    
    //AppDelegate *appdelegate= (AppDelegate *)[[UIApplication sharedApplication]delegate];
    //NSString *getUrl=[appdelegate.serviceURL stringByAppendingString:@"api/Appointments/SessionHistory"];
    
    NSString *getUrl=[appdelegate.serviceURL stringByAppendingString:@"api/Appointments/SessionHistory"];
    
    [self ServiceCall:_sessionHistoryView url:getUrl method:@"GET" param:nil];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

//Loads each time when page appears
-(void)viewWillAppear:(BOOL)animated
{
    //[sessionHistoryTable reloadData];
    id<GAITracker> tracker = [[GAI sharedInstance] defaultTracker];
    [tracker set:kGAIScreenName value:@"SessionHistory"];
    [tracker send:[[GAIDictionaryBuilder createScreenView] build]];
    
}

-(void)viewDidAppear:(BOOL)animated
{
    [_sessionHistoryTable reloadData];
    
    
}

- (IBAction)didChangeValue:(HCSStarRatingView *)sender {
    NSLog(@"Changed rating to %.1f", sender.value);
}

//Close the screen on click of back icon
- (IBAction)backArrrowClick:(id)sender {
    NSLog(@"%@",[self.navigationController.viewControllers objectAtIndex:self.navigationController.viewControllers.count-2]);
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
    //self.tabBarController.selectedIndex = 0;
    
    
}


//  Added by:Zeenath
//  Added Date:2016-20-08.
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
//  Added Date:2016-20-08.
//  Description:To stop the activity indicator.
-(void)stopLoadingIndicator
{
    
    _loadingView.hidden=YES;
}

- (IBAction)sessionHistoryFilter:(id)sender {
    
    /*SessionFilterpopupViewController *SessionFilterPopUp=[self.storyboard instantiateViewControllerWithIdentifier:@"SessionFilterPopUp"];
     
     self.modalPresentationStyle = UIModalPresentationFullScreen;
     
     SessionFilterPopUp.modalPresentationStyle = UIModalPresentationOverCurrentContext;
     [self presentViewController: SessionFilterPopUp animated:YES completion:nil];*/
    
    //[_sessionHistoryTable reloadData];
    _SessionFilterView.hidden=NO;
    /* AppDelegate *appdelegate= (AppDelegate *)[[UIApplication sharedApplication]delegate];
     [self ServiceCall:nil url:[appdelegate.serviceURL stringByAppendingString:@"api/Appointments/AppointmentWaitingApproval"] method:@"GET" param:nil];*/
    
    
}
-(void)ServiceCall :(UIButton *)thebutton url:(NSString *)url method:(NSString *)method param:(NSDictionary *)param
{
    sessionHistoryArray=(NULL);
    //urlValue=url;
    //[self viewDidLoad];
    
    //[_sessionHistoryTable reloadData];
    
    //sessionHistoryArray = [NSMutableArray array];
    AppDelegate *appdelegate= (AppDelegate *)[[UIApplication sharedApplication]delegate];
    //NSString *getUrl=[appdelegate.serviceURL stringByAppendingString:@"api/Appointments/SessionHistory"];
    
    [self startLoadingIndicator];
    [[GlobalFunction sharedInstance] getServerResponseAfterLogin:url method:method param:param withCallback:^(NSInteger statusCode, NSDictionary *response, NSError *error)
     {
         [sessionHistoryArray removeAllObjects];
         details=[response mutableCopy];
         
         [_sessionHistoryTable reloadData];
         if (statusCode == 200)
         {
             //Return number of section in table
             //[self viewDidLoad];
             
             sessionHistoryArray=[response mutableCopy];
             [_sessionHistoryTable reloadData];
             
             //NSLog(@"my response to %@",sessionHistoryArray);
             [self stopLoadingIndicator];
             
             
         }else if(statusCode==404){
             [self stopLoadingIndicator];
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
         }
     }];
    
    // return sessionHistoryArray;
    
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}


//Return the number of rows count to display in table
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return (sessionHistoryArray.count);
}


//Return the data to display and cell in table
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    //Added by: Zeenath
    //Added Date: 20/08/2016
    //Discription: Bind data to the cell
    SessionHistoryTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"sessionHistoryCell" forIndexPath:indexPath];
    AppDelegate *appdelegate=(AppDelegate *)[[UIApplication sharedApplication]delegate];
    NSString *userName=[[appdelegate usersDetails]valueForKey:@"userRole"];
    NSMutableDictionary *myJsonResponseIndividualElement = sessionHistoryArray[indexPath.row];
    //cell.profileImageView.layer.cornerRadius = cell.profileImageView.frame.size.width / 2;
    cell.profileImageView.clipsToBounds = YES;
    
   
    cell.CellView.tag=indexPath.row;
    
    
    UITapGestureRecognizer *cellViewTap =
    [[UITapGestureRecognizer alloc] initWithTarget:self
                                            action:@selector(redirectToSessionDetails:)];
    [cell.CellView addGestureRecognizer:cellViewTap];

    
    if(sessionHistoryArray.count>0)
    {
        
        
        /*if (indexPath.row % 2) {
         cell.mainview.backgroundColor = [[UIColor alloc]initWithRed:51.0/255.0 green:51.0/255.0 blue:51.0/255.0 alpha:1];
         }else{
         cell.mainview.backgroundColor =[[UIColor alloc]initWithRed:62.0/255.0 green:62.0/255.0 blue:62.0/255.0 alpha:1];
         }*/
        
        providerId=[myJsonResponseIndividualElement mutableCopy];
        NSLog(@"myarrayyyy to %@",myJsonResponseIndividualElement);
        NSString *userName=[[appdelegate usersDetails]valueForKey:@"userRole"];
        if ([_headerlbl.text isEqualToString:@"Rescheduled Appointments"]){
             rescheduleappointmentID=myJsonResponseIndividualElement[@"reScheduleAppointmentsId"] ;
            _CreatedBy=myJsonResponseIndividualElement[@"createdBy"] ;
            
        }
        _ProviderId=myJsonResponseIndividualElement[@"providerID"] ;
        _ClientId=myJsonResponseIndividualElement[@"clientID"] ;
        appointmentID=myJsonResponseIndividualElement[@"appointmentID"];
        providerid=myJsonResponseIndividualElement[@"providerID"] ;
        rate=myJsonResponseIndividualElement[@"rating"] ;
        NSLog(@"APPOINT%@",providerId);
        NSLog(@"RATE%@",rate);
        cell.dateTimeLabel.text=myJsonResponseIndividualElement[@"appointmentTimeSting"];
        
        if ([userName isEqualToString:@"Provider"]){
            NSString *name=[myJsonResponseIndividualElement[@"clientFirstName"] stringByAppendingString:@" "];
            cell.firstname.text=name; //[name stringByAppendingString:myJsonResponseIndividualElement[@"clientLastName"]];
            cell.amountLabel.hidden=YES;
            NSString *offeredamount=@"Offered amount:";
            cell.ExpertiseLbl.text=[offeredamount stringByAppendingString:myJsonResponseIndividualElement[@"offeredAmountCurrency"]];
            
            NSString *imagePath= myJsonResponseIndividualElement[@"clientProfilePicPath"];
            NSString *imagename=[appdelegate.imageURL stringByAppendingString:imagePath];
            dispatch_queue_t imagequeue =dispatch_queue_create("imageDownloader", nil);
            dispatch_async(imagequeue, ^{
                
                //download iamge
                NSData *imageData = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:imagename]];
                UIImage *image = [[UIImage alloc] initWithData:imageData];
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    if (image==NULL) {
                        UIImage *image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"upload-profile" ofType:@"png"]];
                        cell.profileImageView.image  = image;
                    }
                    else{
                        cell.profileImageView.image  = image;
                    }
                });
                
            });
        }else{
            cell.amountLabel.hidden=NO;
            cell.ExpertiseLbl.text=myJsonResponseIndividualElement[@"qualification"];
            NSString *name=[myJsonResponseIndividualElement[@"providerFirstName"] stringByAppendingString:@" "];
            cell.firstname.text=name; //[name stringByAppendingString:myJsonResponseIndividualElement[@"clientLastName"]];
            cell.amountLabel.text=[myJsonResponseIndividualElement[@"providerRateCurrency"]stringByAppendingString:@"/hour"];
            
            NSString *imagePath= myJsonResponseIndividualElement[@"providerProfilePicPath"];
            NSString *imagename=[appdelegate.imageURL stringByAppendingString:imagePath];
            dispatch_queue_t imagequeue =dispatch_queue_create("imageDownloader", nil);
            dispatch_async(imagequeue, ^{
                
                //download iamge
                NSData *imageData = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:imagename]];
                UIImage *image = [[UIImage alloc] initWithData:imageData];
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    if (image==NULL) {
                        UIImage *image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"upload-profile" ofType:@"png"]];
                        cell.profileImageView.image  = image;
                    }
                    else{
                        cell.profileImageView.image  = image;
                    }
                });
                
            });
            
        }
        
        
        NSString *getDate=myJsonResponseIndividualElement[@"appointmentDate"];
        
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss"];
        NSDate *dateFromString = [[NSDate alloc] init];
        dateFromString = [dateFormatter dateFromString:getDate];
        
        NSDateFormatter *format = [[NSDateFormatter alloc] init];
        format.dateFormat = @"EEE, dd MMM YYYY";
        NSString *date=[format stringFromDate:dateFromString];
        
        NSString *starttime=  [[GlobalFunction sharedInstance] Convert24FormatTo12Format:myJsonResponseIndividualElement[@"scheduledStartTime"]];
        NSString *endtime=  [[GlobalFunction sharedInstance] Convert24FormatTo12Format:myJsonResponseIndividualElement[@"scheduledEndTime"]];
        
        //NSString *appointmentTime=[[date stringByAppendingString:@" "] stringByAppendingString:starttime];
        
        cell.dayLabel.text=date;
        
        cell.dateTimeLabel.text=[[starttime stringByAppendingString:@" - "] stringByAppendingString:endtime];
        
        
        if (![userName isEqualToString:@"Provider"]){
            
            NSString *rateValue=myJsonResponseIndividualElement[@"rating"];
            HCSStarRatingView *starRatingView = [[HCSStarRatingView alloc] initWithFrame:CGRectMake(95, 0, 100, 50)];
            starRatingView.maximumValue = 5;
            starRatingView.minimumValue = 0;
            starRatingView.allowsHalfStars = YES;
            starRatingView.enabled=false;
            starRatingView.value = [rateValue floatValue];
            starRatingView.tintColor = [UIColor colorWithRed:118.0/255.0 green:183.0/255.0 blue:189.0/255.0 alpha:1];
            //starRatingView.BorderColor=[UIColor colorWithRed:118.0/255.0 green:183.0/255.0 blue:189.0/255.0 alpha:1];
            starRatingView.backgroundColor=[UIColor clearColor];
            
            [starRatingView addTarget:self action:@selector(didChangeValue:) forControlEvents:UIControlEventValueChanged];
            [cell addSubview:starRatingView];
            
        }
    }
    
    if([_headerlbl.text isEqualToString:@"Scheduled Appointments"]){
        [cell setRightUtilityButtons:[self rightButtons] WithButtonWidth:58.0f];
    }else if([_headerlbl.text isEqualToString:@"Rescheduled Appointments"]){
        NSLog(@"createdby%@",_CreatedBy);
         NSLog(@"providerid%@",myJsonResponseIndividualElement[@"providerID"]);
        NSLog(@"clientid%@",myJsonResponseIndividualElement[@"clientID"]);
        if (![userName isEqualToString:@"Provider"]){
            if([_CreatedBy isEqualToString:myJsonResponseIndividualElement[@"clientID"]]){
                [cell setRightUtilityButtons:nil WithButtonWidth:58.0f];
            }else{
                 [cell setRightUtilityButtons:[self rightButtons] WithButtonWidth:58.0f];
            }
        }else if ([userName isEqualToString:@"Provider"]){
            if([_CreatedBy isEqualToString:myJsonResponseIndividualElement[@"providerID"]]){
                [cell setRightUtilityButtons:nil WithButtonWidth:58.0f];
            }else{
                [cell setRightUtilityButtons:[self rightButtons] WithButtonWidth:58.0f];
            }
        }else{
            [cell setRightUtilityButtons:[self rightButtons] WithButtonWidth:58.0f];
        }
        
    
    } else if([_headerlbl.text isEqualToString:@"Session Approval"] ){
        if (![userName isEqualToString:@"Provider"]){
            if([myJsonResponseIndividualElement[@"status"] isEqualToString:@"ReScheduled"]){
                [cell setRightUtilityButtons:[self rightButtons] WithButtonWidth:58.0f];
            }
        }else{
            [cell setRightUtilityButtons:[self rightButtons] WithButtonWidth:58.0f];
        }
    }
    else{
        [cell setRightUtilityButtons:nil WithButtonWidth:58.0f];
    }
    cell.delegate = self;
    

    
    return cell;
}

- (IBAction)CancelBtn:(id)sender {
    _SessionFilterView.hidden=YES;
    //[self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)SessionHistoryBtn:(id)sender {
    _SessionFilterView.hidden=YES;
    _headerlbl.text=@"Session History";
    // [self dismissViewControllerAnimated:YES completion:nil];
    AppDelegate *appdelegate= (AppDelegate *)[[UIApplication sharedApplication]delegate];
    NSString *getUrl=[appdelegate.serviceURL stringByAppendingString:@"api/Appointments/SessionHistory"];
    
    [self ServiceCall:_sessionHistoryView url:getUrl method:@"GET" param:nil];
}

- (IBAction)ScheduleAppointmentBtn:(id)sender {
    _SessionFilterView.hidden=YES;
    _headerlbl.text=@"Scheduled Appointments";
    //[self dismissViewControllerAnimated:YES completion:nil];
    AppDelegate *appdelegate= (AppDelegate *)[[UIApplication sharedApplication]delegate];
    NSString *getUrl=[appdelegate.serviceURL stringByAppendingString:@"api/Appointments/ScheduleAppointment"];
    
    [self ServiceCall:nil url:getUrl method:@"GET" param:nil];
}

- (IBAction)sessionApprovalBtn:(id)sender {
    _SessionFilterView.hidden=YES;
    _headerlbl.text=@"Session Approval";
    //[self dismissViewControllerAnimated:YES completion:nil];
    AppDelegate *appdelegate= (AppDelegate *)[[UIApplication sharedApplication]delegate];
    NSString *getUrl=[appdelegate.serviceURL stringByAppendingString:@"api/Appointments/AppointmentWaitingApproval"];
    
    [self ServiceCall:nil url:getUrl method:@"GET" param:nil];
}

- (IBAction)CancelAppointmentBtn:(id)sender {
    _headerlbl.text=@"Cancelled Appointments";
    _SessionFilterView.hidden=YES;
    //[self dismissViewControllerAnimated:YES completion:nil];
    AppDelegate *appdelegate= (AppDelegate *)[[UIApplication sharedApplication]delegate];
    NSString *getUrl=[appdelegate.serviceURL stringByAppendingString:@"api/Appointments/CanceledAppointments"];
    
    [self ServiceCall:nil url:getUrl method:@"GET" param:nil];
}

- (IBAction)RejectAppointmentBtn:(id)sender {
    _headerlbl.text=@"Rejected Appointments";
    _SessionFilterView.hidden=YES;
    //[self dismissViewControllerAnimated:YES completion:nil];
    AppDelegate *appdelegate= (AppDelegate *)[[UIApplication sharedApplication]delegate];
    NSString *getUrl=[appdelegate.serviceURL stringByAppendingString:@"api/Appointments/RejectedAppointments"];
    [self ServiceCall:nil url:getUrl method:@"GET" param:nil];
}

- (IBAction)RescheduleAppointment:(id)sender {
    
    _SessionFilterView.hidden=YES;
    _headerlbl.text=@"Rescheduled Appointments";
    //[self dismissViewControllerAnimated:YES completion:nil];
    AppDelegate *appdelegate= (AppDelegate *)[[UIApplication sharedApplication]delegate];
    NSString *getUrl=[appdelegate.serviceURL stringByAppendingString:@"api/Appointments/RescheduleAppointmentWaitingApproval"];
    
    [self ServiceCall:nil url:getUrl method:@"GET" param:nil];
    
}
#pragma mark - UIRefreshControl Selector

- (void)toggleCells:(UIRefreshControl*)refreshControl
{
    [refreshControl beginRefreshing];
    self.useCustomCells = !self.useCustomCells;
    if (self.useCustomCells)
    {
        self.refreshControl.tintColor = [UIColor yellowColor];
    }
    else
    {
        self.refreshControl.tintColor = [UIColor blueColor];
    }
    [_sessionHistoryTable reloadData];
    [refreshControl endRefreshing];
}



- (NSArray *)rightButtons
{
    NSMutableArray *rightUtilityButtons = [NSMutableArray new];
    if([_headerlbl.text isEqualToString:@"Session Approval"] || [_headerlbl.text isEqualToString:@"Rescheduled Appointments"]){
        [rightUtilityButtons sw_addUtilityButtonWithColor:
         [UIColor colorWithRed:92.0/255.0 green:103.0/255.0 blue:128.0/255.0 alpha:1]
                                                     icon:[UIImage imageNamed:@"accepted.png"]];
        [rightUtilityButtons sw_addUtilityButtonWithColor:
         [UIColor colorWithRed:247.0/255.0 green:123.0/255.0 blue:132.0/255.0 alpha:1]
                                                     icon:[UIImage imageNamed:@"rejected.png"]];
        [rightUtilityButtons sw_addUtilityButtonWithColor:
         [UIColor colorWithRed:118.0/255.0 green:183.0/255.0 blue:189.0/255.0 alpha:1]
                                                     icon:[UIImage imageNamed:@"rescheduled.png"]];
    }else if([_headerlbl.text isEqualToString:@"Scheduled Appointments"]){
        [rightUtilityButtons sw_addUtilityButtonWithColor:
         [UIColor colorWithRed:247.0/255.0 green:123.0/255.0 blue:132.0/255.0 alpha:1]
                                                     icon:[UIImage imageNamed:@"deleted.png"]];
    }else{
        
    }
    return rightUtilityButtons;
}

- (NSArray *)leftButtons
{
    NSMutableArray *leftUtilityButtons = [NSMutableArray new];
    
    [leftUtilityButtons sw_addUtilityButtonWithColor:
     [UIColor colorWithRed:0.07 green:0.75f blue:0.16f alpha:1.0]
                                                icon:[UIImage imageNamed:@"check.png"]];
    [leftUtilityButtons sw_addUtilityButtonWithColor:
     [UIColor colorWithRed:1.0f green:1.0f blue:0.35f alpha:1.0]
                                                icon:[UIImage imageNamed:@"clock.png"]];
    [leftUtilityButtons sw_addUtilityButtonWithColor:
     [UIColor colorWithRed:1.0f green:0.231f blue:0.188f alpha:1.0]
                                                icon:[UIImage imageNamed:@"cross.png"]];
    [leftUtilityButtons sw_addUtilityButtonWithColor:
     [UIColor colorWithRed:0.55f green:0.27f blue:0.07f alpha:1.0]
                                                icon:[UIImage imageNamed:@"list.png"]];
    
    return leftUtilityButtons;
}

// Set row height on an individual basis

//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
//    return [self rowHeightForIndexPath:indexPath];
//}
//
//- (CGFloat)rowHeightForIndexPath:(NSIndexPath *)indexPath {
//    return ([indexPath row] * 10) + 60;
//}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    // Set background color of cell here if you don't want default white
}

#pragma mark - SWTableViewDelegate

- (void)swipeableTableViewCell:(SWTableViewCell *)cell scrollingToState:(SWCellState)state
{
    switch (state) {
        case 0:
            NSLog(@"utility buttons closed");
            break;
        case 1:
            NSLog(@"left utility buttons open");
            break;
        case 2:
            NSLog(@"right utility buttons open");
            break;
        default:
            break;
    }
}

- (void)swipeableTableViewCell:(SWTableViewCell *)cell didTriggerLeftUtilityButtonWithIndex:(NSInteger)index
{
    switch (index) {
        case 0:
            NSLog(@"left button 0 was pressed");
            break;
        case 1:
            NSLog(@"left button 1 was pressed");
            break;
        case 2:
            NSLog(@"left button 2 was pressed");
            break;
        case 3:
            NSLog(@"left btton 3 was pressed");
        default:
            break;
    }
}

- (void)swipeableTableViewCell:(SWTableViewCell *)cell didTriggerRightUtilityButtonWithIndex:(NSInteger)index
{
    if([_headerlbl.text isEqualToString:@"Scheduled Appointments"]){
        switch (index) {
                
            case 0:
            {
                NSLog(@"delete button was pressed");
                // Delete button was pressed
                // Delete button was pressed
                /*NSIndexPath *cellIndexPath = [_sessionHistoryTable indexPathForCell:cell];
                 [sessionHistoryArray removeObjectAtIndex:cellIndexPath.row];
                 //[_testArray[cellIndexPath.section] removeObjectAtIndex:cellIndexPath.row];
                 [_sessionHistoryTable deleteRowsAtIndexPaths:@[cellIndexPath] withRowAnimation:UITableViewRowAnimationLeft];*/
                AppDelegate *appdelegate=(AppDelegate *)[[UIApplication sharedApplication]delegate];
                NSDictionary *myJsonResponseIndividualElement = sessionHistoryArray[index];
                NSDictionary *appointmentID =  myJsonResponseIndividualElement[@"appointmentID"];
                NSMutableDictionary *dict=[[NSMutableDictionary alloc]init];
                [dict setObject:appointmentID forKey:@"appointmentID"];
                [dict setObject:@"" forKey:@"comments"];
                [dict setObject:rate forKey:@"rating"];
                
                // GlobalFunction *globalValues=[[GlobalFunction alloc]init];
                
                _alert = [UIAlertController
                          alertControllerWithTitle:@""
                          message:[[GlobalFunction sharedInstance].arrayOfAlerts objectAtIndex:59]
                          preferredStyle:UIAlertControllerStyleAlert];
                
                UIAlertAction* yesButton = [UIAlertAction
                                            actionWithTitle:@"Yes"
                                            style:UIAlertActionStyleDefault
                                            handler:^(UIAlertAction * action) {
                                                
                                                NSString *Url=[appdelegate.serviceURL stringByAppendingString:@"api/Appointments/CancelAppointment"];
                                                [self startLoadingIndicator];
                                                [[GlobalFunction sharedInstance]getServerResponseAfterLogin:Url method:@"POST" param:dict withCallback:^(NSInteger statusCode, NSDictionary *response, NSError *error) {
                                                    if(statusCode == 200)
                                                    {
                                                        NSIndexPath *indexPath =[_sessionHistoryTable indexPathForCell:cell];
                                                        [sessionHistoryArray removeObjectAtIndex:indexPath.row];
                                                        [self.sessionHistoryTable reloadData];
                                                        
                                                    }
                                                    [self stopLoadingIndicator];
                                                    
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
                [self presentViewController:_alert animated:YES completion:nil];
                break;
            }
                
                
            default:
                break;
                
        }
    }else{
        
        switch (index) {
                
            case 0:
            {
                NSLog(@"accept button was pressed");
                
                AppDelegate *appdelegate= (AppDelegate *)[[UIApplication sharedApplication]delegate];
                NSString *userName=[[appdelegate usersDetails]valueForKey:@"userRole"];

                
                
                NSDictionary *myJsonResponseIndividualElement = sessionHistoryArray[index];
                NSDictionary * appointmentId =  myJsonResponseIndividualElement[@"appointmentID"];
                
                
                _alert = [UIAlertController
                          alertControllerWithTitle:@""
                          message:[[GlobalFunction sharedInstance].arrayOfAlerts objectAtIndex:135]
                          preferredStyle:UIAlertControllerStyleAlert];
                
                UIAlertAction* yesButton = [UIAlertAction
                                            actionWithTitle:@"Yes"
                                            style:UIAlertActionStyleDefault
                                            handler:^(UIAlertAction * action) {
                                                NSString *appointmentUrl;
                                                NSMutableDictionary *appointmentApprovalData;
                                                 if (![_headerlbl.text isEqualToString:@"Rescheduled Appointments"]){
                                                
                                                appointmentUrl=[appdelegate.serviceURL stringByAppendingString:@"api/Appointments/AppointmentApproval"];
                                                appointmentApprovalData = [[NSMutableDictionary alloc] init];
                                                [appointmentApprovalData setObject:appointmentId forKey:@"appointmentID"];
                                                [appointmentApprovalData setObject:@"true" forKey:@"isApproved"];
                                                [appointmentApprovalData setObject:@"COMMENT" forKey:@"comments"];
                                                NSLog(@"appoint%@",appointmentApprovalData);
                                                 }else{
                                                     NSDictionary *myJsonResponseIndividualElement = sessionHistoryArray[index];
                                                     NSDictionary * rescheduleappointmentId =  myJsonResponseIndividualElement[@"reScheduleAppointmentsId"];

                                                     appointmentUrl=[appdelegate.serviceURL stringByAppendingString:@"api/Appointments/ReScheduleAppointmentApproveReject"];
                                                     
                                                     appointmentApprovalData = [[NSMutableDictionary alloc] init];
                                                     [appointmentApprovalData setObject:rescheduleappointmentId forKey:@"reScheduleAppointmentsId"];
                                                     [appointmentApprovalData setObject:@"true" forKey:@"isApproved"];
                                                     [appointmentApprovalData setObject:@"COMMENT" forKey:@"comments"];
                                                     NSLog(@"appoint%@",appointmentApprovalData);

                                                 }
                                                //[self startLoadingIndicator];
                                                     
                                                [[GlobalFunction sharedInstance] getServerResponseAfterLogin:appointmentUrl method:@"POST" param:appointmentApprovalData withCallback:^(NSInteger statusCode, NSDictionary *response, NSError *error)
                                                 {
                                                     if(statusCode==200){
                                                         
                                                         AppDelegate *appdelegate= (AppDelegate *)[[UIApplication sharedApplication]delegate];
                                                         
                                                         NSString *userName=[[appdelegate usersDetails]valueForKey:@"userRole"];
                                                         if ([_headerlbl.text isEqualToString:@"Rescheduled Appointments"]){
                                                            // [self stopLoadingIndicator];
                                                             
                                                             NSString *getUrl=[appdelegate.serviceURL stringByAppendingString:@"api/Appointments/RescheduleAppointmentWaitingApproval"];
                                                             
                                                             [self ServiceCall:nil url:getUrl method:@"GET" param:nil];
                                                             
                                                             
                                                         }else{
                                                         
                                                         NSIndexPath *indexPath =[_sessionHistoryTable indexPathForCell:cell];
                                                         [sessionHistoryArray removeObjectAtIndex:indexPath.row];
                                                         [self.sessionHistoryTable reloadData];
                                                         if(sessionHistoryArray.count == 0)
                                                         {
                                                             _alert = [UIAlertController
                                                                       alertControllerWithTitle:@""
                                                                       message:[[GlobalFunction sharedInstance].arrayOfAlerts objectAtIndex:84]
                                                                       preferredStyle:UIAlertControllerStyleAlert];
                                                             
                                                             UIAlertAction* okButton = [UIAlertAction
                                                                                        actionWithTitle:@"OK"
                                                                                        style:UIAlertActionStyleDefault
                                                                                        handler:^(UIAlertAction * action) {
                                                                                            [self.navigationController popViewControllerAnimated:YES];
                                                                                            [self.tabBarController setSelectedIndex:0];
                                                                                        }];
                                                             [_alert addAction:okButton];
                                                             [self presentViewController:_alert animated:YES completion:nil];
                                                         }
                                                         }
                                                        // [self stopLoadingIndicator];
                                                         
                                                         
                                                     }else{
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
                [self presentViewController:_alert animated:YES completion:nil];
                
                [cell hideUtilityButtonsAnimated:YES];
                break;
            }
            case 1:
            {
                NSLog(@"reject button was pressed");
                
                AppDelegate *appdelegate= (AppDelegate *)[[UIApplication sharedApplication]delegate];
                
                
                /* NSDictionary *myJsonResponseIndividualElement = sessionHistoryArray[index];
                 NSMutableDictionary * appointmentId =  myJsonResponseIndividualElement[@"appointmentID"]*/;
                
                
                _alert = [UIAlertController
                          alertControllerWithTitle:@""
                          message:[[GlobalFunction sharedInstance].arrayOfAlerts objectAtIndex:61]
                          preferredStyle:UIAlertControllerStyleAlert];
                
                UIAlertAction* yesButton = [UIAlertAction
                                            actionWithTitle:@"Yes"
                                            style:UIAlertActionStyleDefault
                                            handler:^(UIAlertAction * action) {
                                                
                                                UIStoryboard *storyboard = [UIStoryboard storyboardWithName:
                                                                            @"GeneralStoryboard" bundle:nil];
                                                
                                                RejectAppointmentpopupViewController *RejectViewController=[storyboard instantiateViewControllerWithIdentifier:@"RejectPopup"];
                                                RejectViewController.delegate=self;
                                                RejectViewController.RescheduleAppointmentIDValue = rescheduleappointmentID;
                                                RejectViewController.AppointmentIDValue=appointmentID;
                                                RejectViewController.providerIDValue=providerId;
                                                RejectViewController.headerTxt=_headerlbl.text;
                                               
                                                self.modalPresentationStyle = UIModalPresentationFullScreen;
                                                RejectViewController.modalPresentationStyle = UIModalPresentationOverCurrentContext;
                                                
                                                //RejectViewController.modalPresentationStyle = UIModalPresentationOverCurrentContext;
                                                
                                                [self presentViewController:RejectViewController animated:NO completion:nil];
                                                
                                                
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
                
                break;
            }
            case 2:
            {
                
                
                UIStoryboard *storyboard = [UIStoryboard storyboardWithName:
                                            @"UserStoryboard" bundle:nil];
                RescheduleAppointmentViewController *OnlineAvailController=[storyboard instantiateViewControllerWithIdentifier:@"Reschedule"];
                OnlineAvailController.delegate=self;
                OnlineAvailController.AppointmentIDValue=appointmentID;
                OnlineAvailController.providerIDValue=providerId;
                OnlineAvailController.headerTxt=_headerlbl.text;
                self.modalPresentationStyle = UIModalPresentationFullScreen;
                
                OnlineAvailController.modalPresentationStyle = UIModalPresentationOverCurrentContext;
                
                [self presentViewController:OnlineAvailController animated:NO completion:nil];
                //sessionHistoryArray
                NSLog(@"reschedule button 2 was pressed");
                
                break;
            }
                
            default:
                break;
                
        }
        
        
    }
}

- (BOOL)swipeableTableViewCellShouldHideUtilityButtonsOnSwipe:(SWTableViewCell *)cell
{
    // allow just one cell's utility button to be open at once
    return YES;
}

- (BOOL)swipeableTableViewCell:(SWTableViewCell *)cell canSwipeToState:(SWCellState)state
{
    switch (state) {
        case 1:
            // set to NO to disable all left utility buttons appearing
            return YES;
            break;
        case 2:
            // set to NO to disable all right utility buttons appearing
            return YES;
            break;
        default:
            break;
    }
    
    return YES;
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

- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController
{
    return viewController != tabBarController.selectedViewController;
}

- (IBAction)redirectToSessionDetails:(id)sender {
    
    NSLog(@"Button Clicked");
    
    UITapGestureRecognizer *tap = (UITapGestureRecognizer *)sender;
    NSDictionary *myJsonResponseIndividualElement = sessionHistoryArray[tap.view.tag];
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"GeneralStoryboard" bundle:nil];
    SessionDetailsViewController *viewcontrol=[storyboard instantiateViewControllerWithIdentifier:@"SessionDetail"];
    //viewcontrol.providersID=myJsonResponseIndividualElement[@"providerID"];
    
    [self presentViewController:viewcontrol animated:NO completion:nil];
    
}


@end
