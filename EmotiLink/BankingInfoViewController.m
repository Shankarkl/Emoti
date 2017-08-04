/***************************************************************
 Page name: BankingInfoViewController.m
 Created By: nalina
 Created Date:06/07/16
 Description: Banking info implementation file
 ***************************************************************/

#import "BankingInfoViewController.h"
#import "GlobalFunction.h"
#import "LoginViewController.h"
#import "AppDelegate.h"
#import <Google/Analytics.h>

@interface BankingInfoViewController ()

@end

@implementation BankingInfoViewController

//Loads first time when page appears
- (void)viewDidLoad {
    _accountnumberTxt.delegate = self;
    _institutenumberTxt.delegate = self;
    _swiftcodeTxt.delegate = self;
    
    [self.accountnumberTxt addTarget:self action:@selector(ValidationRemovalOnTouch:) forControlEvents:UIControlEventAllTouchEvents];
    [self.accountnumberTxt addTarget:self action:@selector(ValidationRemovalOnTouch:) forControlEvents:UIControlEventEditingChanged];
    
    [self.institutenumberTxt addTarget:self action:@selector(ValidationRemovalOnTouch:) forControlEvents:UIControlEventAllTouchEvents];
    [self.institutenumberTxt addTarget:self action:@selector(ValidationRemovalOnTouch:) forControlEvents:UIControlEventEditingChanged];
    
    [self.swiftcodeTxt addTarget:self action:@selector(ValidationRemovalOnTouch:) forControlEvents:UIControlEventAllTouchEvents];
    [self.swiftcodeTxt addTarget:self action:@selector(ValidationRemovalOnTouch:) forControlEvents:UIControlEventEditingChanged];
    
    [super viewDidLoad];
    
    [self setBorderColor:5];
    
    //Added by: nalina
    //Added Date: 05/08/2016
    //Discription: Get details of user banking info service call
    if (![_pagename isEqualToString:@"firsttime"]) {
   AppDelegate *appdelegate=(AppDelegate *)[[UIApplication sharedApplication]delegate];
    NSString *UrlBankingInfo=[appdelegate.serviceURL stringByAppendingString:@"api/Provider/ProviderBankingInfo"];
    [self startLoadingIndicator];
    
    [[GlobalFunction sharedInstance]getServerResponseAfterLogin:UrlBankingInfo method:@"GET" param:nil withCallback:^(NSInteger statusCode, NSDictionary *response, NSError *error) {
        [self stopLoadingIndicator];
        
        _accountnumberTxt.text=[response objectForKey:@"accountNumber"];
        _institutenumberTxt.text=[response objectForKey:@"institutionNumber"];
        _swiftcodeTxt.text=[response objectForKey:@"swiftCode"];
    
       
        //Added by: Nalina
        //Added Date: 19/07/2016
        //Discription: To add the done button to the number keypad
        
        UIToolbar* numberToolbar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 50)];
        numberToolbar.barStyle = UIBarStyleBlackTranslucent;
        numberToolbar.items = @[
                                [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],
                                [[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(hideNumberKeypad)],[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil]];
        [numberToolbar sizeToFit];
        _accountnumberTxt.inputAccessoryView = numberToolbar;
        _institutenumberTxt.inputAccessoryView = numberToolbar;
        [self stopLoadingIndicator];
    
    }];
    }
    UIImageView *bgImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"LoginBackground.png"]];
    bgImageView.frame = self.view.bounds;
    bgImageView.contentMode = UIViewContentModeScaleAspectFill;
    bgImageView.clipsToBounds = YES;
    [self.view addSubview:bgImageView];
    [self.view sendSubviewToBack:bgImageView];
}

-(void) setBorderColor:(int)tagName{
    UIButton *cancelBtn = (UIButton *) [self.view viewWithTag:tagName];
    cancelBtn.layer.borderColor = [UIColor colorWithRed:246.0/255.0 green:108.0/255.0 blue:118.0/255.0 alpha:1].CGColor;
}

//Hide the number keypad
-(void)hideNumberKeypad{
    [_accountnumberTxt resignFirstResponder];
    [_institutenumberTxt resignFirstResponder];
}

//Added by: Nalina
//Added Date: 6/07/2016
//Discription: set border to the input field

