/***************************************************************
 Page name: ProviderProfileViewController.m
 Created By: nalina
 Created Date:7/07/16
 Description: provider profile implementation file
 ***************************************************************/

#import "ProviderProfileViewController.h"
#import "ProviderProfileSecondViewController.h"
#import "GlobalFunction.h"
#import <Google/Analytics.h>
#import "AppDelegate.h"
#import "PhotopopupViewController.h"


@interface ProviderProfileViewController ()<PhotopopupViewControllerDelegate>
{
    UIImage *bindimage;
    
    
}

@end

@implementation ProviderProfileViewController

- (void)dataFromController:(UIImage *)data
{
    //bindimage = data;
    [self startLoadingIndicator];
    
    _profilePicView.layer.cornerRadius = 10;
    _profilePicView.layer.masksToBounds = YES;
    _profilePicView.image = data;
    
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    // or @"yyyy-MM-dd hh:mm:ss a" if you prefer the time with AM/PM
    NSLog(@"%@",[dateFormatter stringFromDate:[NSDate date]]);
    NSString *s = [dateFormatter stringFromDate:[NSDate date]];
    NSCharacterSet *doNotWant = [NSCharacterSet characterSetWithCharactersInString:@"/:- "];
    s = [[s componentsSeparatedByCharactersInSet: doNotWant] componentsJoinedByString: @""];
    NSLog(@"%@", s);
    
    NSString *name=s;
    
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



//Loads for the first time when page appears
- (void)viewDidLoad {
    
    
    _dumyTxtVw.hidden = YES;
    
    [self setBorderColor:5];
    
    
    UIImage *backgroundImage = [UIImage imageNamed:@"06. Appointment Confirmation.png"];
    UIImageView *backgroundImageView=[[UIImageView alloc]initWithFrame:self.view.frame];
    backgroundImageView.image=backgroundImage;
    [self.view insertSubview:backgroundImageView atIndex:0];

    _firstnameTxt.delegate = self;
    _emailTxt.delegate = self;
    _licence.delegate = self;
    _qualifications.delegate = self;
    _dateOfBirthTxt.delegate = self;
    _ssn.delegate = self;
    
   // _lastnameTxt.delegate = self;
    //_aboutYourselfText.delegate=self;
    
    [self.firstnameTxt addTarget:self action:@selector(RemoveValidation:) forControlEvents:UIControlEventAllTouchEvents];
    [self.firstnameTxt addTarget:self action:@selector(RemoveValidation:) forControlEvents:UIControlEventEditingChanged];
    
    [self.emailTxt addTarget:self action:@selector(RemoveValidation:) forControlEvents:UIControlEventAllTouchEvents];
    [self.emailTxt addTarget:self action:@selector(RemoveValidation:) forControlEvents:UIControlEventEditingChanged];
    
    
    [self.licence addTarget:self action:@selector(RemoveValidation:) forControlEvents:UIControlEventAllTouchEvents];
    [self.licence addTarget:self action:@selector(RemoveValidation:) forControlEvents:UIControlEventEditingChanged];
    
    [self.qualifications addTarget:self action:@selector(RemoveValidation:) forControlEvents:UIControlEventAllTouchEvents];
    [self.qualifications addTarget:self action:@selector(RemoveValidation:) forControlEvents:UIControlEventEditingChanged];
    
    
    [self.dateOfBirthTxt addTarget:self action:@selector(RemoveValidation:) forControlEvents:UIControlEventAllTouchEvents];
    [self.dateOfBirthTxt addTarget:self action:@selector(RemoveValidation:) forControlEvents:UIControlEventEditingChanged];
    
    
    [self.ssn addTarget:self action:@selector(RemoveValidation:) forControlEvents:UIControlEventAllTouchEvents];
    [self.ssn addTarget:self action:@selector(RemoveValidation:) forControlEvents:UIControlEventEditingChanged];
    
    
    
    
    
   /* [self.lastnameTxt addTarget:self action:@selector(RemoveValidation:) forControlEvents:UIControlEventAllTouchEvents];
    [self.lastnameTxt addTarget:self action:@selector(RemoveValidation:) forControlEvents:UIControlEventEditingChanged]; */
    
    [_datePicker setBackgroundColor:[UIColor whiteColor]];
    _datePicker.maximumDate=[NSDate date];
    
    /*  UITapGestureRecognizer *singleFingerTap =
     [[UITapGestureRecognizer alloc] initWithTarget:self
     action:@selector(handleSingleTapped:)];
     [self.pickerBackView addGestureRecognizer:singleFingerTap];*/
    
    [self.qualifications addTarget:self action:@selector(monthClick:) forControlEvents:UIControlEventEditingDidBegin];
    
    /*  UITapGestureRecognizer *dateTap =
     [[UITapGestureRecognizer alloc] initWithTarget:self
     action:@selector(datepickerClickProvider:)];
     [self.dateOfBirthTxt addGestureRecognizer:dateTap]; */
    
    
    
    //Added by: zeenath
    //Added Date: 19/08/2016
    //Discription: Service call to get the data of the provider
    
    AppDelegate *appdelegate=(AppDelegate *)[[UIApplication sharedApplication]delegate];
    NSString *UrlBankingInfo=[appdelegate.serviceURL stringByAppendingString:@"/api/Provider/ProviderInfo"];
    [self startLoadingIndicator];
    
    [[GlobalFunction sharedInstance]getServerResponseAfterLogin:UrlBankingInfo method:@"GET" param:nil withCallback:^(NSInteger statusCode, NSDictionary *response, NSError *error) {
        [self stopLoadingIndicator];
        
        NSDictionary *personaInfo=[response objectForKey:@"personalDetails"];
        
        NSLog(@"personaInfo%@",personaInfo);
        if(![[response valueForKey:@"providerInfo"] isEqual:[NSNull null]])
        {
            providerInfo=[response objectForKey:@"providerInfo"];
            
            if(![[providerInfo valueForKey:@"aboutSelf"] isEqual:[NSNull null]]){
                _aboutYourselfText.text=[providerInfo valueForKey:@"aboutSelf"];
                _aboutYourselfText.textColor = [UIColor colorWithRed:51.0/255.0 green:51.0/255.0 blue:51.0/255.0 alpha:1.0];
            }
            
           /* if(!([[providerInfo valueForKey:@"gender"] isEqual:[NSNull null]]))
            {
                _genderTxt.text=[providerInfo valueForKey:@"gender"];
            } */
        }
        name=[personaInfo valueForKey:@"firstName"];
        _firstnameTxt.text=[personaInfo valueForKey:@"firstName"];
        _emailTxt.text=[personaInfo valueForKey:@"email"];
        _licence.text=[providerInfo valueForKey:@"licenseNumber"];
        _qualifications.text=[providerInfo valueForKey:@"qualification"];
        phoneNumberVal=[personaInfo valueForKey:@"phoneNumber"];
        lastNameVal=[personaInfo valueForKey:@"lastName"];
        userNameVal=[personaInfo valueForKey:@"userName"];
        
        if ([[personaInfo valueForKey:@"dob"] isEqual:[NSNull null]]) {
            _dateOfBirthTxt.text=@"";
        }else{
            
            NSString *getDate=[appdelegate.usersDetails objectForKey:@"dob"];
            
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
            [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss"];
            NSDate *dateFromString = [[NSDate alloc] init];
            dateFromString = [dateFormatter dateFromString:getDate];
            NSDateFormatter *format = [[NSDateFormatter alloc] init];
            format.dateFormat = @"MM/dd/yyyy";
            _dateOfBirthTxt.text=[format stringFromDate:dateFromString];
        }
        
        
        
        if ([[personaInfo valueForKey:@"profilePicPath"] isEqual:[NSNull null]]) {
            imagePath=@"";
        }else{
            
            NSString *nameImage=[appdelegate.usersDetails objectForKey:@"profilePicPath"];
            NSString *imagename=[appdelegate.imageURL stringByAppendingString:nameImage];
            dispatch_queue_t imagequeue =dispatch_queue_create("imageDownloader", nil);
            dispatch_async(imagequeue, ^{
                
                //download iamge
                NSData *imageData = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:imagename]];
                UIImage *image = [[UIImage alloc] initWithData:imageData];
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    if (image==NULL) {
                        UIImage *image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"upload-profile" ofType:@"png"]];
                        _profilePicView.image  = image;
                    }
                    else{
                        _profilePicView.image  = image;
                    }
                });
                
            });
            imagePath=nameImage;
        }
        [self stopLoadingIndicator];
    }];
    
    _datePicker.maximumDate=[NSDate date];
    [super viewDidLoad];
}

