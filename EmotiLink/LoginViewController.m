/***************************************************************
 Page name:LoginViewController.m
 Created By:Nalina
 Created Date:29/6/16
 Description:Login view to login to the emotilink application implementation file
 ***************************************************************/


#import "LoginViewController.h"
#import "GlobalFunction.h"
#import "ForgotPasswordViewController.h"
#import "UserDashboardViewController.h"
#import "ChangePasswordViewController.h"
#import "ProviderDashboard.h"
#import "AppDelegate.h"
#import "OTPViewController.h"
#import "ProviderSignUpFirstViewController.h"
#import <Google/Analytics.h>

#import <WindowsAzureMessaging/WindowsAzureMessaging.h>
#import "HubInfo.h"


@interface LoginViewController ()

@end

@implementation LoginViewController
@synthesize questionArray;
@synthesize questionId;

- (void)viewDidLoad {
    
    /*questionArray = [[NSMutableArray alloc] init];
     questionId= [[NSMutableArray alloc] init];
     userQutArray = [[NSMutableArray alloc] init];
     userQutIdArray= [[NSMutableArray alloc] init];*/
    UIImage *backgroundImage = [UIImage imageNamed:@"LoginBackground.png"];
    UIImageView *backgroundImageView=[[UIImageView alloc]initWithFrame:self.view.frame];
    backgroundImageView.image=backgroundImage;
    [self.view insertSubview:backgroundImageView atIndex:0];
    [super viewDidLoad];
    [self stopLoadingIndicator];
    _userNameTxt.delegate = self;
    _passwordTxt.delegate = self;
    
    _eyeIconBtn.hidden = YES;
    
    // On change and touch events call for text fields
    [self.userNameTxt addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventAllTouchEvents];
    
    [self.passwordTxt addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventAllTouchEvents];
    
    [self.userNameTxt addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    
    [self.passwordTxt addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    
    
    // Added By:Nalina
    // Added Date:01/08/16
    // Description:To get Security questions list service call
    
    /* AppDelegate *appdelegate= (AppDelegate *)[[UIApplication sharedApplication]delegate];
     NSString *securityQuestionUrl=[appdelegate.serviceURL stringByAppendingString:@"api/SecurityQuestions"];
     
     [[GlobalFunction sharedInstance] getServerResponseForUrl:securityQuestionUrl method:@"GET" param:nil withCallback:^(NSInteger statusCode, NSDictionary *response, NSError *error)
     {
     NSDictionary *actualData;
     
     if (statusCode==200) {
     
     NSMutableArray *responseArray = [[NSMutableArray alloc] initWithObjects:response, nil];
     NSMutableArray *sortedArray =[responseArray objectAtIndex:0];
     @autoreleasepool {
     
     for(int i=0;i<sortedArray.count;i++) {
     actualData=[sortedArray objectAtIndex:i];
     NSString *que=[actualData objectForKey:@"question"];
     NSString *id=[actualData objectForKey:@"id"];
     
     [questionArray addObject:que];
     [questionId addObject:id];
     }
     }
     appdelegate.questionArray=questionArray;
     appdelegate.questionIdArray=questionId;
     
     }else{
     if (statusCode==404||statusCode==403||statusCode==503||statusCode==401) {
     [self stopLoadingIndicator];
     }else{
     NSDictionary *messagearray=[response objectForKey:@ "modelState"];
     NSArray *dictValues=[messagearray allValues];
     NSArray *message=[dictValues objectAtIndex:0];
     
     
     _alert = [UIAlertController
     alertControllerWithTitle:@""
     message:[message objectAtIndex:0]
     preferredStyle:UIAlertControllerStyleAlert];
     
     UIAlertAction* okbutton = [UIAlertAction
     actionWithTitle:@"OK"
     style:UIAlertActionStyleDefault
     handler:^(UIAlertAction * action) {
     [self stopLoadingIndicator];
     }];
     
     [_alert addAction:okbutton];
     [self presentViewController:_alert animated:YES completion: nil];
     }
     }
     }];
     //Added bY:ZEENATH
     //Added for:clear the prepopulated data
     //Added on:17-08-16
     
     [appdelegate.usersDetails removeAllObjects];
     appdelegate.usersDetails=nil;
     
     [appdelegate.availabilityArray removeAllObjects];
     appdelegate.availabilityArray=nil;
     
     [appdelegate.availabilityId removeAllObjects];
     appdelegate.availabilityId=nil;
     
     [appdelegate.prepopulateData removeAllObjects];
     appdelegate.prepopulateData=nil;
     
     [appdelegate.prepopulateDataProviderReg removeAllObjects];
     appdelegate.prepopulateDataProviderReg=nil;
     
     [appdelegate.prepopulateDataProvider removeAllObjects];
     appdelegate.prepopulateDataProvider=nil;
     
     [appdelegate.prepopulateDataProviderAboutYourself removeAllObjects];
     appdelegate.prepopulateDataProviderAboutYourself=nil;
     
     appdelegate.availableData=nil;
     appdelegate.prepopulateImage=nil;
     */
}


- (BOOL)textFieldShouldReturn:(UITextField *)theTextField {
    if (theTextField == self.userNameTxt) {
        [self.passwordTxt becomeFirstResponder];
    }
    if (theTextField == self.passwordTxt) {
        [theTextField resignFirstResponder];
    }
    
    return YES;
}

// Added By:Nalina
// Added Date:29/06/16
// Description: Set border to the input field

-(void)setBorder:(UIView *)img
{
    
    img.layer.borderColor = [[UIColor colorWithRed:228.0/255.0 green:109.0/255.0 blue:175.0/255.0 alpha:1.0]CGColor];
    img.layer.borderWidth = 1.0f;
    
}

// Added By:Nalina
// Added Date:29/06/16
// Description: Set border to the input field

-(void)setErrorBorder:(UIView *)img
{
    img.layer.borderColor = [[UIColor redColor]CGColor];
    img.layer.borderWidth = 1.0f;
}


-(void)viewWillAppear:(BOOL)animated{
    [self stopLoadingIndicator];
    [self setBorder:_usenameView];
    [self setBorder:_passwordView];
    _userNameTxt.text=@"";
    _passwordTxt.text=@"";
    
    
    // Added bY:ZEENATH
    // Added for:clear the prepopulated data
    // Added on:17-08-16
    
    AppDelegate *appdelegate= (AppDelegate *)[[UIApplication sharedApplication]delegate];
    [appdelegate.usersDetails removeAllObjects];
    appdelegate.usersDetails=nil;
    id<GAITracker> tracker = [[GAI sharedInstance] defaultTracker];
    [tracker set:kGAIScreenName value:@"Login"];
    [tracker send:[[GAIDictionaryBuilder createScreenView] build]];
    
    [appdelegate.availabilityArray removeAllObjects];
    appdelegate.availabilityArray=nil;
    
    [appdelegate.availabilityId removeAllObjects];
    appdelegate.availabilityId=nil;
    
    [appdelegate.prepopulateData removeAllObjects];
    appdelegate.prepopulateData=nil;
    
    [appdelegate.prepopulateDataProviderReg removeAllObjects];
    appdelegate.prepopulateDataProviderReg=nil;
    
    [appdelegate.prepopulateDataProvider removeAllObjects];
    appdelegate.prepopulateDataProvider=nil;
    
    [appdelegate.prepopulateDataProviderAboutYourself removeAllObjects];
    appdelegate.prepopulateDataProviderAboutYourself=nil;
    
    appdelegate.availableData=nil;
    appdelegate.prepopulateImage=nil;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


// Added By:Nalina
// Added Date:29/07/16
// Description:Login service call functionality

- (void)CallLoginService:(NSString *)url loginParam:(NSString *)loginparams method:(NSString *)methods
{
    
    NSURLSessionConfiguration *defaultConfigObject = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *defaultSession = [NSURLSession sessionWithConfiguration: defaultConfigObject delegate:self delegateQueue: [NSOperationQueue mainQueue]];
    
    
    
    NSMutableURLRequest * loginurl = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]];
    loginurl.timeoutInterval = 500.0;
    [loginurl setHTTPMethod:methods];
    [loginurl setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [loginurl setValue:@"application/json;charset=UTF-8" forHTTPHeaderField:@"Cookie"];
    
    [loginurl setHTTPBody:[loginparams dataUsingEncoding:NSUTF8StringEncoding ]];
    
    NSURLSessionDataTask * dataTaskBrief =[defaultSession dataTaskWithRequest:loginurl
                                                            completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                                                
                                                                if(error == nil)
                                                                {
                                                                    
                                                                    
                                                                    NSDictionary *array = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&error];
                                                                    NSLog(@"jsonarray %@ \n", array);
                                                                    
                                                                    NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *) response;
                                                                    
                                                                    NSLog(@"Status code = %ld",(long)httpResponse.statusCode);
                                                                    
                                                                    [self LoginCallBack:array StatusCode:httpResponse.statusCode];
                                                                    
                                                                    
                                                                }else{
                                                                    NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *) response;
                                                                    
                                                                    NSLog(@"Error Status code = %ld",(long)httpResponse.statusCode);
                                                                }}];
    
    [dataTaskBrief resume];
    [defaultSession finishTasksAndInvalidate];
}