-(void)setBorder:(UIView *)view
{
    view.layer.borderColor = [[UIColor colorWithRed:228.0/255.0 green:109.0/255.0 blue:175.0/255.0 alpha:1.0]CGColor];
    view.layer.borderWidth = 1.0f;
}

//Calls when page appears each time
-(void)viewWillAppear:(BOOL)animated{
    [self setBorder:_accountnumberView];
    [self setBorder:_institutenumberView];
    [self setBorder:_swiftcodeView];
    
    id<GAITracker> tracker = [[GAI sharedInstance] defaultTracker];
    [tracker set:kGAIScreenName value:@"BankingInformation"];
    [tracker send:[[GAIDictionaryBuilder createScreenView] build]];
}

-(void)viewDidAppear:(BOOL)animated
{
    if ([_pagename isEqualToString:@"firsttime"]) {
      [_SubmitBtn setTitle:@"Next" forState:UIControlStateNormal];
      [_CancelBtn setTitle:@"Logout" forState:UIControlStateNormal];
      _BackBtn.hidden=YES;
    }else{
        [_SubmitBtn setTitle:@"Submit" forState:UIControlStateNormal];
        [_CancelBtn setTitle:@"Cancel" forState:UIControlStateNormal];
        _BackBtn.hidden=NO;
        
        
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

//Added by: Nalina
//Added Date: 6/07/2016
//Discription: Restrict the length of the text field

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if([textField isEqual:_accountnumberTxt]){
        NSString *currentString = [textField.text stringByReplacingCharactersInRange:range withString:string];
        NSUInteger length = [currentString length];
        if (length > 17) {
            return NO;
        }
    }
    
    return YES;
}


//Added by: Nalina
//Added Date: 6/07/2016
//Discription: Remove validation on touch of input field

-(void)ValidationRemovalOnTouch:(UITextField *)theTextField{
    if([theTextField isEqual: _accountnumberTxt]){
        
        [self RemoveValidationSettings:_accountnumberTxt errorIcon:_accountnumberError indicationIcon:_accountnumberIcon HintText:@"Account number" imageIs:@"creditcard" viewField:_accountnumberView];
        
    }else if([theTextField isEqual: _institutenumberTxt]){
        _institutionInfoIcon.hidden=NO;
        
        [self RemoveValidationSettings:_institutenumberTxt errorIcon:_institutenumberError indicationIcon:_institutenumberIcon HintText:@"Institute number" imageIs:@"creditcard" viewField:_institutenumberView];
        
    }else if([theTextField isEqual: _swiftcodeTxt]){
        _swiftCodeInfoIcon.hidden=NO;
        [self RemoveValidationSettings:_swiftcodeTxt errorIcon:_swiftcodeError indicationIcon:_swiftcodeIcon HintText:@"Swift code" imageIs:@"creditcard" viewField:_swiftcodeView];
    }
    
}

//Added by: Nalina
//Added Date: 6/07/2016
//Discription: Remove validation design

-(void)RemoveValidationSettings:(UITextField *)textField errorIcon:(UIButton *)errorBtn indicationIcon:(UIImageView *)indicationIcon HintText:(NSString *)hintTextMessage imageIs:(NSString *)imageIs viewField:(UIView *)view{
    
    [textField setValue:[UIColor  colorWithRed:(112/255.0) green:(112/255.0) blue:(112/255.0) alpha:1] forKeyPath:@"_placeholderLabel.textColor"];
    textField.placeholder=hintTextMessage;
    errorBtn.hidden=YES;
    UIImage *image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:imageIs ofType:@"png"]];
    indicationIcon.image = image;
    [self setBorder:view];
    
}

//Calls on click of back icon
- (IBAction)backClick:(id)sender {
     [self dismissViewControllerAnimated:YES completion:nil];
}


//Added by: Nalina
//Added Date: 6/07/2016
//Discription: Remove validations on click of error button in input fields

