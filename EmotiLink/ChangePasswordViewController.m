/***************************************************************
 Page name:ChangePassword.m
 Created By:Nalina
 Created Date:29/6/16
 Description:Change password implementation file
 ***************************************************************/


#import "ChangePasswordViewController.h"
#import "GlobalFunction.h"
#import "AppDelegate.h"
#import "LoginViewController.h"

@interface ChangePasswordViewController ()

@end

@implementation ChangePasswordViewController


//Called when the view controller is first time loaded to memory
- (void)viewDidLoad {
    
    
    UIButton *cancelBtn = (UIButton *) [self.view viewWithTag:1];
    cancelBtn.layer.borderColor = [UIColor colorWithRed:246.0/255.0 green:108.0/255.0 blue:118.0/255.0 alpha:1].CGColor;

    
    
    // Do any additional setup after loading the view.
    
    if([_screenStatus isEqualToString:@""])
    {
        _oldPasswordView.hidden=YES;
    }
    
    _oldPasswordTxt.delegate = self;
    _passwordTxt.delegate = self;
    _confirmPasswordTxt.delegate = self;
    
    AppDelegate *appdelegate= (AppDelegate *)[[UIApplication sharedApplication]delegate];
    apptoken=appdelegate.accessToken;

     [super viewDidLoad];
    UIImage *backgroundImage = [UIImage imageNamed:@"LoginBackground.png"];
    UIImageView *backgroundImageView=[[UIImageView alloc]initWithFrame:self.view.frame];
    backgroundImageView.image=backgroundImage;
    [self.view insertSubview:backgroundImageView atIndex:0];
   /* bgImageView.frame = self.backgroundChangePswView.bounds;
    [_backgroundChangePswView addSubview:bgImageView];
    [_backgroundChangePswView sendSubviewToBack:bgImageView];*/
    
  //  UIImageView *bgImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"LoginBackground.png"]];
    
    
  /*  _oldPasswordTxt.attributedPlaceholder =
    [[NSAttributedString alloc] initWithString:@"Placeholder Text"
                                    attributes:@{
                                                 NSFontAttributeName : [UIFont fontWithName:@"Roboto-Bold" size:10.0]
                                                 }
     ]; */
    
    
}




 // Dispose of any resources that can be recreated.
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
   
}


//  Added by:Nalina
//  Added Date:2016-24-07.
//  Description:Function To focus the textfields and return the keyboard.
- (BOOL)textFieldShouldReturn:(UITextField *)theTextField {
    if (theTextField == self.oldPasswordTxt) {
        [self.passwordTxt becomeFirstResponder];
    }
    if (theTextField == self.passwordTxt) {
        [self.confirmPasswordTxt becomeFirstResponder];
    }
    if (theTextField == self.confirmPasswordTxt) {
        [theTextField resignFirstResponder];
    }
    
    svos = _scrollview.contentOffset;
    CGPoint pt;
    
    pt.x = 0;
    pt.y = 10;
    [_scrollview setContentOffset:pt animated:YES];
    
    [theTextField resignFirstResponder];
    return YES;
        
}

//  Added by:Nalina
//  Added Date:2016-24-07.
//  Description:Function To set the border for the views around the textfields.
-(void)setBorder:(UIView *)view
{
    view.layer.borderColor = [[UIColor colorWithRed:228.0/255.0 green:109.0/255.0 blue:175.0/255.0 alpha:1.0]CGColor];
    view.layer.borderWidth = 1.0f;
}


//called each time when the view appears
-(void)viewWillAppear:(BOOL)animated{
    
  
    [self setBorder:_passwordView];
    [self setBorder:_oldPasswordView];
    [self setBorder:_confirmPasswordView];
    
    
    [self.oldPasswordTxt addTarget:self action:@selector(RemoveValidationOnTouch:) forControlEvents:UIControlEventAllTouchEvents];
    [self.oldPasswordTxt addTarget:self action:@selector(RemoveValidationOnTouch:) forControlEvents:UIControlEventEditingChanged];
    
    [self.passwordTxt addTarget:self action:@selector(RemoveValidationOnTouch:) forControlEvents:UIControlEventAllTouchEvents];
    [self.passwordTxt addTarget:self action:@selector(RemoveValidationOnTouch:) forControlEvents:UIControlEventEditingChanged];
    
    [self.confirmPasswordTxt addTarget:self action:@selector(RemoveValidationOnTouch:) forControlEvents:UIControlEventAllTouchEvents];
    [self.confirmPasswordTxt addTarget:self action:@selector(RemoveValidationOnTouch:) forControlEvents:UIControlEventEditingChanged];
    [super viewDidLoad];
    
}


