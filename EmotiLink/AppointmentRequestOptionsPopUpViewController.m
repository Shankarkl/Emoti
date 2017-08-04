//
//  AppointmentRequestOptionsPopUpViewController.m
//  EmotiLink
//
//  Created by Star on 5/5/17.
//  Copyright © 2017 Stark. All rights reserved.
//

#import "AppointmentRequestOptionsPopUpViewController.h"
#import "MakeAnAppointmentViewController.h"
#import "GlobalFunction.h"
#import "paymentInfoViewController.h"
#import "AppDelegate.h"
#import "JoinSessionViewController.h"

@interface AppointmentRequestOptionsPopUpViewController ()

@end

@implementation AppointmentRequestOptionsPopUpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setBorderColor:1];
    [self setBorderColor:2];
    
    self.modalPresentationStyle = UIModalPresentationCurrentContext;
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

- (IBAction)nowButtonClick:(id)sender {
    
    AppDelegate *appdelegate= (AppDelegate *)[[UIApplication sharedApplication]delegate];
    
    _alert = [UIAlertController
              alertControllerWithTitle:@""
              message:[[GlobalFunction sharedInstance].arrayOfAlerts objectAtIndex:138]
              preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* yesButton = [UIAlertAction
                                actionWithTitle:@"Yes"
                                style:UIAlertActionStyleDefault
                                handler:^(UIAlertAction * action) {
                                    
                                    
                                    NSDate *currentTime=[NSDate date];
                                    NSDateFormatter *timeformat = [[NSDateFormatter alloc] init];
                                    timeformat.dateFormat = @"HH:mm";
                                    
                                    //NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
                                    //[dateFormatter setDateFormat:@"dd/MM/yyyy --- HH:mm"];
                                    
                                    NSDate *currentDate = [NSDate date];
                                    NSDateFormatter *dayformat = [[NSDateFormatter alloc] init];
                                    dayformat.dateFormat = @"EEE, dd MMM yyyy";
                                    
                                    NSDate *nowPlus30Min = [NSDate dateWithTimeIntervalSinceNow:30*60];
                                    
                                    
                                    NSString *scheduleAppointmentUrl=[appdelegate.serviceURL stringByAppendingString:@"api/Appointments/OnlineAppointmentRequest"];
                                    NSMutableDictionary *createScheduleData = [[NSMutableDictionary alloc] init];
                                    [createScheduleData setObject:[_providerDictionary objectForKey:@"providerID"] forKey:@"providerID"];
                                    [createScheduleData setObject:[dayformat stringFromDate:currentDate] forKey:@"scheduledDate"];
                                    [createScheduleData setObject:[timeformat stringFromDate:currentTime] forKey:@"scheduledStartTime"];
                                    [createScheduleData setObject:[timeformat stringFromDate:nowPlus30Min] forKey:@"scheduledEndTime"];
                                    [createScheduleData setObject:[_providerDictionary objectForKey:@"rate"] forKey:@"offeredRate"];
                                    
                                    [self startLoadingIndicator];
                                    [[GlobalFunction sharedInstance] getServerResponseAfterLogin:scheduleAppointmentUrl method:@"POST" param:createScheduleData withCallback:^(NSInteger statusCode, NSDictionary *response, NSError *error)
                                     {
                                         
                                         if (statusCode==200) {
                                             
                                             [self stopLoadingIndicator];
                                             onlineAvailableDict =[response mutableCopy];
                                             
                                             AppDelegate *appdelegate= (AppDelegate *)[[UIApplication sharedApplication]delegate];
                                             [[appdelegate usersDetails] setObject:onlineAvailableDict forKey:@"nextScheduledAppointment"];
                                             
                                             NSNumber *appointmentID = [onlineAvailableDict objectForKey:@"appointmentID"];
                                             
                                             AppDelegate *app= (AppDelegate *)[[UIApplication sharedApplication]delegate];
                                             
                                             UIStoryboard *storyboard = [UIStoryboard storyboardWithName:
                                                                         @"GeneralStoryboard" bundle:nil];
                                             JoinSessionViewController *viewcontrol=[storyboard instantiateViewControllerWithIdentifier:@"JoinSession"];
                                             viewcontrol.appointmentID=appointmentID;
                                             app.screenState=@"userDashboard";
                                             [self presentViewController:viewcontrol animated:NO completion:nil];
                                             
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

- (IBAction)anotherDayButtonClick:(id)sender {
    
    NSLog(@"Values %@",_providerDictionary);
    
    AppDelegate *appdelegate=(AppDelegate *)[[UIApplication sharedApplication]delegate];
    // NSMutableDictionary *myJsonResponseIndividualElement = _providerDictionary;
    
    NSDictionary *userStatus=[[appdelegate usersDetails]valueForKey:@"userStatus"];
    
    
    if([[userStatus valueForKey:@"isPaymentInfoUpdated"] isEqualToNumber:[NSNumber numberWithInt:0]] )
    {
        NSLog(@"Payment Information");
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"UserStoryboard" bundle:nil];
        paymentInfoViewController *vc=[storyboard instantiateViewControllerWithIdentifier:@"paymentInfo"];
        [self presentViewController:vc animated:YES completion:nil];
        
    }else{
        
        NSLog(@"Make An Appointment");
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"UserStoryboard" bundle:nil];
        
        MakeAnAppointmentViewController *vc=[storyboard instantiateViewControllerWithIdentifier:@"makeanappointment"];
        
        vc.screenStatus=@"appointment";
        vc.postScheduleDetails=_providerDictionary;
        [self presentViewController:vc animated:YES completion:nil];
        
    }
    
    
}

- (IBAction)cancelButtonClick:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void) setBorderColor:(int)tagName{
    UIButton *cancelBtn = (UIButton *) [self.view viewWithTag:tagName];
    cancelBtn.layer.borderColor = [UIColor colorWithRed:246.0/255.0 green:108.0/255.0 blue:118.0/255.0 alpha:1].CGColor;
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


-(void)stopLoadingIndicator
{
    _loadingView.hidden=YES;
}



@end