- (void)monthClick:(UITapGestureRecognizer *)recognizer {
   
    dataSource=[[NSArray alloc]initWithObjects:@"Phd/MD",
                @"PSYD",@"MSW",@"LCSW",@"Licensed Counselor", nil];
    [self.pickerView reloadAllComponents];
    _pickerBackView.hidden=NO;
    _datePicker.hidden = YES;
    [self setBorder:_pickerBackView];
    [_qualifications setValue:[UIColor  colorWithRed:(112/255.0) green:(112/255.0) blue:(112/255.0) alpha:1] forKeyPath:@"_placeholderLabel.textColor"];
    _qualifications.placeholder=@"";
      [self.dumyTxtVw becomeFirstResponder];
     [self resignSoftKeyboard];
}


- (void)handleSingleTapped:(UITapGestureRecognizer *)recognizer {
    _datePickerBackView.hidden=YES;
    _pickerView.hidden = YES;
}

//Return number of section in picker
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)thePickerView {
    
    return 1;
}

//Return the number of rows count to display in picker
- (NSInteger)pickerView:(UIPickerView *)thePickerView numberOfRowsInComponent:(NSInteger)component {
    
    return dataSource.count;
    
}

//Return the data to display in picker
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:
(NSInteger)row forComponent:(NSInteger)component{
    return [dataSource objectAtIndex:row];
}

//Returns selected picker data
- (void)pickerView:(UIPickerView *)thePickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    [_pickerView selectRow:0 inComponent:0 animated:YES];

    [_qualifications setText:[dataSource objectAtIndex:row]];
    _pickerBackView.hidden=YES;
    
    [self.firstnameTxt becomeFirstResponder];
    [self resignSoftKeyboard];
}

-(void)resignSoftKeyboard{
    [_qualifications resignFirstResponder];
    [_firstnameTxt resignFirstResponder];
    [_lastnameTxt resignFirstResponder];
    [_emailTxt resignFirstResponder];
    [_genderTxt resignFirstResponder];
    [_dateOfBirthTxt resignFirstResponder];
    [_dumyTxtVw resignFirstResponder];
    [_licence resignFirstResponder];

    
    
}

