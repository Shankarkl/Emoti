/***************************************************************
 Page name:ProviderSignUpFirstViewController.m
 Created By:Zeenath
 Created Date:30/6/16
 Description: Provider sign-up implementation file
 ***************************************************************/

#import "ProviderSignUpFirstViewController.h"
#import "ProviderSignUpSecondViewController.h"
#import "GlobalFunction.h"
#import "AppDelegate.h"
#import <Google/Analytics.h>
#import "PhotopopupViewController.h"

@interface ProviderSignUpFirstViewController ()<PhotopopupViewControllerDelegate>
{
    UIImage *bindimage;
}

@end

@implementation ProviderSignUpFirstViewController

- (void)dataFromController:(UIImage *)data
{
    //bindimage = data;
    _profilePicView.layer.cornerRadius = 10;
    _profilePicView.layer.masksToBounds = YES;
    _profilePicView.image = data;
    [self startLoadingIndicator];
    
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    // or @"yyyy-MM-dd hh:mm:ss a" if you prefer the time with AM/PM
    NSLog(@"%@",[dateFormatter stringFromDate:[NSDate date]]);
    
    NSString *name=[dateFormatter stringFromDate:[NSDate date]]; //[userDetails valueForKey:@"firstName"];
    
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
            imagePath=@"";
            [self stopLoadingIndicator];
            //[userDetails setObject:@"" forKey:@"profilePicPath"];
            
        }
        
        
    }];
    
}



@synthesize prepopulateData;

//Loads first time when page appears
- (void)viewDidLoad {
    [super viewDidLoad];
    
    imagePath=@"";
    
    UIButton *subBtn = (UIButton *) [self.view viewWithTag:6];
    subBtn.layer.borderColor = [UIColor colorWithRed:246.0/255.0 green:108.0/255.0 blue:118.0/255.0 alpha:1].CGColor;
    
    _firstnameText.delegate=self;
    _lastnameText.delegate=self;
    _phoneNumText.delegate=self;
    _emailText.delegate=self;
    _dobText.delegate=self;
    _SSNText.delegate=self;
    
    //[_datePicker setBackgroundColor:[UIColor whiteColor]];
    //_datePicker.maximumDate=[NSDate date];
    
    [self.firstnameText addTarget:self action:@selector(textFielddidChange:) forControlEvents:UIControlEventAllTouchEvents];
    [self.firstnameText addTarget:self action:@selector(textFielddidChange:) forControlEvents:UIControlEventEditingChanged];
    
    [self.lastnameText addTarget:self action:@selector(textFielddidChange:) forControlEvents:UIControlEventAllTouchEvents];
    [self.lastnameText addTarget:self action:@selector(textFielddidChange:) forControlEvents:UIControlEventEditingChanged];
    [self.phoneNumText addTarget:self action:@selector(textFielddidChange:) forControlEvents:UIControlEventAllTouchEvents];
    [self.phoneNumText addTarget:self action:@selector(textFielddidChange:) forControlEvents:UIControlEventEditingChanged];
    
    [self.emailText addTarget:self action:@selector(textFielddidChange:) forControlEvents:UIControlEventAllTouchEvents];
    [self.emailText addTarget:self action:@selector(textFielddidChange:) forControlEvents:UIControlEventEditingChanged];
    [_pickerView setBackgroundColor:[UIColor whiteColor]];
    _pickerView.maximumDate=[NSDate date];
    
    UITapGestureRecognizer *singleFingerTap =
    [[UITapGestureRecognizer alloc] initWithTarget:self
                                            action:@selector(handleSingleTapped:)];
    [self.pickerBackView addGestureRecognizer:singleFingerTap];
    
    
    [self.dobText addTarget:self action:@selector(handledobTap:) forControlEvents:UIControlEventAllTouchEvents];
    [self.dobText addTarget:self action:@selector(handledobTap:) forControlEvents:UIControlEventEditingChanged];
    
    
    [self.SSNText addTarget:self action:@selector(textFielddidChange:) forControlEvents:UIControlEventAllTouchEvents];
    [self.SSNText addTarget:self action:@selector(textFielddidChange:) forControlEvents:UIControlEventEditingChanged];
    
    UIToolbar* numberToolbar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 50)];
    numberToolbar.barStyle = UIBarStyleBlackTranslucent;
    numberToolbar.items = @[
                            [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],
                            [[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(doneWithNumberPad)],[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil]];
    [numberToolbar sizeToFit];
    _SSNText.inputAccessoryView = numberToolbar;
    
    numberToolbar.barStyle = UIBarStyleBlackTranslucent;
    numberToolbar.items = @[
                            [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],
                            [[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(doneWithNumberPad)],[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil]];
    [numberToolbar sizeToFit];
    _phoneNumText.inputAccessoryView = numberToolbar;
    
   
    
    UITapGestureRecognizer *licensureStateTap =
    [[UITapGestureRecognizer alloc] initWithTarget:self
                                            action:@selector(handlelicensureStateTap:)];
    [self.providerStateView addGestureRecognizer:licensureStateTap];
    UITapGestureRecognizer *qualificationTap =
    [[UITapGestureRecognizer alloc] initWithTarget:self
                                            action:@selector(qualificationTap:)];
    [self.providerQualificationView addGestureRecognizer:qualificationTap];
    
    UITapGestureRecognizer *dobTap =
    [[UITapGestureRecognizer alloc] initWithTarget:self
                                            action:@selector(handledobTap:)];
    [self.dobText addGestureRecognizer:dobTap];
    
    
    UIImageView *bgImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"LoginBackground.png"]];
    bgImageView.frame = self.view.bounds;
    bgImageView.contentMode = UIViewContentModeScaleAspectFill;
    bgImageView.clipsToBounds = YES;
    [_backgroundSignUpView addSubview:bgImageView];
    [_backgroundSignUpView sendSubviewToBack:bgImageView];
    
    
}

