/***************************************************************
 Page name:Forgotpasswordviewcontroller.m
 Created By: zeenath
 Created Date:29/6/16
 Description:Forgot password implementation of functionality file
 ***************************************************************/


#import "ForgotPasswordViewController.h"
#import "ProviderSignUpTellUsAboutYourself.h"
#import "GlobalFunction.h"
#import "ThanksViewController.h"
#import "ChangePasswordViewController.h"
#import "AppDelegate.h"
#import "LoginViewController.h"
#import "OTPViewController.h"
#import "TermsAndConditionViewController.h"
#define appdelegate (AppDelegate *)[[UIApplication sharedApplication]delegate]
@interface ForgotPasswordViewController ()

@end

@implementation ForgotPasswordViewController



//Loads first time when page appears
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setBorderColor:5];
    
    UIImage *backgroundImage = [UIImage imageNamed:@"LoginBackground.png"];
    UIImageView *backgroundImageView=[[UIImageView alloc]initWithFrame:self.view.frame];
    backgroundImageView.image=backgroundImage;
    [self.view insertSubview:backgroundImageView atIndex:0];

    /*bgImageView.frame = self.backgroundForgotPswView.bounds;
    [_backgroundForgotPswView addSubview:bgImageView];
    [_backgroundForgotPswView sendSubviewToBack:bgImageView];*/
   
   
    NSLog(@"globalforgot %@",_secondLabelText);
    _emailLabelText= @"";
    //NSLog(@"globalemail %@",_emailLabelText);
   //self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"background.png"]];*/
    /*UIImageView *bgImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"background.png"]];
    bgImageView.frame = self.view.bounds;
    //[ addSubview:bgImageView];
    //[UIView sendSubviewToBack:bgImageView];*/
    [super viewDidLoad];
    //self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"background.png"]];

   
    _emailTxt.delegate = self;
    
    [self.emailTxt addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventAllTouchEvents];
    [self.emailTxt addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

//Hides the soft keypad
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

-(void) setBorderColor:(int)tagName{
    UIButton *cancelBtn = (UIButton *) [self.view viewWithTag:tagName];
    cancelBtn.layer.borderColor = [UIColor colorWithRed:246.0/255.0 green:108.0/255.0 blue:118.0/255.0 alpha:1].CGColor;
}

//Loads each time when page appears
-(void)viewWillAppear:(BOOL)animated{
    
   // _emailView.layer.borderColor = [[UIColor colorWithRed:228.0/255.0 green:109.0/255.0 blue:175.0/255.0 alpha:1.0]CGColor];
    //_emailView.layer.borderWidth = 1.0f;
}

//  Added by: nalina
//  Added Date:30/06/16
//  Description: Remove validation on change of text field

-(void)textFieldDidChange :(UITextField *)theTextField
{
    [self.emailTxt setValue:[UIColor  colorWithRed:(112/255.0) green:(112/255.0) blue:(112/255.0) alpha:1] forKeyPath:@"_placeholderLabel.textColor"];
    _emailTxt.placeholder=@"Phone number";
    _emailErrorClose.hidden=YES;
    UIImage *image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"email" ofType:@"png"]];
    _emailIcon.image = image;
    _emailView.layer.borderColor = [[UIColor colorWithRed:228.0/255.0 green:109.0/255.0 blue:175.0/255.0 alpha:1.0]CGColor];
    _emailView.layer.borderWidth = 1.0f;
}

//  Added by: nalina
//  Added Date:30/06/16
//  Description: Remove validation on click of error close button

- (IBAction)emailCloseBtn:(id)sender {
    _emailCloseIcon.hidden=YES;
    [self.emailTxt setValue:[UIColor  colorWithRed:(112/255.0) green:(112/255.0) blue:(112/255.0) alpha:1] forKeyPath:@"_placeholderLabel.textColor"];
    _emailTxt.placeholder=@"Email";
    _emailErrorClose.hidden=YES;
    UIImage *image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"email" ofType:@"png"]];
    _emailIcon.image = image;
    _emailView.layer.borderColor = [[UIColor colorWithRed:228.0/255.0 green:109.0/255.0 blue:175.0/255.0 alpha:1.0]CGColor];
    _emailView.layer.borderWidth = 0.0f;
}


//  Added by: nalina
//  Added Date:30/06/16
//  Description: validation pattren of email text field