-(void)setBorder:(UIView *)img
{
    
    img.layer.borderColor = [[UIColor colorWithRed:228.0/255.0 green:109.0/255.0 blue:175.0/255.0 alpha:1.0]CGColor];
    img.layer.borderWidth = 1.0f;
    
}



//Return number of section in picker view
/*- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)thePickerView {
    
    return 1;
}

//Return the number of rows count to display in picker
- (NSInteger)pickerView:(UIPickerView *)thePickerView numberOfRowsInComponent:(NSInteger)component {
    
    return [pickerArray count];
}

//Return the data to display in picker
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:
(NSInteger)row forComponent:(NSInteger)component{
    return [pickerArray objectAtIndex:row];
}


//Return the data selected in picker
- (void)pickerView:(UIPickerView *)thePickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    [_genderPicker selectRow:0 inComponent:0 animated:YES];
    [_genderTxt setText:[pickerArray objectAtIndex:row]];
    _datePickerBackView.hidden=YES;
    
} */
//Added by: Nalina
//Added Date: 12/08/2016
//Discription: To show the picker on touch of input fields

/*- (void)handleSingleTapped:(UITapGestureRecognizer *)recognizer {
    _datePickerBackView.hidden=YES;
}*/

- (void)handlegenderTapped:(UITapGestureRecognizer *)recognizer {
    _datePickerBackView.hidden=NO;
    _genderPicker.hidden=NO;
}