-(void)doneWithNumberPad{
    [_SSNText resignFirstResponder];
     [_phoneNumText resignFirstResponder];
}

//  Added by: zeenath
//  Added Date: 30/6/16
//  Description: pop the picker on touch of input fields

- (void)handleSingleTapped:(UITapGestureRecognizer *)recognizer {
    [self.view endEditing:YES];
    //   _dobText.enabled = YES;
    _pickerBackView.hidden=YES;
    [self resignSoftKeyboard];
}

- (void)handlelicensureStateTap:(UITapGestureRecognizer *)recognizer {
    [_firstnameText resignFirstResponder];
    [_lastnameText resignFirstResponder];
    [_emailText resignFirstResponder];
    
  
    
    //  [self.pickerView reloadAllComponents];
    _pickerBackView.hidden=NO;
    [_pickerView setHidden:NO];
    [_datePicker setHidden:YES];
    [_datePickerButtonView setHidden:YES];
    clickedbutton=@"stateDropdown";
    
}


- (void)qualificationTap:(UITapGestureRecognizer *)recognizer {
    
    [_firstnameText resignFirstResponder];
    [_lastnameText resignFirstResponder];
    [_emailText resignFirstResponder];
    //[_stateText resignFirstResponder];
    // [_usernameText resignFirstResponder];
    // [_licenceText resignFirstResponder];
    [_SSNText resignFirstResponder];
    _pickerArray=[[NSMutableArray alloc]init];
    _pickerArray = [[NSMutableArray alloc]initWithObjects:@"Phd/MD",
                    @"PSYD",@"MSW",@"LCSW",@"Licensed Counselor", nil];
    //  [self.pickerView reloadAllComponents];
    _pickerBackView.hidden=NO;
    [_pickerView setHidden:NO];
    [_datePicker setHidden:YES];
    [_datePickerButtonView setHidden:YES];
    clickedbutton=@"qualificationDropdown";
}


- (void)handledobTap:(UITapGestureRecognizer *)recognizer {
     [_pickerBackView setHidden:NO];
    [_pickerView setHidden:YES];
    [_datePicker setHidden:NO];
    [_datePickerButtonView setHidden:NO];
   // [self resignSoftKeyboard];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

//Loads each time when page appears
-(void)viewWillAppear:(BOOL)animated
{
    [self setBorder:_providerFirstNameView];
    [self setBorder:_providerLastNameView];
    [self setBorder:_providerPhoneNumberView];
    [self setBorder:_providerEmailView];
    [self setBorder:_providerDobView];
    [self setBorder:_providerSSNView];
    [_pickerBackView setHidden:YES];
    
    id<GAITracker> tracker = [[GAI sharedInstance] defaultTracker];
    [tracker set:kGAIScreenName value:@"ProviderSignup"];
    [tracker send:[[GAIDictionaryBuilder createScreenView] build]];
}


//  Added by: zeenath
//  Added Date:30/6/16
//  Description: Set border to the input fields

-(void)setBorder:(UIView *)img
{
    img.layer.borderColor = [[UIColor colorWithRed:228.0/255.0 green:109.0/255.0 blue:175.0/255.0 alpha:1.0]CGColor];
    img.layer.borderWidth = 1.0f;
}


//  Added by: zeenath
//  Added Date:25/8/16
//  Description: Cancel button click to close the screen and store data in app delegate to prepopulate

- (IBAction)backButtonAction:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
    NSMutableDictionary *detailsDict=detailsDict=[[NSMutableDictionary alloc]init];;
    
    //[detailsDict setObject:[_usernameText.text stringByTrimmingCharactersInSet:
    //  [NSCharacterSet whitespaceCharacterSet]] forKey:@"userName"];
    
    [detailsDict setObject:[_firstnameText.text stringByTrimmingCharactersInSet:
                            [NSCharacterSet whitespaceCharacterSet]] forKey:@"firstName"];
    [detailsDict setObject:[_lastnameText.text stringByTrimmingCharactersInSet:
                            [NSCharacterSet whitespaceCharacterSet]] forKey:@"lastName"];
    [detailsDict setObject:[_phoneNumText.text stringByTrimmingCharactersInSet:
                            [NSCharacterSet whitespaceCharacterSet]] forKey:@"phoneNumber"];
    [detailsDict setObject:[_emailText.text stringByTrimmingCharactersInSet:
                            [NSCharacterSet whitespaceCharacterSet]] forKey:@"email"];
   
    
    [detailsDict setObject:[_dobText.text stringByTrimmingCharactersInSet:
                            [NSCharacterSet whitespaceCharacterSet]] forKey:@"dob"];
    [detailsDict setObject:[_SSNText.text stringByTrimmingCharactersInSet:
                            [NSCharacterSet whitespaceCharacterSet]] forKey:@"ssn"];
}


