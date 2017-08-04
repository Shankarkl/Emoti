//
//  AppointmentConfirmSecondViewController.m
//  EmotiLink
//
//  Created by Star on 4/27/17.
//  Copyright © 2017 Stark. All rights reserved.
//

#import "AppointmentConfirmSecondViewController.h"
#import "AppDelegate.h"
#import "MakeAnAppointmentViewController.h"
#import "UserDashboardViewController.h"
#define appdelegate (AppDelegate *)[[UIApplication sharedApplication]delegate]
@interface AppointmentConfirmSecondViewController ()

@end

@implementation AppointmentConfirmSecondViewController

- (void)viewDidLoad {
    NSLog(@"DETAILS1%@",_providerDetails);
    _details=[[appdelegate usersDetails] mutableCopy];
    NSString *name=[[_providerDetails objectForKey:@"providerfirstName"] stringByAppendingString:@" "];
     NSString *providerName= [name stringByAppendingString:[_providerDetails objectForKey:@"providerlastName"]];
    NSString *userName=[[appdelegate usersDetails]valueForKey:@"displayName"];
    _ThankyouLBL.text = [NSString stringWithFormat:@"%@%@%@", @"Thank you ", userName, @"!"];

       _yourappointmentlbl.text = [NSString stringWithFormat:@"%@%@%@", @"Your Appointment with ", providerName, @" has been confirmed"];
   
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

- (IBAction)bookbtn:(id)sender {
    [[[self presentingViewController]presentingViewController]dismissViewControllerAnimated:YES completion:nil];
    MakeAnAppointmentViewController *vc=[self.storyboard instantiateViewControllerWithIdentifier:@"makeanappointment"];
    //vc.providersID=providerId;
    vc.postScheduleDetails=_providerDetails;
     [self presentViewController:vc animated:NO completion:nil];
}

- (IBAction)homebtn:(id)sender {
    [[[[[self presentingViewController]presentingViewController]presentingViewController]presentingViewController] dismissViewControllerAnimated:YES completion:nil];
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"UserStoryboard" bundle:nil];
    UserDashboardViewController *viewcontrol=[storyboard instantiateViewControllerWithIdentifier:@"dashboardUsers"];
    viewcontrol.providerDetails=_details;
    [self presentViewController:[storyboard instantiateViewControllerWithIdentifier:@"UserDashboard"] animated:NO completion:nil];
}
@end
