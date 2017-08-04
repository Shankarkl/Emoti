
/***************************************************************
 Page name: UserProfileViewController.m
 Created By:Nalina
 Created Date:04/07/16
 Description: user profile view implementation file
 ***************************************************************/

#import "UserProfileViewController.h"
#import "GlobalFunction.h"
#import "AppDelegate.h"
#import <Google/Analytics.h>
#import "PhotopopupViewController.h"
@interface UserProfileViewController ()<PhotopopupViewControllerDelegate>
{
    UIImage *bindimage;
}

@end

@implementation UserProfileViewController

- (void)dataFromController:(UIImage *)data
{
    //bindimage = data;
    [self startLoadingIndicator];
    
    _userProfilePicture.layer.cornerRadius = 10;
    _userProfilePicture.layer.masksToBounds = YES;
    _userProfilePicture.image = data;
    
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    // or @"yyyy-MM-dd hh:mm:ss a" if you prefer the time with AM/PM
    NSLog(@"%@",[dateFormatter stringFromDate:[NSDate date]]);
    NSString *s = [dateFormatter stringFromDate:[NSDate date]];
    NSCharacterSet *doNotWant = [NSCharacterSet characterSetWithCharactersInString:@"/:- "];
    s = [[s componentsSeparatedByCharactersInSet: doNotWant] componentsJoinedByString: @""];
    NSLog(@"%@", s);
    
    NSString *name=s; //[userDetails valueForKey:@"firstName"];
    
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


//Called when the view controller is first time loaded to memory
- (void)viewDidLoad {
    
    
    _firstNameError.hidden = YES;
    
    _firstNameTxt.delegate = self;
    _lastNameTxt.delegate = self;
    _emailTxt.delegate = self;
    _dateOfBirthTxt.delegate = self;
    
    _emailTxt.enabled = NO;
    
    // self.userProfilePicture.contentMode = UIViewContentModeScaleAspectFit;
    
    userProfileData = [[NSMutableDictionary alloc] init];
    
    [self.firstNameTxt addTarget:self action:@selector(textFieldChaneOnTouch:) forControlEvents:UIControlEventAllTouchEvents];
    [self.firstNameTxt addTarget:self action:@selector(textFieldChaneOnTouch:) forControlEvents:UIControlEventEditingChanged];
    [self.lastNameTxt addTarget:self action:@selector(textFieldChaneOnTouch:) forControlEvents:UIControlEventAllTouchEvents];
    [self.lastNameTxt addTarget:self action:@selector(textFieldChaneOnTouch:) forControlEvents:UIControlEventEditingChanged];
    
    [_datePickerView setBackgroundColor:[UIColor whiteColor]];
    _datePickerView.maximumDate=[NSDate date];
    
    UITapGestureRecognizer *singleFingerTap =
    [[UITapGestureRecognizer alloc] initWithTarget:self
                                            action:@selector(handleSingleTapped:)];
    [self.datePickerBackView addGestureRecognizer:singleFingerTap];
    
    
    
    
    UIToolbar* numberToolbar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 50)];
    numberToolbar.barStyle = UIBarStyleBlackTranslucent;
    numberToolbar.items = @[
                            [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],
                            [[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(doneWithNumberPad)],[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil]];
    [numberToolbar sizeToFit];
    _phoneNumberTxt.inputAccessoryView = numberToolbar;
    
    
    //Added by: Nalina
    //Added Date: 29/08/2016
    //Discription: call service to SET VALUES TO THE INPUT FIELDS
    
    AppDelegate *appdelegate= (AppDelegate *)[[UIApplication sharedApplication]delegate];
    NSString *getUserInfoUrl=[appdelegate.serviceURL stringByAppendingString:@"api/User"];
    [self startLoadingIndicator];
    [[GlobalFunction sharedInstance] getServerResponseAfterLogin:getUserInfoUrl method:@"GET" param:nil withCallback:^(NSInteger statusCode, NSDictionary *response, NSError *error)
     {
         
         NSString *message;
         
         NSMutableDictionary *dict=[[NSMutableDictionary alloc]init];
         
         if (statusCode == 200)
         {
             [dict setObject:[response objectForKey:@"phoneNumber"] forKey:@"phoneNumber"];
             [dict setObject:[response objectForKey:@"displayName"] forKey:@"displayName"];
             [dict setObject:[response objectForKey:@"userName"] forKey:@"userName"];
             [dict setObject:[response objectForKey:@"firstName"] forKey:@"firstName"];
             [dict setObject:[response objectForKey:@"email"] forKey:@"email"];
             [dict setObject:[response objectForKey:@"lastName"] forKey:@"lastName"];
             [dict setObject:[response objectForKey:@"dob"] forKey:@"dob"];
             [dict setObject:[response objectForKey:@"profilePicPath"] forKey:@"profilePicPath"];
             [dict setObject:[response objectForKey:@"isFirstTime"] forKey:@"isFirstTime"];
             [dict setObject:[response objectForKey:@"userRole"] forKey:@"userRole"];
             [dict setObject:[response objectForKey:@"nextScheduledAppointment"] forKey:@"nextScheduledAppointment"];
             [dict setObject:[response objectForKey:@"providerStatus"] forKey:@"providerStatus"];
             [dict setObject:[response objectForKey:@"userStatus"] forKey:@"userStatus"];
             appdelegate.usersDetails=dict;
             
             [self stopLoadingIndicator];
             
             self.userProfilePicture.layer.cornerRadius = 10;
             self.userProfilePicture.clipsToBounds = YES;
             
             if ([[response objectForKey:@"profilePicPath"] isEqual:[NSNull null]]) {
                 
                 UIImage *image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"upload-profile" ofType:@"png"]];
                 _userProfilePicture.image=image;
                 imagePath=@"";
             }else{
                 
                 
                 NSString *name=[response objectForKey:@"profilePicPath"];
                 imagePath= name;
                 
                 NSString *imagename=[appdelegate.imageURL stringByAppendingString:name];
                 dispatch_queue_t imagequeue =dispatch_queue_create("imageDownloader", nil);
                 dispatch_async(imagequeue, ^{
                     
                     //download iamge
                     NSData *imageData = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:imagename]];
                     UIImage *image = [[UIImage alloc] initWithData:imageData];
                     dispatch_async(dispatch_get_main_queue(), ^{
                         
                         if (image==NULL) {
                             UIImage *image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"upload-profile" ofType:@"png"]];
                             _userProfilePicture.image  = image;
                         }
                         else{
                             _userProfilePicture.image  = image;
                         }
                     });
                     
                 });
                 
                 [userProfileData setObject:name forKey:@"profilePicPath"];
             }
             
             _firstNameTxt.text=[response objectForKey:@"firstName"];
             _lastNameTxt.text=[response objectForKey:@"displayName"];
             _emailTxt.text=[response objectForKey:@"email"];
             _phoneNumberTxt.text=[response objectForKey:@"phoneNumber"];
             
             if ([[response objectForKey:@"dob"] isEqual:[NSNull null]]) {
                 _dateOfBirthTxt.text=@"";
             }else{
                 
                 NSString *getDate=[response objectForKey:@"dob"];
                 
                 NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
                 [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss"];
                 NSDate *dateFromString = [[NSDate alloc] init];
                 dateFromString = [dateFormatter dateFromString:getDate];
                 NSDateFormatter *format = [[NSDateFormatter alloc] init];
                 format.dateFormat = @"MM/dd/yyyy";
                 _dateOfBirthTxt.text=[format stringFromDate:dateFromString];
             }
             
             
             
         }
         else {
             //  GlobalFunction *globalValues=[[GlobalFunction alloc]init];
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
    
    
    /*UITapGestureRecognizer *datePickerTap =
     [[UITapGestureRecognizer alloc] initWithTarget:self
     action:@selector(datepickerClick:)];
     [self.dateOfBirthTxt addGestureRecognizer:datePickerTap];*/
    
    [self.dateOfBirthTxt addTarget:self action:@selector(datepickerClick:) forControlEvents:UIControlEventAllTouchEvents];
    [self.dateOfBirthTxt addTarget:self action:@selector(datepickerClick:) forControlEvents:UIControlEventEditingChanged];
    
    UITapGestureRecognizer *dateFingerTap =
    [[UITapGestureRecognizer alloc] initWithTarget:self
                                            action:@selector(datepickerClick:)];
    [self.dateOfBirthTxt addGestureRecognizer:dateFingerTap];
    

    
    [super viewDidLoad];
    UIImage *backgroundImage = [UIImage imageNamed:@"LoginBackground.png"];
    UIImageView *backgroundImageView=[[UIImageView alloc]initWithFrame:self.view.frame];
    backgroundImageView.frame = self.view.bounds;
    backgroundImageView.contentMode = UIViewContentModeScaleAspectFit;
    backgroundImageView.clipsToBounds = YES;
    backgroundImageView.image=backgroundImage;
    [self.view insertSubview:backgroundImageView atIndex:0];
    
    
}

