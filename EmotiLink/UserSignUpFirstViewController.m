/***************************************************************
 Page name:UserSignUpFirstViewController.m
 Created By:Nalina
 Created Date:30/6/16
 Description:User sign-up implementation file
 ***************************************************************/


#import "UserSignUpFirstViewController.h"
#import "GlobalFunction.h"
#import "UploadProfilePicture.h"
#import "AppDelegate.h"
#import <Google/Analytics.h>
#import "ThanksViewController.h"
#import "PhotopopupViewController.h"

#import "ProviderSignUpThankYou.h"

@interface UserSignUpFirstViewController ()<PhotopopupViewControllerDelegate>
{
    UIImage *bindimage;
}

@end

@implementation UserSignUpFirstViewController

- (void)dataFromController:(UIImage *)data
{
    //bindimage = data;
    
    _profilePicImage.layer.cornerRadius = 10;
    _profilePicImage.layer.masksToBounds = YES;
    _profilePicImage.image = data;
    [self startLoadingIndicator];
    
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    // or @"yyyy-MM-dd hh:mm:ss a" if you prefer the time with AM/PM
    NSLog(@"%@",[dateFormatter stringFromDate:[NSDate date]]);
    NSString *s = [dateFormatter stringFromDate:[NSDate date]];
    NSCharacterSet *doNotWant = [NSCharacterSet characterSetWithCharactersInString:@"/:- "];
    s = [[s componentsSeparatedByCharactersInSet: doNotWant] componentsJoinedByString: @""];
    NSLog(@"%@", s);
    
    NSString *name=s;
    //NSString *name=[dateFormatter stringFromDate:[NSDate date]]; //[userDetails valueForKey:@"firstName"];
    
    AppDelegate *appDelegat=(AppDelegate *)[[UIApplication sharedApplication]delegate];
    [appDelegat uploadBlobToContainer:data name:name path:1 withCallback:^(NSString *response, NSError *error) {
        if (error == nil)
        {
            [self stopLoadingIndicator];
            imagePath=response;
            //[userDetails setObject:response forKey:@"profilePicPath"];
            
            //self.profileImage.image = image;
            
        }
        else
        {
            //imagePath=@"";
            [self stopLoadingIndicator];
            //[userDetails setObject:@"" forKey:@"profilePicPath"];
            
        }
        
        
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

//  Added by: Nalina
//  Added Date:30/6/16
//  Description: set border to the input fields

-(void)setBorder:(UIView *)view
{
    view.layer.borderColor = [[UIColor colorWithRed:228.0/255.0 green:109.0/255.0 blue:175.0/255.0 alpha:1.0]CGColor];
    view.layer.borderWidth = 1.0f;
}

//Loads each time when page appears
-(void)viewWillAppear:(BOOL)animated{
    /* [self setBorder:_firstnameTxt];
     [self setBorder:_displaynameTxt];
     [self setBorder:_phoneNumTxt];
     [self setBorder:_emailView];
     [self setBorder:_usernameView];
     [self setBorder:_passwordView];
     [self setBorder:_confirmPasswordView];*/
    
    id<GAITracker> tracker = [[GAI sharedInstance] defaultTracker];
    [tracker set:kGAIScreenName value:@"UserSignup"];
    [tracker send:[[GAIDictionaryBuilder createScreenView] build]];
    _confirmPasswordTxt.text=@"";
    _passwordTxt.text=@"";
    
}

-(void)viewDidAppear:(BOOL)animated{
    //AppDelegate *appdelegate= (AppDelegate *)[[UIApplication sharedApplication]delegate];
    //_profilePicImage.image=appdelegate.cropProfileImage;
    
    _termConditionCheck.frame = CGRectMake(39, 565, 30, 30);
    _iagreelbl.frame = CGRectMake(75, 570, 100, 18);
    _termAndCondlbl.frame = CGRectMake(152, 570, 160, 18);
    _signUpBtn.frame = CGRectMake(38, 615, _signUpBtn.frame.size.width, _signUpBtn.frame.size.height);
    _termconditionBtnLbl.frame = CGRectMake(152, 575, 160, 18);
}

/*-(void) bindImage{
 AppDelegate *appdelegate= (AppDelegate *)[[UIApplication sharedApplication]delegate];
 _profilePicImage.image=appdelegate.cropProfileImage;
 }*/

//Loads first time when page appears
- (void)viewDidLoad {
    _firstnameTxt.delegate = self;
    _displaynameTxt.delegate = self;
    _phoneNumTxt.delegate=self;
    _emailTxt.delegate = self;
    _userTxt.delegate = self;
    _passwordTxt.delegate = self;
    _confirmPasswordTxt.delegate = self;
    
    myBool=NO;
    _eyeBtn.hidden = YES;
    _eyeSecBtn.hidden = YES;
    boolTermsCond=NO;
    clickedbutton=@"uncheck";
    clickedcheckboxbutton =@"uncheck";
    imagePath=@"";
    _refferralcodeTxtField.hidden = YES;
    
    /*[self.passwordTxt addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventAllTouchEvents];
     [self.confirmPasswordTxt addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventAllTouchEvents];*/
    
    [self.firstnameTxt addTarget:self action:@selector(RemoveValidationOnTouch:) forControlEvents:UIControlEventAllTouchEvents];
    [self.firstnameTxt addTarget:self action:@selector(RemoveValidationOnTouch:) forControlEvents:UIControlEventEditingChanged];
    
    [self.phoneNumTxt addTarget:self action:@selector(RemoveValidationOnTouch:) forControlEvents:UIControlEventAllTouchEvents];
    [self.phoneNumTxt addTarget:self action:@selector(RemoveValidationOnTouch:) forControlEvents:UIControlEventEditingChanged];
    
    [self.displaynameTxt addTarget:self action:@selector(RemoveValidationOnTouch:) forControlEvents:UIControlEventAllTouchEvents];
    [self.displaynameTxt addTarget:self action:@selector(RemoveValidationOnTouch:) forControlEvents:UIControlEventEditingChanged];
    
    [self.emailTxt addTarget:self action:@selector(RemoveValidationOnTouch:) forControlEvents:UIControlEventAllTouchEvents];
    [self.emailTxt addTarget:self action:@selector(RemoveValidationOnTouch:) forControlEvents:UIControlEventEditingChanged];
    
    [self.userTxt addTarget:self action:@selector(RemoveValidationOnTouch:) forControlEvents:UIControlEventAllTouchEvents];
    [self.userTxt addTarget:self action:@selector(RemoveValidationOnTouch:) forControlEvents:UIControlEventEditingChanged];
    
    [self.passwordTxt addTarget:self action:@selector(RemoveValidationOnTouch:) forControlEvents:UIControlEventAllTouchEvents];
    [self.passwordTxt addTarget:self action:@selector(RemoveValidationOnTouch:) forControlEvents:UIControlEventEditingChanged];
    
    [self.confirmPasswordTxt addTarget:self action:@selector(RemoveValidationOnTouch:) forControlEvents:UIControlEventAllTouchEvents];
    [self.confirmPasswordTxt addTarget:self action:@selector(RemoveValidationOnTouch:) forControlEvents:UIControlEventEditingChanged];
    [super viewDidLoad];
    UIImageView *bgImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"LoginBackground.png"]];
    bgImageView.frame = self.view.bounds;
    bgImageView.contentMode = UIViewContentModeScaleAspectFill;
    bgImageView.clipsToBounds = YES;
    [_backgroundUserSignUpView addSubview:bgImageView];
    [_backgroundUserSignUpView sendSubviewToBack:bgImageView];
    
    
    UIToolbar* numberToolbar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 50)];
    numberToolbar.barStyle = UIBarStyleBlackTranslucent;
    numberToolbar.items = @[
                            [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],
                            [[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(doneWithNumberPad)],[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil]];
    [numberToolbar sizeToFit];
    _phoneNumTxt.inputAccessoryView = numberToolbar;
    
}