- (void)handledateTapped:(UITapGestureRecognizer *)recognizer {
    [_firstnameTxt resignFirstResponder];
    [_lastnameTxt resignFirstResponder];
    _datePickerBackView.hidden=NO;
    _datePicker.hidden=NO;
    _datePickerButtonBackView.hidden=NO;
    _photoPopupView.hidden=YES;
    _genderPicker.hidden=YES;
    _pickerBackView.hidden=NO;
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



//Added by: Nalina
//Added Date: 7/7/2016
//Discription: To validate name field pattern

- (BOOL)validateNameField:(NSString*)name
{
    NSString *nameRegex = @"^[a-zA-Z ]*$";
    NSPredicate *nameTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", nameRegex];
    return [nameTest evaluateWithObject:name];
}


//Added by: Nalina
//Added Date:7/7/2016
//Discription: Set the border to the input fields

/*-(void)setBorder:(UIView *)view
{
    /*view.layer.borderColor = [[UIColor colorWithRed:228.0/255.0 green:109.0/255.0 blue:175.0/255.0 alpha:1.0]CGColor];
    view.layer.borderWidth = 1.0f;*/
    
/*    [_qualifications setValue:[UIColor  colorWithRed:(112/255.0) green:(112/255.0) blue:(112/255.0) alpha:1] forKeyPath:@"_placeholderLabel.textColor"];
    _qualifications.placeholder=@"";
}

-(void)resignSoftKeyboard{
    [_qualifications resignFirstResponder];
    
}*/



//Loads each time page appears
-(void)viewWillAppear:(BOOL)animated{
    //self.profilePicView.layer.cornerRadius = self.profilePicView.frame.size.width / 2;
    self.profilePicView.clipsToBounds = YES;
    [self setBorder:_firstnameView];
    [self setBorder:_emailView];
    [self setBorder:_licenceView];
    [self setBorder:_qualificationsView];
    [self setBorder:_dateOfBirthView];
    [self setBorder:_ssnView];
    
    
  /*  [self setBorder:_lastnameView];
    [self setBorder:_genderView];
    [self setBorder:_aboutYourselfView]; */
    
  /*  _aboutYourselfText.text = @"About your professional interest, experience, etc.";
    _aboutYourselfText.textColor = [UIColor colorWithRed:112.0/255.0 green:112.0/255.0 blue:112.0/255.0 alpha:1.0]; */
    
    id<GAITracker> tracker = [[GAI sharedInstance] defaultTracker];
    [tracker set:kGAIScreenName value:@"ProviderProfile"];
    [tracker send:[[GAIDictionaryBuilder createScreenView] build]];
    
    AppDelegate *appdelegate=(AppDelegate *)[[UIApplication sharedApplication]delegate];
    
   /* if(appdelegate.prepopulateImage != nil){
        
        
        NSString *aboutSelf=appdelegate.prepopulateImage;
        _aboutYourselfText.text=aboutSelf;
        
        _aboutYourselfText.textColor = [UIColor blackColor];
    }
    else
    {
        if(![[providerInfo valueForKey:@"aboutSelf"] isEqual:[NSNull null]]){
            _aboutYourselfText.text=[providerInfo valueForKey:@"aboutSelf"];
            _aboutYourselfText.textColor = [UIColor colorWithRed:51.0/255.0 green:51.0/255.0 blue:51.0/255.0 alpha:1.0];
        }
    } */
    
    
}

//Calls when user clicks on back icon in header
- (IBAction)pageBackClick:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

//Added by: Nalina
//Added Date:7/7/2016
//Discription: Clears the data in input fields on click of error button

- (IBAction)firstnameErrorClose:(id)sender {
    [self RemoveValidationSettings:_firstnameTxt errorIcon:_firstnameError indicationIcon:_firstnameIcon HintText:@"First name" imageIs:@"user" viewField:_firstnameView];
}


- (IBAction)genderPickerClick:(id)sender {
    _datePickerBackView.hidden=NO;
    _genderPicker.hidden=NO;
}

- (IBAction)emailErrorClose:(id)sender {
    [self RemoveValidationSettings:_emailTxt errorIcon:_emailError indicationIcon:_emailIcon HintText:@"Email" imageIs:@"email" viewField:_emailView];
}
- (IBAction)dobErrorClose:(id)sender {
    [self RemoveValidationSettings:_dateOfBirthTxt errorIcon:_dobError indicationIcon:_dobIcon HintText:@"Date of Birth" imageIs:@"dob" viewField:_dateOfBirthView];
}

- (IBAction)dateOfBirthPicker:(id)sender {
    [_firstnameTxt resignFirstResponder];
    //[_lastnameTxt resignFirstResponder];
    _datePickerBackView.hidden=NO;
    _datePicker.hidden=NO;
    _datePickerButtonBackView.hidden=NO;
    _photoPopupView.hidden=YES;
    _genderPicker.hidden=YES;
    _pickerBackView.hidden = YES;
    _datePickerButtonBackView.hidden = NO;
    _pickerView.hidden = YES;
    _pickerBackView.hidden=YES;
}


- (IBAction)qualificationErrorClose:(id)sender {
    [self RemoveValidationSettings:_qualifications errorIcon:_qualificationError indicationIcon:_qualificationIcon HintText:@"Qualification" imageIs:@"qualification" viewField:_qualificationsView];
}


- (IBAction)licenceErrorClose:(id)sender {
    [self RemoveValidationSettings:_licence errorIcon:_licenceError indicationIcon:_licenceIcon HintText:@"Licence Number" imageIs:@"licence" viewField:_licenceView];
}

- (IBAction)ssnErrorClose:(id)sender {
    [self RemoveValidationSettings:_ssn errorIcon:_ssnError indicationIcon:_ssnIcon HintText:@"SSN Number" imageIs:@"ssn" viewField:_ssnView];
}




/* - (IBAction)lastnameErrorClose:(id)sender {
    [self RemoveValidationSettings:_lastnameTxt errorIcon:_lastnameError indicationIcon:_lastnameIcon HintText:@"Last name" imageIs:@"user" viewField:_lastnameView];
}

- (IBAction)genderPickerClick:(id)sender {
    _datePickerBackView.hidden=NO;
    _genderPicker.hidden=NO;
}*/





//Added by: Nalina
//Added Date:7/7/2016
//Discription: Remove validation design in input fields

-(void)RemoveValidation:(UITextField *)theTextField{
    if([theTextField isEqual: _firstnameTxt]){
        
        [self RemoveValidationSettings:_firstnameTxt errorIcon:_firstnameError indicationIcon:_firstnameIcon HintText:@"First name" imageIs:@"user" viewField:_firstnameView];
        
    }/*else if([theTextField isEqual: _lastnameTxt]){
        
        [self RemoveValidationSettings:_lastnameTxt errorIcon:_lastnameError indicationIcon:_lastnameIcon HintText:@"Last name" imageIs:@"user" viewField:_lastnameView];
        
    }*/
    
    
    else if([theTextField isEqual: _emailTxt]){
        
        [self RemoveValidationSettings:_emailTxt errorIcon:_emailError indicationIcon:_emailIcon HintText:@"Email" imageIs:@"email" viewField:_emailView];
        
    }else if([theTextField isEqual: _licence]){
        
        [self RemoveValidationSettings:_licence errorIcon:_licenceError indicationIcon:_licenceIcon HintText:@"Licence" imageIs:@"licence" viewField:_emailView];
        
    }else if([theTextField isEqual: _qualifications]){
        
        [self RemoveValidationSettings:_qualifications errorIcon:_qualificationError indicationIcon:_qualificationIcon HintText:@"Qualifications" imageIs:@"qualification" viewField:_qualificationsView];
        
    }else if([theTextField isEqual: _dateOfBirthTxt]){
        
        [self RemoveValidationSettings:_dateOfBirthTxt errorIcon:_dobError indicationIcon:_dobIcon HintText:@"Date of Birth" imageIs:@"dob" viewField:_dateOfBirthView];
        
    }else if([theTextField isEqual: _ssn]){
        
        [self RemoveValidationSettings:_ssn errorIcon:_ssnError indicationIcon:_ssnIcon HintText:@"SSN Number" imageIs:@"ssn" viewField:_ssnView];
        
    }
    
    /*else if([theTextField isEqual: _aboutYourselfText]){
        [self RemoveValidationSettingToTextView:_aboutYourselfText errorIcon:_aboutYourselfError indicationIcon:_aboutYourSelfIcon HintText:@"About your professional interest, experience, etc. " imageIs:@"user" viewField:_aboutYourselfView];
        _aboutYourselfText.textColor = [UIColor darkGrayColor];
    } */
}

//Added by: Nalina
//Added Date:7/7/2016
//Discription: Remove validation design in text view

-(void)RemoveValidationSettingToTextView:(UITextView *)textField errorIcon:(UIButton *)errorBtn indicationIcon:(UIImageView *)indicationIcon HintText:(NSString *)hintTextMessage imageIs:(NSString *)imageIs viewField:(UIView *)view{
    
    [textField setValue:[UIColor  colorWithRed:(112/255.0) green:(112/255.0) blue:(112/255.0) alpha:1] forKeyPath:@"_placeholderLabel.textColor"];
    
    if(![hintTextMessage isEqualToString:@""]){
        textField.text=hintTextMessage;
    }
    
    errorBtn.hidden=YES;
    UIImage *image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:imageIs ofType:@"png"]];
    indicationIcon.image = image;
    [self setBorder:view];
    
}

