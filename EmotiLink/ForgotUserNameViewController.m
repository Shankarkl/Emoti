/***************************************************************
 Page name:ForgotUserNameViewController.m
 Created By:Nalina
 Created Date:30/6/16
 Description:Forgot user name implementation file
 ***************************************************************/


#import "ForgotUserNameViewController.h"
#import "GlobalFunction.h"
#import "OTPViewController.h"
#import "AppDelegate.h"
#import <QuartzCore/QuartzCore.h>

@interface ForgotUserNameViewController ()

@end

@implementation ForgotUserNameViewController

//Loads first time when page appears
- (void)viewDidLoad {
    [super viewDidLoad];
    _emailTxt.delegate = self;
    _phoneTxt.delegate =self;
    
    UIButton *subBtn = (UIButton *) [self.view viewWithTag:5];
    
    subBtn.layer.borderColor = [UIColor colorWithRed:246.0/255.0 green:108.0/255.0 blue:118.0/255.0 alpha:1].CGColor;
    
    //[subBtn.layer setBorderColor:[[UIColor colorWithRed:202.0/255.0 green:0 blue:11/255.0 alpha:1] CGColor]];
    
    //[subBtn.layer.borderColor:[[UIColor colorWithRed:202.0/255.0 green:0 blue:11/255.0 alpha:1] CGColor]];
    
    
    [self.emailTxt addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventAllTouchEvents];
    [self.emailTxt addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [self.phoneTxt addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventAllTouchEvents];
    [self.phoneTxt addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    UIImage *backgroundImage = [UIImage imageNamed:@"LoginBackground.png"];
    UIImageView *backgroundImageView=[[UIImageView alloc]initWithFrame:self.view.frame];
    backgroundImageView.image=backgroundImage;
    [self.view insertSubview:backgroundImageView atIndex:0];
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

//Loads each time when page appears
-(void)viewWillAppear:(BOOL)animated{
    
   /* _emailTxt.layer.borderColor = [[UIColor blackColor]CGColor];
     _emailTxt.layer.borderWidth = 1.0f;
     _phoneTxt.layer.borderColor = [[UIColor blackColor]CGColor];
     _phoneTxt.layer.borderWidth = 1.0f;*/
}

//  Added by: nalina
//  Added Date:30/06/16
//  Description: Remove validation on change of text field

-(void)textFieldDidChange :(UITextField *)theTextField
{
    if([theTextField isEqual: _emailTxt]){
        [self.emailTxt setValue:[UIColor  colorWithRed:(112/255.0) green:(112/255.0) blue:(112/255.0) alpha:1] forKeyPath:@"_placeholderLabel.textColor"];
        _emailTxt.placeholder=@" Email";
       // _emailTxt.layer.borderColor = [[UIColor blackColor]CGColor];
       // _emailTxt.layer.borderWidth = 1.0f;
        _emailIcon.hidden=YES;
        _emailErrorClose.hidden=YES;
    }else{
        // UIImage *image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"email" ofType:@"png"]];
        //_emailIcon.image = image;
        // _emailTxt.layer.borderColor = [[UIColor colorWithRed:228.0/255.0 green:109.0/255.0 blue:175.0/255.0 alpha:1.0]CGColor];
        //_emailTxt.layer.borderWidth = 1.0f;
        [self.phoneTxt setValue:[UIColor  colorWithRed:(112/255.0) green:(112/255.0) blue:(112/255.0) alpha:1] forKeyPath:@"_placeholderLabel.textColor"];
       // _phoneTxt.placeholder=@"Phone number";
        _PhoneError.hidden=YES;
        _phoneErrorBtn.hidden = YES;
        //UIImage *imageone = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"email" ofType:@"png"]];
        //_PhoneError.image = imageone;
        // _phoneTxt.layer.borderColor = [[UIColor colorWithRed:228.0/255.0 green:109.0/255.0 blue:175.0/255.0 alpha:1.0]CGColor];
        //_phoneTxt.layer.borderWidth = 1.0f;
        
    }
    
    
}

//  Added by: nalina
//  Added Date:30/06/16
//  Description: Remove validation on click of error close button

- (IBAction)emailCloseBtn:(id)sender {
    [self.emailTxt setValue:[UIColor  colorWithRed:(112/255.0) green:(112/255.0) blue:(112/255.0) alpha:1] forKeyPath:@"_placeholderLabel.textColor"];
    // _emailTxt.placeholder=@"Email";
    _emailTxt.layer.borderColor = [[UIColor blackColor]CGColor];
    _emailTxt.layer.borderWidth = 1.0f;
    _emailIcon.hidden=YES;
    
    //UIImage *image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"email" ofType:@"png"]];
    //_emailIcon.image = image;
    //_emailTxt.layer.borderColor = [[UIColor colorWithRed:228.0/255.0 green:109.0/255.0 blue:175.0/255.0 alpha:1.0]CGColor];
    //_emailTxt.layer.borderWidth = 1.0f;
}


//  Added by: nalina
//  Added Date:30/06/16
//  Description: validation pattren of email text field

- (BOOL)validateEmail:(NSString*)email
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}
- (BOOL)validatePhone:(NSString*)phone
{
    NSString *phoneRegex = @"[0-9]{10}";
    NSPredicate *PhoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", phoneRegex];
    return [PhoneTest evaluateWithObject:phone];
}


//  Added by: nalina
//  Added Date:30/06/16
//  Description: validation and service call on click of submit button

- (IBAction)submitClick:(id)sender {
    
    // GlobalFunction *globalValues=[[GlobalFunction alloc]init];
    AppDelegate *appdelegate= (AppDelegate *)[[UIApplication sharedApplication]delegate];
    
    BOOL internetCheck= [appdelegate testInternetConnection];
    
    if (internetCheck) {
        
    }else{
        [appdelegate displayNetworkAlert];
        [self presentViewController:appdelegate.alert animated:YES completion:nil];
        return;
    }
    
    if([_emailTxt.text isEqualToString:@""]){
        [self.emailTxt setValue:[UIColor redColor] forKeyPath:@"_placeholderLabel.textColor"];
        _emailTxt.placeholder=[[GlobalFunction sharedInstance].arrayOfAlerts objectAtIndex:2];
        _emailErrorClose.hidden=NO;
        UIImage *image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"error_close" ofType:@"png"]];
        _emailErrorClose.image = image;
      //  _emailTxt.layer.borderColor = [[UIColor redColor]CGColor];
      //  _emailTxt.layer.borderWidth = 1.0f;
        
    }else  if(!([self validateEmail:_emailTxt.text])) {
        [self.emailTxt setValue:[UIColor redColor] forKeyPath:@"_placeholderLabel.textColor"];
        _emailTxt.placeholder=[[GlobalFunction sharedInstance].arrayOfAlerts objectAtIndex:6];
        _emailErrorClose.hidden=NO;
        UIImage *image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"error_close" ofType:@"png"]];
        _emailErrorClose.image = image;
        _emailTxt.text=@"";
      //  _emailTxt.layer.borderColor = [[UIColor redColor]CGColor];
      //  _emailTxt.layer.borderWidth = 1.0f;
        
    }
    
    if([_phoneTxt.text isEqualToString:@""]){
        [self.phoneTxt setValue:[UIColor redColor] forKeyPath:@"_placeholderLabel.textColor"];
        _phoneTxt.placeholder=[[GlobalFunction sharedInstance].arrayOfAlerts objectAtIndex:127];
        _phoneErrorBtn.hidden=NO;
        //UIImage *imageone = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"error_close" ofType:@"png"]];
        //_phoneErrorBtn.image = imageone;
       // _phoneTxt.layer.borderColor = [[UIColor redColor]CGColor];
      //  _phoneTxt.layer.borderWidth=1.0f;
        
        
        
    }else  if(!([self validatePhone:_phoneTxt.text])) {
        [self.phoneTxt setValue:[UIColor redColor] forKeyPath:@"_placeholderLabel.textColor"];
        _phoneTxt.placeholder=[[GlobalFunction sharedInstance].arrayOfAlerts objectAtIndex:128];
        _phoneErrorBtn.hidden=NO;
        //UIImage *image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"error_close" ofType:@"png"]];
        //_phoneErrorBtn.image = image;
        _phoneTxt.text=@"";
       // _phoneTxt.layer.borderColor = [[UIColor redColor]CGColor];
       // _phoneTxt.layer.borderWidth = 1.0f;
        
    }
    
    if((![_emailTxt.text isEqualToString:@""])&&([self validateEmail:_emailTxt.text]) && (![_phoneTxt.text isEqualToString:@""])){
        NSLog(@"global.userDetails ");
        
        _emailErrorClose.hidden=YES;
        
        // Added By:Nalina
        // Added Date:03/08/16
        // Description: forgot username service call functionality
        
        NSString *forgotUsernameUrl=[appdelegate.serviceURL stringByAppendingString:@"api/Account/ForgotUserName"];
        NSMutableDictionary *forgotUsernameData = [[NSMutableDictionary alloc] init];
        [forgotUsernameData setObject:_emailTxt.text forKey:@"email"];
        [forgotUsernameData setObject:_phoneTxt.text forKey:@"phoneNumber"];
        if (internetCheck) {
            [self startLoadingIndicator];
        }
        [[GlobalFunction sharedInstance] getServerResponseForUrl:forgotUsernameUrl method:@"POST" param:forgotUsernameData withCallback:^(NSInteger statusCode, NSDictionary *response, NSError *error)
         {
             
             // GlobalFunction *globalValues=[[GlobalFunction alloc]init];
             NSString *message;
             
             if (statusCode == 200)
             {
                  NSLog(@"globalresponse %@",response);
                 
                 UIStoryboard *storyboard = [UIStoryboard storyboardWithName:
                                             @"GeneralStoryboard" bundle:nil];
                 
                 OTPViewController *OTPViewController=[storyboard instantiateViewControllerWithIdentifier:@"OTPViewController"];
                 
                 OTPViewController.secondLabelText=_secondLabelText;
                 OTPViewController.emailLabelText=_emailTxt.text;
                 
                 self.modalPresentationStyle = UIModalPresentationFullScreen;
                   OTPViewController.modalPresentationStyle = UIModalPresentationOverCurrentContext;
                 
                 OTPViewController.modalPresentationStyle = UIModalPresentationOverCurrentContext;
                 
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

//Close the screen on click of cancel button
- (IBAction)cancelClick:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)PhoneErrorBtn:(id)sender {
    [self.phoneTxt setValue:[UIColor  colorWithRed:(112/255.0) green:(112/255.0) blue:(112/255.0) alpha:1] forKeyPath:@"_placeholderLabel.textColor"];
    _phoneTxt.placeholder=@" Phone number";
    _phoneErrorBtn.hidden=YES;
   // _phoneTxt.layer.borderColor = [[UIColor blackColor]CGColor];
   // _phoneTxt.layer.borderWidth = 1.0f;
    //UIImage *image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"email" ofType:@"png"]];
    //_PhoneError.image = image;
    //_phoneTxt.layer.borderColor = [[UIColor colorWithRed:228.0/255.0 green:109.0/255.0 blue:175.0/255.0 alpha:1.0]CGColor];
    //_phoneTxt.layer.borderWidth = 1.0f;
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

- (IBAction)backArrowClick:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
