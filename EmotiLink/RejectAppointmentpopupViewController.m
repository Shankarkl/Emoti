//
//  RejectAppointmentpopupViewController.m
//  EmotiLink
//
//  Created by Star on 4/11/17.
//  Copyright © 2017 Stark. All rights reserved.
//

#import "RejectAppointmentpopupViewController.h"
#import "AppDelegate.h"
#import "GlobalFunction.h"
#import "RescheduleAppointmentViewController.h"
@interface RejectAppointmentpopupViewController ()

@end

@implementation RejectAppointmentpopupViewController

- (void)viewDidLoad {
    _comments =_otherresponsibility.titleLabel.text;
    
    anotherAppointmentSelected=NO;
    offerSelected=NO;
    otherSelected=NO;
    rescheduleSelected=NO;
    donotEmotilinkSelected=NO;
    otherRespSelected=YES;
    
    [super viewDidLoad];
    
    [self setRejectButtonBorderColor:1];
    [self setRejectButtonBorderColor:2];
    [self setRejectButtonBorderColor:3];
    [self setRejectButtonBorderColor:4];
    [self setRejectButtonBorderColor:6];
    [self setRejectButtonBorderColor:7];
    
    [self setBorderColor:5];
    self.modalPresentationStyle = UIModalPresentationCurrentContext;
    // Do any additional setup after loading the view.
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


-(void) setBorderColor:(int)tagName{
    UIButton *cancelBtn = (UIButton *) [self.view viewWithTag:tagName];
    cancelBtn.layer.borderColor = [UIColor colorWithRed:246.0/255.0 green:108.0/255.0 blue:118.0/255.0 alpha:1].CGColor;
}

-(void) setRejectButtonBorderColor:(int)tagName{
    UIButton *cancelBtn = (UIButton *) [self.view viewWithTag:tagName];
    cancelBtn.layer.borderColor = [UIColor colorWithRed:197.0/255.0 green:224.0/255.0 blue:224.0/255.0 alpha:1].CGColor;
}

- (IBAction)CancelBtn:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)otherresponsibilityBtn:(id)sender {
    _otheroption.enabled=NO;
    _comments=_otherresponsibility.titleLabel.text;
    [self resetAllButtonColors];
    otherRespSelected=[self setButtonColorOnSelected:1 boolValue:otherRespSelected];
}

- (IBAction)AnotherAppointmentBtn:(id)sender {
    _otheroption.enabled=NO;
    _comments=_anotherappointment.titleLabel.text;
    [self resetAllButtonColors];
    anotherAppointmentSelected=[self setButtonColorOnSelected:2 boolValue:anotherAppointmentSelected];
}

- (IBAction)OfferBtn:(id)sender {
    _otheroption.enabled=NO;
    _comments=_doesntmeet.titleLabel.text;
    [self resetAllButtonColors];
    offerSelected=[self setButtonColorOnSelected:4 boolValue:offerSelected];
}

- (IBAction)OtherBtn:(id)sender {
    _comments =@""; //_otherbutton.titleLabel.text;
    _otheroption.enabled=YES;
    [self resetAllButtonColors];
    otherSelected=[self setButtonColorOnSelected:7 boolValue:otherSelected];
}

- (IBAction)RescheduleBtn:(id)sender {
    _otheroption.enabled=NO;
    _comments=_reschedule.titleLabel.text;
    [self resetAllButtonColors];
    rescheduleSelected=[self setButtonColorOnSelected:6 boolValue:rescheduleSelected];
UIStoryboard *storyboard = [UIStoryboard storyboardWithName:
                                @"UserStoryboard" bundle:nil];
    RescheduleAppointmentViewController *OnlineAvailController=[storyboard instantiateViewControllerWithIdentifier:@"Reschedule"];
    OnlineAvailController.AppointmentIDValue=_AppointmentIDValue;
    OnlineAvailController.providerIDValue=_providerIDValue;
    self.modalPresentationStyle = UIModalPresentationFullScreen;
    
    OnlineAvailController.modalPresentationStyle = UIModalPresentationOverCurrentContext;
    
    [self presentViewController:OnlineAvailController animated:NO completion:nil];
;
}

- (IBAction)IdonotemotilinkBtn:(id)sender {
    _otheroption.enabled=NO;
    _comments=_donotemotilink.titleLabel.text;
    [self resetAllButtonColors];
    donotEmotilinkSelected=[self setButtonColorOnSelected:3 boolValue:donotEmotilinkSelected];
}