- (IBAction)callBack:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

// Added By:Nalina
// Added Date:29/07/16
// Description: validation on click of login button

- (IBAction)loginClick:(id)sender {
    
    [_userNameTxt resignFirstResponder];
    [_passwordTxt resignFirstResponder];
    
    //  GlobalFunction *globalValues=[[GlobalFunction alloc]init];
    AppDelegate *appdelegate= (AppDelegate *)[[UIApplication sharedApplication]delegate];
    
    BOOL internetCheck= [appdelegate testInternetConnection];
    
    if (internetCheck) {
        
    }else{
        [appdelegate displayNetworkAlert];
        [self presentViewController:appdelegate.alert animated:YES completion:nil];
        return;
    }
    
    if([_userNameTxt.text isEqualToString:@""]){
        [self.userNameTxt setValue:[UIColor redColor] forKeyPath:@"_placeholderLabel.textColor"];
        _userNameTxt.placeholder=[[GlobalFunction sharedInstance].arrayOfAlerts objectAtIndex:0];
        _userCloseBtn.hidden=NO;
        UIImage *image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"error-user" ofType:@"png"]];
        _userIcon.image = image;
        [self setErrorBorder:_usenameView];
    }else if(!([self validateNameField:_userNameTxt.text])) {
        _userNameTxt.text=@"";
        [self.userNameTxt setValue:[UIColor redColor] forKeyPath:@"_placeholderLabel.textColor"];
        _userNameTxt.placeholder=[[GlobalFunction sharedInstance].arrayOfAlerts objectAtIndex:30];
        _userCloseBtn.hidden=NO;
        UIImage *image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"error-user" ofType:@"png"]];
        _userIcon.image = image;
        [self setErrorBorder:_usenameView];
    }
    
    if([_passwordTxt.text isEqualToString:@""]){
        [self.passwordTxt setValue:[UIColor redColor] forKeyPath:@"_placeholderLabel.textColor"];
        _passwordTxt.placeholder=[[GlobalFunction sharedInstance].arrayOfAlerts objectAtIndex:1];
        _passwordCloseBtn.hidden=NO;
        UIImage *image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"error-password" ofType:@"png"]];
        _passwordIcon.image = image;
        [self setErrorBorder:_passwordView];
        _infoIcon.hidden=YES;
    }else  if(!([self validatePassword:_passwordTxt.text])) {
        [self.passwordTxt setValue:[UIColor redColor] forKeyPath:@"_placeholderLabel.textColor"];
        _passwordTxt.placeholder=[[GlobalFunction sharedInstance].arrayOfAlerts objectAtIndex:7];
        _infoIcon.hidden=YES;
        _passwordTxt.text=@"";
        UIImage *image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"error-password" ofType:@"png"]];
        _passwordIcon.image = image;
        _passwordCloseBtn.hidden=NO;
        [self setErrorBorder:_passwordView];
    }
    
    if(!([_userNameTxt.text isEqualToString:@""]) && ([self validateNameField:_userNameTxt.text]) &&  ![_passwordTxt.text isEqualToString:@""] && ([self validatePassword:_passwordTxt.text]))
    {
        if (internetCheck){
            // NSLog(@"global.userDetails %d");
            [self startLoadingIndicator];
        }
        NSString *loginServiceURL=[appdelegate.serviceURL stringByAppendingString:@"Token"];
        NSString *grantType= @"grant_type=password&";
        NSString *loginDetails=[grantType stringByAppendingFormat:@"username=%@&password=%@",[_userNameTxt.text stringByTrimmingCharactersInSet:
                                                                                              [NSCharacterSet whitespaceCharacterSet]],[_passwordTxt.text stringByTrimmingCharactersInSet:
                                                                                                                                        [NSCharacterSet whitespaceCharacterSet]]];
        [self CallLoginService:loginServiceURL loginParam:loginDetails method:@"POST"];
        //NSLog(@"global.logincredentials %@",loginDetails);
        
    }
    
    
}