//Added by: Nalina
//Added Date: 29/08/2016
//Discription: Show the date picker to set the dob
-(void)datepickerClick:(UITapGestureRecognizer *)recognizer {
    
    _datePickerBackView.hidden=NO;
    _datePickerBtnView.hidden=NO;
    _datePickerView.hidden=NO;
    _photoPopUpView.hidden=YES;
}

//Added by: Nalina
//Added Date: 29/08/2016
//Discription: hide the date picker to set the dob

- (void)handleSingleTapped:(UITapGestureRecognizer *)recognizer {
    //Do stuff here...
    [self resignSoftKeyboard];
    _datePickerBackView.hidden=YES;
}

//Added by: Nalina
//Added Date: 29/08/2016
//Discription: To focus the textfield and return the keyboard
- (BOOL)textFieldShouldReturn:(UITextField *)theTextField {
    
    
  /*  if (theTextField == self.firstNameTxt) {
        [self.lastNameTxt becomeFirstResponder];
    }
    if (theTextField == self.lastNameTxt) {
        [theTextField resignFirstResponder];
    }
    if (theTextField == self.dateOfBirthTxt) {
        [self resignSoftKeyboard];
    }*/
     [self resignSoftKeyboard];
    return NO;
    
    
    
}

//Added by: Nalina
//Added Date: 29/08/2016
//Discription: Called on touch of textfield
-(void)textFieldChaneOnTouch :(UITextField *)theTextField
{
    [self RemoveValidationOnTouch:theTextField];
}


