/***************************************************************
 Page name: RateViewController.m
 Created By:Nalina
 Created Date:2016-07-19
 Description: Provider rate update implementation file
 ***************************************************************/

#import "RateViewController.h"
#import "GlobalFunction.h"
#import "BankingInfoViewController.h"
#import "LoginViewController.h"
#import "AppDelegate.h"
#import <Google/Analytics.h>
@interface RateViewController ()

@end

@implementation RateViewController

//Loads when page appears for the first time
- (void)viewDidLoad {
    
    [self setBorderColor:5];
    [self stopLoadingIndicator];
    _rateTxt.delegate = self;
    
    [self.rateTxt addTarget:self action:@selector(textRemoveValidation:) forControlEvents:UIControlEventAllTouchEvents];
    [self.rateTxt addTarget:self action:@selector(textRemoveValidation:) forControlEvents:UIControlEventEditingChanged];
    
    _rateView.layer.borderColor = [[UIColor colorWithRed:228.0/255.0 green:109.0/255.0 blue:175.0/255.0 alpha:1.0]CGColor];
    _rateView.layer.borderWidth = 1.0f;
    
    
    
    
    //Added by: Nalina
    //Added Date: 19/07/2016
    //Discription: To add the done button to the number keypad
    
    UIToolbar* numberToolbar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 50)];
    numberToolbar.barStyle = UIBarStyleBlackTranslucent;
    numberToolbar.items = @[
                            [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],
                            [[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(doneWithNumberPad)],[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil]];
    [numberToolbar sizeToFit];
    _rateTxt.inputAccessoryView = numberToolbar;
    
    if (![_pagename isEqualToString:@"firsttime"]) {
    AppDelegate *appdelegate=(AppDelegate *)[[UIApplication sharedApplication]delegate];
    NSString *Url=[appdelegate.serviceURL stringByAppendingString:@"api/Provider/ProviderRate"];
    [self startLoadingIndicator];
    [[GlobalFunction sharedInstance]getServerResponseAfterLogin:Url method:@"GET" param:nil withCallback:^(NSInteger statusCode, NSDictionary *response, NSError *error) {
        [self stopLoadingIndicator];
        if(statusCode==200){
            NSString *amount=[response valueForKey:@"amount"];
            NSNumber *value=[NSNumber numberWithInteger:[amount integerValue]];
            _rateTxt.text=[value stringValue];
        }
        
    }];
    }
    
    [super viewDidLoad];
    [self setBorderColor:5];
    
    UIImage *backgroundImage = [UIImage imageNamed:@"LoginBackground.png"];
    UIImageView *backgroundImageView=[[UIImageView alloc]initWithFrame:self.view.frame];
    backgroundImageView.image=backgroundImage;
    [self.view insertSubview:backgroundImageView atIndex:0];
}



-(void) setBorderColor:(int)tagName{
    UIButton *cancelBtn = (UIButton *) [self.view viewWithTag:tagName];
    cancelBtn.layer.borderColor = [UIColor colorWithRed:246.0/255.0 green:108.0/255.0 blue:118.0/255.0 alpha:1].CGColor;
}
-(void)viewDidAppear:(BOOL)animated
{
    if ([_pagename isEqualToString:@"firsttime"]) {
        [_SubmitBtn setTitle:@"Next" forState:UIControlStateNormal];
         [_Cancelbtn setTitle:@"Logout" forState:UIControlStateNormal];
        _backbutton.hidden=YES;
    }else{
        [_SubmitBtn setTitle:@"Submit" forState:UIControlStateNormal];
        [_Cancelbtn setTitle:@"Cancel" forState:UIControlStateNormal];
        _backbutton.hidden=NO;
        
        
    }

}
//Loads each time when page appears
-(void)viewWillAppear:(BOOL)animated
{
    id<GAITracker> tracker = [[GAI sharedInstance] defaultTracker];
    [tracker set:kGAIScreenName value:@"Rate"];
    [tracker send:[[GAIDictionaryBuilder createScreenView] build]];
}