//  Added by:Nalina
//  Added Date:2016-24-07.
//  Description:Function To remove validation message for the the textfields on touch.
-(void)RemoveValidationOnTouch:(UITextField *)theTextField{
    if([theTextField isEqual: _oldPasswordTxt]){
        
        [self RemoveValidationSettings:_oldPasswordTxt errorIcon:_oldPasswordClose indicationIcon:_oldPasswordIcon HintText:@"Old password" imageIs:@"password" viewField:_oldPasswordView];
        _oldPasswordInfoIcon.hidden = NO;
        
    }else if([theTextField isEqual: _passwordTxt]){
        _infoBtn.hidden=NO;
        [self RemoveValidationSettings:_passwordTxt errorIcon:_passwordError indicationIcon:_passwordIcon HintText:@"Password" imageIs:@"password" viewField:_passwordView];
          _changePasswordInfoIcon.hidden = NO;
        
    }else if([theTextField isEqual: _confirmPasswordTxt]){
        
        [self RemoveValidationSettings:_confirmPasswordTxt errorIcon:_confirmPasswordError indicationIcon:_confirmPasswordIcon HintText:@"Confirm password" imageIs:@"password" viewField:_confirmPasswordView];
          _confirmPasswordInfoIcon.hidden = NO;
    }
    
}

//  Added by:Nalina
//  Added Date:2016-24-07.
//  Description:Function To remove validation message for the the textfields on begin typing.
-(void)RemoveValidationSettings:(UITextField *)textField errorIcon:(UIButton *)errorBtn indicationIcon:(UIImageView *)indicationIcon HintText:(NSString *)hintTextMessage imageIs:(NSString *)imageIs viewField:(UIView *)view{
    
    [textField setValue:[UIColor  colorWithRed:(112/255.0) green:(112/255.0) blue:(112/255.0) alpha:1] forKeyPath:@"_placeholderLabel.textColor"];
    textField.placeholder=hintTextMessage;
    errorBtn.hidden=YES;
    UIImage *image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:imageIs ofType:@"png"]];
    indicationIcon.image = image;
    [self setBorder:view];
    
}

//  Added by:Nalina
//  Added Date:2016-24-07.
//  Description:Function To remove validation message for the the textfields on click of close button.
- (IBAction)oldPasswordErrorClose:(id)sender {
    _oldPasswordInfoIcon.hidden=NO;
    [self RemoveValidationSettings:_oldPasswordTxt errorIcon:_oldPasswordClose indicationIcon:_oldPasswordIcon HintText:@"Old password" imageIs:@"password" viewField:_oldPasswordView];
}

- (IBAction)passwordErrorClose:(id)sender {
     _changePasswordInfoIcon.hidden=NO;
    [self RemoveValidationSettings:_passwordTxt errorIcon:_passwordError indicationIcon:_passwordIcon HintText:@"New password" imageIs:@"password" viewField:_passwordView];
}

//  Added by:Nalina
//  Added Date:2016-24-07.
//  Description:Function To show validation message for the the valid password.
- (IBAction)infoBtnClose:(id)sender {
   // GlobalFunction *globalValues=[[GlobalFunction alloc]init];
    [self RemoveValidationSettings:_passwordTxt errorIcon:_passwordError indicationIcon:_passwordIcon HintText:@"Password" imageIs:@"password" viewField:_passwordView];
    _infoBtn.hidden=NO;
    
    _alertView = [UIAlertController
              alertControllerWithTitle:@""
              message:[[GlobalFunction sharedInstance].arrayOfAlerts objectAtIndex:9]
              preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* okButton = [UIAlertAction
                               actionWithTitle:@"OK"
                               
                               style:UIAlertActionStyleDefault
                               handler:^(UIAlertAction * action) {
                                   //Handle your yes please button action here
                               }];
    [_alertView addAction:okButton];
    [self presentViewController:_alertView animated:YES completion:nil];
    
}

- (IBAction)confirmPasswordErrorClose:(id)sender {
    _confirmPasswordInfoIcon.hidden=NO;
    [self RemoveValidationSettings:_confirmPasswordTxt errorIcon:_confirmPasswordError indicationIcon:_confirmPasswordIcon HintText:@"Confirm password" imageIs:@"password" viewField:_confirmPasswordView];
}


//  Added by:Nalina
//  Added Date:2016-24-07.
//  Description:Function To show validation message for the the invalid fields.
-(void)SetValidationSettinds:(UITextField *)textField errorIcon:(UIButton *)errorBtn indicationIcon:(UIImageView *)indicationIcon validationMessage:(NSString *)validationMessage imageIs:(NSString *)imageIs viewField:(UIView *)viewIs{
    
    [textField setValue:[UIColor redColor] forKeyPath:@"_placeholderLabel.textColor"];
    textField.placeholder=validationMessage;
    errorBtn.hidden=NO;
    UIImage *image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:imageIs ofType:@"png"]];
    indicationIcon.image = image;
    viewIs.layer.borderColor = [[UIColor redColor]CGColor];
    viewIs.layer.borderWidth = 1.0f;
    
}


