//
//  sessionHistoryRedirectViewController.m
//  EmotiLink
//
//  Created by Starsoft on 2017-04-17.
//  Copyright © 2017 Stark. All rights reserved.
//

#import "sessionHistoryRedirectViewController.h"
#import "SessionHistoryViewController.h"

@interface sessionHistoryRedirectViewController ()

@end

@implementation sessionHistoryRedirectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSLog(@"viewDidLoad: tab index= %lu",self.tabBarController.selectedIndex);
    
    // Do any additional setup after loading the view.
    
    
    /*  UIStoryboard *storyboard = [UIStoryboard storyboardWithName:
     @"GeneralStoryboard" bundle:nil];
     
     [self presentViewController:[storyboard instantiateViewControllerWithIdentifier:@"sessionhistory"] animated:NO completion:nil];
     
     UIStoryboard *storyboard = [UIStoryboard storyboardWithName:
     @"GeneralStoryboard" bundle:nil];
     
     SessionHistoryViewController*viewcontrol=[storyboard instantiateViewControllerWithIdentifier:@"sessionhistory"];
     
     viewcontrol.userRole = @"User";
     
     
     [self presentViewController:[storyboard instantiateViewControllerWithIdentifier:@"sessionhistory"] animated:NO completion:nil];*/
    //self.tabBarController.selectedIndex = 0;
    
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

- (void)viewWillAppear:(BOOL)animated {
    
    NSLog(@"tab index= %lu",self.tabBarController.selectedIndex);
    
    //if(!(self.tabBarController.selectedIndex==0)){
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:
                                @"GeneralStoryboard" bundle:nil];
    
    SessionHistoryViewController*viewcontrol=[storyboard instantiateViewControllerWithIdentifier:@"sessionhistory"];
    
    viewcontrol.userRole = @"User";
    
    [self presentViewController:[storyboard instantiateViewControllerWithIdentifier:@"sessionhistory"] animated:NO completion:nil];
    
    //}
    //self.tabBarController.selectedIndex = 0;
    
    [self.tabBarController setSelectedIndex:0];
}

- (void)viewDidAppear:(BOOL)animated {
    /*UIStoryboard *storyboard = [UIStoryboard storyboardWithName:
     @"GeneralStoryboard" bundle:nil];
     
     SessionHistoryViewController*viewcontrol=[storyboard instantiateViewControllerWithIdentifier:@"sessionhistory"];
     
     viewcontrol.userRole = @"User";
     
     
     [self presentViewController:[storyboard instantiateViewControllerWithIdentifier:@"sessionhistory"] animated:NO completion:nil];*/
    
    //self.tabBarController.selectedIndex = 0;
}

@end