//Added by: Nalina
//Added Date:7/7/2016
//Discription: Remove validation design

-(void)RemoveValidationSettings:(UITextField *)textField errorIcon:(UIButton *)errorBtn indicationIcon:(UIImageView *)indicationIcon HintText:(NSString *)hintTextMessage imageIs:(NSString *)imageIs viewField:(UIView *)view{
    
    [textField setValue:[UIColor  colorWithRed:(112/255.0) green:(112/255.0) blue:(112/255.0) alpha:1] forKeyPath:@"_placeholderLabel.textColor"];
    textField.placeholder=hintTextMessage;
    errorBtn.hidden=YES;
    UIImage *image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:imageIs ofType:@"png"]];
    indicationIcon.image = image;
    [self setBorder:view];
    
}

//Added by: zeenath
//Added Date:19/08/2016
//Discription: Remove validation on change of text view

/*- (BOOL) textViewShouldBeginEditing:(UITextView *)textView
{
    [self RemoveValidationSettingToTextView:_aboutYourselfText errorIcon:_aboutYourselfError indicationIcon:_aboutYourSelfIcon HintText:@"" imageIs:@"user" viewField:_aboutYourselfView];
    _aboutYourselfText.textColor = [UIColor blackColor];
    
    
    AppDelegate *appdelegate=(AppDelegate *)[[UIApplication sharedApplication]delegate];
    if([_aboutYourselfText.text isEqualToString:@"Please enter about yourself."])
    {
        _aboutYourselfText.text = @"";
        _aboutYourselfText.textColor = [UIColor blackColor];
    }
    else{
        if(appdelegate.prepopulateImage != nil){
            
            
            NSString *aboutSelf=appdelegate.prepopulateImage;
            _aboutYourselfText.text=aboutSelf;
            
            _aboutYourselfText.textColor = [UIColor blackColor];
            
        }
        
    }
    return YES;
}  */


//Added by: zeenath
//Added Date:19/08/2016
//Discription: calls on change of input fields

- (void)textViewDidBeginEditing:(UITextView *)textView{
    
    [self RemoveValidationSettingToTextView:_aboutYourselfText errorIcon:_aboutYourselfError indicationIcon:_aboutYourSelfIcon HintText:@"" imageIs:@"user" viewField:_aboutYourselfView];
    _aboutYourselfText.textColor = [UIColor blackColor];
    
    
    svos = _scrollView.contentOffset;
    CGPoint pt;
    CGRect rc = [textView bounds];
    rc = [textView convertRect:rc toView:_scrollView];
    pt = rc.origin;
    pt.x = 0;
    pt.y -= -5;
    [_scrollView setContentOffset:pt animated:YES];
    AppDelegate *appdelegate=(AppDelegate *)[[UIApplication sharedApplication]delegate];
    
    if([_aboutYourselfText.text isEqualToString:@"Please enter about yourself."])
    {
        _aboutYourselfText.text = @"";
        _aboutYourselfText.textColor = [UIColor blackColor];
    }
    else{
        if(appdelegate.prepopulateImage != nil){
            
            
            NSString *aboutSelf=appdelegate.prepopulateImage;
            _aboutYourselfText.text=aboutSelf;
            
            _aboutYourselfText.textColor = [UIColor blackColor];
            
        }
        
    }
}

//After changinf the text field
/*-(void) textViewDidChange:(UITextView *)textView
{
    if(_aboutYourselfText.text.length == 0){
        _aboutYourselfText.text = @"About your professional interest, experience, etc.";
        AppDelegate *appdelegate=(AppDelegate *)[[UIApplication sharedApplication]delegate];
        appdelegate.prepopulateImage=nil;
        [textView resignFirstResponder];
    }
    
}*/



//Added by: nalina
//Added Date:7/07/2016
//Discription: set validations on input fields

-(void)SetValidationSettingsTextView:(UITextView *)textView errorIcon:(UIButton *)errorBtn indicationIcon:(UIImageView *)indicationIcon validationMessage:(NSString *)validationMessage imageIs:(NSString *)imageIs viewField:(UIView *)viewIs{
    textView.text=validationMessage;
    errorBtn.hidden=NO;
    UIImage *image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:imageIs ofType:@"png"]];
    indicationIcon.image = image;
    textView.textColor=[UIColor redColor];
    viewIs.layer.borderColor = [[UIColor redColor]CGColor];
    viewIs.layer.borderWidth = 1.0f;
}

//Close screen when user click on cancel button
- (IBAction)cancelClick:(id)sender {
    AppDelegate *appdelegate=(AppDelegate *)[[UIApplication sharedApplication]delegate];
    appdelegate.prepopulateImage=nil;
    [self dismissViewControllerAnimated:YES completion:nil];
}

//Added by: nalina
//Added Date:7/07/2016
//Discription: validation and redirect to next screen on click of next click