//After click on number pad done button hide the keyboard
-(void)doneWithNumberPad{
    [_rateTxt resignFirstResponder];
}

//To hide the soft keypad
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// Added By:Nalina
// Added Date:19/07/16
// Description: Remove validation design on change of the text field

-(void)textRemoveValidation :(UITextField *)theTextField
{
    [self.rateTxt setValue:[UIColor  colorWithRed:(112/255.0) green:(112/255.0) blue:(112/255.0) alpha:1] forKeyPath:@"_placeholderLabel.textColor"];
    _rateTxt.placeholder=@"Enter Rate";
    _rateError.hidden=YES;
    _rateView.layer.borderColor = [[UIColor colorWithRed:228.0/255.0 green:109.0/255.0 blue:175.0/255.0 alpha:1.0]CGColor];
    _rateView.layer.borderWidth = 1.0f;
}

//Close the screen on click of back button in header
- (IBAction)backClick:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

//Close the validation field on click of rate error close button
- (IBAction)rateErrorClose:(id)sender {
    [self.rateTxt setValue:[UIColor  colorWithRed:(112/255.0) green:(112/255.0) blue:(112/255.0) alpha:1] forKeyPath:@"_placeholderLabel.textColor"];
    _rateTxt.placeholder=@"Enter Rate";
    _rateError.hidden=YES;
    _rateView.layer.borderColor = [[UIColor colorWithRed:228.0/255.0 green:109.0/255.0 blue:175.0/255.0 alpha:1.0]CGColor];
    _rateView.layer.borderWidth = 1.0f;
}