- (IBAction)accountnumberErrorClose:(id)sender {
    
    [self RemoveValidationSettings:_accountnumberTxt errorIcon:_accountnumberError indicationIcon:_accountnumberIcon HintText:@"Account number" imageIs:@"creditcard" viewField:_accountnumberView];
}
- (IBAction)institutenumberErrorClose:(id)sender {
    _institutionInfoIcon.hidden=NO;
    [self RemoveValidationSettings:_institutenumberTxt errorIcon:_institutenumberError indicationIcon:_institutenumberIcon HintText:@"Institute number" imageIs:@"creditcard" viewField:_institutenumberView];
}
- (IBAction)swiftcodeErrorClose:(id)sender {
    _swiftCodeInfoIcon.hidden=NO;
    [self RemoveValidationSettings:_swiftcodeTxt errorIcon:_swiftcodeError indicationIcon:_swiftcodeIcon HintText:@"Swiftcode" imageIs:@"creditcard" viewField:_swiftcodeView];
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

//Added by: Nalina
//Added Date: 6/07/2016
//Discription: Set validation to the account number field

- (BOOL)validateAccountField:(NSString*)account
{
    NSString *accountRegex = @"^[0-9]{4,17}$";
    NSPredicate *accountTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", accountRegex];
    return [accountTest evaluateWithObject:account];
}

//Added by: Nalina
//Added Date: 6/07/2016
//Discription: validation and service call to update banking information in submit click

- (IBAction)submitClick:(id)sender {
    
    AppDelegate *appdelegate= (AppDelegate *)[[UIApplication sharedApplication]delegate];
    
    BOOL internetCheck= [appdelegate testInternetConnection];
    
    if (internetCheck==NO) {
        [appdelegate displayNetworkAlert];
        [self presentViewController:appdelegate.alert animated:YES completion:nil];
    }
   // GlobalFunction *globalValues=[[GlobalFunction alloc]init];
    
    if([_accountnumberTxt.text isEqualToString:@""]){
        
        [self SetValidationSettinds:_accountnumberTxt errorIcon:_accountnumberError indicationIcon:_accountnumberIcon validationMessage:[[GlobalFunction sharedInstance].arrayOfAlerts objectAtIndex:17] imageIs:@"error-creditCard" viewField:_accountnumberView];
        
    }else if(!([self validateAccountField:_accountnumberTxt.text])){
        _accountnumberTxt.text=@"";
        [self SetValidationSettinds:_accountnumberTxt errorIcon:_accountnumberError indicationIcon:_accountnumberIcon validationMessage:[[GlobalFunction sharedInstance].arrayOfAlerts objectAtIndex:89] imageIs:@"error-creditCard" viewField:_accountnumberView];
    }
    
    if([_institutenumberTxt.text isEqualToString:@""]){
        _institutionInfoIcon.hidden=YES;
        [self SetValidationSettinds:_institutenumberTxt errorIcon:_institutenumberError indicationIcon:_institutenumberIcon validationMessage:[[GlobalFunction sharedInstance].arrayOfAlerts objectAtIndex:18] imageIs:@"error-creditCard" viewField:_institutenumberView];
    }
    if([_swiftcodeTxt.text isEqualToString:@""]){
        _swiftCodeInfoIcon.hidden=YES;
        [self SetValidationSettinds:_swiftcodeTxt errorIcon:_swiftcodeError indicationIcon:_swiftcodeIcon validationMessage:[[GlobalFunction sharedInstance].arrayOfAlerts objectAtIndex:18] imageIs:@"error-creditCard" viewField:_swiftcodeView];
    }
    
    if(![_accountnumberTxt.text isEqualToString:@""] && ![_institutenumberTxt.text isEqualToString:@""]&& ![_swiftcodeTxt.text isEqualToString:@""]&&([self validateAccountField:_accountnumberTxt.text]))
    {
        
        NSMutableDictionary *dict=[[NSMutableDictionary alloc]init];
        [dict setObject:_accountnumberTxt.text forKey:@"accountNumber"];
        [dict setObject:_institutenumberTxt.text  forKey:@"institutionNumber"];
        [dict setObject:_swiftcodeTxt.text  forKey:@"swiftCode"];
        AppDelegate *appdelegate=(AppDelegate *)[[UIApplication sharedApplication]delegate];
        NSString *Url=[appdelegate.serviceURL stringByAppendingString:@"api/Provider/ProviderBankingInfo"];
        [self startLoadingIndicator];
        [[GlobalFunction sharedInstance]getServerResponseAfterLogin:Url method:@"POST" param:dict withCallback:^(NSInteger statusCode, NSDictionary *response, NSError *error) {
            NSString *message;
            if(statusCode == 200)
            {
                
                NSMutableDictionary *data=[[NSMutableDictionary alloc]initWithDictionary:[appdelegate usersDetails]];
                
                NSMutableDictionary *dataStatus = [[data valueForKey:@"providerStatus"] mutableCopy];
                
                [dataStatus setObject:[NSNumber numberWithInt:1] forKey:@"isBankInfoUpdated"];
                [appdelegate.usersDetails removeObjectForKey:@"providerStatus"];
                
                [appdelegate.usersDetails setObject:dataStatus forKey:@"providerStatus"];
                [self stopLoadingIndicator];
                if ([_pagename isEqualToString:@"firsttime"]) {
                    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:
                                                @"ProviderStoryboard" bundle:nil];
                    BankingInfoViewController *viewcontrol=[storyboard instantiateViewControllerWithIdentifier:@"Availability"];
                    viewcontrol.pagename=@"firsttime";
                    [self presentViewController:viewcontrol animated:NO completion:nil];
                }else{
                    

                NSString *message=[[GlobalFunction sharedInstance].arrayOfAlerts objectAtIndex:87];
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
            else
            {
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
                                               [self stopLoadingIndicator];
                                           }];
                [_alertView addAction:okButton];
                UIViewController *top = [self topMostController];
                [top presentViewController:_alertView animated:YES completion: nil];

            }
            
        }];
        
    }
    
}