//Added by: Nalina
//Added Date: 29/08/2016
//Discription: Called remove the validation message on touch of textfield
-(void)RemoveValidationOnTouch:(UITextField *)theTextField{
    if([theTextField isEqual: _firstNameTxt]){
        
        [self RemoveValidationSettings:_firstNameTxt errorIcon:_firstNameError indicationIcon:_firstNameIcon HintText:@"Full name" imageIs:@"user" viewField:_firstNameView];
        
    }else if([theTextField isEqual: _lastNameTxt]){
        
        [self RemoveValidationSettings:_lastNameTxt errorIcon:_lastNameError indicationIcon:_lastNameIcon HintText:@"Display name" imageIs:@"user" viewField:_lastNameView];
        
    }
}

//Added by: Nalina
//Added Date: 29/08/2016
//Discription: Called remove the validation message when textfield is edited
-(void)RemoveValidationSettings:(UITextField *)textField errorIcon:(UIButton *)errorBtn indicationIcon:(UIImageView *)indicationIcon HintText:(NSString *)hintTextMessage imageIs:(NSString *)imageIs viewField:(UIView *)view{
    
    [textField setValue:[UIColor  colorWithRed:(112/255.0) green:(112/255.0) blue:(112/255.0) alpha:1] forKeyPath:@"_placeholderLabel.textColor"];
    textField.placeholder=hintTextMessage;
    errorBtn.hidden=YES;
    UIImage *image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:imageIs ofType:@"png"]];
    indicationIcon.image = image;
    [self setBorder:view];
    
}

// Dispose of any resources that can be recreated.
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


//  Added by:Zeenath
//  Added Date:2016-24-07.
//  Description:Function To make the image view rounded.
-(void)setBorder:(UIView *)view
{
    view.layer.borderColor = [[UIColor colorWithRed:228.0/255.0 green:109.0/255.0 blue:175.0/255.0 alpha:1.0]CGColor];
    view.layer.borderWidth = 1.0f;
}

//called each time when the view appears
-(void)viewWillAppear:(BOOL)animated{
    /*self.userProfilePicture.layer.cornerRadius = self.userProfilePicture.frame.size.width / 2;
     self.userProfilePicture.clipsToBounds = YES;*/
    
    [self setBorder:_firstNameView];
    [self setBorder:_lastNameView];
    [self setBorder:_emailView];
    [self setBorder:_dateOfBirthView];
    
    id<GAITracker> tracker = [[GAI sharedInstance] defaultTracker];
    [tracker set:kGAIScreenName value:@"UserProfile"];
    [tracker send:[[GAIDictionaryBuilder createScreenView] build]];
}