//  Added by: zeenath
//  Added Date: 25/8/16
//  Description: validation and redirect to next screen on click of submit

- (IBAction)nextButtonAction:(id)sender {
    CGPoint pt;
    
    pt.x = 0;
    pt.y = 13;
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
    
    if([_firstnameText.text isEqualToString:@""]){
        [self SetValidationSettinds:_firstnameText errorIcon:_firstnameCloseButton indicationIcon:_firstNameIcon validationMessage:[[GlobalFunction sharedInstance].arrayOfAlerts objectAtIndex:3] imageIs:@"error-user" viewField:_providerFirstNameView];
        
    }
    else if(!([self validateNameField:_firstnameText.text])) {
        _firstnameText.text=@"";
        [self SetValidationSettinds:_firstnameText errorIcon:_firstnameCloseButton indicationIcon:_firstNameIcon validationMessage:[[GlobalFunction sharedInstance].arrayOfAlerts objectAtIndex:28] imageIs:@"error-user" viewField:_providerFirstNameView];
    }
    
    if([_lastnameText.text isEqualToString:@""]){
        [self SetValidationSettinds:_lastnameText errorIcon:_lastnameCloseButton indicationIcon:_lastNameIcon validationMessage:[[GlobalFunction sharedInstance].arrayOfAlerts objectAtIndex:4] imageIs:@"error-user" viewField:_providerLastNameView];
    }
    else if(!([self validateNameField:_lastnameText.text])) {
        _lastnameText.text=@"";
        [self SetValidationSettinds:_lastnameText errorIcon:_lastnameCloseButton indicationIcon:_lastNameIcon validationMessage:[[GlobalFunction sharedInstance].arrayOfAlerts objectAtIndex:29] imageIs:@"error-user" viewField:_providerLastNameView];
    }
    
    if([_phoneNumText.text isEqualToString:@""]){
        [self SetValidationSettinds:_phoneNumText errorIcon:_phoneNumberCloseButton indicationIcon:_phoneNumberIcon validationMessage:[[GlobalFunction sharedInstance].arrayOfAlerts objectAtIndex:127] imageIs:@"error-user" viewField:_providerPhoneNumberView];
    }
    else if(!([self validatPhoneNumber:_phoneNumText.text])) {
        _phoneNumText.text=@"";
        [self SetValidationSettinds:_phoneNumText errorIcon:_phoneNumberCloseButton indicationIcon:_phoneNumberIcon validationMessage:[[GlobalFunction sharedInstance].arrayOfAlerts objectAtIndex:128] imageIs:@"error-user" viewField:_providerPhoneNumberView];
    }
    
    
  
    if([_emailText.text isEqualToString:@""]){
        [self SetValidationSettinds:_emailText errorIcon:_emailCloseButton indicationIcon:_emailIcon validationMessage:[[GlobalFunction sharedInstance].arrayOfAlerts objectAtIndex:2] imageIs:@"error-email" viewField:_providerEmailView];
    }
    else if(!([self validateEmail:_emailText.text])) {
        
        _emailText.text=@"";
        [self SetValidationSettinds:_emailText errorIcon:_emailCloseButton indicationIcon:_emailIcon validationMessage:[[GlobalFunction sharedInstance].arrayOfAlerts objectAtIndex:6] imageIs:@"error-email" viewField:_providerEmailView];
    }
    
    /*
     if([_qualificationText.text isEqualToString:@""]){
     [self SetValidationSettinds:_qualificationText errorIcon:_qualificationButton indicationIcon:_qualificationIcon validationMessage:[[GlobalFunction sharedInstance].arrayOfAlerts objectAtIndex:22]imageIs:@"error-qualification" viewField:_providerQualificationView];
     }*/
    
    
    if([_dobText.text isEqualToString:@""]){
        [_dobDropIcon setHidden:YES];
        [self SetValidationSettinds:_dobText errorIcon:_dobCloseButton indicationIcon:_dobIcon validationMessage:[[GlobalFunction sharedInstance].arrayOfAlerts objectAtIndex:46]imageIs:@"error-dob" viewField:_providerDobView];
    }
    if([_SSNText.text isEqualToString:@""]){
        [self SetValidationSettinds:_SSNText errorIcon:_SSNCloseButton indicationIcon:_SSNIcon validationMessage:[[GlobalFunction sharedInstance].arrayOfAlerts objectAtIndex:70]imageIs:@"error-user" viewField:_providerSSNView];
    }
    else if(!([self validatSSN:_SSNText.text])) {
        _SSNText.text=@"";
        [self SetValidationSettinds:_SSNText errorIcon:_SSNCloseButton indicationIcon:_SSNIcon validationMessage:[[GlobalFunction sharedInstance].arrayOfAlerts objectAtIndex:71]imageIs:@"error-user" viewField:_providerSSNView];
        
    }
    
    if(!([_firstnameText.text isEqualToString:@""])&&!([_lastnameText.text isEqualToString:@""])&& !([_phoneNumText.text isEqualToString:@""])&& !([_emailText.text isEqualToString:@""])&&([self validateEmail:_emailText.text])
       
       /*&& !([_usernameText.text isEqualToString:@""])&& !([_stateText.text isEqualToString:@""])&& !([_qualificationText.text isEqualToString:@""])*/
       && !([_dobText.text isEqualToString:@""])&& !([_SSNText.text isEqualToString:@""])
       /*&& !([_licenceText.text isEqualToString:@""])*/
       
       ){
        
        //  Added by: Nalina
        //  Added Date:29/07/16
        //  Description: Check duplicate user and duplicate email service call
        
        NSString *duplicateemailUrl=[appdelegate.serviceURL stringByAppendingString:@"api/Account/CheckUser"];
        NSMutableDictionary *duplicateemailData = [[NSMutableDictionary alloc] init];
        [duplicateemailData setObject:[_emailText.text stringByTrimmingCharactersInSet:
                                       [NSCharacterSet whitespaceCharacterSet]] forKey:@"userNameOrEmail"];
        [duplicateemailData setObject:@"Email" forKey:@"checkType"];
        if (internetCheck) {
            //[self startLoadingIndicator];
        }
        [self startLoadingIndicator];

        [[GlobalFunction sharedInstance] getServerResponseForUrl:duplicateemailUrl method:@"POST" param:duplicateemailData withCallback:^(NSInteger statusCode, NSDictionary *response, NSError *error)
         {
             NSString *message;
             
             if (statusCode == 200)
             {
                 
                   [self stopLoadingIndicator];
                 NSMutableDictionary *detailsDict=detailsDict=[[NSMutableDictionary alloc]init];
                 
                 //username not required
                 
                 /* [detailsDict setObject:[_usernameText.text stringByTrimmingCharactersInSet:
                  [NSCharacterSet whitespaceCharacterSet]] forKey:@"userName"];*/
                 
                 [detailsDict setObject:[_firstnameText.text stringByTrimmingCharactersInSet:
                                         [NSCharacterSet whitespaceCharacterSet]] forKey:@"firstName"];
                 [detailsDict setObject:[_lastnameText.text stringByTrimmingCharactersInSet:
                                         [NSCharacterSet whitespaceCharacterSet]] forKey:@"lastName"];
                 [detailsDict setObject:[_phoneNumText.text stringByTrimmingCharactersInSet:
                                         [NSCharacterSet whitespaceCharacterSet]] forKey:@"phoneNumber"];
                 [detailsDict setObject:[_emailText.text stringByTrimmingCharactersInSet:
                                         [NSCharacterSet whitespaceCharacterSet]] forKey:@"email"];
                 
                 // licensenumber, licensestate and qualification not required
                 
                 /*[detailsDict setObject:[_stateText.text stringByTrimmingCharactersInSet:
                  [NSCharacterSet whitespaceCharacterSet]] forKey:@"licensureState"];
                  
                  if([_licenceText.text isEqualToString:@""]){
                  }
                  else{
                  [detailsDict setObject:[_licenceText.text stringByTrimmingCharactersInSet:
                  [NSCharacterSet whitespaceCharacterSet]] forKey:@"licenseNumber"];
                  }
                  [detailsDict setObject:[_qualificationText.text stringByTrimmingCharactersInSet:
                  [NSCharacterSet whitespaceCharacterSet]] forKey:@"qualification"]; */
                 
                 
                 [detailsDict setObject:[_dobText.text stringByTrimmingCharactersInSet:
                                         [NSCharacterSet whitespaceCharacterSet]] forKey:@"dob"];
                 [detailsDict setObject:[_SSNText.text stringByTrimmingCharactersInSet:
                                         [NSCharacterSet whitespaceCharacterSet]] forKey:@"ssn"];
                 
                 [detailsDict setObject:imagePath forKey:@"profilePicPath"];
                 
                 ProviderSignUpSecondViewController *vc=[self.storyboard instantiateViewControllerWithIdentifier:@"signUpSecond"];
                 vc.providerDetails=detailsDict;
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
    }
}


//  Added by: zeenath
//  Added Date: 25/8/16
//  Description: Set validation design

-(void)SetValidationSettinds:(UITextField *)textField errorIcon:(UIButton *)errorBtn indicationIcon:(UIImageView *)indicationIcon validationMessage:(NSString *)validationMessage imageIs:(NSString *)imageIs viewField:(UIView *)viewIs{
    
    [textField setValue:[UIColor redColor] forKeyPath:@"_placeholderLabel.textColor"];
    textField.placeholder=validationMessage;
    errorBtn.hidden=NO;
    UIImage *image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:imageIs ofType:@"png"]];
    indicationIcon.image = image;
    viewIs.layer.borderColor = [[UIColor redColor]CGColor];
    viewIs.layer.borderWidth = 1.0f;
}

//Hides the soft keypad
- (BOOL)textFieldShouldReturn:(UITextField *)theTextField {
    if (theTextField == self.firstnameText) {
        [self.lastnameText becomeFirstResponder];
    }
    if (theTextField == self.lastnameText) {
        [self.phoneNumText becomeFirstResponder];
          }
    if (theTextField == self.phoneNumText) {
        [self.emailText becomeFirstResponder];
        //[self.phoneNumText becomeFirstResponder];
    } if (theTextField == self.emailText) {
        //[self.usernameText becomeFirstResponder];
         [theTextField resignFirstResponder];
    }   if (theTextField == self.usernameText) {
        [self.licenceText becomeFirstResponder];
    }   if (theTextField == self.licenceText) {
        [self.SSNText becomeFirstResponder];    }
    if (theTextField == self.SSNText) {
        [theTextField resignFirstResponder];    }
    
    return YES;
}


//  Added by: zeenath
//  Added Date: 25/8/16
//  Description: Close the validation design on click of error icon in input field

- (IBAction)firstNameCloseButton:(id)sender {
    [self RemoveValidationSettings:_firstnameText errorIcon:_firstnameCloseButton indicationIcon:_firstNameIcon HintText:@"First name" imageIs:@"user" viewField:_providerFirstNameView];
}

- (IBAction)lastNameClose:(id)sender {
    [self RemoveValidationSettings:_lastnameText errorIcon:_lastnameCloseButton indicationIcon:_lastNameIcon HintText:@"Last name" imageIs:@"user" viewField:_providerLastNameView];
}
- (IBAction)phoneNumberClose:(id)sender {
    [self RemoveValidationSettings:_phoneNumText errorIcon:_phoneNumberCloseButton indicationIcon:_phoneNumberIcon HintText:@"Phone Number" imageIs:@"user" viewField:_providerPhoneNumberView];
}
- (IBAction)emailClose:(id)sender {
    
    [self RemoveValidationSettings:_emailText errorIcon:_emailCloseButton indicationIcon:_emailIcon HintText:@"Email" imageIs:@"user" viewField:_providerEmailView];
}
- (IBAction)dobClose:(id)sender {
    
    [self RemoveValidationSettings:_dobText errorIcon:_dobCloseButton indicationIcon:_dobIcon HintText:@"Date of birth" imageIs:@"user" viewField:_providerDobView];
}
- (IBAction)SSNClose:(id)sender {
    
    [self RemoveValidationSettings:_SSNText errorIcon:_SSNCloseButton indicationIcon:_SSNIcon HintText:@"SSN" imageIs:@"user" viewField:_providerSSNView];
}


/*
 - (IBAction)userNameClose:(id)sender {
 [self RemoveValidationSettings:_usernameText errorIcon:_usernameCloseButton indicationIcon:_userNameIcon HintText:@"Username" imageIs:@"user" viewField:_providerUsernameView];
 }
 - (IBAction)stateClose:(id)sender {
 [self RemoveValidationSettings:_stateText errorIcon:_stateCloseButton indicationIcon:_stateIcon HintText:@"State of licensure" imageIs:@"state-licence" viewField:_providerStateView];
 }
 - (IBAction)licenceClose:(id)sender {
 [self RemoveValidationSettings:_licenceText errorIcon:_licenceCloseButton indicationIcon:_licenceIcon HintText:@"Licence number" imageIs:@"licence" viewField:_providerLicenceNumberView];
 }
 
 - (IBAction)qualificationClose:(id)sender {
 [self RemoveValidationSettings:_qualificationText errorIcon:_qualificationButton indicationIcon:_qualificationIcon HintText:@"Specialty" imageIs:@"qualification" viewField:_providerQualificationView];
 
 }  */

//  Added by: zeenath
//  Added Date: 25/8/16
//  Description: Remove validation design

-(void)RemoveValidationSettings:(UITextField *)textField errorIcon:(UIButton *)errorBtn indicationIcon:(UIImageView *)indicationIcon HintText:(NSString *)hintTextMessage imageIs:(NSString *)imageIs viewField:(UIView *)view{
    
    [textField setValue:[UIColor  colorWithRed:(112/255.0) green:(112/255.0) blue:(112/255.0) alpha:1] forKeyPath:@"_placeholderLabel.textColor"];
    textField.placeholder=hintTextMessage;
    errorBtn.hidden=YES;
    UIImage *image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:imageIs ofType:@"png"]];
    indicationIcon.image = image;
    [self setBorder:view];
    
}