- (BOOL)validateEmail:(NSString*)email
{
    NSString *emailRegex = @"[0-9]{10}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}


//  Added by: nalina
//  Added Date:30/06/16
//  Description: validation and service call on click of submit button

- (IBAction)submitClick:(id)sender {
   
}

//Close the screen on click of cancel button
- (IBAction)cancelClick:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)ConfirmClick:(id)sender {
    
    // GlobalFunction *globalValues=[[GlobalFunction alloc]init];
    AppDelegate *appdelegates= (AppDelegate *)[[UIApplication sharedApplication]delegate];
    
    BOOL internetCheck= [appdelegates testInternetConnection];
    
    if (internetCheck) {
        
    }else{
        [appdelegates displayNetworkAlert];
        [self presentViewController:appdelegates.alert animated:YES completion:nil];
        return;
    }
    
    if([_emailTxt.text isEqualToString:@""]){
        NSLog(@"global.validate");
        [self.emailTxt setValue:[UIColor redColor] forKeyPath:@"_placeholderLabel.textColor"];
        _emailTxt.placeholder=[[GlobalFunction sharedInstance].arrayOfAlerts objectAtIndex:127];
        _emailErrorClose.hidden=NO;
        _emailCloseIcon.hidden = NO;
    
        UIImage *image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"error_close" ofType:@"png"]];
        
        _emailIcon.image = image;
       /* _emailTxt.layer.borderColor = [[UIColor redColor]CGColor];
        _emailTxt.layer.borderWidth = 1.0f;
        _emailTxt.layer.cornerRadius = 10.0f;*/
        
    }else  if(!([self validateEmail:_emailTxt.text])) {
        [self.emailTxt setValue:[UIColor redColor] forKeyPath:@"_placeholderLabel.textColor"];
        _emailTxt.placeholder=[[GlobalFunction sharedInstance].arrayOfAlerts objectAtIndex:128];
        _emailCloseIcon.hidden=NO;
        UIImage *image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"error_close" ofType:@"png"]];
        _emailIcon.image = image;
        _emailTxt.text=@"";
      /*  _emailTxt.layer.borderColor = [[UIColor redColor]CGColor];
        _emailTxt.layer.borderWidth = 1.0f;
        _emailTxt.layer.cornerRadius = 10.0f;*/
        
    }
    
    if((![_emailTxt.text isEqualToString:@""])&&([self validateEmail:_emailTxt.text])){
        // NSLog(@"global.validateinside");
         _OTPview.hidden=NO;
         NSLog(@"globaluser %@",_secondLabelText);
         NSLog(@"globalphone %@",_emailTxt.text);
        [self.view addSubview:_OTPview];
        // Added By:Nalina
        // Added Date:03/08/16
        // Description: forgot username service call functionality
        
        NSString *forgotUsernameUrl=[appdelegates.serviceURL stringByAppendingString:@"api/Account/ForgotPassword"];
        NSMutableDictionary *forgotUsernameData = [[NSMutableDictionary alloc] init];
        [forgotUsernameData setObject:_emailTxt.text forKey:@"phoneNumber"];
        [forgotUsernameData setObject:_secondLabelText forKey:@"userName"];
        if (internetCheck) {
            [self startLoadingIndicator];
        }
        [[GlobalFunction sharedInstance] getServerResponseForUrl:forgotUsernameUrl method:@"POST" param:forgotUsernameData withCallback:^(NSInteger statusCode, NSDictionary *response, NSError *error)
         {
             
             // GlobalFunction *globalValues=[[GlobalFunction alloc]init];
              NSLog(@"globalresponse %@",response);
             NSString *message;
             
             if (statusCode == 200)
             {
                 NSLog(@"globalresponse %@",response);
                 
                 UIStoryboard *storyboard = [UIStoryboard storyboardWithName:
                                             @"GeneralStoryboard" bundle:nil];
                 OTPViewController *OTPViewController=[storyboard instantiateViewControllerWithIdentifier:@"OTPViewController"];
                  self.modalPresentationStyle = UIModalPresentationFullScreen;
                 
                 OTPViewController.modalPresentationStyle = UIModalPresentationOverCurrentContext;
                 
                 OTPViewController.secondLabelText=_secondLabelText;
                 OTPViewController.emailLabelText=@"";
                 [self presentViewController:OTPViewController animated:NO completion:nil];
                 [self stopLoadingIndicator];
                 /*message=[[GlobalFunction sharedInstance].arrayOfAlerts objectAtIndex:66];
                 
                 _alert = [UIAlertController
                           alertControllerWithTitle:@""
                           message:message
                           preferredStyle:UIAlertControllerStyleAlert];
                 
                 UIAlertAction* okButton = [UIAlertAction
                                            actionWithTitle:@"OK"
                                            style:UIAlertActionStyleDefault
                                            handler:^(UIAlertAction * action) {
                                                [self dismissViewControllerAnimated:YES completion:nil];
                                            }];
                 [_alert addAction:okButton];
                 [self presentViewController:_alert animated:YES completion:nil];*/
                 
                 
             }else if(statusCode == 404){
                 _alert = [UIAlertController
                           alertControllerWithTitle:@""
                           message:[[GlobalFunction sharedInstance].arrayOfAlerts objectAtIndex:65]
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
             else {
                 
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
                                                [self stopLoadingIndicator];
                                            }];
                 [_alert addAction:okButton];
                 [self presentViewController:_alert animated:YES completion:nil];
                 
                 
             }
             
         }];
        
    }
}