-(void)doneWithNumberPad{
    [_phoneNumTxt resignFirstResponder];
}



//  Added by: Nalina
//  Added Date:30/6/16
//  Description:validation pattrens for the input fields

- (BOOL)validateNameField:(NSString*)name
{
    NSString *nameRegex = @"^[a-zA-Z ]*$";
    NSPredicate *nameTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", nameRegex];
    return [nameTest evaluateWithObject:name];
}

- (BOOL)validatePhone:(NSString*)phone
{
    /*NSString *phoneRegex = @"^[0-9]{10}*$";
     NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", phoneRegex];
     return [phoneTest evaluateWithObject:phone];*/
    
    NSError *error = NULL;
    NSDataDetector *detector = [NSDataDetector dataDetectorWithTypes:NSTextCheckingTypePhoneNumber error:&error];
    NSArray *matches = [detector matchesInString:phone options:0 range:NSMakeRange(0, [phone length])];
    if (matches != nil) {
        for (NSTextCheckingResult *match in matches) {
            if ([match resultType] == NSTextCheckingTypePhoneNumber) {
                //Log(@"Found phone number %@", [match phoneNumber]);
                return true;
            }
        }
    }
    return false;
}

- (BOOL)validateEmail:(NSString*)email
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}

- (BOOL)validatePassword:(NSString*)password
{
    NSString *passwordRegex = @"^(?=.*[A-Z])(?=.*[0-9])(?=.*[$@$!%*#?&])[A-Za-z0-9$@$!%*#?&]{8,12}$";
    NSPredicate *passwordTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", passwordRegex];
    return [passwordTest evaluateWithObject:password];
}