//  Added by:Nalina
//  Added Date:2016-29-07.
//  Description:Function called when the back button is clicked.
- (IBAction)backClick:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}


//  Added by:NALINA
//  Added Date:2016-29-07.
//  Description:Function called when the close button is clicked to remove the validation message.
- (IBAction)firstNameErrorClose:(id)sender {
    [self RemoveValidationSettings:_firstNameTxt errorIcon:_firstNameError indicationIcon:_firstNameIcon HintText:@"First name" imageIs:@"user" viewField:_firstNameView];
}
- (IBAction)lastNameErrorClose:(id)sender {
    [self RemoveValidationSettings:_lastNameTxt errorIcon:_lastNameError indicationIcon:_lastNameIcon HintText:@"Display name" imageIs:@"user" viewField:_lastNameView];
}
- (IBAction)emailErrorClose:(id)sender {
    [self RemoveValidationSettings:_emailTxt errorIcon:_emailError indicationIcon:_emailIcon HintText:@"Email " imageIs:@"email" viewField:_emailView];
}
- (IBAction)dateOfBirthErrorClick:(id)sender {
    
    [self RemoveValidationSettings:_dateOfBirthTxt errorIcon:_dateOfBirthError indicationIcon:_dateOfBirthIcon HintText:@"Date of birth " imageIs:@"dob" viewField:_dateOfBirthView];
    
}


- (IBAction)phoneNumbererrorbtnclick:(id)sender {
    
    [self RemoveValidationSettings:_phoneNumberTxt errorIcon:_phoneNumberError indicationIcon:_phoneerror HintText:@"Phone number" imageIs:@"Phone number" viewField:_dateOfBirthView];
    
}




/*- (IBAction)phoneerrorbtnclick:(id)sender {
 
 [self RemoveValidationSettings:_phoneNumberTxt errorIcon:_phoneNumberError indicationIcon:_dateOfBirthIcon HintText:@"Date of birth " imageIs:@"dob" viewField:_dateOfBirthView];
 }*/


// Added By:Nalina
// Added Date:29/07/16
// Description: Regular expression for the name field
- (BOOL)validateNameField:(NSString*)name
{
    NSString *nameRegex = @"^[a-zA-Z ]*$";
    NSPredicate *nameTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", nameRegex];
    return [nameTest evaluateWithObject:name];
}


// Added By:Nalina
// Added Date:05/08/16
// Description: User profile update service call

- (IBAction)phoneerrorbtnclick:(id)sender {
}

