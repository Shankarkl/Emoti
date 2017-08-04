/***************************************************************
 Page name: ClientDetailsViewController.m
 Created By: Nalina
 Created Date: 2016-09-13
 Description:Client details display implementation screen
 ***************************************************************/

#import "ClientDetailsViewController.h"
#import "GlobalFunction.h"
#import "AppDelegate.h"
@interface ClientDetailsViewController ()

@end

@implementation ClientDetailsViewController

- (void)viewDidLoad {
    
    _reasonTxtField.text=@"";
    self.userProfilePicture.layer.cornerRadius = self.userProfilePicture.frame.size.width / 2;
    self.userProfilePicture.clipsToBounds = YES;
    
    AppDelegate *appdelegate= (AppDelegate *)[[UIApplication sharedApplication]delegate];
    NSLog(@"_detailsDict=%@",_detailsDict);
   // toggleBtn=nil;
  //  [_notAvailableBtn setImage:[UIImage imageNamed:@"check.png"] forState:UIControlStateNormal];
    
    NSString *userName=[[appdelegate usersDetails] valueForKey:@"firstName"];
    
    
    UIFont *font1 = [UIFont fontWithName:@"CenturyGothic" size:14];
    NSDictionary *arialDict = [NSDictionary dictionaryWithObject: font1 forKey:NSFontAttributeName];
    NSMutableAttributedString *aAttrString1 = [[NSMutableAttributedString alloc] initWithString:@"Hello, " attributes: arialDict];
    
    UIFont *font2 = [UIFont fontWithName:@"CenturyGothic-Bold" size:14];
    NSDictionary *arialDict2 = [NSDictionary dictionaryWithObject: font2 forKey:NSFontAttributeName];
    NSMutableAttributedString *aAttrString2 = [[NSMutableAttributedString alloc] initWithString:userName attributes: arialDict2];

    [aAttrString1 appendAttributedString:aAttrString2];
    _providerNameLabel.attributedText = aAttrString1;
    
    if ([_screenStatus isEqualToString:@"sessionApproval"]) {
        _userNameLabel.text=[NSString stringWithFormat:@"%@ %@",[_detailsDict objectForKey:@"clientFirstName"],[_detailsDict objectForKey:@"clientLastName"]];
        _fromTimeLabel.text=[self Convert24FormatTo12Format:[_detailsDict objectForKey:@"scheduledStartTime"]];
        _toTimeLabel.text=[self Convert24FormatTo12Format:[_detailsDict objectForKey:@"scheduledEndTime"]];
        
        NSArray* foo = [[_detailsDict objectForKey:@"appointmentTimeSting"] componentsSeparatedByString: @" at "];
        _dateLabel.text = [foo objectAtIndex: 0];
        
        _offeredAmountLabel.text=[_detailsDict objectForKey:@"offeredAmountCurrency"];
        
        _userFirstLastnameLabel.text=[NSString stringWithFormat:@"%@ %@",[_detailsDict objectForKey:@"clientFirstName"],[_detailsDict objectForKey:@"clientLastName"]];
        imageIs=[_detailsDict objectForKey:@"clientProfilePicPath"];
        _headingLabel.text=@"SESSION DETAILS";
        [_submitBtn setTitle:@"Accept" forState:UIControlStateNormal];
        [_cancelBtn setTitle:@"Reject" forState:UIControlStateNormal];
        _qualificationLbl.text=@"";

    }else if ([_screenStatus isEqualToString:@"myclients"]){
        _userNameLabel.text=[NSString stringWithFormat:@"%@ %@",[_detailsDict objectForKey:@"firstName"],[_detailsDict objectForKey:@"lastName"]];
        
        _fromTimeLabel.text=[self Convert24FormatTo12Format:[_detailsDict objectForKey:@"scheduledStartTime"]];
        _toTimeLabel.text=[self Convert24FormatTo12Format:[_detailsDict objectForKey:@"scheduledEndTime"]];
        
        NSArray* dateForm = [[_detailsDict objectForKey:@"lastScheduledSession"] componentsSeparatedByString: @","];
        _dateLabel.text = [dateForm objectAtIndex: 0];
        
        NSString *amount=[_detailsDict objectForKey:@"totalBilledAmount"];
        NSNumber *value=[NSNumber numberWithInteger:[amount integerValue]];
        _offeredAmountLabel.text=[NSString stringWithFormat:@"%@ %@",@"$",[value stringValue]];

        _userFirstLastnameLabel.text=[NSString stringWithFormat:@"%@ %@",[_detailsDict objectForKey:@"firstName"],[_detailsDict objectForKey:@"lastName"]];
        imageIs=[_detailsDict objectForKey:@"profilePicPath"];
        _headingLabel.text=@"CLIENT DETAILS";
        _rateLabel.text=@"Total amount";
        [_submitBtn setTitle:@"Back" forState:UIControlStateNormal];
        [_cancelBtn setTitle:@"Delete" forState:UIControlStateNormal];
        _qualificationLbl.text=@"";

    }else if ([_screenStatus isEqualToString:@"scheduledAppointment"]){
        
        _headingLabel.text=@"APPOINTMENT DETAILS";
        [_submitBtn setTitle:@"Back" forState:UIControlStateNormal];
        [_cancelBtn setTitle:@"Delete" forState:UIControlStateNormal];
        
        if ([[[appdelegate usersDetails] objectForKey:@"userRole"] isEqualToString:@"Provider"]) {
            _userNameLabel.text=[NSString stringWithFormat:@"%@ %@",[_detailsDict objectForKey:@"clientFirstName"],[_detailsDict objectForKey:@"clientLastName"]];
            _fromTimeLabel.text=[self Convert24FormatTo12Format:[_detailsDict objectForKey:@"scheduledStartTime"]];
            _toTimeLabel.text=[self Convert24FormatTo12Format:[_detailsDict objectForKey:@"scheduledEndTime"]];
            
            NSArray* foo = [[_detailsDict objectForKey:@"appointmentTimeSting"] componentsSeparatedByString: @"at"];
            _dateLabel.text = [foo objectAtIndex: 0];
            
            _offeredAmountLabel.text=[_detailsDict objectForKey:@"offeredAmountCurrency"];
            
            _userFirstLastnameLabel.text=[NSString stringWithFormat:@"%@ %@",[_detailsDict objectForKey:@"clientFirstName"],[_detailsDict objectForKey:@"clientLastName"]];
            imageIs=[_detailsDict objectForKey:@"clientProfilePicPath"];
          _qualificationLbl.text=@"";
        }else{
            _userNameLabel.text=[NSString stringWithFormat:@"%@ %@",[_detailsDict objectForKey:@"providerFirstName"],[_detailsDict objectForKey:@"providerLastName"]];
            _fromTimeLabel.text=[self Convert24FormatTo12Format:[_detailsDict objectForKey:@"scheduledStartTime"]];
            _toTimeLabel.text=[self Convert24FormatTo12Format:[_detailsDict objectForKey:@"scheduledEndTime"]];
            
            NSArray* foo = [[_detailsDict objectForKey:@"appointmentTimeSting"] componentsSeparatedByString: @"at"];
            _dateLabel.text = [foo objectAtIndex: 0];
            
            _offeredAmountLabel.text=[_detailsDict objectForKey:@"offeredAmountCurrency"];
            
            _userFirstLastnameLabel.text=[NSString stringWithFormat:@"%@ %@",[_detailsDict objectForKey:@"providerFirstName"],[_detailsDict objectForKey:@"providerLastName"]];
            imageIs=[_detailsDict objectForKey:@"providerProfilePicPath"];
            _qualificationLbl.text=[_detailsDict objectForKey:@"qualification"];
        }
    }
   
    if ([imageIs isEqual:[NSNull null]]) {
        
        UIImage *image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"upload-profile" ofType:@"png"]];
        _userProfilePicture.image=image;
        
    }else{
        
        NSString *imagename=[appdelegate.imageURL stringByAppendingString:imageIs];
        dispatch_queue_t imagequeue =dispatch_queue_create("imageDownloader", nil);
        dispatch_async(imagequeue, ^{
            
            //download iamge
            NSData *imageData = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:imagename]];
            UIImage *image = [[UIImage alloc] initWithData:imageData];
            dispatch_async(dispatch_get_main_queue(), ^{
                
                if (image==NULL) {
                    UIImage *image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"upload-profile" ofType:@"png"]];
                    _userProfilePicture.image  = image;
                }
                else{
                    _userProfilePicture.image  = image;
                }
            });
            
        });
    }
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