//  Added by:Nalina
//  Added Date:2016-24-07.
//  Description:Function To set the regular expression for the password.
- (BOOL)validatePassword:(NSString*)password
{
    NSString *passwordRegex = @"^(?=.*[A-Z])(?=.*[0-9])(?=.*[$@$!%*#?&])[A-Za-z0-9$@$!%*#?&]{8,12}$";
    NSPredicate *passwordTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", passwordRegex];
    return [passwordTest evaluateWithObject:password];
}


// Added By:Nalina
// Added Date:03/08/16
// Description:Change password service call


- (IBAction)submitClick:(id)sender {
    CGPoint pt;
    
    pt.x = 0;
    pt.y = 10;
    [_scrollview setContentOffset:pt animated:YES];
//    GlobalFunction *globalValues=[[GlobalFunction alloc]init];
    AppDelegate *appdelegate= (AppDelegate *)[[UIApplication sharedApplication]delegate];

    
    BOOL internetCheck= [appdelegate testInternetConnection];
    
    if (internetCheck==NO) {
        [appdelegate displayNetworkAlert];
        [self presentViewController:appdelegate.alert animated:YES completion:nil];
    }
    
    if([_oldPasswordTxt.text isEqualToString:@""]){
        
        _oldPasswordInfoIcon.hidden=YES;
        [self SetValidationSettinds:_oldPasswordTxt errorIcon:_oldPasswordClose indicationIcon:_oldPasswordIcon validationMessage:[[GlobalFunction sharedInstance].arrayOfAlerts objectAtIndex:10] imageIs:@"error-password" viewField:_oldPasswordView];
    }
    
    if([_passwordTxt.text isEqualToString:@""]){
        _changePasswordInfoIcon.hidden=YES;
        [self SetValidationSettinds:_passwordTxt errorIcon:_passwordError indicationIcon:_passwordIcon validationMessage:[[GlobalFunction sharedInstance].arrayOfAlerts objectAtIndex:1] imageIs:@"error-password" viewField:_passwordView];
        
    }else if(!([self validatePassword:_passwordTxt.text])) {
        
        _passwordTxt.text=@"";
        _changePasswordInfoIcon.hidden=YES;
        [self SetValidationSettinds:_passwordTxt errorIcon:_passwordError indicationIcon:_passwordIcon validationMessage:[[GlobalFunction sharedInstance].arrayOfAlerts objectAtIndex:7] imageIs:@"error-password" viewField:_passwordView];
        
    } if([_confirmPasswordTxt.text isEqualToString:@""]){
         _confirmPasswordInfoIcon.hidden=YES;
        
        [self SetValidationSettinds:_confirmPasswordTxt errorIcon:_confirmPasswordError indicationIcon:_confirmPasswordIcon validationMessage:[[GlobalFunction sharedInstance].arrayOfAlerts objectAtIndex:5] imageIs:@"error-password" viewField:_confirmPasswordView];
        
    }else if(!([_confirmPasswordTxt.text isEqual:_passwordTxt.text])){
         _confirmPasswordInfoIcon.hidden=YES;
        _confirmPasswordTxt.text=@"";
        [self SetValidationSettinds:_confirmPasswordTxt errorIcon:_confirmPasswordError indicationIcon:_confirmPasswordIcon validationMessage:[[GlobalFunction sharedInstance].arrayOfAlerts objectAtIndex:8] imageIs:@"error-password" viewField:_confirmPasswordView];
    }
    
    if((![_oldPasswordTxt.text isEqualToString:@""])&&(![_passwordTxt.text isEqualToString:@""])&&([self validatePassword:_passwordTxt.text])&&(![_confirmPasswordTxt.text isEqualToString:@""])&&([_confirmPasswordTxt.text isEqual:_passwordTxt.text])){
        
        /************** Call change password service ******************/
        NSString *changePasswordUrl=[appdelegate.serviceURL stringByAppendingString:@"api/Account/ChangePassword"];
        NSMutableDictionary *changePwdData = [[NSMutableDictionary alloc] init];
        [changePwdData setObject:_oldPasswordTxt.text forKey:@"currentPassword"];
        [changePwdData setObject:_passwordTxt.text forKey:@"newPassword"];
        [self startLoadingIndicator];
        [[GlobalFunction sharedInstance] getServerResponseAfterLogin:changePasswordUrl method:@"POST" param:changePwdData withCallback:^(NSInteger statusCode, NSDictionary *response, NSError *error)
         {
             
           //  GlobalFunction *globalValues=[[GlobalFunction alloc]init];
             NSString *message;
             
             if (statusCode == 200)
             {
                 message=[[GlobalFunction sharedInstance].arrayOfAlerts objectAtIndex:64];
                 
                 _alertView = [UIAlertController
                           alertControllerWithTitle:@""
                           message:message
                           preferredStyle:UIAlertControllerStyleAlert];
                 
                 UIAlertAction* okButton = [UIAlertAction
                                            actionWithTitle:@"OK"
                                            style:UIAlertActionStyleDefault
                                            handler:^(UIAlertAction * action) {
                                                [self stopLoadingIndicator];
                                               // if([_screenStatus isEqualToString:@"login"]){
                                                    [self dismissViewControllerAnimated:YES completion:nil];
                                                    
                                               /* }else{
                                                    [self.navigationController popViewControllerAnimated:YES];
                                                    
                                                }*/
                                            }];
                 [_alertView addAction:okButton];
                 UIViewController *top = [self topMostController];
                 [top presentViewController:_alertView animated:YES completion: nil];
                 
             }
             else {
                 
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

//  Added by:Nalina
//  Added Date:2016-24-07.
//  Description:Function To show alert messages.
- (UIViewController*) topMostController {
    UIViewController *topController = [UIApplication sharedApplication].keyWindow.rootViewController;
    
    while (topController.presentedViewController) {
        topController = topController.presentedViewController;
    }
    
    return topController;
}


//  Added by:Zeenath
//  Added Date:2016-24-08.
//  Description:Function To focus the textfield and scroll back when keyboard is returned.
- (void)textFieldDidBeginEditing:(UITextField *)textField {
    svos = _scrollview.contentOffset;
    CGPoint pt;
    CGRect rc = [textField bounds];
    rc = [textField convertRect:rc toView:_scrollview];
    pt = rc.origin;
    pt.x = 0;
    pt.y -= -5;
    [_scrollview setContentOffset:pt animated:YES];
}


//  Added by:Nalina
//  Added Date:2016-24-07.
//  Description:Function called when cancel button is clicked.
- (IBAction)cancelClick:(id)sender {
    
    /*if([_screenStatus isEqualToString:@"login"]){
        [self dismissViewControllerAnimated:YES completion:nil];
    }else{
        [self.navigationController popViewControllerAnimated:YES];

    }*/
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

-(void)stopLoadingIndicator
{
    
    _loadingView.hidden=YES;
}


/*- (IBAction)eyebtnoldpassword:(id)sender {
    
    _oldPasswordTxt.secureTextEntry = NO;
    NSLog(@"textvalue%@",_oldPasswordTxt);
}

- (IBAction)eyeBtnTouchDown:(id)sender {
    _oldPasswordTxt.secureTextEntry = YES;

} */

- (IBAction)backArrowClick:(id)sender {
     [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)oldPasswordTouch:(id)sender {
    _oldPasswordTxt.secureTextEntry = YES;
}

- (IBAction)oldPasswordTouchDown:(id)sender {
    _oldPasswordTxt.secureTextEntry = NO;
}

- (IBAction)newPasswordTouch:(id)sender {
     _passwordTxt.secureTextEntry = YES;
}

- (IBAction)newPasswordDowntouch:(id)sender {
      _passwordTxt.secureTextEntry = NO;
}


- (IBAction)confirmPasswordtouch:(id)sender {
    
    _confirmPasswordTxt.secureTextEntry = YES;
}

- (IBAction)confirmPasswordtouchdown:(id)sender {
    _confirmPasswordTxt.secureTextEntry = NO;
}

@end