//Added by: Nalina
//Added Date: 6/07/2016
//Discription: set the validation to the input fields

-(void)SetValidationSettinds:(UITextField *)textField errorIcon:(UIButton *)errorBtn indicationIcon:(UIImageView *)indicationIcon validationMessage:(NSString *)validationMessage imageIs:(NSString *)imageIs viewField:(UIView *)viewIs{
    
    [textField setValue:[UIColor redColor] forKeyPath:@"_placeholderLabel.textColor"];
    textField.placeholder=validationMessage;
    errorBtn.hidden=NO;
    UIImage *image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:imageIs ofType:@"png"]];
    indicationIcon.image = image;
    viewIs.layer.borderColor = [[UIColor redColor]CGColor];
    viewIs.layer.borderWidth = 1.0f;
    
}


//Hides soft keypad
- (BOOL)textFieldShouldReturn:(UITextField *)theTextField {
    if (theTextField == self.accountnumberTxt) {
        [self.institutenumberTxt becomeFirstResponder];
    }
    if (theTextField == self.institutenumberTxt) {
        [self.swiftcodeTxt becomeFirstResponder];
    }    if (theTextField == self.swiftcodeTxt) {
        [theTextField resignFirstResponder];
    }
    return YES;
}




//  Added by:Zeenath
//  Added Date:2016-20-09.
//  Description:Called when institution information icon is clicked.
- (IBAction)institutionInfoClick:(id)sender {
   
  //  GlobalFunction *globalValues=[[GlobalFunction alloc]init];
    _alertView = [UIAlertController
                  alertControllerWithTitle:@""
                  message:[[GlobalFunction sharedInstance].arrayOfAlerts objectAtIndex:125]
                  preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* okButton = [UIAlertAction
                               actionWithTitle:@"OK"
                               style:UIAlertActionStyleDefault
                               handler:^(UIAlertAction * action) {
                                   [self stopLoadingIndicator];
                               }];
    [_alertView addAction:okButton];
    UIViewController *top = [self topMostController];
    [top presentViewController:_alertView animated:YES completion: nil];
}


//  Added by:Zeenath
//  Added Date:2016-20-09.
//  Description:Called when swift code icon is clicked.
- (IBAction)swiftCodeInfoClick:(id)sender {
   
   // GlobalFunction *[GlobalFunction sharedInstance]=[[GlobalFunction alloc]init];
    _alertView = [UIAlertController
                  alertControllerWithTitle:@""
                  message:[[GlobalFunction sharedInstance].arrayOfAlerts objectAtIndex:124]
                  preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* okButton = [UIAlertAction
                               actionWithTitle:@"OK"
                               style:UIAlertActionStyleDefault
                               handler:^(UIAlertAction * action) {
                                   [self stopLoadingIndicator];
                               }];
    [_alertView addAction:okButton];
    UIViewController *top = [self topMostController];
    [top presentViewController:_alertView animated:YES completion: nil];
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


- (IBAction)backArrowClick:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