- (IBAction)submitClick:(id)sender {
    
    
    // svos = _scrollview.contentOffset;
    CGPoint pt;
    
    pt.x = 0;
    pt.y = 10;
    [_scrollView setContentOffset:pt animated:YES];
    // _phoneNumberTxt.text=@"121231123";
    
    //GlobalFunction *globalValues=[[GlobalFunction alloc]init];
    AppDelegate *appdelegate= (AppDelegate *)[[UIApplication sharedApplication]delegate];
    
    BOOL internetCheck= [appdelegate testInternetConnection];
    
    if (internetCheck==NO) {
        [appdelegate displayNetworkAlert];
        [self presentViewController:appdelegate.alert animated:YES completion:nil];
    }
    
    
    if([_firstNameTxt.text isEqualToString:@""]){
        
        [self SetValidationSettinds:_firstNameTxt errorIcon:_firstNameError indicationIcon:_firstNameIcon validationMessage:[[GlobalFunction sharedInstance].arrayOfAlerts objectAtIndex:3] imageIs:@"error-user" viewField:_firstNameView];
        _firstNameIcon.hidden = NO;
    }else if(!([self validateNameField:_firstNameTxt.text])) {
        
        _firstNameTxt.text=@"";
        [self SetValidationSettinds:_firstNameTxt errorIcon:_firstNameError indicationIcon:_firstNameIcon validationMessage:[[GlobalFunction sharedInstance].arrayOfAlerts objectAtIndex:28] imageIs:@"error-user" viewField:_firstNameView];
    }
    
    
    if([_lastNameTxt.text isEqualToString:@""]){
        
        [self SetValidationSettinds:_lastNameTxt errorIcon:_lastNameError indicationIcon:_lastNameIcon validationMessage:[[GlobalFunction sharedInstance].arrayOfAlerts objectAtIndex:4] imageIs:@"error-user" viewField:_lastNameView];
        
    }else if(!([self validateNameField:_lastNameTxt.text])) {
        
        _lastNameTxt.text=@"";
        [self SetValidationSettinds:_lastNameTxt errorIcon:_lastNameError indicationIcon:_lastNameIcon validationMessage:[[GlobalFunction sharedInstance].arrayOfAlerts objectAtIndex:29] imageIs:@"error-user" viewField:_lastNameView];
        
    }
    if([_emailTxt.text isEqualToString:@""]) {
        
        [self SetValidationSettinds:_emailTxt errorIcon:_emailError indicationIcon:_lastNameIcon validationMessage:[[GlobalFunction sharedInstance].arrayOfAlerts objectAtIndex:6] imageIs:@"error-user" viewField:_lastNameView];
    }
    
    else if(!([self validateEmail:_emailTxt.text])) {
        
        _emailTxt.text=@"";
        [self SetValidationSettinds:_emailTxt errorIcon:_emailError indicationIcon:_emailIcon validationMessage:[[GlobalFunction sharedInstance].arrayOfAlerts objectAtIndex:6] imageIs:@"error-email" viewField:_lastNameView];
    }
    
    
    if([_dateOfBirthTxt.text isEqualToString:@""]) {
        
        [self SetValidationSettinds:_dateOfBirthTxt errorIcon:_dateOfBirthError indicationIcon:_lastNameIcon validationMessage:[[GlobalFunction sharedInstance].arrayOfAlerts objectAtIndex:132] imageIs:@"error-user" viewField:_lastNameView];
    }
    if([_phoneNumberTxt.text isEqualToString:@""]) {
        
        [self SetValidationSettinds:_phoneNumberTxt errorIcon:_emailError indicationIcon:_lastNameIcon validationMessage:[[GlobalFunction sharedInstance].arrayOfAlerts objectAtIndex:127] imageIs:@"error-user" viewField:_lastNameView];
    }
    
    
    if(!([_firstNameTxt.text isEqualToString:@""])&& !([_lastNameTxt.text isEqualToString:@""])&&([self validateNameField:_firstNameTxt.text])&&([self validateNameField:_lastNameTxt.text]) && !([_emailTxt.text isEqualToString:@""] && !([_dateOfBirthTxt.text isEqualToString:@""]) && !([_phoneNumberTxt.text isEqualToString:@""]))                           ){
        
        /************** Call user profile update ******************/
        
        NSString *userprofileUrl=[appdelegate.serviceURL stringByAppendingString:@"api/User/UserProfileUpdate"];
        
        [userProfileData setObject:[appdelegate.usersDetails objectForKey:@"userName"] forKey:@"userName"];
        [userProfileData setObject:[_firstNameTxt.text stringByTrimmingCharactersInSet:
                                    [NSCharacterSet whitespaceCharacterSet]] forKey:@"firstName"];
        [userProfileData setObject:[_lastNameTxt.text stringByTrimmingCharactersInSet:
                                    [NSCharacterSet whitespaceCharacterSet]] forKey:@"displayName"];
        [userProfileData setObject:[_emailTxt.text stringByTrimmingCharactersInSet:
                                    [NSCharacterSet whitespaceCharacterSet]] forKey:@"email"];
        [userProfileData setObject:_dateOfBirthTxt.text forKey:@"dob"];
        [userProfileData setObject: _phoneNumberTxt.text forKey:@"phoneNumber"];
        [userProfileData setObject: imagePath forKey:@"profilePicPath"];
        
        
        [self startLoadingIndicator];
        [[GlobalFunction sharedInstance] getServerResponseAfterLogin:userprofileUrl method:@"POST" param:userProfileData withCallback:^(NSInteger statusCode, NSDictionary *response, NSError *error)
         {
             
             //  GlobalFunction *globalValues=[[GlobalFunction alloc]init];
             NSString *message;
             
             if (statusCode == 200)
             {
                 NSLog(@" inside status sucess");
                 
                 [appdelegate.usersDetails removeObjectForKey:@"firstName"];
                 [appdelegate.usersDetails setObject:[_firstNameTxt.text stringByTrimmingCharactersInSet:
                                                      [NSCharacterSet whitespaceCharacterSet]] forKey:@"firstName"];
                 
                 [appdelegate.usersDetails removeObjectForKey:@"lastName"];
                 [appdelegate.usersDetails setObject:[_lastNameTxt.text stringByTrimmingCharactersInSet:
                                                      [NSCharacterSet whitespaceCharacterSet]] forKey:@"lastName"];
                 
                 [appdelegate.usersDetails removeObjectForKey:@"profilePicPath"];
                 [appdelegate.usersDetails setObject:[userProfileData objectForKey:@"profilePicPath"] forKey:@"profilePicPath"];
                 
                 [appdelegate.usersDetails removeObjectForKey:@"dob"];
                 [appdelegate.usersDetails setObject:_dateOfBirthTxt.text forKey:@"dob"];
                 
                 [appdelegate.usersDetails removeObjectForKey:@"phoneNumber"];
                 [appdelegate.usersDetails setObject:_phoneNumberTxt.text forKey:@"phoneNumber"];
                 
                 message=[[GlobalFunction sharedInstance].arrayOfAlerts objectAtIndex:69];
                 
                 NSLog(@" Alertview starting");
                 
                 _alert = [UIAlertController
                           alertControllerWithTitle:@""
                           message:message
                           preferredStyle:UIAlertControllerStyleAlert];
                 
                 UIAlertAction* okButton = [UIAlertAction
                                            actionWithTitle:@"OK"
                                            style:UIAlertActionStyleDefault
                                            handler:^(UIAlertAction * action) {
                                                NSLog(@" Alertview inside dislay");
                                                
                                                [self stopLoadingIndicator];
                                                [self dismissViewControllerAnimated:YES completion:nil];
                                            }];
                 [_alert addAction:okButton];
                 [self presentViewController:_alert animated:YES completion: nil];
                 NSLog(@" Alertview ending");
                 [self stopLoadingIndicator];
                 
                 
                 
             }
             else {
                 NSString *message;
                 
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
                                                [self dismissViewControllerAnimated:YES completion:nil];
                                                
                                                
                                            }];
                 [_alert addAction:okButton];
                 [self presentViewController:_alert animated:YES completion: nil];
             }
             
         }];
        
        
        
    }
    
    
    
}


