//
//  OTPViewController.m
//  EmotiLink
//
//  Created by Star on 3/27/17.
//  Copyright © 2017 Stark. All rights reserved.
//

#import "OTPViewController.h"
#import "AppDelegate.h"
#import "GlobalFunction.h"
#import "LoginViewController.h"
#import "ForgotPasswordViewController.h"
#import "ForgotUserNameViewController.h"
#import "UserDashboardViewController.h"
#import "ProviderDashboard.h"

@interface OTPViewController ()

@end

@implementation OTPViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"global %@",_secondLabelText);
    NSLog(@"globalemail %@",_emailLabelText);
    
    self.modalPresentationStyle = UIModalPresentationCurrentContext;
    
    UIButton *cancelBtn = (UIButton *) [self.view viewWithTag:5];
    cancelBtn.layer.borderColor = [UIColor colorWithRed:246.0/255.0 green:108.0/255.0 blue:118.0/255.0 alpha:1].CGColor;

    
    /*[self.view setBackgroundColor:[UIColor clearColor]];
    [self.view setOpaque:NO];*/
    // Do any additional setup after loading the view.
    
    
    
    UIToolbar* numberToolbar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 50)];
    numberToolbar.barStyle = UIBarStyleBlackTranslucent;
    numberToolbar.items = @[
                            [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],
                            [[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(doneWithNumberPad)],[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil]];
    [numberToolbar sizeToFit];
    _OTPtxt.inputAccessoryView = numberToolbar;
    
    
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

- (IBAction)SubmitClick:(id)sender {
    AppDelegate *appdelegate= (AppDelegate *)[[UIApplication sharedApplication]delegate];
    
    
    BOOL internetCheck= [appdelegate testInternetConnection];
    
    if (internetCheck) {
        // ForgotPasswordViewController *forgotPasswordviewController=[self.storyboard instantiateViewControllerWithIdentifier:@"ForgotPasswordViewController"];
        
    }else{
        [appdelegate displayNetworkAlert];
        [self presentViewController:appdelegate.alert animated:YES completion:nil];
        return;
    }
    
    // GlobalFunction *globalValues=[[GlobalFunction alloc]init];
    if([_OTPtxt.text isEqualToString:@""]){
        [self.OTPtxt setValue:[UIColor redColor] forKeyPath:@"_placeholderLabel.textColor"];
        _OTPtxt.placeholder=[[GlobalFunction sharedInstance].arrayOfAlerts objectAtIndex:134];
        
        
    }
    
    if(!([_OTPtxt.text isEqualToString:@""]))
    {
        
        /************** validate username service ******************/
        
        
        AppDelegate *appdelegate=(AppDelegate *)[[UIApplication sharedApplication]delegate];
        NSString *OTPUrl=[appdelegate.serviceURL stringByAppendingString:@"api/Account/VerifyOTP"];
        NSMutableDictionary *forgototpData = [[NSMutableDictionary alloc] init];
        
        if(!_emailLabelText || [_emailLabelText isKindOfClass:[NSNull class]]){
            //[forgototpData setObject:@"" forKey:@"email"];
        }else{
            [forgototpData setObject:_emailLabelText forKey:@"email"];
        }
        
        if(!_secondLabelText || [_secondLabelText isKindOfClass:[NSNull class]]){
            //[forgototpData setObject:@"" forKey:@"userName"];
        }
        
        else{
            [forgototpData setObject:_secondLabelText forKey:@"userName"];
        }
        
        [forgototpData setObject:_OTPtxt.text forKey:@"otpCode"];
        
        NSLog(@"forgototpData=  %@",forgototpData);

        /*if (internetCheck) {
         [self startLoadingIndicator];
         }*/
        
        [self startLoadingIndicator];
        [[GlobalFunction sharedInstance] getServerResponseForUrl:OTPUrl method:@"POST" param:forgototpData withCallback:^(NSInteger statusCode, NSDictionary *response, NSError *error)
         {
             
             // GlobalFunction *globalValues=[[GlobalFunction alloc]init];
             NSLog(@"globalresponse %@",response);
             NSString *message;
             
             if (statusCode == 200)
             {
                 message=[[GlobalFunction sharedInstance].arrayOfAlerts objectAtIndex:66];
                 
                 _alert = [UIAlertController
                           alertControllerWithTitle:@""
                           message:message
                           preferredStyle:UIAlertControllerStyleAlert];
                 
                 UIAlertAction* okButton = [UIAlertAction
                                            actionWithTitle:@"OK"
                                            style:UIAlertActionStyleDefault
                                            handler:^(UIAlertAction * action) {
                                                /*if ([[[appdelegate usersDetails] valueForKey:@"userRole"] isEqualToString:@"Provider"]) {
                                                    ProviderDashboard *vc=[self.storyboard instantiateViewControllerWithIdentifier:@"ProviderDashboard"];
                                                    [self presentViewController:vc animated:YES completion:nil];
                                                }else{
                                                    UserDashboardViewController *vc=[self.storyboard instantiateViewControllerWithIdentifier:@"UserDashboard"];
                                                    UserDashboardViewController *viewcontrol=[self.storyboard instantiateViewControllerWithIdentifier:@"dashboardUsers"];
                                                    viewcontrol.providerDetails=response;
                                                    [self presentViewController:vc animated:YES completion:nil];
                                             }*/
                                                
                                                [self dismissViewControllerAnimated:YES completion:nil];
                                                
                                                //[[appdelegate usersDetails] valueForKey:@"nextScheduledAppointment"]
                                                
                                                
                                                
                                            }];
                 [_alert addAction:okButton];
                 [self presentViewController:_alert animated:YES completion:nil];
                 [self.navigationController popViewControllerAnimated:YES];
                  [self stopLoadingIndicate];
                 
             }else if(statusCode == 404){
                  [self stopLoadingIndicate];
                 _alert = [UIAlertController
                           alertControllerWithTitle:@""
                           message:[[GlobalFunction sharedInstance].arrayOfAlerts objectAtIndex:65]
                           preferredStyle:UIAlertControllerStyleAlert];
                 
                 UIAlertAction* okButton = [UIAlertAction
                                            actionWithTitle:@"OK"
                                            style:UIAlertActionStyleDefault
                                            handler:^(UIAlertAction * action) {
                                                //[self stopLoadingIndicator];
                                            }];
                 [_alert addAction:okButton];
                 [self presentViewController:_alert animated:YES completion:nil];
             }
             else {
                  [self stopLoadingIndicate];
                 if(statusCode==403||statusCode==503){
                     
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
                                                [self stopLoadingIndicate];
                                            }];
                 [_alert addAction:okButton];
                 [self presentViewController:_alert animated:YES completion:nil];
                 
                 
             }
             
         }];
    }
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

//Added by: Nalina
//Added date: 12/08/16
//Description: To stop and stop the activity indicator.

-(void)stopLoadingIndicate
{
    _loadingView.hidden=YES;
}

- (BOOL) textFieldShouldBeginEditing:(UITextField *)textField
{
    
    return NO;
    
}
-(void)doneWithNumberPad{
    [_OTPtxt resignFirstResponder];
}

- (IBAction)cancelBtnClick:(id)sender {
     [self dismissViewControllerAnimated:YES completion:nil];
}
@end