// Added By:Nalina
// Added Date:03/08/16
//Description:Get Barer token and callback response functionality

-(void)LoginCallBack:(NSDictionary *)responseData StatusCode:(NSInteger)statusCode
{
    AppDelegate *appdelegate= (AppDelegate *)[[UIApplication sharedApplication]delegate];
    // NSLog(@"global.userDetails %d",statusCode);
    
    if (statusCode==200) {
        Data=200;
        appdelegate.accessToken=[responseData objectForKey:@"access_token"];
        
        SBNotificationHub* hub = [[SBNotificationHub alloc] initWithConnectionString:HUBLISTENACCESS
                                                                 notificationHubPath:HUBNAME];
        NSSet *set = [NSSet setWithObjects:_userNameTxt.text, nil];
        
        [hub registerNativeWithDeviceToken:appdelegate.deviceToken tags:set completion:^(NSError* error) {
            if (error != nil) {
            }
            else {
            }
        }];
        
        /************** Call User service to get the details of user ******************/
        AppDelegate *appdelegate= (AppDelegate *)[[UIApplication sharedApplication]delegate];
        NSString *getUserInfoUrl=[appdelegate.serviceURL stringByAppendingString:@"api/User"];
        
        [[GlobalFunction sharedInstance] getServerResponseAfterLogin:getUserInfoUrl method:@"GET" param:nil withCallback:^(NSInteger statusCode, NSDictionary *response, NSError *error)
         {
             
             AppDelegate *appdelegate=(AppDelegate *)[[UIApplication sharedApplication]delegate];
             NSString *message;
             
             NSMutableDictionary *dict=[[NSMutableDictionary alloc]init];
             
             if (statusCode == 200)
             {
                 //[self stopLoadingIndicator];
                 [dict setObject:[response objectForKey:@"userName"] forKey:@"userName"];
                 [dict setObject:[response objectForKey:@"displayName"] forKey:@"displayName"];
                 [dict setObject:[response objectForKey:@"firstName"] forKey:@"firstName"];
                 [dict setObject:[response objectForKey:@"email"] forKey:@"email"];
                 [dict setObject:[response objectForKey:@"lastName"] forKey:@"lastName"];
                 [dict setObject:[response objectForKey:@"dob"] forKey:@"dob"];
                 [dict setObject:[response objectForKey:@"profilePicPath"] forKey:@"profilePicPath"];
                 [dict setObject:[response objectForKey:@"isFirstTime"] forKey:@"isFirstTime"];
                 [dict setObject:[response objectForKey:@"userRole"] forKey:@"userRole"];
                 [dict setObject:[response objectForKey:@"isPasswordExpired"] forKey:@"isPasswordExpired"];
                 [dict setObject:[response objectForKey:@"nextScheduledAppointment"] forKey:@"nextScheduledAppointment"];
                 [dict setObject:[response objectForKey:@"providerStatus"] forKey:@"providerStatus"];
                 [dict setObject:[response objectForKey:@"userStatus"] forKey:@"userStatus"];
                 NSLog(@"global.userDetails %@",dict);
                 appdelegate.usersDetails=dict;
                 NSLog(@"global.userDetailsmain %@",appdelegate.usersDetails);
                 //[[appdelegate usersDetails]valueForKey:@"displayName"]
                 
                 
                 /*AppDelegate *appdelegate=(AppDelegate *)[[UIApplication sharedApplication]delegate];
                  NSString *validateUsernameUrl=[appdelegate.serviceURL stringByAppendingString:@"api/Account/SendOTP"];
                  NSMutableDictionary *UsernameData = [[NSMutableDictionary alloc] init];
                  [UsernameData setObject:_userNameTxt.text forKey:@"userName"];
                  NSLog(@"global.usertext %@",_userNameTxt.text);
                  NSLog(@"global.userDetailsOTP %@",UsernameData);
                  
                  [[GlobalFunction sharedInstance] getServerResponseAfterLogin:validateUsernameUrl method:@"POST" param:UsernameData withCallback:^(NSInteger statusCode, NSDictionary *response, NSError *error)
                  {
                  
                  if (statusCode == 200)
                  {
                  NSLog(@"globalresponse %@",response);
                  
                  OTPViewController *OTPViewController=[self.storyboard instantiateViewControllerWithIdentifier:@"OTPViewController"];
                  OTPViewController.secondLabelText=_userNameTxt.text;
                  OTPViewController.emailLabelText=[response objectForKey:@"email"];
                  
                  //OTPViewController.view.backgroundColor = [UIColor clearColor];
                  
                  self.modalPresentationStyle = UIModalPresentationFullScreen;
                  
                  OTPViewController.modalPresentationStyle = UIModalPresentationOverCurrentContext;
                  
                  [self presentViewController:OTPViewController animated:YES completion:nil];
                  
                  
                  }
                  else {
                  NSString *message;
                  
                  if (statusCode == 404){
                  
                  message=[[GlobalFunction sharedInstance].arrayOfAlerts objectAtIndex:68];
                  
                  }else if(statusCode==403||statusCode==503){
                  
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
                  
                  }];*/
                 
                 // GlobalFunction *globalValues=[[GlobalFunction alloc]init];
                 
                 if ([[response objectForKey:@"isPasswordExpired"]isEqual:[NSNumber numberWithInt:1]]) {
                     _alert = [UIAlertController
                               alertControllerWithTitle:@""
                               message:[[GlobalFunction sharedInstance].arrayOfAlerts objectAtIndex:112]
                               preferredStyle:UIAlertControllerStyleAlert];
                     
                     UIAlertAction* okButton = [UIAlertAction
                                                actionWithTitle:@"OK"
                                                style:UIAlertActionStyleDefault
                                                handler:^(UIAlertAction * action) {
                                                    [self stopLoadingIndicator];
                                                    ChangePasswordViewController *changePwd=[self.storyboard instantiateViewControllerWithIdentifier:@"ChangePassword"];
                                                    changePwd.screenStatus=@"login";
                                                    [self presentViewController:changePwd animated:YES completion:nil];
                                                    
                                                }];
                     [_alert addAction:okButton];
                     [self presentViewController:_alert animated:YES completion: nil];
                     
                     
                 }else{
                     [self stopLoadingIndicator];
                     
                     if ([[response objectForKey:@"userRole"] isEqualToString:@"Provider"]) {
                         //Redirecting to provider Dashboard
                         UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"ProviderStoryboard" bundle:nil];
                         ProviderDashboard *viewcontrol=[storyboard instantiateViewControllerWithIdentifier:@"ProviderHomeDashboard"];
                         [self presentViewController:[storyboard instantiateViewControllerWithIdentifier:@"ProviderDashboard"] animated:NO completion:nil];
                     }else{
                         UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"UserStoryboard" bundle:nil];
                         UserDashboardViewController *viewcontrol=[storyboard instantiateViewControllerWithIdentifier:@"dashboardUsers"];
                         viewcontrol.providerDetails=response;
                         [self presentViewController:[storyboard instantiateViewControllerWithIdentifier:@"UserDashboard"] animated:NO completion:nil];
                     }
                 }
             }
             else {
                 //  GlobalFunction *globalValues=[[GlobalFunction alloc]init];
                 
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
                 [self presentViewController:_alert animated:YES completion: nil];
             }
             
         }];
        
    }else{
        //  GlobalFunction *globalValues=[[GlobalFunction alloc]init];
        NSString *message;
        
        if(statusCode == 403||statusCode == 503||statusCode==404)
        {
            message=[[GlobalFunction sharedInstance].arrayOfAlerts objectAtIndex:74];
            
        }else if(statusCode==401){
            
            message=[[GlobalFunction sharedInstance].arrayOfAlerts objectAtIndex:63];
            
        }else{
            
            message=[responseData objectForKey:@ "error_description"];
            
        }
        
        _alert = [UIAlertController
                  alertControllerWithTitle:@""
                  message:message
                  preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* okButton = [UIAlertAction
                                   actionWithTitle:@"OK"
                                   style:UIAlertActionStyleDefault
                                   handler:^(UIAlertAction * action) {
                                       //Handle your yes please button action here
                                       [self stopLoadingIndicator];
                                   }];
        [_alert addAction:okButton];
        [self presentViewController:_alert animated:YES completion:nil];
    }
}