// Added By:Nalina
// Added Date:29/07/16
// Description:Function To show the validation message for the textfields
-(void)SetValidationSettinds:(UITextField *)textField errorIcon:(UIButton *)errorBtn indicationIcon:(UIImageView *)indicationIcon validationMessage:(NSString *)validationMessage imageIs:(NSString *)imageIs viewField:(UIView *)viewIs{
    
    [textField setValue:[UIColor redColor] forKeyPath:@"_placeholderLabel.textColor"];
    textField.placeholder=validationMessage;
    errorBtn.hidden=NO;
    UIImage *image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:imageIs ofType:@"png"]];
    indicationIcon.image = image;
    viewIs.layer.borderColor = [[UIColor redColor]CGColor];
    viewIs.layer.borderWidth = 1.0f;
    
}

// Added By:Nalina
// Added Date:29/07/16
// Description:Function called when the cancel button is clicked
- (IBAction)cancelClick:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
    
}

// Added By:Nalina
// Added Date:29/07/16
// Description:Function set the date from the datepicker on the textfield
- (IBAction)setDateClick:(id)sender {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"MM/dd/yyyy"];
    dateOfBirth = [dateFormatter stringFromDate:self.datePickerView.date];
    _dateOfBirthTxt.text=dateOfBirth;
    _datePickerBackView.hidden=YES;
    _datePickerBtnView.hidden=YES;
    _datePickerView.hidden=YES;
    _photoPopUpView.hidden=YES;
    [_phoneNumberTxt becomeFirstResponder];
     [self resignSoftKeyboard];
}


// Added By:Nalina
// Added Date:29/07/16
// Description:Function hide the datepicker
- (IBAction)cancelDateClick:(id)sender {
    _datePickerBackView.hidden=YES;
    _datePickerBtnView.hidden=YES;
    _datePickerView.hidden=YES;
    _photoPopUpView.hidden=YES;
    [_phoneNumberTxt becomeFirstResponder];
    [self resignSoftKeyboard];
}

- (IBAction)datePickerBtn:(id)sender {
    [_firstNameTxt resignFirstResponder];
    [_lastNameTxt resignFirstResponder];
    
    _datePickerBackView.hidden=NO;
    _datePickerBtnView.hidden=NO;
    _datePickerView.hidden=NO;
    _photoPopUpView.hidden=YES;
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
 }
 */

