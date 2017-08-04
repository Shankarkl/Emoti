//
//  ProviderSessionHistoryRedirectViewController.m
//  EmotiLink
//
//  Created by Star on 4/17/17.
//  Copyright © 2017 Stark. All rights reserved.
//

#import "ProviderSessionHistoryRedirectViewController.h"
#import "SessionHistoryViewController.h"
#import "ProviderDashboard.h"

@interface ProviderSessionHistoryRedirectViewController ()

@end

@implementation ProviderSessionHistoryRedirectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:
                                @"GeneralStoryboard" bundle:nil];
    
    SessionHistoryViewController*viewcontrol=[storyboard instantiateViewControllerWithIdentifier:@"sessionhistory"];
    
    viewcontrol.userRole = @"Provider";
    
    [self presentViewController:[storyboard instantiateViewControllerWithIdentifier:@"sessionhistory"] animated:NO completion:nil];
    
    // Do any additional setup after loading the view.
    [self.tabBarController setSelectedIndex:0];
}

@end