//  Added by: zeenath
//  Added Date: 25/8/16
//  Description: validation pattern to the input field

- (BOOL)validateNameField:(NSString*)name
{
    NSString *nameRegex = @"^[a-zA-Z ]*$";
    NSPredicate *nameTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", nameRegex];
    return [nameTest evaluateWithObject:name];
}


- (BOOL)validateEmail:(NSString*)email
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}

- (BOOL)validatPhoneNumber:(NSString*)PhoneNumber
{
    NSString *PhoneNumberRegex = @"(^[0-9]+$)";
    NSPredicate *PhoneNumberTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", PhoneNumberRegex];
    return [PhoneNumberTest evaluateWithObject:PhoneNumber];
}

- (BOOL)validatSSN:(NSString*)SSN
{
    NSString *SSNRegex = @"(^[0-9]{3}-[0-9]{2}-[0-9]{4}$)";
    NSPredicate *SSNTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", SSNRegex];
    return [SSNTest evaluateWithObject:SSN];
}


//- (BOOL)validatlicenseNumber:(NSString*)licenseNumber
//{
// if(![_licenceText.text isEqualToString:@""])
// {
// NSString *licenceNumberRegex = @"(^[a-z0-9]*$)";
// NSPredicate *licenseNumberTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", licenceNumberRegex];
//return [licenseNumberTest evaluateWithObject:licenseNumber];
/* }
 else if([_licenceText.placeholder isEqualToString:@"Please enter a valid license Number."])
 {
 return false;
 }
 else{
 return true;
 }*/