- (IBAction)nextClick:(id)sender {
    CGPoint pt;
    
    pt.x = 0;
    pt.y = 10;
    [_scrollView setContentOffset:pt animated:YES];
   // GlobalFunction *globalValues=[[GlobalFunction alloc]init];
    
    if([_firstnameTxt.text isEqualToString:@""]){
        
        [self SetValidationSettinds:_firstnameTxt errorIcon:_firstnameError indicationIcon:_firstnameIcon validationMessage:[[GlobalFunction sharedInstance].arrayOfAlerts objectAtIndex:3] imageIs:@"error-user" viewField:_firstnameView];
    }else if(!([self validateNameField:_firstnameTxt.text])) {
        
        _firstnameTxt.text=@"";
        [self SetValidationSettinds:_firstnameTxt errorIcon:_firstnameError indicationIcon:_firstnameIcon validationMessage:[[GlobalFunction sharedInstance].arrayOfAlerts objectAtIndex:28] imageIs:@"error-user" viewField:_firstnameView];
    }
    
    if([_emailTxt.text isEqualToString:@""]){
        
        [self SetValidationSettinds:_emailTxt errorIcon:_emailError indicationIcon:_emailIcon validationMessage:[[GlobalFunction sharedInstance].arrayOfAlerts objectAtIndex:2] imageIs:@"error-email" viewField:_emailView];
    }
    else if(!([self validateEmail:_emailTxt.text])) {
        _emailTxt.text=@"";
        [self SetValidationSettinds:_emailTxt errorIcon:_emailError indicationIcon:_emailIcon validationMessage:[[GlobalFunction sharedInstance].arrayOfAlerts objectAtIndex:65] imageIs:@"error-mail" viewField:_emailView];
    }
    
   /* if([_licence.text isEqualToString:@""]){
        
        [self SetValidationSettinds:_licence errorIcon:_licenceError indicationIcon:_licenceIcon validationMessage:[[GlobalFunction sharedInstance].arrayOfAlerts objectAtIndex:21] imageIs:@"error-licence" viewField:_licenceView];
        
    } */
    
    /*else if(!([self validateNameField:_licence.text])) {
     
     _licence.text=@"";
     [self SetValidationSettinds:_licence errorIcon:_emailError indicationIcon:_licenceIcon validationMessage:[[GlobalFunction sharedInstance].arrayOfAlerts objectAtIndex:77] imageIs:@"error-licence" viewField:_licenceView];
     }*/
    
    
    if([_qualifications.text isEqualToString:@""])
    {
        [self SetValidationSettinds:_qualifications errorIcon:_qualificationError indicationIcon:_qualificationIcon validationMessage:@"Please enter Qualification." imageIs:@"error-qualification" viewField:_qualificationsView];
    }
    
    
    if([_dateOfBirthTxt.text isEqualToString:@""])
    {
        [self SetValidationSettinds:_dateOfBirthTxt errorIcon:_dobError indicationIcon:_dobIcon validationMessage:@"Please enter Date of birth." imageIs:@"error-date of birth" viewField:_dateOfBirthView];
    }
    
    /*if([_ssn.text isEqualToString:@""]){
        
        [self SetValidationSettinds:_ssn errorIcon:_ssnError indicationIcon:_ssnIcon validationMessage:[[GlobalFunction sharedInstance].arrayOfAlerts objectAtIndex:70] imageIs:@"error-ssn" viewField:_licenceView];
    }else if(!([self validateNameField:_ssn.text])) {
        
        _ssn.text=@"";
        [self SetValidationSettinds:_ssn errorIcon:_ssnError indicationIcon:_ssnIcon validationMessage:[[GlobalFunction sharedInstance].arrayOfAlerts objectAtIndex:71] imageIs:@"error-ssn" viewField:_ssnView];
    }*/
    
    
    
    /*if([_lastnameTxt.text isEqualToString:@""]){
        
        [self SetValidationSettinds:_lastnameTxt errorIcon:_lastnameError indicationIcon:_lastnameIcon validationMessage:[[GlobalFunction sharedInstance].arrayOfAlerts objectAtIndex:4] imageIs:@"error-user" viewField:_lastnameView];
    }else if(!([self validateNameField:_lastnameTxt.text])) {
        
        _lastnameTxt.text=@"";
        [self SetValidationSettinds:_lastnameTxt errorIcon:_lastnameError indicationIcon:_lastnameIcon validationMessage:[[GlobalFunction sharedInstance].arrayOfAlerts objectAtIndex:29] imageIs:@"error-user" viewField:_lastnameView];
        
    }
    if([_aboutYourselfText.text isEqualToString:@"About your professional interest, experience, etc."] || [_aboutYourselfText.text isEqualToString:@""])
    {
        _aboutYourselfText.text=@"";
        [self SetValidationSettingsTextView:_aboutYourselfText errorIcon:_aboutYourselfError indicationIcon:_aboutYourSelfIcon validationMessage:@"Please enter about yourself." imageIs:@"error-user" viewField:_aboutYourselfView];
        [_aboutYourselfText resignFirstResponder];
    } */
    
    if((![_firstnameTxt.text isEqualToString:@""])&&(![_emailTxt.text isEqualToString:@""])&& (![_qualifications.text isEqualToString:@""])&& (![_dateOfBirthTxt.text isEqualToString:@""]) && (![_ssn.text isEqualToString:@""])
        /*(![_lastnameTxt.text isEqualToString:@""])&&([self validateNameField:_firstnameTxt.text])&&([self validateNameField:_lastnameTxt.text])&&(![_aboutYourselfText.text isEqualToString:@"About your professional interest, experience, etc."])&&(![_aboutYourselfText.text isEqualToString:@"Please enter about yourself."])*/){
        
        
        ProviderProfileSecondViewController *providerProfile= [self.storyboard instantiateViewControllerWithIdentifier:@"providerProfileSecond"];
        
        NSMutableDictionary *dict=[[NSMutableDictionary alloc]init];
        NSMutableDictionary *personalDetails=[[NSMutableDictionary alloc]init];
        NSMutableDictionary *providerInfoData=[[NSMutableDictionary alloc]init];
        
        [personalDetails setObject:[_firstnameTxt.text stringByTrimmingCharactersInSet:
                                    [NSCharacterSet whitespaceCharacterSet]] forKey:@"firstName"];
        
        /*[personalInfo setObject:[_lastnameTxt.text stringByTrimmingCharactersInSet:
         [NSCharacterSet whitespaceCharacterSet]] forKey:@"lastName"]; */
        [personalDetails setObject:[_emailTxt.text stringByTrimmingCharactersInSet:
                                    [NSCharacterSet whitespaceCharacterSet]] forKey:@"email"];
        
        [providerInfoData setObject:[_licence.text stringByTrimmingCharactersInSet:
                                     [NSCharacterSet whitespaceCharacterSet]] forKey:@"licenseNumber"];
        [providerInfoData setObject:[_qualifications.text stringByTrimmingCharactersInSet:
                                     [NSCharacterSet whitespaceCharacterSet]] forKey:@"qualification"];
        [personalDetails setObject:_dateOfBirthTxt.text forKey:@"dob"];
        
        [personalDetails setObject:phoneNumberVal forKey:@"phoneNumber"];
        //Uncomment after the ssn is updated in API
        
        /*[personalInfo setObject:[_ssn.text stringByTrimmingCharactersInSet:
         [NSCharacterSet whitespaceCharacterSet]] forKey:@"ssn"]; */
        
        //imagePath
        [personalDetails setObject:imagePath forKey:@"profilePicPath"];
        
        [personalDetails setObject:userNameVal forKey:@"userName"];
        [personalDetails setObject:lastNameVal forKey:@"lastName"];
        
        /*[personalInfo setObject:userName forKey:@"userName"];
         [dict setObject:personalInfo forKey:@"personalDetails"]; */
        if(providerInfo != nil)
        {
            [dict setObject:providerInfo forKey:@"providerInfo"];
        }
        
        [dict setObject:providerInfoData forKey:@"providerInfoData"];
        [dict setObject:personalDetails forKey:@"personalDetails"];
        
        providerProfile.userProfileData =  dict;
       // providerProfile.aboutUs = _aboutYourselfText.text;
       // providerProfile.gender =  _genderTxt.text;
        //[self.navigationController pushViewController:providerProfile animated:YES ];
        [self presentViewController:providerProfile animated:YES completion:nil];
        
    }
    
}