//Close the screen on click of cancel button
- (IBAction)cancelClick:(id)sender {
    if ([_pagename isEqualToString:@"firsttime"]) {
        AppDelegate *appdelegate=(AppDelegate *)[[UIApplication sharedApplication]delegate];
        
        _alert = [UIAlertController
                  alertControllerWithTitle:@""
                  message:[[GlobalFunction sharedInstance].arrayOfAlerts objectAtIndex:52]
                  preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* yesButton = [UIAlertAction
                                    actionWithTitle:@"Yes"
                                    style:UIAlertActionStyleDefault
                                    handler:^(UIAlertAction * action) {
                                        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
                                        LoginViewController *vc=[storyboard instantiateViewControllerWithIdentifier:@"LoginScreen"];
                                        [self presentViewController:vc animated:YES completion:nil];
                                        // [self dismissViewControllerAnimated:YES completion:nil];
                                        /*[[[[[self presentingViewController]presentingViewController]presentingViewController]presentingViewController]dismissViewControllerAnimated:YES completion:nil];*/
                                        appdelegate.accessToken=nil;
                                        appdelegate.usersDetails=nil;
                                        appdelegate.availabilityArray=nil;
                                        appdelegate.availabilityId=nil;
                                        appdelegate.availableData=nil;
                                        appdelegate.screenStatus=@"";
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
    }else{
   [self dismissViewControllerAnimated:YES completion:nil];
    }

}

// Added By:Nalina
// Added Date:19/07/16
// Description: Save button click and validate the input field

- (IBAction)saveClick:(id)sender {
    
    AppDelegate *appdelegate= (AppDelegate *)[[UIApplication sharedApplication]delegate];
    
    BOOL internetCheck= [appdelegate testInternetConnection];
    
    if (internetCheck==NO) {
        [appdelegate displayNetworkAlert];
        [self presentViewController:appdelegate.alert animated:YES completion:nil];
    }
    //  GlobalFunction *globalValues=[[GlobalFunction alloc]init];
    if([_rateTxt.text isEqualToString:@""]){
        [self.rateTxt setValue:[UIColor redColor] forKeyPath:@"_placeholderLabel.textColor"];
        _rateTxt.placeholder=[[GlobalFunction sharedInstance].arrayOfAlerts objectAtIndex:55];
        _rateError.hidden=NO;
        _rateView.layer.borderColor = [[UIColor redColor]CGColor];
        _rateView.layer.borderWidth = 1.0f;
    }
    
    if(![_rateTxt.text isEqualToString:@""] )
    {
        //  Added by:Zeenath
        //  Added Date:2016-10-08.
        //  Description:call the web services to update the rate
        
        NSMutableDictionary *dict=[[NSMutableDictionary alloc]init];
        NSString *amount=_rateTxt.text;
        [dict setObject:amount forKey:@"amount"];
        AppDelegate *appdelegate=(AppDelegate *)[[UIApplication sharedApplication]delegate];
        NSString *Url=[appdelegate.serviceURL stringByAppendingString:@"api/Provider/ProviderRate"];
        [self startLoadingIndicator];
        [[GlobalFunction sharedInstance]getServerResponseAfterLogin:Url method:@"POST" param:dict withCallback:^(NSInteger statusCode, NSDictionary *response, NSError *error) {
            if(statusCode == 200)
            {
                [self stopLoadingIndicator];
                NSMutableDictionary *data=[[NSMutableDictionary alloc]initWithDictionary:[appdelegate usersDetails]];
                
                NSMutableDictionary *dataStatus = [[data valueForKey:@"providerStatus"] mutableCopy];
                
                [dataStatus setObject:[NSNumber numberWithInt:1] forKey:@"isRateUpdated"];
                [appdelegate.usersDetails removeObjectForKey:@"providerStatus"];
                
                [appdelegate.usersDetails setObject:dataStatus forKey:@"providerStatus"];
                
                if ([_pagename isEqualToString:@"firsttime"]) {
                    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:
                                                @"ProviderStoryboard" bundle:nil];
                    BankingInfoViewController *viewcontrol=[storyboard instantiateViewControllerWithIdentifier:@"Banking"];
                    viewcontrol.pagename=@"firsttime";
                    [self presentViewController:viewcontrol animated:NO completion:nil];
                }else{

               
                 NSString *message=[[GlobalFunction sharedInstance].arrayOfAlerts objectAtIndex:82];
                _alertView = [UIAlertController
                              alertControllerWithTitle:@""
                              message:message
                              preferredStyle:UIAlertControllerStyleAlert];
                
                UIAlertAction* okButton = [UIAlertAction
                                           actionWithTitle:@"OK"
                                           style:UIAlertActionStyleDefault
                                           handler:^(UIAlertAction * action) {
                                               
                                               [self dismissViewControllerAnimated:YES completion:nil];
                                               
                                           }];
                [_alertView addAction:okButton];
                UIViewController *top = [self topMostController];
                [top presentViewController:_alertView animated:YES completion: nil];
                }
               
            }
            else{
                NSString *message;
                [self stopLoadingIndicator];
                
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
                
                _alertView = [UIAlertController
                              alertControllerWithTitle:@""
                              message:message
                              preferredStyle:UIAlertControllerStyleAlert];
                
                UIAlertAction* okButton = [UIAlertAction
                                           actionWithTitle:@"OK"
                                           style:UIAlertActionStyleDefault
                                           handler:^(UIAlertAction * action) {
                                               
                                               [self.navigationController popViewControllerAnimated:YES];
                                               
                                           }];
                [_alertView addAction:okButton];
                UIViewController *top = [self topMostController];
                [top presentViewController:_alertView animated:YES completion: nil];
                [self stopLoadingIndicator];
            }
            // [self stopLoadingIndicator];
    
        }];
        
    }
}

- (UIViewController*) topMostController {
    UIViewController *topController = [UIApplication sharedApplication].keyWindow.rootViewController;
    
    while (topController.presentedViewController) {
        topController = topController.presentedViewController;
    }
    
    return topController;
}



//  Added by:Zeenath
//  Added Date:2016-10-08.
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
//  Added Date:2016-10-08.
//  Description:To stop the activity indicator.

-(void)stopLoadingIndicator
{
    _loadingView.hidden=YES;
}

- (IBAction)backbtn:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