//}

/*
 - (BOOL)validateUsername:(NSString*)userName
 {
 NSString *usernameRegExp =@"(^[A-Za-z0-9]*$)";
 NSPredicate *usernameTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", usernameRegExp];
 return [usernameTest evaluateWithObject:userName];
 } */

//  Added by: zeenath
//  Added Date: 25/8/16
//  Description: Remove validation set on change of text field

-(void) textFielddidChange:(UITextField *)theTextField
{
    if([theTextField isEqual:_firstnameText])
    {
        [self RemoveValidationSettings:_firstnameText errorIcon:_firstnameCloseButton indicationIcon:_firstNameIcon HintText:@"First name" imageIs:@"user" viewField:_providerFirstNameView];
        
    }else if([theTextField isEqual:_lastnameText])
    {
        [self RemoveValidationSettings:_lastnameText errorIcon:_lastnameCloseButton indicationIcon:_lastNameIcon HintText:@"Last name" imageIs:@"user" viewField:_providerLastNameView];
        
    }else if([theTextField isEqual:_phoneNumText])
    {
        [self RemoveValidationSettings:_phoneNumText errorIcon:_phoneNumberCloseButton indicationIcon:_phoneNumberIcon HintText:@"Phone Number" imageIs:@"user" viewField:_providerPhoneNumberView];
        
    }else if([theTextField isEqual:_emailText])
    {
        [self RemoveValidationSettings:_emailText errorIcon:_emailCloseButton indicationIcon:_emailIcon HintText:@"Email" imageIs:@"email" viewField:_providerEmailView];
        
        
    } 
    else if([theTextField isEqual:_dobText])
    {
        [_pickerBackView setHidden:NO];
        [self RemoveValidationSettings:_dobText errorIcon:_dobCloseButton indicationIcon:_dobIcon HintText:@"Date of Birth" imageIs:@"dob" viewField:_providerDobView];
        
    }
    else if([theTextField isEqual:_SSNText])
    {
        [_pickerBackView setHidden:NO];
        [self RemoveValidationSettings:_SSNText errorIcon:_SSNCloseButton indicationIcon:_SSNIcon HintText:@"SSN" imageIs:@"user" viewField:_providerSSNView];
        _pickerBackView.hidden=YES;
        
    }
}