//Added by: nalina
//Added Date:7/07/2016
//Discription: set validation to the input fields

-(void)SetValidationSettinds:(UITextField *)textField errorIcon:(UIButton *)errorBtn indicationIcon:(UIImageView *)indicationIcon validationMessage:(NSString *)validationMessage imageIs:(NSString *)imageIs viewField:(UIView *)viewIs{
    
    [textField setValue:[UIColor redColor] forKeyPath:@"_placeholderLabel.textColor"];
    textField.placeholder=validationMessage;
    errorBtn.hidden=NO;
    UIImage *image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:imageIs ofType:@"png"]];
    indicationIcon.image = image;
    viewIs.layer.borderColor = [[UIColor redColor]CGColor];
    viewIs.layer.borderWidth = 1.0f;
    
}

//Hides soft keyboard
- (BOOL)textFieldShouldReturn:(UITextField *)theTextField {
    if (theTextField == self.firstnameTxt) {
        [self.lastnameTxt becomeFirstResponder];
    }
    if (theTextField == self.lastnameTxt) {
        [theTextField resignFirstResponder];
    }
    CGPoint pt;
    
    pt.x = 0;
    pt.y = 10;
    [_scrollView setContentOffset:pt animated:YES];
    
    [theTextField resignFirstResponder];
    return YES;
}



//Added by: nalina
//Added Date:7/07/2016
//Discription: Date picker set and cancel button click functionality

- (IBAction)setDateClick:(id)sender {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"MM/dd/yyyy"];
    dateOfBirth = [dateFormatter stringFromDate:self.datePicker.date];
    _dateOfBirthTxt.text=dateOfBirth;
    _datePickerBackView.hidden=YES;
    _datePicker.hidden=YES;
    _datePickerButtonBackView.hidden=YES;
    _photoPopupView.hidden=YES;
    _genderPicker.hidden=YES;
    _pickerBackView.hidden = YES;
    [self.dumyTxtVw becomeFirstResponder];
    [self resignSoftKeyboard];
}

- (IBAction)cancelDateClick:(id)sender {
    _datePickerBackView.hidden=YES;
    _datePicker.hidden=YES;
    _datePickerButtonBackView.hidden=YES;
    _photoPopupView.hidden=YES;
    _genderPicker.hidden=YES;
    _pickerBackView.hidden = YES;
    [self.dumyTxtVw becomeFirstResponder];
    [self resignSoftKeyboard];
}


//Added by: nalina
//Added Date:7/07/2016
//Discription: photo pop up cancel button click

- (IBAction)photoPopUpCancel:(id)sender {
    _datePickerBackView.hidden=YES;
    _photoPopupView.hidden=YES;
    _datePicker.hidden=YES;
    _datePickerButtonBackView.hidden=YES;
    _genderPicker.hidden=YES;
}

