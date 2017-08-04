
/***************************************************************
 Page name: SessionApprovalViewController.m
 Created By:Nalina
 Created Date:08/07/16
 Description: session approval implementation file
 ***************************************************************/

#import "SessionApprovalViewController.h"
#import "SessionApprovalTableViewCell.h"
#import "GlobalFunction.h"
#import "AppDelegate.h"
#import "ClientDetailsViewController.h"
#import <Google/Analytics.h>

@interface SessionApprovalViewController ()

@end

@implementation SessionApprovalViewController

//Loads first time when page appears
- (void)viewDidLoad {
    _reasonTxtField.text=@"";
    sessionApprovalArray = [NSMutableArray array];
    appointmentId=[NSDictionary dictionary];
    _reasonTxtField.delegate = self;
    
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

//Returns the keypad
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

//Loads each time when page appears
-(void)viewWillAppear:(BOOL)animated{
    self.reasonTxtField.layer.borderColor=[[UIColor colorWithRed:228.0/255.0 green:109.0/255.0 blue:175.0/255.0 alpha:1.0]CGColor];
    self.reasonTxtField.layer.borderWidth = 1.0f;
    [[self navigationController] setNavigationBarHidden:YES animated:YES];
    self.navigationItem.title = @"PROVIDERS MARKETPLACE";
    id<GAITracker> tracker = [[GAI sharedInstance] defaultTracker];
    [tracker set:kGAIScreenName value:@"SessionApproval"];
    [tracker send:[[GAIDictionaryBuilder createScreenView] build]];
}

//Added by: Nalina
//Added Date: 20/08/2016
//Discription: get session approval details

-(void)viewDidAppear:(BOOL)animated{
    
    [[[[self.tabBarController tabBar]items]objectAtIndex:0]setEnabled:FALSE];
    [[[[self.tabBarController tabBar]items]objectAtIndex:1]setEnabled:FALSE];
    [[[[self.tabBarController tabBar]items]objectAtIndex:3]setEnabled:FALSE];
   // toggleBtn=nil;
    //[_notAvailableBtn setImage:[UIImage imageNamed:@"check.png"] forState:UIControlStateNormal];

   // GlobalFunction *globalValues=[[GlobalFunction alloc]init];
    AppDelegate *appdelegate= (AppDelegate *)[[UIApplication sharedApplication]delegate];
    NSString *getProviderUrl=[appdelegate.serviceURL stringByAppendingString:@"api/Appointments/AppointmentWaitingApproval"];
    [self startLoadingIndicator];
    [[GlobalFunction sharedInstance] getServerResponseAfterLogin:getProviderUrl method:@"GET" param:nil withCallback:^(NSInteger statusCode, NSDictionary *response, NSError *error)
     {
         [[[[self.tabBarController tabBar]items]objectAtIndex:0]setEnabled:TRUE];
         [[[[self.tabBarController tabBar]items]objectAtIndex:1]setEnabled:TRUE];
         [[[[self.tabBarController tabBar]items]objectAtIndex:3]setEnabled:TRUE];
         
         if (statusCode == 200)
         {
             sessionApprovalArray=[response mutableCopy];
             [self stopLoadingIndicator];
             [_sessionTableView reloadData];
             
         }else if(statusCode==404){
             [_sessionTableView reloadData];

             if (sessionApprovalArray.count>0) {
                 
                 NSString *badgeCount=[NSString stringWithFormat:@"%lu", (unsigned long)sessionApprovalArray.count] ;
                 [[[[self.tabBarController tabBar]items]objectAtIndex:2]setBadgeValue:badgeCount];
             }else{
                 [[[[self.tabBarController tabBar]items]objectAtIndex:2]setBadgeValue:nil];
             }
             
             [self stopLoadingIndicator];
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
    
}

//Return number of section in table
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

//Return the number of rows count to display in table
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return sessionApprovalArray.count;
}


//Return the data to display and cell in table
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //Added by: Nalina
    //Added Date: 20/08/2016
    //Discription:Bind the data to the cell
    if (sessionApprovalArray.count>0) {
        
        NSString *badgeCount=[NSString stringWithFormat:@"%lu", (unsigned long)sessionApprovalArray.count] ;
        [[[[self.tabBarController tabBar]items]objectAtIndex:2]setBadgeValue:badgeCount];
    }else{
        [[[[self.tabBarController tabBar]items]objectAtIndex:2]setBadgeValue:nil];
    }
    
    SessionApprovalTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"sessionCell" forIndexPath:indexPath];
    //cell.profileImageView.layer.cornerRadius = cell.profileImageView.frame.size.width / 2;
    cell.profileImageView.clipsToBounds = YES;
    
    if (indexPath.row % 2) {
        cell.mainview.backgroundColor = [[UIColor alloc]initWithRed:51.0/255.0 green:51.0/255.0 blue:51.0/255.0 alpha:1];
    }else{
        cell.mainview.backgroundColor =[[UIColor alloc]initWithRed:62.0/255.0 green:62.0/255.0 blue:62.0/255.0 alpha:1];
    }
    
    //Accept button click event
    cell.acceptBtn.tag = indexPath.row;
    [cell.acceptBtn addTarget:self action:@selector(AcceptClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    //Reject button click event
    cell.rejectBtn.tag = indexPath.row;
    [cell.rejectBtn addTarget:self action:@selector(RejectClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    _okBtn.tag=indexPath.row;
    
    NSDictionary *myJsonResponseIndividualElement = sessionApprovalArray[indexPath.row];
    
    NSString *name=[myJsonResponseIndividualElement[@"clientFirstName"] stringByAppendingString:@" "];
    cell.firstName.text= [name stringByAppendingString:myJsonResponseIndividualElement[@"clientLastName"]];
    cell.dateAndTime.text=myJsonResponseIndividualElement[@"appointmentTimeSting"];
    
    AppDelegate *appdelegate=(AppDelegate *)[[UIApplication sharedApplication]delegate];
    NSString *amount=myJsonResponseIndividualElement[@"offeredAmount"];
    NSNumber *value=[NSNumber numberWithFloat:[amount floatValue]];
    cell.amountLabel.text =[@"$ " stringByAppendingString:[value stringValue]];
    
    if ([myJsonResponseIndividualElement[@"clientProfilePicPath"] isEqual:[NSNull null]]) {
        
    }else{
        
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
    }
    
    
    return cell;
}


//Added by: Nalina
//Added Date: 20/08/2016
//Discription: Approve user request

- (void)AcceptClicked:(UIButton*)sender{
   // GlobalFunction *globalValues=[[GlobalFunction alloc]init];
    AppDelegate *appdelegate= (AppDelegate *)[[UIApplication sharedApplication]delegate];
    
    UIButton *btn=(UIButton *)sender;
    NSDictionary *myJsonResponseIndividualElement = sessionApprovalArray[btn.tag];
    NSDictionary * appointmentId =  myJsonResponseIndividualElement[@"appointmentID"];
    
    
    _alert = [UIAlertController
              alertControllerWithTitle:@""
              message:[[GlobalFunction sharedInstance].arrayOfAlerts objectAtIndex:60]
              preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* yesButton = [UIAlertAction
                                actionWithTitle:@"Yes"
                                style:UIAlertActionStyleDefault
                                handler:^(UIAlertAction * action) {
                                    
                                    
                                    NSString *appointmentUrl=[appdelegate.serviceURL stringByAppendingString:@"api/Appointments/AppointmentApporval"];
                                    NSMutableDictionary *appointmentApprovalData = [[NSMutableDictionary alloc] init];
                                    [appointmentApprovalData setObject:appointmentId forKey:@"appointmentID"];
                                    [appointmentApprovalData setObject:@"true" forKey:@"isApporved"];
                                    [appointmentApprovalData setObject:@"" forKey:@"comments"];
                                    
                                    [self startLoadingIndicator];
                                    [[GlobalFunction sharedInstance] getServerResponseAfterLogin:appointmentUrl method:@"POST" param:appointmentApprovalData withCallback:^(NSInteger statusCode, NSDictionary *response, NSError *error)
                                     {
                                         if(statusCode==200){
                                             
                                             
                                             CGPoint touchPoint = [sender convertPoint:CGPointZero toView:self.sessionTableView];
                                             NSIndexPath *indexPath = [self.sessionTableView indexPathForRowAtPoint:touchPoint];
                                             [sessionApprovalArray removeObjectAtIndex:indexPath.row];
                                             [self.sessionTableView reloadData];
                                             if(sessionApprovalArray.count == 0)
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
                                             [self stopLoadingIndicator];
                                             
                                             
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
    
}


//Added by: Nalina
//Added Date: 24/08/2016
//Discription: Redirect to client details screen to check the details of session requested client

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ClientDetailsViewController *vc=[self.storyboard instantiateViewControllerWithIdentifier:@"clientDetails"];
    vc.detailsDict=sessionApprovalArray[indexPath.row];
    vc.screenStatus=@"sessionApproval";
    [self.navigationController pushViewController:vc animated:YES];
}


//Added by: Nalina
//Added Date: 20/08/2016
//Discription: Reject user request and pop up the reject screen

- (void)RejectClicked:(UIButton*)sender{
    
   // GlobalFunction *globalValues=[[GlobalFunction alloc]init];
    
    UIButton *btn=(UIButton *)sender;
    NSDictionary *myJsonResponseIndividualElement = sessionApprovalArray[btn.tag];
    appointmentId =  myJsonResponseIndividualElement[@"appointmentID"];
    
    CGPoint touchPoint = [btn convertPoint:CGPointZero toView:self.sessionTableView];
    removeIndexPath = [self.sessionTableView indexPathForRowAtPoint:touchPoint];

    _alert = [UIAlertController
              alertControllerWithTitle:@""
              message:[[GlobalFunction sharedInstance].arrayOfAlerts objectAtIndex:61]
              preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* yesButton = [UIAlertAction
                                actionWithTitle:@"Yes"
                                style:UIAlertActionStyleDefault
                                handler:^(UIAlertAction * action) {
                                    _confirmationPopUpBackView.hidden=NO;
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


//Added by: Nalina
//Added Date: 08/07/2016
//Discription: Radio button functionality in reject popup

-(void)ToggleFunctionality{
    if([toggleBtn isEqualToString:@"alredySchedule"]){
        [_notAvailableBtn setImage:[UIImage imageNamed:@"uncheck.png"] forState:UIControlStateNormal];
        [_notInterestedBtn setImage:[UIImage imageNamed:@"uncheck.png"] forState:UIControlStateNormal];
        [_alredyScheduleBtn setImage:[UIImage imageNamed:@"check.png"] forState:UIControlStateNormal];
        [_doesntMeetRateBtn setImage:[UIImage imageNamed:@"uncheck.png"] forState:UIControlStateNormal];
        [_otherBtn setImage:[UIImage imageNamed:@"uncheck.png"] forState:UIControlStateNormal];
        _reasonTxtField.enabled=NO;
        _reasonTxtField.text=@"";
        comment=@"Another appointment at that time";
        
    }else if([toggleBtn isEqualToString:@"notInterested"]){
        [_notAvailableBtn setImage:[UIImage imageNamed:@"uncheck.png"] forState:UIControlStateNormal];
        [_alredyScheduleBtn setImage:[UIImage imageNamed:@"uncheck.png"] forState:UIControlStateNormal];
        [_notInterestedBtn setImage:[UIImage imageNamed:@"check.png"] forState:UIControlStateNormal];
        [_doesntMeetRateBtn setImage:[UIImage imageNamed:@"uncheck.png"] forState:UIControlStateNormal];
        [_otherBtn setImage:[UIImage imageNamed:@"uncheck.png"] forState:UIControlStateNormal];
        _reasonTxtField.enabled=NO;
        _reasonTxtField.text=@"";
        comment=@"I do not emotilink at that time";

    }else if([toggleBtn isEqualToString:@"notAvailable"]){
        [_notInterestedBtn setImage:[UIImage imageNamed:@"uncheck.png"] forState:UIControlStateNormal];
        [_alredyScheduleBtn setImage:[UIImage imageNamed:@"uncheck.png"] forState:UIControlStateNormal];
        [_notAvailableBtn setImage:[UIImage imageNamed:@"check.png"] forState:UIControlStateNormal];
        [_doesntMeetRateBtn setImage:[UIImage imageNamed:@"uncheck.png"] forState:UIControlStateNormal];
        [_otherBtn setImage:[UIImage imageNamed:@"uncheck.png"] forState:UIControlStateNormal];
        _reasonTxtField.enabled=NO;
        _reasonTxtField.text=@"";
        comment=@"Other responsibilities at that time";
        
    }else if([toggleBtn isEqualToString:@"doesntmeetRate"]){
        [_notInterestedBtn setImage:[UIImage imageNamed:@"uncheck.png"] forState:UIControlStateNormal];
        [_alredyScheduleBtn setImage:[UIImage imageNamed:@"uncheck.png"] forState:UIControlStateNormal];
        [_notAvailableBtn setImage:[UIImage imageNamed:@"uncheck.png"] forState:UIControlStateNormal];
        [_doesntMeetRateBtn setImage:[UIImage imageNamed:@"check.png"] forState:UIControlStateNormal];
        [_otherBtn setImage:[UIImage imageNamed:@"uncheck.png"] forState:UIControlStateNormal];
        _reasonTxtField.enabled=NO;
        _reasonTxtField.text=@"";
        comment=@"The offer doesn't meet my rate";
        
    }else if([toggleBtn isEqualToString:@"other"]){
        [_notInterestedBtn setImage:[UIImage imageNamed:@"uncheck.png"] forState:UIControlStateNormal];
        [_alredyScheduleBtn setImage:[UIImage imageNamed:@"uncheck.png"] forState:UIControlStateNormal];
        [_notAvailableBtn setImage:[UIImage imageNamed:@"uncheck.png"] forState:UIControlStateNormal];
        [_doesntMeetRateBtn setImage:[UIImage imageNamed:@"uncheck.png"] forState:UIControlStateNormal];
        [_otherBtn setImage:[UIImage imageNamed:@"check.png"] forState:UIControlStateNormal];
        _reasonTxtField.enabled=YES;

    }
}

//Calls on click of back icon
- (IBAction)backClick:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}


//Calls on click of cancel button
- (IBAction)cancelPopupClick:(id)sender {
    _confirmationPopUpBackView.hidden=YES;
    _reasonTxtField.enabled=NO;
    _reasonTxtField.text=@"";
}


//Added by: Nalina
//Added Date: 20/08/2016
//Discription: Reject user request

- (IBAction)okPopupClick:(id)sender {
    //GlobalFunction *globalValues=[[GlobalFunction alloc]init];
    AppDelegate *appdelegate= (AppDelegate *)[[UIApplication sharedApplication]delegate];
    
    if([toggleBtn isEqualToString:@"other"]){
    comment=_reasonTxtField.text;
    }
    
    if([comment isEqualToString:@""]||comment==nil||[comment isEqual:[NSNull null]]){
       comment=@"Other responsibilities at that time";
     }
        
    NSString *appointmentUrl=[appdelegate.serviceURL stringByAppendingString:@"api/Appointments/AppointmentApporval"];
    NSMutableDictionary *appointmentApprovalData = [[NSMutableDictionary alloc] init];
    [appointmentApprovalData setObject:appointmentId forKey:@"appointmentID"];
    [appointmentApprovalData setObject:@"false" forKey:@"isApporved"];
    [appointmentApprovalData setObject:comment forKey:@"comments"];

    NSLog(@"data =%@",appointmentApprovalData);
    [self startLoadingIndicator];
    [[GlobalFunction sharedInstance] getServerResponseAfterLogin:appointmentUrl method:@"POST" param:appointmentApprovalData withCallback:^(NSInteger statusCode, NSDictionary *response, NSError *error)
     {
         if(statusCode==200){
            
             [sessionApprovalArray removeObjectAtIndex:removeIndexPath.row];
             
             [self.sessionTableView reloadData];
             if(sessionApprovalArray.count == 0)
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
             _confirmationPopUpBackView.hidden=YES;
             [self stopLoadingIndicator];
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
    
}

//Added by: Nalina
//Added Date: 08/07/2016
//Discription: Radio buttons click on reject popup

- (IBAction)alredyScheduleClick:(id)sender {
    toggleBtn=@"alredySchedule";
    [self ToggleFunctionality];
}

- (IBAction)notInterestedClick:(id)sender {
    toggleBtn=@"notInterested";
    [self ToggleFunctionality];
}

- (IBAction)notAvailableClick:(id)sender {
    toggleBtn=@"notAvailable";
    [self ToggleFunctionality];
}
- (IBAction)doesntmeetRateClick:(id)sender {
    toggleBtn=@"doesntmeetRate";
    [self ToggleFunctionality];
}
- (IBAction)otherBtnClick:(id)sender {
    toggleBtn=@"other";
    [self ToggleFunctionality];
}


//Added by: Nalina
//Added Date: 20/08/2016
//Discription: Start loading indicator

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

//Added by: Nalina
//Added Date: 20/08/2016
//Discription: Stop loading indicator

-(void)stopLoadingIndicator
{
    _loadingView.hidden=YES;
}

@end