//  Added by: zeenath
//  Added Date: 25/8/16
//  Description: changes in input fields on change of text fields

- (BOOL) textFieldShouldBeginEditing:(UITextField *)textField
{
    if(textField == _dobText )
    {
      [self resignSoftKeyboard];
       [_dobText resignFirstResponder];
        _pickerBackView.hidden=NO;
        [_pickerView setHidden:NO];
        [_datePicker setHidden:NO];
        [_datePickerButtonView setHidden:NO];
        return NO;
        
    }
    
    return YES;
}

//  Added by: zeenath
//  Added Date: 15/9/16
//  Description:  Restrict entry to format 123-45-7890


- (BOOL)textField:(UITextField *)textField
shouldChangeCharactersInRange:(NSRange)range
replacementString:(NSString *)string {
    if(textField == _SSNText)
    {
        // All digits entered
        if (range.location == 11) {
            return NO;
        }
        
        // Reject appending non-digit characters
        if (range.length == 0 &&
            ![[NSCharacterSet decimalDigitCharacterSet] characterIsMember:[string characterAtIndex:0]]) {
            return NO;
        }
        
        // Auto-add hyphen before appending 4rd or 7th digit
        if (range.length == 0 &&
            (range.location == 3 || range.location == 6)) {
            _SSNText.text = [NSString stringWithFormat:@"%@-%@", textField.text, string];
            return NO;
        }
        
        // Delete hyphen when deleting its trailing digit
        if (range.length == 1 &&
            (range.location == 4 || range.location == 7))  {
            range.location--;
            range.length = 2;
            _SSNText.text = [textField.text stringByReplacingCharactersInRange:range withString:@""];
            return NO;
        }
    }
    return YES;
}