//Added by: Nalina
//Added Date: 20/07/2016
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
//Added Date: 26/09/2016
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


//Added by: Nalina
//Added Date: 26/09/2016
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



//Calls on click of cancel button
- (IBAction)cancelPopupClick:(id)sender {
    _confirmationPopUpBackView.hidden=YES;
    _reasonTxtField.enabled=NO;
    _reasonTxtField.text=@"";
}


//Added by: Nalina
//Added Date: 26/09/2016
//Discription: Reject user request

- (IBAction)okPopupClick:(id)sender {
   // GlobalFunction *globalValues=[[GlobalFunction alloc]init];
    AppDelegate *appdelegate= (AppDelegate *)[[UIApplication sharedApplication]delegate];
 
    if([toggleBtn isEqualToString:@"other"]){
        comment=_reasonTxtField.text;
    }
    if([comment isEqualToString:@""]||comment==nil||[comment isEqual:[NSNull null]]){
        comment=@"Other responsibilities at that time";
    }
    
    NSString *appointmentUrl=[appdelegate.serviceURL stringByAppendingString:@"api/Appointments/AppointmentApporval"];
    NSMutableDictionary *appointmentApprovalData = [[NSMutableDictionary alloc] init];
    [appointmentApprovalData setObject:[_detailsDict objectForKey:@"appointmentID"] forKey:@"appointmentID"];
    [appointmentApprovalData setObject:@"false" forKey:@"isApporved"];
    [appointmentApprovalData setObject:comment forKey:@"comments"];
    
    [self startLoadingIndicator];
    [[GlobalFunction sharedInstance] getServerResponseAfterLogin:appointmentUrl method:@"POST" param:appointmentApprovalData withCallback:^(NSInteger statusCode, NSDictionary *response, NSError *error)
     {
         if(statusCode==200){
             _confirmationPopUpBackView.hidden=YES;
             [self stopLoadingIndicator];
             [self.navigationController popViewControllerAnimated:YES];
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

-(void)CallMethodToDeleteClient{
  //  GlobalFunction *globalValues=[[GlobalFunction alloc]init];
    AppDelegate *appdelegate= (AppDelegate *)[[UIApplication sharedApplication]delegate];
    _alert = [UIAlertController
              alertControllerWithTitle:@""
              message:[[GlobalFunction sharedInstance].arrayOfAlerts objectAtIndex:62]
              preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* yesButton = [UIAlertAction
                                actionWithTitle:@"Yes"
                                style:UIAlertActionStyleDefault
                                handler:^(UIAlertAction * action) {
                                    NSString *removeClientUrl=[appdelegate.serviceURL stringByAppendingString:@"api/MyClients"];
                                    NSMutableDictionary *myClientData = [[NSMutableDictionary alloc] init];
                                    [myClientData setObject:[_detailsDict objectForKey:@"clientID"] forKey:@"clientID"];
                                    [myClientData setObject:@"false" forKey:@"isMyClient"];
                                    [self startLoadingIndicator];
                                    [[GlobalFunction sharedInstance] getServerResponseAfterLogin:removeClientUrl method:@"POST" param:myClientData withCallback:^(NSInteger statusCode, NSDictionary *response, NSError *error)
                                     {
                                         if(statusCode==200){
                                             [self stopLoadingIndicator];
                                             [self.navigationController popViewControllerAnimated:YES];
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
//Added Date: 27/09/2016
//Discription: Approve user request from session approval

- (void)AcceptUserRequest{
 //   GlobalFunction *globalValues=[[GlobalFunction alloc]init];
    AppDelegate *appdelegate= (AppDelegate *)[[UIApplication sharedApplication]delegate];
    
    
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
                                    [appointmentApprovalData setObject:[_detailsDict objectForKey:@"appointmentID"] forKey:@"appointmentID"];
                                    [appointmentApprovalData setObject:@"true" forKey:@"isApporved"];
                                    [appointmentApprovalData setObject:@"" forKey:@"comments"];
                                    
                                    [self startLoadingIndicator];
                                    [[GlobalFunction sharedInstance] getServerResponseAfterLogin:appointmentUrl method:@"POST" param:appointmentApprovalData withCallback:^(NSInteger statusCode, NSDictionary *response, NSError *error)
                                     {
                                         if(statusCode==200){
                                         [self stopLoadingIndicator];
                                             [self.navigationController popViewControllerAnimated:YES];
                                             
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
//Added Date: 27/09/2016
//Discription: Approve user request from session approval

- (void)DeleteScheduledAppointment{
   
    AppDelegate *appdelegate=(AppDelegate *)[[UIApplication sharedApplication]delegate];
    NSDictionary *appointmentID = [_detailsDict objectForKey:@"appointmentID"];
    NSMutableDictionary *dict=[[NSMutableDictionary alloc]init];
    [dict setObject:appointmentID forKey:@"appointmentID"];
    [dict setObject:@"" forKey:@"comments"];
    
//    GlobalFunction *globalValues=[[GlobalFunction alloc]init];
    
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
                                            [self stopLoadingIndicator];
                                            [self.navigationController popViewControllerAnimated:YES];

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
//Added Date: 26/09/2016
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
//Added Date: 26/09/2016
//Discription: Stop loading indicator

-(void)stopLoadingIndicator
{
    _loadingView.hidden=YES;
}

- (IBAction)submitClick:(id)sender {
    if ([_screenStatus isEqualToString:@"sessionApproval"]) {
        [self AcceptUserRequest];
   }else{
    [self.navigationController popViewControllerAnimated:YES];
    }
}

- (IBAction)deleteClick:(id)sender {
    if ([_screenStatus isEqualToString:@"sessionApproval"]) {

 //   GlobalFunction *globalValues=[[GlobalFunction alloc]init];
    
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
   }else if ([_screenStatus isEqualToString:@"myclients"]){
       [self CallMethodToDeleteClient];
   }else{
        [self DeleteScheduledAppointment];
    }
}

- (IBAction)pagebackClick:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
@end