- (IBAction)ConfirmBtn:(id)sender {
    
    if((_otheroption.enabled==YES) && !([_otheroption.text isEqualToString:@""])){
        _comments=_otheroption.text;
    }
    
    AppDelegate *appdelegate= (AppDelegate *)[[UIApplication sharedApplication]delegate];
    NSString *userName=[[appdelegate usersDetails]valueForKey:@"userRole"];
    NSLog(@"confirm%@",_comments);
    //AppDelegate *appdelegate= (AppDelegate *)[[UIApplication sharedApplication]delegate];
    NSString *appointmentUrl;
    NSMutableDictionary *appointmentApprovalData;
    if (![_headerTxt isEqualToString:@"Rescheduled Appointments"]){
    appointmentUrl=[appdelegate.serviceURL stringByAppendingString:@"api/Appointments/AppointmentApproval"];
    appointmentApprovalData = [[NSMutableDictionary alloc] init];
    [appointmentApprovalData setObject:_AppointmentIDValue forKey:@"appointmentID"];
    [appointmentApprovalData setObject:@"false" forKey:@"isApproved"];
    [appointmentApprovalData setObject:_comments forKey:@"comments"];
    NSLog(@"value sent%@",appointmentApprovalData);
    }else{
        appointmentUrl=[appdelegate.serviceURL stringByAppendingString:@"api/Appointments/ReScheduleAppointmentApproveReject"];
        
        appointmentApprovalData = [[NSMutableDictionary alloc] init];
        [appointmentApprovalData setObject:_RescheduleAppointmentIDValue forKey:@"reScheduleAppointmentsId"];
        [appointmentApprovalData setObject:@"false" forKey:@"isApproved"];
        [appointmentApprovalData setObject:_comments forKey:@"comments"];
        NSLog(@"appoint%@",appointmentApprovalData);
        

    }
    
    [[GlobalFunction sharedInstance] getServerResponseAfterLogin:appointmentUrl method:@"POST" param:appointmentApprovalData withCallback:^(NSInteger statusCode, NSDictionary *response, NSError *error)
     {
         if(statusCode==200){
             
             [self dismissViewControllerAnimated:YES completion:nil];
             
             if ([_delegate respondsToSelector:@selector(dataFromController:)])
             {
                 [_delegate dataFromController:@"200"];
                 
             }
             
             
             
             
             /*_alert = [UIAlertController
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
              [self presentViewController:_alert animated:YES completion:nil];*/
             
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
                                            
                                        }];
             [_alert addAction:okButton];
             [self presentViewController:_alert animated:YES completion: nil];
         }
     }];
    
}

-(bool) setButtonColorOnSelected:(int)tagName boolValue:(bool)boolValue  {
    
    
    UIButton *expertiseBtn = (UIButton *) [self.view viewWithTag:tagName];
    
    if(boolValue==YES){
        expertiseBtn.layer.backgroundColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0  alpha:1].CGColor;
        
        [expertiseBtn setTitleColor:[UIColor colorWithRed:118.0/255.0 green:183.0/255.0 blue:189.0/255.0  alpha:1] forState:UIControlStateNormal];
        return NO;
    }else{
        expertiseBtn.layer.backgroundColor = [UIColor colorWithRed:118.0/255.0 green:183.0/255.0 blue:189.0/255.0 alpha:1].CGColor;
        [expertiseBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        return YES;
        
    }
}

-(void) resetAllButtonColors {
    
    /*Monthlybtn = NO;
     Weeklybtn = NO;
     Dailybtn =  NO;
     Unavailblebtn = NO;
     */
    
    UIButton *expertiseBtn = (UIButton *) [self.view viewWithTag:1];
    expertiseBtn.layer.backgroundColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0  alpha:1].CGColor;
    [expertiseBtn setTitleColor:[UIColor colorWithRed:118.0/255.0 green:183.0/255.0 blue:189.0/255.0  alpha:1] forState:UIControlStateNormal];
    
    expertiseBtn = (UIButton *) [self.view viewWithTag:2];
    expertiseBtn.layer.backgroundColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0  alpha:1].CGColor;
    [expertiseBtn setTitleColor:[UIColor colorWithRed:118.0/255.0 green:183.0/255.0 blue:189.0/255.0  alpha:1] forState:UIControlStateNormal];
    
    expertiseBtn = (UIButton *) [self.view viewWithTag:3];
    expertiseBtn.layer.backgroundColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0  alpha:1].CGColor;
    [expertiseBtn setTitleColor:[UIColor colorWithRed:118.0/255.0 green:183.0/255.0 blue:189.0/255.0  alpha:1] forState:UIControlStateNormal];
    
    expertiseBtn = (UIButton *) [self.view viewWithTag:4];
    expertiseBtn.layer.backgroundColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0  alpha:1].CGColor;
    [expertiseBtn setTitleColor:[UIColor colorWithRed:118.0/255.0 green:183.0/255.0 blue:189.0/255.0  alpha:1] forState:UIControlStateNormal];
    
}


@end