// Added By:Nalina
// Added Date:03/08/16
// Description:Function hide the image upload popup
- (IBAction)cancelPhotoPopupClick:(id)sender {
    _datePickerBackView.hidden=YES;
    _photoPopUpView.hidden=YES;
    _datePickerBtnView.hidden=YES;
    _datePickerView.hidden=YES;
    
}


// Added By:Nalina
// Added Date:03/08/16
// Description:Function show the image upload popup
- (IBAction)photoUploadClick:(id)sender {
    [_firstNameTxt resignFirstResponder];
    [_lastNameTxt resignFirstResponder];
    
    _datePickerBackView.hidden=NO;
    _photoPopUpView.hidden=NO;
    _datePickerBtnView.hidden=YES;
    _datePickerView.hidden=YES;
}



// Added By:Nalina
// Added Date:03/08/16
// Description:Function upload the image from gallery
- (IBAction)galleryClick:(id)sender {
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc]init];
    imagePickerController.delegate = self;
    imagePickerController.sourceType =  UIImagePickerControllerSourceTypePhotoLibrary;
    
    [self presentViewController:imagePickerController animated:YES completion:nil];
}


// Added By:Nalina
// Added Date:03/08/16
// Description:Function upload the image from camera
- (IBAction)cameraClick:(id)sender {
    
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc]init];
    imagePickerController.delegate = self;
    imagePickerController.sourceType =  UIImagePickerControllerSourceTypeCamera;
    [self presentViewController:imagePickerController animated:YES completion:nil];
}

- (IBAction)backArrowClick:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)imgClick:(id)sender {
    
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:
                                @"GeneralStoryboard" bundle:nil];
    
    PhotopopupViewController *photopopup=[storyboard instantiateViewControllerWithIdentifier:@"photopopup"];
    photopopup.delegate=self;
    self.modalPresentationStyle = UIModalPresentationFullScreen;
    
    photopopup.modalPresentationStyle = UIModalPresentationOverCurrentContext;
    
    [self presentViewController:photopopup animated:NO completion:nil];
    
}

- (IBAction)dateTxtfieldClick:(id)sender {
    
     [self resignSoftKeyboard];
     [self.dateOfBirthTxt resignFirstResponder];
    
    
}
// becomeFirstResponder
// Added By:Nalina
// Added Date:03/08/16
// Description:Function called the set the image in the image view and upload it to azure blob
- (void) imagePickerController:(UIImagePickerController *)picker
         didFinishPickingImage:(UIImage *)image
                   editingInfo:(NSDictionary *)editingInfo
{
    AppDelegate *appDelegat=(AppDelegate *)[[UIApplication sharedApplication]delegate];
    self.userProfilePicture.image = image;
    _datePickerBackView.hidden=YES;
    _photoPopUpView.hidden=YES;
    _datePickerBtnView.hidden=YES;
    _datePickerView.hidden=YES;
    NSString *name=[appDelegat.usersDetails valueForKey:@"firstName"];
    
    [appDelegat uploadBlobToContainer:image name:name path:1 withCallback:^(NSString *response, NSError *error) {
        if (error == nil)
        {
            [userProfileData setObject:response forKey:@"profilePicPath"];
            
        }
        else
        {
            [userProfileData setObject:@"" forKey:@"profilePicPath"];
            
        }
        
    }];
    
    [self dismissModalViewControllerAnimated:YES];
    
}



//Added by: Nalina
//Added date: 23/08/16
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



- (BOOL)validateEmail:(NSString*)email
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}



-(void)resignSoftKeyboard{
    [_firstNameTxt resignFirstResponder];
    [_lastNameTxt resignFirstResponder];
    [_emailTxt resignFirstResponder];
    [_phoneNumberTxt resignFirstResponder];
    [_dateOfBirthTxt resignFirstResponder];
   
}

- (BOOL) textFieldShouldBeginEditing:(UITextField *)textField
{
    if(textField == _dateOfBirthTxt )
    {
        [self resignSoftKeyboard];
        [_dateOfBirthTxt resignFirstResponder];
        _datePickerBackView.hidden=NO;
        _datePickerBtnView.hidden=NO;
        _datePickerView.hidden=NO;
        _photoPopUpView.hidden=YES;
        return NO;
    }
    
    return YES;
    
}

-(void)doneWithNumberPad{
    [_phoneNumberTxt resignFirstResponder];
}


- (IBAction)Firstnamerroricon:(id)sender {
}
@end
