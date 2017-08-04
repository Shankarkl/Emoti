//
//  AmountEarnedViewController.m
//  EmotiLink
//
//  Created by Star on 3/14/17.
//  Copyright © 2017 Stark. All rights reserved.
//

#import "AmountEarnedViewController.h"
#import "GlobalFunction.h"
#import "AppDelegate.h"


@interface AmountEarnedViewController ()

@end

@implementation AmountEarnedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIImage *backgroundImage = [UIImage imageNamed:@"06. Appointment Confirmation.png"];
    UIImageView *backgroundImageView=[[UIImageView alloc]initWithFrame:self.view.frame];
    backgroundImageView.image=backgroundImage;
    [self.view insertSubview:backgroundImageView atIndex:0];
    // Do any additional setup after loading the view.
    
    //Discription: get the payment due details
    
    
    AppDelegate *app= (AppDelegate *)[[UIApplication sharedApplication]delegate];
    NSString *dueUrl=[app.serviceURL stringByAppendingString:@"/api/Provider/DueAmount"];
   
    [[GlobalFunction sharedInstance] getServerResponseAfterLogin:dueUrl method:@"GET" param:nil withCallback:^(NSInteger statusCode, NSDictionary *response, NSError *error)
     {
    if(statusCode==200) {
        
        NSString *Sessions=[response valueForKey:@"numberOfSessions"];
        NSNumber *value=[NSNumber numberWithInteger:[Sessions integerValue]];
        _NoSessions.text=[value stringValue];
        _TotalBillbl.text=[response objectForKey:@"totalBilledCurrency"];
        _TotalDepositeLbl.text=[response objectForKey:@"totalDepositedCurrency"];
        
    }else{
        _NoSessions.text=@"0";
        _TotalBillbl.text=@"0";
        _TotalDepositeLbl.text=@"0";
    }
     
     
     }];
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

- (IBAction)CloseBtn:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)backbtn:(id)sender {
     [self dismissViewControllerAnimated:YES completion:nil];
}


@end