//  Added by: zeenath
//  Added Date: 25/8/16
//  Description: Drop down button click to pop a picker

/*
 - (IBAction)stateDropdownButton:(id)sender {
 
 _pickerArray = [[NSMutableArray alloc]initWithObjects:@"Alabama",
 @"Alaska",@"Arizona",@"Arkansas",@"California",@"Colorado",
 @"Connecticut",
 @"Delaware",
 @"Florida",
 @"Georgia",
 @"Hawaii",
 @"Idaho",
 @"Illinois",
 @"Indiana",
 @"Iowa",
 @"Kansas",
 @"Kentucky[D]",
 @"Louisiana",
 @"Maine",
 @"Maryland",
 @"Massachusetts",
 @"Michigan",
 @"Minnesota",
 @"Mississippi",
 @"Missouri",
 @"Montana",
 @"Nebraska",
 @"Nevada",
 @"New Hampshire",
 @"New Jersey",
 @"New Mexico",
 @"New York",
 @"North Carolina",
 @"North Dakota",
 @"Ohio",
 @"Oklahoma",
 @"Oregon",
 @"Pennsylvania[F]",@"Rhode Island[G]",
 @"South Carolina",
 @"South Dakota",
 @"Tennessee",
 @"Texas",
 @"Utah",
 @"Vermont",@"Virginia[H]",
 @"Washington",@"West Virginia",@"Wisconsin",@"Wyoming",
 nil];
 [self.pickerView reloadAllComponents];
 
 clickedbutton=@"stateDropdown";
 _pickerBackView.hidden=NO;
 [_pickerView setHidden:NO];
 [_datePicker setHidden:YES];
 [_datePickerButtonView setHidden:YES];
 }
 
 - (IBAction)qualificationDownArrowButton:(id)sender {
 _pickerArray=[[NSMutableArray alloc]init];
 _pickerArray = [[NSMutableArray alloc]initWithObjects:@"Phd/MD",
 @"PSYD",@"MSW",@"LCSW",@"Licensed Counselor", nil];
 clickedbutton=@"qualificationDropdown";
 [self.pickerView reloadAllComponents];
 
 _pickerBackView.hidden=NO;
 [_pickerView setHidden:NO];
 [_datePicker setHidden:YES];
 [_datePickerButtonView setHidden:YES];
 }
 
 //Returns the number of sections in picker view
 - (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)thePickerView {
 return 1;
 }
 
 //Returns the number of rows to the picker
 - (NSInteger)pickerView:(UIPickerView *)thePickerView numberOfRowsInComponent:(NSInteger)component {
 return [_pickerArray count];
 }
 
 //Returns the data to the picker
 - (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:
 (NSInteger)row forComponent:(NSInteger)component{
 return [_pickerArray objectAtIndex:row];
 }
 
 //Returns the selected rows to the picker
 - (void)pickerView:(UIPickerView *)thePickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
 [_pickerView selectRow:0 inComponent:0 animated:YES];
 
 if([clickedbutton isEqualToString:@"stateDropdown"])
 {
 [_stateText setText:[_pickerArray objectAtIndex:row]];
 [self RemoveValidationSettings:_stateText errorIcon:_stateCloseButton indicationIcon:_stateIcon HintText:@"State of licensure" imageIs:@"state-licence" viewField:_providerStateView];
 
 }
 else if([clickedbutton isEqualToString:@"qualificationDropdown"])
 {
 [_qualificationText setText:[_pickerArray objectAtIndex:row]];
 [self RemoveValidationSettings:_qualificationText errorIcon:_qualificationButton indicationIcon:_qualificationIcon HintText:@"Specialty" imageIs:@"qualification" viewField:_providerQualificationView];
 }
 _pickerBackView.hidden=YES;
 
 }
 */

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    // svos = _scrollView.contentOffset;
    CGPoint pt;
    CGRect rc = [textField bounds];
    rc = [textField convertRect:rc toView:_scrollView];
    pt = rc.origin;
    pt.x = 0;
    pt.y -= -5;
    [_scrollView setContentOffset:pt animated:YES];
}