// Added By:Nalina
// Added Date:29/07/16
// Description: validation pattren set in input field

- (BOOL)validateNameField:(NSString*)name
{
    NSString *nameRegex = @"(^[A-Za-z0-9 ]*$)";
    NSPredicate *nameTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", nameRegex];
    return [nameTest evaluateWithObject:name];
}

- (BOOL)validatePassword:(NSString*)password
{
    NSString *passwordRegex = @"^(?=.*[A-Z])(?=.*[0-9])(?=.*[$@$!%*#?&])[A-Za-z0-9$@$!%*#?&]{8,12}$";
    NSPredicate *passwordTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", passwordRegex];
    return [passwordTest evaluateWithObject:password];
}

-(void)textFieldDidChange :(UITextField *)theTextField
{
    [self ValidationSettings:theTextField];
    
    if([theTextField isEqual: _passwordTxt]){
        
        _infoIcon.hidden = YES;
        _eyeIconBtn.hidden = NO;
    }
  if([_passwordTxt.text isEqualToString:@""]){
        
        _infoIcon.hidden = NO;
        _eyeIconBtn.hidden = YES;
    }

 
}


- (void)textFieldDidBeginEditing:(UITextField *)textField {
    
    /*if([textField isEqual: _userNameTxt]){
        _infoIcon.hidden = NO;
        _eyeIconBtn.hidden = YES;
    } */
    
  
}



