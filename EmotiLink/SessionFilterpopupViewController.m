//
//  SessionFilterpopupViewController.m
//  EmotiLink
//
//  Created by Star on 4/18/17.
//  Copyright © 2017 Stark. All rights reserved.
//

#import "SessionFilterpopupViewController.h"
#import "SessionHistoryViewController.h"
#import "GlobalFunction.h"
#import "AppDelegate.h"

@interface SessionFilterpopupViewController ()

@end

@implementation SessionFilterpopupViewController

- (void)viewDidLoad {
    [super viewDidLoad];
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

- (IBAction)CancelBtn:(id)sender {
     [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)SessionHistoryBtn:(id)sender {
      [self dismissViewControllerAnimated:YES completion:nil];
    AppDelegate *appdelegate= (AppDelegate *)[[UIApplication sharedApplication]delegate];
    NSString *getUrl=[appdelegate.serviceURL stringByAppendingString:@"api/Appointments/SessionHistory"];
    [[SessionHistoryViewController sharedInstance] ServiceCall:_sessionHistoryView url:getUrl method:@"GET" param:nil];
}

- (IBAction)ScheduleAppointmentBtn:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
    AppDelegate *appdelegate= (AppDelegate *)[[UIApplication sharedApplication]delegate];
    NSString *getUrl=[appdelegate.serviceURL stringByAppendingString:@"api/Appointments/ScheduleAppointment"];
    [[SessionHistoryViewController sharedInstance] ServiceCall:_sessionHistoryView url:getUrl method:@"GET" param:nil];
}

- (IBAction)sessionApprovalBtn:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
    AppDelegate *appdelegate= (AppDelegate *)[[UIApplication sharedApplication]delegate];
    NSString *getUrl=[appdelegate.serviceURL stringByAppendingString:@"api/Appointments/AppointmentWaitingApproval"];
    [[SessionHistoryViewController sharedInstance] ServiceCall:_sessionHistoryView url:getUrl method:@"GET" param:nil];
}

- (IBAction)CancelAppointmentBtn:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
    AppDelegate *appdelegate= (AppDelegate *)[[UIApplication sharedApplication]delegate];
    NSString *getUrl=[appdelegate.serviceURL stringByAppendingString:@"api/Appointments/CanceledAppointments"];
    [[SessionHistoryViewController sharedInstance] ServiceCall:_sessionHistoryView url:getUrl method:@"GET" param:nil];
}

- (IBAction)RejectAppointmentBtn:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
    AppDelegate *appdelegate= (AppDelegate *)[[UIApplication sharedApplication]delegate];
    NSString *getUrl=[appdelegate.serviceURL stringByAppendingString:@"api/Appointments/SessionHistory"];
    [[SessionHistoryViewController sharedInstance] ServiceCall:_sessionHistoryView url:getUrl method:@"GET" param:nil];
}
@end