//Added by: nalina
//Added Date:7/07/2016
//Discription: upload button click on photo popup

- (IBAction)uploadPhotoClick:(id)sender {
    [_firstnameTxt resignFirstResponder];
    [_lastnameTxt resignFirstResponder];
    
    _datePickerBackView.hidden=NO;
    _photoPopupView.hidden=NO;
    _datePicker.hidden=YES;
    _datePickerButtonBackView.hidden=YES;
    _genderPicker.hidden=YES;
}


//Added by: nalina
//Added Date:7/07/2016
//Discription: gallery button click on photo popup

- (IBAction)galleryClick:(id)sender {
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc]init];
    imagePickerController.delegate = self;
    imagePickerController.sourceType =  UIImagePickerControllerSourceTypePhotoLibrary;
    
    [self presentViewController:imagePickerController animated:YES completion:nil];
}

//Added by: nalina
//Added Date:7/07/2016
//Discription: camera button click on photo popup

- (IBAction)cameraClick:(id)sender {
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc]init];
    imagePickerController.delegate = self;
    imagePickerController.sourceType =  UIImagePickerControllerSourceTypeCamera;
    [self presentViewController:imagePickerController animated:YES completion:nil];
}


//Added by: zeenath
//Added Date:19/08/2016
//Discription: Selected/ captured image path callback

- (void) imagePickerController:(UIImagePickerController *)picker
         didFinishPickingImage:(UIImage *)image
                   editingInfo:(NSDictionary *)editingInfo
{
    self.profilePicView.image = image;
    _datePickerBackView.hidden=YES;
    _photoPopupView.hidden=YES;
    
    _datePicker.hidden=YES;
    _datePickerButtonBackView.hidden=YES;
    _genderPicker.hidden=YES;
    
    AppDelegate *appDelegat=(AppDelegate *)[[UIApplication sharedApplication]delegate];
    [appDelegat uploadBlobToContainer:image name:name path:1 withCallback:^(NSString *response, NSError *error) {
        if (error == nil)
        {
            providerImage=response;
        }
        else
        {
            providerImage=@"";
        }
        
    }];
    
   /* if(![[providerInfo valueForKey:@"aboutSelf"] isEqual:[NSNull null]]){
        _aboutYourselfText.text=[providerInfo valueForKey:@"aboutSelf"];
        _aboutYourselfText.textColor = [UIColor colorWithRed:51.0/255.0 green:51.0/255.0 blue:51.0/255.0 alpha:1.0];
    } */
    
    [self dismissModalViewControllerAnimated:YES];
    
}



//Added by: nalina
//Added Date:7/07/2016
//Discription: Clear validation on click of error button in input fields

/*- (IBAction)aboutYourselfErrorClose:(id)sender {
    [self RemoveValidationSettingToTextView:_aboutYourselfText errorIcon:_aboutYourselfError indicationIcon:_aboutYourSelfIcon HintText:@"About your professional interest, experience, etc. " imageIs:@"user" viewField:_aboutYourselfView];
    _aboutYourselfText.textColor = [UIColor darkGrayColor];
} */


- (IBAction)backIconClick:(id)sender {
     [self dismissViewControllerAnimated:YES completion:nil];
}

- (BOOL) textView: (UITextView*) textView
shouldChangeTextInRange: (NSRange) range
  replacementText: (NSString*) text
{
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        CGPoint pt;
        
        pt.x = 0;
        pt.y = 10;
        [_scrollView setContentOffset:pt animated:YES];
        return NO;
    }
      return YES;
}



//  Added by:Zeenath
//  Added Date:2016-20-08.
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
//  Added Date:2016-20-08.
//  Description:To stop the activity indicator.
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



- (BOOL) textFieldShouldBeginEditing:(UITextField *)textField
{
    if(textField == _dateOfBirthTxt )
    {
        [self resignSoftKeyboard];
        [_dateOfBirthTxt resignFirstResponder];
        _pickerBackView.hidden=NO;
        [_pickerView setHidden:YES];
        [_datePicker setHidden:NO];
        [_datePickerButtonBackView setHidden:NO];
        [self.dumyTxtVw becomeFirstResponder];
        [self resignSoftKeyboard];
        return NO;
        
    }
    [_pickerView setHidden:NO];
    [self.dumyTxtVw becomeFirstResponder];
    [self resignSoftKeyboard];
    return YES;
    
}


//Added by: Nalina
//Added Date: 29/08/2016
//Discription: Show the date picker to set the dob
-(void)datepickerClickProvider:(UITapGestureRecognizer *)recognizer {
    
   // [_firstnameTxt resignFirstResponder];
    //[_lastnameTxt resignFirstResponder];
    _datePickerButtonBackView.hidden = NO;
    _datePickerBackView.hidden=NO;
    _datePicker.hidden=NO;
    _datePickerButtonBackView.hidden=NO;
    _pickerBackView.hidden = YES;
    _datePickerButtonBackView.hidden = NO;
    _pickerView.hidden = YES;
    _pickerBackView.hidden=YES;
    [self.dumyTxtVw becomeFirstResponder];
    [self resignSoftKeyboard];
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

-(void) setBorderColor:(int)tagName{
    UIButton *cancelBtn = (UIButton *) [self.view viewWithTag:tagName];
    cancelBtn.layer.borderColor = [UIColor colorWithRed:246.0/255.0 green:108.0/255.0 blue:118.0/255.0 alpha:1].CGColor;
}

@end