//  Added by: zeenath
//  Added Date: 25/8/16
//  Description: Remove validation set on click of error icon

- (IBAction)dobCloseClick:(id)sender {
    [_dobDropIcon setHidden:NO];
    [self RemoveValidationSettings:_dobText errorIcon:_dobCloseButton indicationIcon:_dobIcon HintText:@"Date of birth" imageIs:@"dob" viewField:_providerDobView];
}
- (IBAction)SSNCloseClick:(id)sender {
    [self RemoveValidationSettings:_SSNText errorIcon:_SSNCloseButton indicationIcon:_SSNIcon HintText:@"SSN" imageIs:@"user" viewField:_providerSSNView];
}

//  Added by: zeenath
//  Added Date: 25/8/16
//  Description: Display the date picker pop up

- (IBAction)datePickerClick:(id)sender {
    [_pickerBackView setHidden:NO];
    [_pickerView setHidden:YES];
    [_datePicker setHidden:NO];
    [_datePickerButtonView setHidden:NO];
    
}

//On click of set button
- (IBAction)setDateClick:(id)sender {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"MM/dd/yyyy"];
    NSString *dateOfBirth = [dateFormatter stringFromDate:self.datePicker.date];
    _dobText.text=dateOfBirth;
    [_pickerBackView setHidden:YES];
    [_datePicker setHidden:YES];
    [_datePickerButtonView setHidden:YES];
    [self RemoveValidationSettings:_dobText errorIcon:_dobCloseButton indicationIcon:_dobIcon HintText:@"Date of birth" imageIs:@"dob" viewField:_providerDobView];
    [self.SSNText becomeFirstResponder];
    [self resignSoftKeyboard ];
}

//On click of cancel button in date picker
- (IBAction)cancelDateClick:(id)sender {
    [_pickerBackView setHidden:YES];
    [_datePicker setHidden:YES];
    [_datePickerButtonView setHidden:YES];
    [self.SSNText becomeFirstResponder];
    [self resignSoftKeyboard];
}

- (IBAction)dateofbirthClick:(id)sender {
    [self resignSoftKeyboard];
}

//  Added by: zeenath
//  Added Date: 25/8/16
//  Description: To start the loading indicator

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

//  Added by: zeenath
//  Added Date: 25/8/16
//  Description: To stop the loading indicator

-(void)stopLoadingIndicator
{
    
    _loadingView.hidden=YES;
}

- (IBAction)backClick:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)cameraClick:(id)sender {
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:
                                @"GeneralStoryboard" bundle:nil];
    
    PhotopopupViewController *photopopup=[storyboard instantiateViewControllerWithIdentifier:@"photopopup"];
    photopopup.delegate=self;
    self.modalPresentationStyle = UIModalPresentationFullScreen;
    
    photopopup.modalPresentationStyle = UIModalPresentationOverCurrentContext;
    
    [self presentViewController:photopopup animated:NO completion:nil];
    
    
}
-(void)resignSoftKeyboard{
    [_firstnameText resignFirstResponder];
    [_lastnameText resignFirstResponder];
    [_phoneNumText resignFirstResponder];
    [_emailText resignFirstResponder];
    [_SSNText resignFirstResponder];
    [_dobText resignFirstResponder];
    [_SSNText resignFirstResponder];
}

- (IBAction)dobDropClick:(id)sender {
}
@end