- (BOOL)validateUsername:(NSString*)userName
{
    NSString *usernameRegExp =@"(^[A-Za-z0-9]*$)";
    NSPredicate *usernameTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", usernameRegExp];
    return [usernameTest evaluateWithObject:userName];
}

//  Added by: Nalina
//  Added Date:30/6/16
//  Description: validation design to the input fields

-(void)SetValidationSettinds:(UITextField *)textField errorIcon:(UIButton *)errorBtn indicationIcon:(UIImageView *)indicationIcon validationMessage:(NSString *)validationMessage imageIs:(NSString *)imageIs viewField:(UIView *)viewIs{
    
    [textField setValue:[UIColor redColor] forKeyPath:@"_placeholderLabel.textColor"];
    textField.placeholder=validationMessage;
    errorBtn.hidden=NO;
    UIImage *image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:imageIs ofType:@"png"]];
    indicationIcon.image = image;
    viewIs.layer.borderColor = [[UIColor redColor]CGColor];
    viewIs.layer.borderWidth = 1.0f;
    
}


//  Added by: Nalina
//  Added Date:30/6/16
//  Description: next button click and validation

- (IBAction)nextBtnClick:(id)sender {
    CGPoint pt;
    
    pt.x = 0;
    pt.y = 10;
    [_scrollView setContentOffset:pt animated:YES];
    // GlobalFunction *globalValues=[[GlobalFunction alloc]init];
    AppDelegate *appdelegate= (AppDelegate *)[[UIApplication sharedApplication]delegate];
    
    BOOL internetCheck= [appdelegate testInternetConnection];
    
    if (internetCheck) {
        
    }else{
        [appdelegate displayNetworkAlert];
        [self presentViewController:appdelegate.alert animated:YES completion:nil];
        return;
    }
    
    
    
    
    if([clickedcheckboxbutton isEqualToString:@"uncheck"])
    {
        // GlobalFunction *[GlobalFunction sharedInstance]=[[GlobalFunction alloc]init];
        
        _alert = [UIAlertController
                  alertControllerWithTitle:@""
                  message:[[GlobalFunction sharedInstance].arrayOfAlerts objectAtIndex:33]
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
    
    
    if([_firstnameTxt.text isEqualToString:@""]){
        
        [self SetValidationSettinds:_firstnameTxt errorIcon:_firstnameError indicationIcon:_firstnameIcon validationMessage:[[GlobalFunction sharedInstance].arrayOfAlerts objectAtIndex:3] imageIs:@"error-user" viewField:_firstnameView];
        
    }else if(!([self validateNameField:_firstnameTxt.text])) {
        
        _firstnameTxt.text=@"";
        [self SetValidationSettinds:_firstnameTxt errorIcon:_firstnameError indicationIcon:_firstnameIcon validationMessage:[[GlobalFunction sharedInstance].arrayOfAlerts objectAtIndex:28] imageIs:@"error-user" viewField:_firstnameView];
    }
    if([_displaynameTxt.text isEqualToString:@""]){
        
        [self SetValidationSettinds:_displaynameTxt errorIcon:_displaynameError indicationIcon:_lastnameIcon validationMessage:[[GlobalFunction sharedInstance].arrayOfAlerts objectAtIndex:129] imageIs:@"error-user" viewField:_lastnameView];
        
    }else if(!([self validateNameField:_displaynameTxt.text])) {
        
        _displaynameTxt.text=@"";
        [self SetValidationSettinds:_displaynameTxt errorIcon:_displaynameError indicationIcon:_lastnameIcon validationMessage:[[GlobalFunction sharedInstance].arrayOfAlerts objectAtIndex:130] imageIs:@"error-user" viewField:_lastnameView];
        
    }
    if([_phoneNumTxt.text isEqualToString:@""]){
        [self SetValidationSettinds:_phoneNumTxt errorIcon:_phoneNumError indicationIcon:_lastnameIcon validationMessage:[[GlobalFunction sharedInstance].arrayOfAlerts objectAtIndex:127] imageIs:@"error-user" viewField:_lastnameView];
        
    }else if(!([self validatePhone:_phoneNumTxt.text])) {
        
        _phoneNumTxt.text=@"";
        [self SetValidationSettinds:_phoneNumTxt errorIcon:_phoneNumError indicationIcon:_lastnameIcon validationMessage:[[GlobalFunction sharedInstance].arrayOfAlerts objectAtIndex:128] imageIs:@"error-user" viewField:_lastnameView];
        
    }
    
    
    if([_emailTxt.text isEqualToString:@""]){
        
        [self SetValidationSettinds:_emailTxt errorIcon:_emailError indicationIcon:_emailIcon validationMessage:[[GlobalFunction sharedInstance].arrayOfAlerts objectAtIndex:2] imageIs:@"error-email" viewField:_emailView];
        
    }else if(!([self validateEmail:_emailTxt.text])) {
        
        _emailTxt.text=@"";
        [self SetValidationSettinds:_emailTxt errorIcon:_emailError indicationIcon:_emailIcon validationMessage:[[GlobalFunction sharedInstance].arrayOfAlerts objectAtIndex:6] imageIs:@"error-email" viewField:_emailView];
        
    } if([_userTxt.text isEqualToString:@""]){
        
        [self SetValidationSettinds:_userTxt errorIcon:_userError indicationIcon:_userIcon validationMessage:[[GlobalFunction sharedInstance].arrayOfAlerts objectAtIndex:0] imageIs:@"error-user" viewField:_usernameView];
        
    }else if(!([self validateUsername:_userTxt.text])) {
        
        _userTxt.text=@"";
        [self SetValidationSettinds:_userTxt errorIcon:_userError indicationIcon:_userIcon validationMessage:[[GlobalFunction sharedInstance].arrayOfAlerts objectAtIndex:30] imageIs:@"error-user" viewField:_usernameView];
    }
    
    if([_passwordTxt.text isEqualToString:@""]){
        _infoIcon.hidden=YES;
        [self SetValidationSettinds:_passwordTxt errorIcon:_passwordError indicationIcon:_passwordIcon validationMessage:[[GlobalFunction sharedInstance].arrayOfAlerts objectAtIndex:1] imageIs:@"error-password" viewField:_passwordView];
        
    }else if(!([self validatePassword:_passwordTxt.text])) {
        _infoIcon.hidden=YES;
        _passwordTxt.text=@"";
        [self SetValidationSettinds:_passwordTxt errorIcon:_passwordError indicationIcon:_passwordIcon validationMessage:[[GlobalFunction sharedInstance].arrayOfAlerts objectAtIndex:7] imageIs:@"error-password" viewField:_passwordView];
        _eyeBtn.hidden = YES;
        
    } if([_confirmPasswordTxt.text isEqualToString:@""]){
        _confirmInfo.hidden=YES;
        [self SetValidationSettinds:_confirmPasswordTxt errorIcon:_confirmPasswordError indicationIcon:_confirmPasswordIcon validationMessage:[[GlobalFunction sharedInstance].arrayOfAlerts objectAtIndex:5] imageIs:@"error-password" viewField:_confirmPasswordView];
        _eyeBtn.hidden = YES;
        
    }else if(!([_confirmPasswordTxt.text isEqual:_passwordTxt.text])){
        _confirmInfo.hidden=YES;
        _confirmPasswordTxt.text=@"";
        [self SetValidationSettinds:_confirmPasswordTxt errorIcon:_confirmPasswordError indicationIcon:_confirmPasswordIcon validationMessage:[[GlobalFunction sharedInstance].arrayOfAlerts objectAtIndex:8] imageIs:@"error-password" viewField:_confirmPasswordView];
        
        _eyeSecBtn.hidden = YES;
        
        
    }
    
    if(!([_firstnameTxt.text isEqualToString:@""]) && !([clickedcheckboxbutton isEqualToString:@"uncheck"]) &&!([_displaynameTxt.text isEqualToString:@""])&&!([_phoneNumTxt.text isEqualToString:@""])&&([self validatePhone:_phoneNumTxt.text])&& !([_emailTxt.text isEqualToString:@""])&&([self validateEmail:_emailTxt.text])&& !([_userTxt.text     isEqualToString:@""])&& !([_passwordTxt.text isEqualToString:@""])&& ([self validatePassword:_passwordTxt.text])&& !([_confirmPasswordTxt.text isEqualToString:@""])&&([_confirmPasswordTxt.text isEqual:_passwordTxt.text])&&([self validateNameField:_firstnameTxt.text])&&([self validateNameField:_displaynameTxt.text])){
        
        //  Added by: Nalina
        //  Added Date:29/07/16
        //  Description: Check duplicate user and duplicate email service call
        [self startLoadingIndicator];
        NSString *duplicateemailUrl=[appdelegate.serviceURL stringByAppendingString:@"api/Account/CheckUser"];
        NSMutableDictionary *duplicateemailData = [[NSMutableDictionary alloc] init];
        [duplicateemailData setObject:[_emailTxt.text stringByTrimmingCharactersInSet:
                                       [NSCharacterSet whitespaceCharacterSet]] forKey:@"userNameOrEmail"];
        [duplicateemailData setObject:@"Email" forKey:@"checkType"];
        if (internetCheck) {
            
        }
        
        [[GlobalFunction sharedInstance] getServerResponseForUrl:duplicateemailUrl method:@"POST" param:duplicateemailData withCallback:^(NSInteger statusCode, NSDictionary *response, NSError *error)
         {
             NSString *message;
             
             if (statusCode == 200)
             {
                 
                 NSString *duplicateuserUrl=[appdelegate.serviceURL stringByAppendingString:@"api/Account/CheckUser"];
                 NSMutableDictionary *duplicateuserData = [[NSMutableDictionary alloc] init];
                 [duplicateuserData setObject:[_userTxt.text stringByTrimmingCharactersInSet:
                                               [NSCharacterSet whitespaceCharacterSet]] forKey:@"userNameOrEmail"];
                 [duplicateuserData setObject:@"UserName" forKey:@"checkType"];
                 
                 [[GlobalFunction sharedInstance] getServerResponseForUrl:duplicateuserUrl method:@"POST" param:duplicateuserData withCallback:^(NSInteger statusCode, NSDictionary *response, NSError *error)
                  {
                      NSString *message;
                      
                      if (statusCode == 200)
                      {
                          
                          NSMutableDictionary *detailsDict=detailsDict=[[NSMutableDictionary alloc]init];;
                          
                          [detailsDict setObject:[_firstnameTxt.text stringByTrimmingCharactersInSet:
                                                  [NSCharacterSet whitespaceCharacterSet]] forKey:@"firstName"];
                          [detailsDict setObject:[_displaynameTxt.text stringByTrimmingCharactersInSet:
                                                  [NSCharacterSet whitespaceCharacterSet]] forKey:@"displayName"];
                          [detailsDict setObject:[_phoneNumTxt.text stringByTrimmingCharactersInSet:
                                                  [NSCharacterSet whitespaceCharacterSet]] forKey:@"phoneNumber"];
                          
                          [detailsDict setObject:[_emailTxt.text stringByTrimmingCharactersInSet:
                                                  [NSCharacterSet whitespaceCharacterSet]] forKey:@"email"];
                          [detailsDict setObject:[_userTxt.text stringByTrimmingCharactersInSet:
                                                  [NSCharacterSet whitespaceCharacterSet]] forKey:@"userName"];
                          [detailsDict setObject:_passwordTxt.text forKey:@"password"];
                          [detailsDict setObject:@"" forKey:@"dob"];
                          
                          [detailsDict setObject:imagePath forKey:@"profilePicPath"];
                          [detailsDict setObject:_refferralcodeTxtField.text forKey:@"appSharedKey"];
                          
                          NSLog(@"detailsDict = %@",detailsDict);
                          
                          /*UploadProfilePicture *uploadPicture=[self.storyboard instantiateViewControllerWithIdentifier:@"uploadProfilePic"];
                           uploadPicture.screenStatus=@"userSignup";
                           uploadPicture.userDetails=detailsDict;
                           [self presentViewController:uploadPicture animated:YES completion:nil];
                           [self stopLoadingIndicator];*/
                          
                          NSString *userRegisterUrl=[appdelegate.serviceURL stringByAppendingString:@"api/Account/RegisterUser"];
                          
                          //[_providerDetails setObject:questionArray forKey:@"userSecurityQuestion"];
                          //[self startLoadingIndicator];
                          
                          [[GlobalFunction sharedInstance] getServerResponseForUrl:userRegisterUrl method:@"POST" param:detailsDict withCallback:^(NSInteger statusCode, NSDictionary *response, NSError *error)
                           {
                               
                               NSString *message;
                               
                               if (statusCode == 200)
                               {
                                   [self stopLoadingIndicator];
                                   /*ThanksViewController *vc=[self.storyboard instantiateViewControllerWithIdentifier:@"Thanks"];
                                    vc.screenStatus=@"userSignup";
                                    [self presentViewController:vc animated:YES completion:nil];*/
                                   [self stopLoadingIndicator];
                                   ProviderSignUpThankYou *vc=[self.storyboard instantiateViewControllerWithIdentifier:@"ProviderSignUpThankYou"];
                                   vc.screenStatus=@"userSignUp";
                                   vc.userNametoDisplay=_displaynameTxt.text;
                                   [self presentViewController:vc animated:YES completion:nil];
                                   
                                   
                               } else {
                                   [self stopLoadingIndicator];
                                   if(statusCode==403||statusCode==503||statusCode == 404){
                                       
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
                          
                          
                      } else {
                          [self stopLoadingIndicator];
                          if(statusCode==403||statusCode==503||statusCode == 404){
                              
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
                 
                 
             } else {
                 [self stopLoadingIndicator];
                 if(statusCode==403||statusCode==503||statusCode == 404){
                     
                     message=[[GlobalFunction sharedInstance].arrayOfAlerts objectAtIndex:74];
                     
                 }else if(statusCode==401){
                     
                     message=[[GlobalFunction sharedInstance].arrayOfAlerts objectAtIndex:63];
                     
                 }
                 
                 
                 else{
                     
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
    
    
}

//  Added by: Nalina
//  Added Date:30/6/16
//  Description: Remove validation on touch of input fields

-(void)RemoveValidationOnTouch:(UITextField *)theTextField{
    if([theTextField isEqual: _firstnameTxt]){
        
        [self RemoveValidationSettings:_firstnameTxt errorIcon:_firstnameError indicationIcon:_firstnameIcon HintText:@"First name" imageIs:@"user" viewField:_firstnameView];
        
    }else if([theTextField isEqual: _displaynameTxt]){
        
        [self RemoveValidationSettings:_displaynameTxt errorIcon:_lastnameError indicationIcon:_lastnameIcon HintText:@"Display name" imageIs:@"user" viewField:_lastnameView];
        
    }else if([theTextField isEqual: _phoneNumTxt]){
        
        [self RemoveValidationSettings:_phoneNumTxt errorIcon:_lastnameError indicationIcon:_lastnameIcon HintText:@"Phone number" imageIs:@"user" viewField:_lastnameView];
        
    }else if([theTextField isEqual: _emailTxt]){
        
        [self RemoveValidationSettings:_emailTxt errorIcon:_emailError indicationIcon:_emailIcon HintText:@"Email" imageIs:@"email" viewField:_emailView];
        
    }else if([theTextField isEqual: _userTxt]){
        
        [self RemoveValidationSettings:_userTxt errorIcon:_userError indicationIcon:_userIcon HintText:@"Username" imageIs:@"user" viewField:_usernameView];
        
    }else if([theTextField isEqual: _passwordTxt]){
        _infoIcon.hidden=NO;
        [self RemoveValidationSettings:_passwordTxt errorIcon:_passwordError indicationIcon:_passwordIcon HintText:@"Password" imageIs:@"password" viewField:_passwordView];
        
        
        if([theTextField isEqual: _passwordTxt]){
            
            _infoIcon.hidden = YES;
            _eyeBtn.hidden = NO;
        }
        if([_passwordTxt.text isEqualToString:@""]){
            
            _infoIcon.hidden = NO;
            _eyeBtn.hidden = YES;
        }
        
        
        
    }else if([theTextField isEqual: _confirmPasswordTxt]){
        
        [self RemoveValidationSettings:_confirmPasswordTxt errorIcon:_confirmPasswordError indicationIcon:_confirmPasswordIcon HintText:@"Confirm password" imageIs:@"password" viewField:_confirmPasswordView];
        //_confirmInfo.hidden = NO;
        // _eyeSecBtn.hidden = YES;
        if([theTextField isEqual: _confirmPasswordTxt]){
            
            _confirmInfo.hidden = YES;
            _eyeSecBtn.hidden = NO;
        }
        if([_confirmPasswordTxt.text isEqualToString:@""]){
            
            _confirmInfo.hidden = NO;
            _eyeSecBtn.hidden = YES;
        }
        
        
    }
}

//  Added by: Nalina
//  Added Date:30/6/16
//  Description: Remove validation design

-(void)RemoveValidationSettings:(UITextField *)textField errorIcon:(UIButton *)errorBtn indicationIcon:(UIImageView *)indicationIcon HintText:(NSString *)hintTextMessage imageIs:(NSString *)imageIs viewField:(UIView *)view{
    
    [textField setValue:[UIColor  colorWithRed:(112/255.0) green:(112/255.0) blue:(112/255.0) alpha:1] forKeyPath:@"_placeholderLabel.textColor"];
    textField.placeholder=hintTextMessage;
    errorBtn.hidden=YES;
    UIImage *image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:imageIs ofType:@"png"]];
    indicationIcon.image = image;
    [self setBorder:view];
    
}

//Close screen on click of cancel button
- (IBAction)cancelBtnClick:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}



//  Added by: Nalina
//  Added Date:30/6/16
//  Description: Close validation design on click of error button in input fields

- (IBAction)firstnameErrorClose:(id)sender {
    [self RemoveValidationSettings:_firstnameTxt errorIcon:_firstnameError indicationIcon:_firstnameIcon HintText:@"First name" imageIs:@"user" viewField:_firstnameView];
}
- (IBAction)displaynameErrorClose:(id)sender {
    [self RemoveValidationSettings:_displaynameTxt errorIcon:_displaynameError indicationIcon:_lastnameIcon HintText:@"Display Name" imageIs:@"user" viewField:_lastnameView];
}
- (IBAction)emailErrorClose:(id)sender {
    [self RemoveValidationSettings:_emailTxt errorIcon:_emailError indicationIcon:_emailIcon HintText:@"Email" imageIs:@"email" viewField:_emailView];
}
- (IBAction)userErrorClose:(id)sender {
    [self RemoveValidationSettings:_userTxt errorIcon:_userError indicationIcon:_userIcon HintText:@"Username" imageIs:@"user" viewField:_usernameView];
}
- (IBAction)passwordErrorClose:(id)sender {
    _infoIcon.hidden=NO;
    [self RemoveValidationSettings:_passwordTxt errorIcon:_passwordError indicationIcon:_passwordIcon HintText:@"Password" imageIs:@"password" viewField:_passwordView];
}
- (IBAction)confirmPasswordErrorClose:(id)sender {
    _confirmInfo.hidden=NO;
    [self RemoveValidationSettings:_confirmPasswordTxt errorIcon:_confirmPasswordError indicationIcon:_confirmPasswordIcon HintText:@"Confirm password" imageIs:@"password" viewField:_confirmPasswordView];
}


//  Added by: Nalina
//  Added Date:30/6/16
//  Description: information icon to alert user about the password

- (IBAction)infoIconClick:(id)sender {
    //   GlobalFunction *globalValues=[[GlobalFunction alloc]init];
    [self RemoveValidationSettings:_passwordTxt errorIcon:_passwordError indicationIcon:_passwordIcon HintText:@"Password" imageIs:@"password" viewField:_passwordView];
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

//Hides the soft keypad
- (BOOL)textFieldShouldReturn:(UITextField *)theTextField {
    if (theTextField == self.firstnameTxt) {
        [self.emailTxt becomeFirstResponder];
    }
    if (theTextField == self.emailTxt) {
        [self.phoneNumTxt becomeFirstResponder];
    }   if (theTextField == self.phoneNumTxt) {
        [self.userTxt becomeFirstResponder];
    }   if (theTextField == self.userTxt) {
        [self.displaynameTxt becomeFirstResponder];
    }   if (theTextField == self.displaynameTxt) {
        [self.passwordTxt becomeFirstResponder];
    }   if (theTextField == self.passwordTxt) {
        [self.confirmPasswordTxt becomeFirstResponder];
    }    if (theTextField == self.confirmPasswordTxt) {
        [theTextField resignFirstResponder];
    }
    
    return YES;
}


/*- (void)textFieldDidBeginEditing:(UITextField *)textField {
 svos = _scrollView.contentOffset;
 CGPoint pt;
 CGRect rc = [textField bounds];
 rc = [textField convertRect:rc toView:_scrollView];
 pt = rc.origin;
 pt.x = 0;
 pt.y -= -5;
 [_scrollView setContentOffset:pt animated:YES];
 }*/

//  Added by: Nalina
//  Added Date:23/08/2016
//  Description: To start loading indicator

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

//  Added by: Nalina
//  Added Date:23/08/2016
//  Description: To stop loading indicator

-(void)stopLoadingIndicator
{
    
    _loadingView.hidden=YES;
}

- (IBAction)phoneNumErrorClose:(id)sender {
    [self RemoveValidationSettings:_phoneNumTxt errorIcon:_phoneNumError indicationIcon:_emailIcon HintText:@"Phone number" imageIs:@"email" viewField:_emailView];
    
}
- (IBAction)usernameErrorClose:(id)sender {
    [self RemoveValidationSettings:_userTxt errorIcon:_emailError indicationIcon:_emailIcon HintText:@"Username" imageIs:@"user" viewField:_emailView];
}

- (IBAction)ConfirminfoClick:(id)sender {
    [self RemoveValidationSettings:_confirmPasswordTxt errorIcon:_passwordError indicationIcon:_passwordIcon HintText:@"Confirm Password" imageIs:@"password" viewField:_passwordView];
    _confirmInfo.hidden=NO;
    
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

- (IBAction)backClick:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

- (IBAction)imageClick:(id)sender {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:
                                @"GeneralStoryboard" bundle:nil];
    
    PhotopopupViewController *photopopup=[storyboard instantiateViewControllerWithIdentifier:@"photopopup"];
    
    photopopup.delegate=self;
    
    self.modalPresentationStyle = UIModalPresentationFullScreen;
    
    photopopup.modalPresentationStyle = UIModalPresentationOverCurrentContext;
    
    [self presentViewController:photopopup animated:NO completion:nil];
}

-(void)bindImage :(UIImage *)theimage viewcontrol:(UIViewController *)viewcontroller
{
    NSLog(@"IMAGEPATH%@",theimage);
    //[self viewDidAppear:YES];
    //_profilePicImage.image=theimage;
}



- (IBAction)eyeBtnTouchupClick:(id)sender {
    _passwordTxt.secureTextEntry = YES;
}
- (IBAction)eyeBtnTouchDownClick:(id)sender {
    _passwordTxt.secureTextEntry = NO;
}


- (IBAction)eyeSecBtnTouchUpClick:(id)sender {
    _confirmPasswordTxt.secureTextEntry = YES;
    
}

- (IBAction)eyeSecBtnTouchDownClick:(id)sender {
    _confirmPasswordTxt.secureTextEntry = NO;
    
}


//Added bY:ZEENATH
//Added on:11-07-16
//Description:To agree the terms and conditions
- (IBAction)termsAndConditionsBtnClick:(id)sender {
    // [_textView resignFirstResponder];
    
    if (boolTermsCond==NO) {
        
        [_termConditionCheck setImage:[UIImage imageNamed:@"check.png"] forState:UIControlStateNormal];
        boolTermsCond=YES;
        clickedcheckboxbutton=@"check";
        
    }
    else if(boolTermsCond==YES)
    {
        [_termConditionCheck setImage:[UIImage imageNamed:@"uncheck.png"] forState:UIControlStateNormal];
        boolTermsCond=NO;
        clickedcheckboxbutton=@"uncheck";
        
    }
    
}

- (IBAction)applyReferralCode:(id)sender {
    
    if (myBool==NO) {
        
        [_applyReferralCode setImage:[UIImage imageNamed:@"check.png"] forState:UIControlStateNormal];
        myBool=YES;
        clickedbutton=@"check";
        [_refferralcodeTxtField setHidden:NO];
        
        _termConditionCheck.frame = CGRectMake(39, 600, 30, 30);
        _iagreelbl.frame = CGRectMake(75, 605, 100, 18);
        _termAndCondlbl.frame = CGRectMake(152, 605, 160, 18);
        _signUpBtn.frame = CGRectMake(38, 640, _signUpBtn.frame.size.width, _signUpBtn.frame.size.height);
        _termconditionBtnLbl.frame  = CGRectMake(152, 605, 160, 18);
    }
    else if(myBool==YES)
    {
        [_applyReferralCode setImage:[UIImage imageNamed:@"uncheck.png"] forState:UIControlStateNormal];
        myBool=NO;
        clickedbutton=@"uncheck";
        [_refferralcodeTxtField setHidden:YES];
        
        _termConditionCheck.frame = CGRectMake(39, 565, 30, 30);
        _iagreelbl.frame = CGRectMake(75, 575, 100, 18);
        _termAndCondlbl.frame = CGRectMake(152, 575, 160, 18);
        _signUpBtn.frame = CGRectMake(38, 615,  _signUpBtn.frame.size.width, _signUpBtn.frame.size.height);
        _termconditionBtnLbl.frame = CGRectMake(152, 575, 160, 18);
    }
}




- (IBAction)termandconditionBtnClick:(id)sender {
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:
                                @"GeneralStoryboard" bundle:nil];
    
    [self presentViewController:[storyboard instantiateViewControllerWithIdentifier:@"TermsConditionViewController"] animated:NO completion:nil];
    
}
@end

