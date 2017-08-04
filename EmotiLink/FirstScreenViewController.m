//
//  FirstScreenViewController.m
//  EmotiLink
//
//  Created by Starsoft on 2017-02-27.
//  Copyright © 2017 Stark. All rights reserved.
//

#import "FirstScreenViewController.h"
#import "ProviderMarketPlaceViewController.h"
#import "AppDelegate.h"
#import "GlobalFunction.h"
#import "TopRankingListViewController.h"

@interface FirstScreenViewController ()

@end

@implementation FirstScreenViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIImageView *bgImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"01.PreLogin.png"]];
    bgImageView.frame = self.view.bounds;
    bgImageView.contentMode = UIViewContentModeScaleAspectFill;
    bgImageView.clipsToBounds = YES;
    [self setBorderColor:5];
    
    [_mainViewBackground addSubview:bgImageView];
    [_mainViewBackground sendSubviewToBack:bgImageView];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void) setBorderColor:(int)tagName{
    UIButton *cancelBtn = (UIButton *) [self.view viewWithTag:tagName];
    cancelBtn.layer.borderColor = [UIColor colorWithRed:83.0/255.0 green:93.0/255.0 blue:122.0/255.0 alpha:1].CGColor;
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

- (IBAction)searchProviderClick:(id)sender {
    /*UIStoryboard *storyboard = [UIStoryboard storyboardWithName:
     @"GeneralStoryboard" bundle:nil];
     
     [self presentViewController:[storyboard instantiateViewControllerWithIdentifier:@"sessionHistory"] animated:NO completion:nil];*/
    
    [self ServiceCall];
    
    //ProviderMarketPlaceViewController *vc=[self.storyboard instantiateViewControllerWithIdentifier:@"ProviderMarketPlace"];
    //NSMutableArray *responseArray=[response mutableCopy];
    //vc.providerDataArray=responseArray;
    //[self.navigationController pushViewController:vc animated:YES];
    
    //[self presentViewController:vc animated:YES completion:nil];
    
}


//  Added by:Zeenath
//  Added Date:2016-08-08.
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
//  Added Date:2016-08-08.
//  Description:To stop the activity indicator.
-(void)stopLoadingIndicator
{
    
    _loadingView.hidden=YES;
}


//call Ranking API
-(void)ServiceCall{
    
    [self startLoadingIndicator];
    AppDelegate *appdelegate= (AppDelegate *)[[UIApplication sharedApplication]delegate];
    
    NSString *getRankingUrl=[appdelegate.serviceURL stringByAppendingString:@"api/Admin/GetProviderRanking"];
    [[GlobalFunction sharedInstance] getServerResponseForUrl:getRankingUrl method:@"GET" param:nil withCallback:^(NSInteger statusCode, NSDictionary *response, NSError *error)
     {
         
         // GlobalFunction *globalValues=[[GlobalFunction alloc]init];
         NSString *message;
         
         if (statusCode == 200 || statusCode==400)
         {
             [self stopLoadingIndicator];
             UIStoryboard *storyboard = [UIStoryboard storyboardWithName:
                                         @"UserStoryboard" bundle:nil];
             
             TopRankingListViewController *vc=[storyboard instantiateViewControllerWithIdentifier:@"TopRankingList"];
             
             if(statusCode==200){
                 NSMutableArray *responseArray=[response mutableCopy];
                 vc.providerDataArray=responseArray;
             }
             
             [self presentViewController:vc animated:YES completion:nil];
             
         }else if(statusCode==404){
             
             _alert = [UIAlertController
                       alertControllerWithTitle:@""
                       message:[[GlobalFunction sharedInstance].arrayOfAlerts objectAtIndex:78]
                       preferredStyle:UIAlertControllerStyleAlert];
             
             UIAlertAction* okButton = [UIAlertAction
                                        actionWithTitle:@"OK"
                                        style:UIAlertActionStyleDefault
                                        handler:^(UIAlertAction * action) {
                                            [self stopLoadingIndicator];
                                        }];
             [_alert addAction:okButton];
             [self presentViewController:_alert animated:YES completion:nil];
             
         }else{
             
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


- (IBAction)tcClick:(id)sender {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:
                                @"GeneralStoryboard" bundle:nil];
    
    [self presentViewController:[storyboard instantiateViewControllerWithIdentifier:@"TermsConditionViewController"] animated:NO completion:nil];
}

- (IBAction)ppClick:(id)sender {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:
                                @"GeneralStoryboard" bundle:nil];
    
    [self presentViewController:[storyboard instantiateViewControllerWithIdentifier:@"Aboutusview"] animated:NO completion:nil];
}

@end