- (IBAction)backArrowClick:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

//Added by: Nalina
//Added date: 12/08/16
//Description: To start and stop the activity indicator.

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

-(void)stopLoadingIndicator
{
    _loadingView.hidden=YES;
}
- (IBAction)OTPsubmit:(id)sender {
    [_OTPview removeFromSuperview];
    // GlobalFunction *globalValues=[[GlobalFunction alloc]init];
    AppDelegate *appdelegates= (AppDelegate *)[[UIApplication sharedApplication]delegate];
    
    BOOL internetCheck= [appdelegates testInternetConnection];
    
    if (internetCheck) {
        
    }else{
        [appdelegates displayNetworkAlert];
        [self presentViewController:appdelegates.alert animated:YES completion:nil];
        return;
    }
    
    if([_OTPTxt.text isEqualToString:@""]){
        NSLog(@"global.validate");
        [self.OTPTxt setValue:[UIColor redColor] forKeyPath:@"_placeholderLabel.textColor"];
        _OTPTxt.placeholder=[[GlobalFunction sharedInstance].arrayOfAlerts objectAtIndex:127];
        //_emailErrorClose.hidden=NO;
        /*UIImage *image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"error_close" ofType:@"png"]];
        
        _emailIcon.image = image;*/
        _OTPTxt.layer.borderColor = [[UIColor redColor]CGColor];
        _OTPTxt.layer.borderWidth = 1.0f;
        
    }else  if(!([self validateEmail:_OTPTxt.text])) {
        [self.emailTxt setValue:[UIColor redColor] forKeyPath:@"_placeholderLabel.textColor"];
        _OTPTxt.placeholder=[[GlobalFunction sharedInstance].arrayOfAlerts objectAtIndex:128];
        //_emailErrorClose.hidden=NO;
        //UIImage *image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"error_close" ofType:@"png"]];
        //_emailIcon.image = image;
        _OTPTxt.text=@"";
        _OTPTxt.layer.borderColor = [[UIColor redColor]CGColor];
        _OTPTxt.layer.borderWidth = 1.0f;
        
    }
    
    if((![_emailTxt.text isEqualToString:@""])&&([self validateEmail:_emailTxt.text])){
        // NSLog(@"global.validateinside");
        
        NSLog(@"globalOTP %@",_OTPTxt.text);
        [self.view addSubview:_OTPview];
        // Added By:Nalina
        // Added Date:03/08/16
        // Description: forgot username service call functionality
        
        NSString *OTPUrl=[appdelegates.serviceURL stringByAppendingString:@"api/Account/VerifyOTP"];
        NSMutableDictionary *forgototpData = [[NSMutableDictionary alloc] init];
        [forgototpData setObject:_OTPTxt.text forKey:@"otpCode"];
        [forgototpData setObject:_secondLabelText forKey:@"userName"];
        [forgototpData setObject:_emailLabelText forKey:@"email"];
        if (internetCheck) {
            [self startLoadingIndicator];
        }
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
                                                [self dismissViewControllerAnimated:YES completion:nil];
                                            }];
                 [_alert addAction:okButton];
                 [self presentViewController:_alert animated:YES completion:nil];
                 
                 
             }else if(statusCode == 404){
                 _alert = [UIAlertController
                           alertControllerWithTitle:@""
                           message:[[GlobalFunction sharedInstance].arrayOfAlerts objectAtIndex:65]
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
             else {
                 
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
                                                [self stopLoadingIndicator];
                                            }];
                 [_alert addAction:okButton];
                 [self presentViewController:_alert animated:YES completion:nil];
                 
                 
             }
             
         }];
        
    }
}
@end