// Added By:Nalina
// Added Date:29/07/16
// Description: set validation design to the input fields

-(void)ValidationSettings:(UITextField *)theTextField{
    if([theTextField isEqual: _userNameTxt]){
        [self.userNameTxt setValue:[UIColor  colorWithRed:(112/255.0) green:(112/255.0) blue:(112/255.0) alpha:1] forKeyPath:@"_placeholderLabel.textColor"];
        _userNameTxt.placeholder=@"Username";
        _userCloseBtn.hidden=YES;
        UIImage *image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"user" ofType:@"png"]];
        _userIcon.image = image;
        [self setBorder:_usenameView];
    }else if([theTextField isEqual: _passwordTxt]){
        [self.passwordTxt setValue:[UIColor  colorWithRed:(112/255.0) green:(112/255.0) blue:(112/255.0) alpha:1] forKeyPath:@"_placeholderLabel.textColor"];
        _passwordTxt.placeholder=@"Password";
        _passwordCloseBtn.hidden=YES;
        _infoIcon.hidden=NO;
        UIImage *image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"password" ofType:@"png"]];
        _passwordIcon.image = image;
        [self setBorder:_passwordView];
    }
    
}


// Added By:Nalina
// Added Date:29/07/16
// Description: close the validation settings on click of error button

- (IBAction)userErrorCloseBtn:(id)sender {
    [self.userNameTxt setValue:[UIColor  colorWithRed:(112/255.0) green:(112/255.0) blue:(112/255.0) alpha:1] forKeyPath:@"_placeholderLabel.textColor"];
    _userNameTxt.placeholder=@"Username";
    [self setBorder:_usenameView];
    _userCloseBtn.hidden=YES;
    UIImage *image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"user" ofType:@"png"]];
    _userIcon.image = image;
}

- (IBAction)passwordErrorCloseBtn:(id)sender {
    [self.passwordTxt setValue:[UIColor  colorWithRed:(112/255.0) green:(112/255.0) blue:(112/255.0) alpha:1] forKeyPath:@"_placeholderLabel.textColor"];
    _passwordTxt.placeholder=@"Password";
    _passwordCloseBtn.hidden=YES;
    UIImage *image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"password" ofType:@"png"]];
    _passwordIcon.image = image;
    _infoIcon.hidden=NO;
    [self setBorder:_passwordView];
}


- (IBAction)forgotPasword:(id)sender {
    NSLog(@"global.userDetails");
    [_userNameTxt resignFirstResponder];
    [_passwordTxt resignFirstResponder];
    
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
    if([_userNameTxt.text isEqualToString:@""]){
        [self.userNameTxt setValue:[UIColor redColor] forKeyPath:@"_placeholderLabel.textColor"];
        _userNameTxt.placeholder=[[GlobalFunction sharedInstance].arrayOfAlerts objectAtIndex:0];
        _userCloseBtn.hidden=NO;
        UIImage *image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"error-user" ofType:@"png"]];
        _userIcon.image = image;
        [self setErrorBorder:_usenameView];
    }else if(!([self validateNameField:_userNameTxt.text])) {
        _userNameTxt.text=@"";
        [self.userNameTxt setValue:[UIColor redColor] forKeyPath:@"_placeholderLabel.textColor"];
        _userNameTxt.placeholder=[[GlobalFunction sharedInstance].arrayOfAlerts objectAtIndex:30];
        _userCloseBtn.hidden=NO;
        UIImage *image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"error-user" ofType:@"png"]];
        _userIcon.image = image;
        [self setErrorBorder:_usenameView];
    }
    
    if(!([_userNameTxt.text isEqualToString:@""]) && ([self validateNameField:_userNameTxt.text]))
    {
        
        /************** validate username service ******************/
        NSString *validateUsernameUrl=[appdelegate.serviceURL stringByAppendingString:@"api/Account/ValidateUserName"];
        NSMutableDictionary *UsernameData = [[NSMutableDictionary alloc] init];
        [UsernameData setObject:_userNameTxt.text forKey:@"userName"];
        if (internetCheck) {
            [self startLoadingIndicator];
        }
        [[GlobalFunction sharedInstance] getServerResponseForUrl:validateUsernameUrl method:@"POST" param:UsernameData withCallback:^(NSInteger statusCode, NSDictionary *response, NSError *error)
         {
             
             if (statusCode == 200)
             {
                 NSLog(@"global.userDetails %@",_emailText);
                 ForgotPasswordViewController *vc=[self.storyboard instantiateViewControllerWithIdentifier:@"ForgotPasswordViewController"];
                 
                 vc.secondLabelText=_userNameTxt.text;
                 // vc.emailLabelText = [response objectForKey:@"email"];
                 [self presentViewController:vc animated:YES completion:nil];
                 
                 // Added By:Nalina
                 // Added Date:18/08/16
                 //Description: Get security questions for respective users functionality
                 
                 /* AppDelegate *appdelegate= (AppDelegate *)[[UIApplication sharedApplication]delegate];
                  NSString *getUserInfoUrl=[appdelegate.serviceURL stringByAppendingString:@"api/User"];
                  [[GlobalFunction sharedInstance] getServerResponseForUrl:getUserInfoUrl method:@"GET" param:nil withCallback:^(NSInteger statusCode, NSDictionary *response, NSError *error){
                  if (statusCode == 200)
                  {
                  [self stopLoadingIndicator];
                  ForgotPasswordViewController *vc=[self.storyboard instantiateViewControllerWithIdentifier:@"ForgotPasswordViewController"];
                  
                  vc.secondLabelText=[response objectForKey:@"userName"];;
                  vc.emailLabelText = [response objectForKey:@"email"];;
                  [self presentViewController:vc animated:YES completion:nil];
                  
                  }else{
                  NSString *message;
                  
                  if(statusCode==403||statusCode==503||statusCode==404){
                  
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
                  }];*/
                 
             }
             else {
                 NSString *message;
                 
                 if (statusCode == 404){
                     
                     message=[[GlobalFunction sharedInstance].arrayOfAlerts objectAtIndex:68];
                     
                 }else if(statusCode==403||statusCode==503){
                     
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

//  Added by: Nalina
//  Added Date:30/6/16
//  Description: information icon to alert user about the password

- (IBAction)infoIconClick:(id)sender {
    
    // GlobalFunction *globalValues=[[GlobalFunction alloc]init];
    _infoIcon.hidden=NO;
    _alert = [UIAlertController
              alertControllerWithTitle:@""
              message:[[GlobalFunction sharedInstance].arrayOfAlerts objectAtIndex:9]
              preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* okButton = [UIAlertAction
                               actionWithTitle:@"OK"
                               style:UIAlertActionStyleDefault
                               handler:^(UIAlertAction * action) {
                                   //Handle your yes please button action here
                               }];
    [_alert addAction:okButton];
    [self presentViewController:_alert animated:YES completion:nil];
}


//  Added by: zeenath
//  Added Date: 05/07/16
//  Description: Redirect to the provider sign-up screen on click of provider button

- (IBAction)providerSignUpClick:(id)sender {
    [self performSegueWithIdentifier:@"providerSignUp" sender:nil ];
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


- (IBAction)eyeBtnTouchUp:(id)sender {
    _passwordTxt.secureTextEntry = YES;
}

- (IBAction)eyebtnTouchDown:(id)sender {
    _passwordTxt.secureTextEntry = NO;
}
@end
