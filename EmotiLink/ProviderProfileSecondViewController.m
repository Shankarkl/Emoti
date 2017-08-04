/***************************************************************
 Page name: ProviderProfileSecondViewController.m
 Created By: nalina
 Created Date:7/07/16
 Description: provider profile implementation file
 ***************************************************************/

#import "ProviderProfileSecondViewController.h"
#import "GlobalFunction.h"
#import "ProviderProfileViewController.h"
#import "UserSettingsViewController.h"
#import <Google/Analytics.h>
#import "AppDelegate.h"
@interface ProviderProfileSecondViewController ()

@end

@implementation ProviderProfileSecondViewController

//Loads first time when page appears
- (void)viewDidLoad {
    UIImage *backgroundImage = [UIImage imageNamed:@"06. Appointment Confirmation.png"];
    UIImageView *backgroundImageView=[[UIImageView alloc]initWithFrame:self.view.frame];
    backgroundImageView.image=backgroundImage;
    [self.view insertSubview:backgroundImageView atIndex:0];
    
    //Buttons border radius
    UIButton *subBtn = (UIButton *) [self.view viewWithTag:5];
    subBtn.layer.borderColor = [UIColor colorWithRed:246.0/255.0 green:108.0/255.0 blue:118.0/255.0 alpha:1].CGColor;
    
    
    
    
    UITapGestureRecognizer *singleFingerTap =
    [[UITapGestureRecognizer alloc] initWithTarget:self
                                            action:@selector(handleSingleTapped:)];

    [self.pickerView addGestureRecognizer:singleFingerTap];
    
    [self.stateTxt addTarget:self action:@selector(secondTotmClick:) forControlEvents:UIControlEventEditingDidBegin];
    
    

    _addressTxt.delegate=self;
    _cityTxt.delegate = self;
    _stateTxt.delegate = self;
    _zipCodeTxt.delegate = self;
    

    //_stateLicensureTxt.delegate = self;
    //_licenceNumTxt.delegate = self;
    //_qualificationTxt.delegate = self;
    
    
    [self.addressText addTarget:self action:@selector(ValidationRemovalTouch:) forControlEvents:UIControlEventAllTouchEvents];
    [self.addressText addTarget:self action:@selector(ValidationRemovalTouch:) forControlEvents:UIControlEventEditingChanged];
    
    [self.cityTxt addTarget:self action:@selector(ValidationRemovalTouch:) forControlEvents:UIControlEventAllTouchEvents];
    [self.cityTxt addTarget:self action:@selector(ValidationRemovalTouch:) forControlEvents:UIControlEventEditingChanged];
    
    [self.stateTxt addTarget:self action:@selector(ValidationRemovalTouch:) forControlEvents:UIControlEventAllTouchEvents];
    [self.stateTxt addTarget:self action:@selector(ValidationRemovalTouch:) forControlEvents:UIControlEventEditingChanged];
    
    [self.zipCodeTxt addTarget:self action:@selector(ValidationRemovalTouch:) forControlEvents:UIControlEventAllTouchEvents];
    [self.zipCodeTxt addTarget:self action:@selector(ValidationRemovalTouch:) forControlEvents:UIControlEventEditingChanged];
    
    /* [self.licenceNumTxt addTarget:self action:@selector(ValidationRemovalTouch:) forControlEvents:UIControlEventAllTouchEvents];
    [self.licenceNumTxt addTarget:self action:@selector(ValidationRemovalTouch:) forControlEvents:UIControlEventEditingChanged];*/
    
    
    
    
    UITapGestureRecognizer *pickerSingleTap =
    [[UITapGestureRecognizer alloc] initWithTarget:self
                                            action:@selector(pickerSingleTapped:)];
    [self.pickerBackView addGestureRecognizer:pickerSingleTap];
    
    UITapGestureRecognizer *stateLicensureTap =
    [[UITapGestureRecognizer alloc] initWithTarget:self
                                            action:@selector(handleStateLicensureTapped:)];
    [self.stateLicensureView addGestureRecognizer:stateLicensureTap];
    
    UITapGestureRecognizer *stateTap =
    [[UITapGestureRecognizer alloc] initWithTarget:self
                                            action:@selector(handleStateTapped:)];
    [self.stateView addGestureRecognizer:stateTap];
    
    UITapGestureRecognizer *qualificationTap =
    [[UITapGestureRecognizer alloc] initWithTarget:self
                                            action:@selector(handlequalificationTapped:)];
    [self.qualificationView addGestureRecognizer:qualificationTap];
    
    //Added by: Nalina
    //Added Date: 19/07/2016
    //Discription: To add the done button to the number keypad
    
    UIToolbar* numberToolbar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 50)];
    numberToolbar.barStyle = UIBarStyleBlackTranslucent;
    numberToolbar.items = @[
                            [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],
                            [[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(doneWithNumberPad)],[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil]];
    [numberToolbar sizeToFit];
    _licenceNumTxt.inputAccessoryView = numberToolbar;
    _zipCodeTxt.inputAccessoryView = numberToolbar;
    
    _userNameText.hidden=YES;
    
    if(![[_userProfileData valueForKey:@"providerInfo"] isEqual:[NSNull null]])
    {
        
        NSMutableDictionary *provider=[_userProfileData valueForKey:@"providerInfo"];
        NSMutableDictionary *providerPersonalDet=[_userProfileData valueForKey:@"personalDetails"];
        if(provider != nil)
        {
           // _stateLicensureTxt.text=[provider valueForKey:@"licensureState"];
            
            /*if ([[provider valueForKey:@"licenseNumber"] isEqual:[NSNull null]]) {
                _licenceNumTxt.text=@"";
            }else{
                _licenceNumTxt.text=[provider valueForKey:@"licenseNumber"];
            }*/
            //_qualificationTxt.text=[provider valueForKey:@"qualification"];
            
          /*  if(![[provider valueForKey:@"address"] isEqual:[NSNull null]] || ![[provider valueForKey:@"address"] isEqualToString:@""])
            {
                _addressTxt.text=[provider valueForKey:@"address"];
            }
            else{
                _addressTxt.text = @"Address";
                _addressTxt.textColor = [UIColor colorWithRed:112.0/255.0 green:112.0/255.0 blue:112.0/255.0 alpha:1.0];
            } */
            
            _addressText.text=[provider valueForKey:@"address"];
            _cityTxt.text=[provider valueForKey:@"city"];
            _stateTxt.text=[provider valueForKey:@"state"];
            _zipCodeTxt.text=[provider valueForKey:@"zipCode"];
            _userNameText.text=[provider valueForKey:@"userName"];
            _phoneNumberText.text=[provider valueForKey:@"phoneNumber"];
            
            if ([[providerPersonalDet valueForKey:@"profilePicPath"] isEqual:[NSNull null]]) {
                //imagePath=@"";
            }else{
                AppDelegate *appdelegate=(AppDelegate *)[[UIApplication sharedApplication]delegate];
                
                NSString *nameImage=[providerPersonalDet valueForKey:@"profilePicPath"];
                NSString *imagename=[appdelegate.imageURL stringByAppendingString:nameImage];
                dispatch_queue_t imagequeue =dispatch_queue_create("imageDownloader", nil);
                dispatch_async(imagequeue, ^{
                    
                    //download iamge
                    NSData *imageData = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:imagename]];
                    UIImage *image = [[UIImage alloc] initWithData:imageData];
                    dispatch_async(dispatch_get_main_queue(), ^{
                        
                        _profilePicture.layer.cornerRadius = 10;
                        _profilePicture.layer.masksToBounds = YES;
                        
                        if (image==NULL) {
                            UIImage *image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"upload-profile" ofType:@"png"]];
                            _profilePicture.image  = image;
                        }
                        else{
                            _profilePicture.image  = image;
                        }
                    });
                    
                });
                
            }
            
        }
        else{
            _addressTxt.text = @"Address";
            _addressTxt.textColor = [UIColor colorWithRed:112.0/255.0 green:112.0/255.0 blue:112.0/255.0 alpha:1.0];
        }
        
    }
    
    [super viewDidLoad];
}


- (void)handleSingleTapped:(UITapGestureRecognizer *)recognizer {
    _pickerView.hidden = YES;
    [self resignSoftKeyboard];
}

//Close the number keypad
-(void)doneWithNumberPad{
    [_licenceNumTxt resignFirstResponder];
    [_zipCodeTxt resignFirstResponder];
    CGPoint pt;
    
    pt.x = 0;
    pt.y = 10;
    [_scrollView setContentOffset:pt animated:YES];
}

//Return number of section in picker
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)thePickerView {
    
    return 1;
}

//Return the number of rows in picker
- (NSInteger)pickerView:(UIPickerView *)thePickerView numberOfRowsInComponent:(NSInteger)component {
    
    return [pickerArray count];
}

//Return the data to display
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:
(NSInteger)row forComponent:(NSInteger)component{
    return [pickerArray objectAtIndex:row];
}
/*
//Return the selected picker row data
- (void)pickerView:(UIPickerView *)thePickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    [_pickerView selectRow:0 inComponent:0 animated:YES];

    if([clickedbutton isEqualToString:@"stateDropdown"])
    {
        [_stateTxt setText:[pickerArray objectAtIndex:row]];
        
    }
    else if([clickedbutton isEqualToString:@"qualification"])
    {
        [_qualificationTxt setText:[pickerArray objectAtIndex:row]];
    }
    else if([clickedbutton isEqualToString:@"stateLicensure"])
    {
        [_stateLicensureTxt setText:[pickerArray objectAtIndex:row]];
    }
    
    _pickerBackView.hidden=YES;
    
} */

//On touch of picker outseide should close the picker view
- (void)pickerSingleTapped:(UITapGestureRecognizer *)recognizer {
    _pickerBackView.hidden=YES;
    [self resignSoftKeyboard];
    [self.userNameText becomeFirstResponder];
    
}

//Added by: zeenath
//Added Date: 19/07/2016
//Discription:Initialize state picker data

- (void)handleStateLicensureTapped:(UITapGestureRecognizer *)recognizer {
    pickerArray = [[NSMutableArray alloc]initWithObjects:@"Alabama",
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
    _pickerBackView.hidden=NO;
    clickedbutton=@"stateLicensure";
    [_licenceNumTxt resignFirstResponder];
    [_cityTxt resignFirstResponder];
    [_zipCodeTxt resignFirstResponder];
    [self RemoveValidationSettings:_stateLicensureTxt errorIcon:_stateLicensureError indicationIcon:_stateLicensureIcon HintText:@"State of licensure" imageIs:@"state-licence" viewField:_stateLicensureView];
}

//Added by: zeenath
//Added Date: 19/07/2016
//Discription:Initialize state picker data on touch of input field

/*- (void)handleStateTapped:(UITapGestureRecognizer *)recognizer {
    pickerArray = [[NSMutableArray alloc]initWithObjects:@"Alabama",
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
    _pickerBackView.hidden=NO;
    clickedbutton=@"stateDropdown";
    [_licenceNumTxt resignFirstResponder];
    [_cityTxt resignFirstResponder];
    [_zipCodeTxt resignFirstResponder];
    [self RemoveValidationSettings:_stateTxt errorIcon:_stateError indicationIcon:_stateIcon HintText:@"State" imageIs:@"city" viewField:_stateView];
}*/

//Added by: zeenath
//Added Date: 19/07/2016
//Discription:Initialize qualification picker data on touch of input field

- (void)handlequalificationTapped:(UITapGestureRecognizer *)recognizer {
    pickerArray=[[NSMutableArray alloc]init];
    pickerArray = [[NSMutableArray alloc]initWithObjects:@"Phd/MD",
                   @"PSYD",@"MSW",@"LCSW",@"Licensed Counselor", nil];
    clickedbutton=@"qualificationDropdown";
    [self.pickerView reloadAllComponents];
    _pickerBackView.hidden=NO;
    clickedbutton=@"qualification";
    [_licenceNumTxt resignFirstResponder];
    [_cityTxt resignFirstResponder];
    [_zipCodeTxt resignFirstResponder];
    [self RemoveValidationSettings:_qualificationTxt errorIcon:_qualificationError indicationIcon:_qualificationIcon HintText:@"Specialty" imageIs:@"qualification" viewField:_qualificationView];
}

//Returns the soft keypad
- (BOOL)textFieldShouldReturn:(UITextField *)theTextField {
    if (theTextField == self.addressTxt) {
        [self.cityTxt becomeFirstResponder];
    }
    if (theTextField == self.cityTxt) {
        //[self.zipCodeTxt becomeFirstResponder];
        [theTextField resignFirstResponder];
    }
    if (theTextField == self.zipCodeTxt) {
        [theTextField resignFirstResponder];
    }
    CGPoint pt;
    
    pt.x = 0;
    pt.y = 10;
    [_scrollView setContentOffset:pt animated:YES];
    
    [theTextField resignFirstResponder];
    return YES;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

//Added by: nalina
//Added Date: 07/07/2016
//Discription:validation design remove from input field

-(void)ValidationRemovalTouch:(UITextField *)theTextField{
   /* if([theTextField isEqual: _stateLicensureTxt]){
        
        [self RemoveValidationSettings:_stateLicensureTxt errorIcon:_stateLicensureError indicationIcon:_stateLicensureIcon HintText:@"State of licensure" imageIs:@"state-licence" viewField:_stateLicensureView];
        
    }else if([theTextField isEqual: _licenceNumTxt]){
        
        [self RemoveValidationSettings:_licenceNumTxt errorIcon:_licenceNumError indicationIcon:_licenceNumIcon HintText:@"Licence number" imageIs:@"licence" viewField:_licenceNumView];
        
    }else if([theTextField isEqual: _qualificationTxt]){
        
        [self RemoveValidationSettings:_qualificationTxt errorIcon:_qualificationError indicationIcon:_qualificationIcon HintText:@"Specialty" imageIs:@"qualification" viewField:_qualificationView];
        
    }else */
    
    
    if([theTextField isEqual:_addressText])
    {
        [self RemoveValidationSettings:_addressText errorIcon:_addressError indicationIcon:_addressIcon HintText:@"Address " imageIs:@"address" viewField:_addressView];
        
    }else if([theTextField isEqual: _cityTxt]){
        
        [self RemoveValidationSettings:_cityTxt errorIcon:_cityError indicationIcon:_cityIcon HintText:@"City" imageIs:@"city" viewField:_cityView];
        
    }else if([theTextField isEqual: _stateTxt]){
        
        [self RemoveValidationSettings:_stateTxt errorIcon:_stateError indicationIcon:_stateIcon HintText:@"State" imageIs:@"state" viewField:_stateView];
        
    }else if([theTextField isEqual: _zipCodeTxt]){
        
        [self RemoveValidationSettings:_zipCodeTxt errorIcon:_zipCodeError indicationIcon:_zipCodeIcon HintText:@"Zipcode" imageIs:@"password" viewField:_zipCodeView];
        
    }
 
}

//Added by: nalina
//Added Date: 07/07/2016
//Discription: remove validation design in text view

-(void)RemoveValidationSettingTextView:(UITextView *)textField errorIcon:(UIButton *)errorBtn indicationIcon:(UIImageView *)indicationIcon HintText:(NSString *)hintTextMessage imageIs:(NSString *)imageIs viewField:(UIView *)view{
    
    [textField setValue:[UIColor  colorWithRed:(112/255.0) green:(112/255.0) blue:(112/255.0) alpha:1] forKeyPath:@"_placeholderLabel.textColor"];
    
    if (![hintTextMessage isEqualToString:@""]) {
        textField.text=hintTextMessage;
    }
    
    errorBtn.hidden=YES;
    UIImage *image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:imageIs ofType:@"png"]];
    indicationIcon.image = image;
    [self setBorder:view];
    
}

//Added by: nalina
//Added Date: 07/07/2016
//Discription:remove validation design

-(void)RemoveValidationSettings:(UITextField *)textField errorIcon:(UIButton *)errorBtn indicationIcon:(UIImageView *)indicationIcon HintText:(NSString *)hintTextMessage imageIs:(NSString *)imageIs viewField:(UIView *)view{
    
    [textField setValue:[UIColor  colorWithRed:(112/255.0) green:(112/255.0) blue:(112/255.0) alpha:1] forKeyPath:@"_placeholderLabel.textColor"];
    textField.placeholder=hintTextMessage;
    errorBtn.hidden=YES;
    UIImage *image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:imageIs ofType:@"png"]];
    indicationIcon.image = image;
    [self setBorder:view];
    
}

//Added by: nalina
//Added Date: 07/07/2016
//Discription:Set border to the text field

-(void)setBorder:(UIView *)view
{
    view.layer.borderColor = [[UIColor colorWithRed:228.0/255.0 green:109.0/255.0 blue:175.0/255.0 alpha:1.0]CGColor];
    view.layer.borderWidth = 1.0f;
}

//Loads each time when page appears
-(void)viewWillAppear:(BOOL)animated{
    //[self setBorder:_stateLicensureView];
    //[self setBorder:_licenceNumView];
     //[self setBorder:_qualificationView];
   
    [self setBorder:_addressView];
    [self setBorder:_stateView];
    [self setBorder:_cityView];
    [self setBorder:_zipCodeView];
    
    id<GAITracker> tracker = [[GAI sharedInstance] defaultTracker];
    [tracker set:kGAIScreenName value:@"ProviderProfile"];
    [tracker send:[[GAIDictionaryBuilder createScreenView] build]];
}


//Added by: nalina
//Added Date: 07/07/2016
//Discription: Remove validations on click of error close button in input fields

- (IBAction)addressErrorClose:(id)sender {
    [self RemoveValidationSettings:_addressText errorIcon:_addressError indicationIcon:_addressIcon HintText:@"Address " imageIs:@"address" viewField:_addressView];
    _addressTxt.textColor = [UIColor darkGrayColor];
}

/*- (IBAction)licenceErrorClose:(id)sender {
    [self RemoveValidationSettings:_licenceNumTxt errorIcon:_licenceNumError indicationIcon:_licenceNumIcon HintText:@"Licence number" imageIs:@"licence" viewField:_licenceNumView];
} */


/*- (IBAction)qualificationPicker:(id)sender {
    pickerArray=[[NSMutableArray alloc]init];
    pickerArray = [[NSMutableArray alloc]initWithObjects:@"Phd/MD",
                   @"PSYD",@"MSW",@"LCSW",@"Licensed Counselor", nil];
    clickedbutton=@"qualificationDropdown";
    [self.pickerView reloadAllComponents];
    _pickerBackView.hidden=NO;
    clickedbutton=@"qualification";
    [_licenceNumTxt resignFirstResponder];
    [_cityTxt resignFirstResponder];
    [_zipCodeTxt resignFirstResponder];
    [self RemoveValidationSettings:_qualificationTxt errorIcon:_qualificationError indicationIcon:_qualificationIcon HintText:@"Specialty" imageIs:@"qualification" viewField:_qualificationView];
}*/


/*- (IBAction)qualificationErrorClose:(id)sender {
    [self RemoveValidationSettings:_qualificationTxt errorIcon:_qualificationError indicationIcon:_qualificationIcon HintText:@"Specialty" imageIs:@"qualification" viewField:_qualificationView];
}*/


- (IBAction)cityErrorClose:(id)sender {
    [self RemoveValidationSettings:_cityTxt errorIcon:_cityError indicationIcon:_cityIcon HintText:@"City" imageIs:@"city" viewField:_cityView];
}


- (IBAction)statePicker:(id)sender {
    pickerArray = [[NSMutableArray alloc]initWithObjects:@"Alabama",
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
    _pickerBackView.hidden=NO;
    clickedbutton=@"stateDropdown";
    [_licenceNumTxt resignFirstResponder];
    [_cityTxt resignFirstResponder];
    [_zipCodeTxt resignFirstResponder];
    [self RemoveValidationSettings:_stateTxt errorIcon:_stateError indicationIcon:_stateIcon HintText:@"State" imageIs:@"city" viewField:_stateView];
}


- (IBAction)stateErrorClose:(id)sender {
    [self RemoveValidationSettings:_stateTxt errorIcon:_stateError indicationIcon:_stateIcon HintText:@"State" imageIs:@"city" viewField:_stateView];
}


- (IBAction)zipCodeErrorClose:(id)sender {
    [self RemoveValidationSettings:_zipCodeTxt errorIcon:_zipCodeError indicationIcon:_zipCodeIcon HintText:@"Zipcode" imageIs:@"password" viewField:_zipCodeView];
}


- (IBAction)stateLicensurePicker:(id)sender {
    pickerArray = [[NSMutableArray alloc]initWithObjects:@"Alabama",
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
    _pickerBackView.hidden=NO;
    clickedbutton=@"stateLicensure";
    [_licenceNumTxt resignFirstResponder];
    [_cityTxt resignFirstResponder];
    [_zipCodeTxt resignFirstResponder];
    [self RemoveValidationSettings:_stateLicensureTxt errorIcon:_stateLicensureError indicationIcon:_stateLicensureIcon HintText:@"State of licensure" imageIs:@"state-licence" viewField:_stateLicensureView];
}


- (IBAction)stateLicensureErrorClose:(id)sender {
    [self RemoveValidationSettings:_stateLicensureTxt errorIcon:_stateLicensureError indicationIcon:_stateLicensureIcon HintText:@"State of licensure" imageIs:@"state-licence" viewField:_stateLicensureView];
    
}

- (IBAction)backArrow:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
    }


//Added by: zeenath
//Added Date: 19/07/2016
//Discription: validate the pattern of licence number

/*- (BOOL)validatlicenseNumber:(NSString*)licenseNumber
{
    if(![_licenceNumTxt.text isEqualToString:@""])
    {
        NSString *licenceNumberRegex = @"(^[a-z0-9]*$)";
        NSPredicate *licenseNumberTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", licenceNumberRegex];
        return [licenseNumberTest evaluateWithObject:licenseNumber];
    }
    else if([_licenceNumTxt.placeholder isEqualToString:@"Please enter a valid license Number."])
    {
        return false;
    }
    else{
        return true;
    }
}*/

//Added by: nalina
//Added Date: 07/07/2016
//Discription: Submit click and validation of input fields

- (IBAction)submitClick:(id)sender {
    CGPoint pt;
    
    pt.x = 0;
    pt.y = 10;
    [_scrollView setContentOffset:pt animated:YES];
 //   GlobalFunction *globalValues=[[GlobalFunction alloc]init];
  /*  if([_stateLicensureTxt.text isEqualToString:@""]){
        
        [self SetValidationSettinds:_stateLicensureTxt errorIcon:_stateLicensureError indicationIcon:_stateLicensureIcon validationMessage:[[GlobalFunction sharedInstance].arrayOfAlerts objectAtIndex:20] imageIs:@"error-state-licence" viewField:_stateLicensureView];
    }
    
    if([_qualificationTxt.text isEqualToString:@""]){
        
        [self SetValidationSettinds:_qualificationTxt errorIcon:_qualificationError indicationIcon:_qualificationIcon validationMessage:[[GlobalFunction sharedInstance].arrayOfAlerts objectAtIndex:22] imageIs:@"error-qualification" viewField:_qualificationView];
    } */
    
    
    if([_addressText.text isEqualToString:@""])
    {
        [self SetValidationSettinds:_addressText errorIcon:_addressError indicationIcon:_addressIcon validationMessage:@"Please enter Address." imageIs:@"error-address" viewField:_addressView];
    }
    
    if([_cityTxt.text isEqualToString:@""]){
        
        [self SetValidationSettinds:_cityTxt errorIcon:_cityError indicationIcon:_cityIcon validationMessage:[[GlobalFunction sharedInstance].arrayOfAlerts objectAtIndex:23] imageIs:@"error-city" viewField:_cityView];
    }
    if([_stateTxt.text isEqualToString:@""]){
        
        [self SetValidationSettinds:_stateTxt errorIcon:_stateError indicationIcon:_stateIcon validationMessage:[[GlobalFunction sharedInstance].arrayOfAlerts objectAtIndex:24] imageIs:@"error-state" viewField:_stateView];
    }
    
    if([_zipCodeTxt.text isEqualToString:@""]){
        
        [self SetValidationSettinds:_zipCodeTxt errorIcon:_zipCodeError indicationIcon:_zipCodeIcon validationMessage:[[GlobalFunction sharedInstance].arrayOfAlerts objectAtIndex:16] imageIs:@"error-zipcode" viewField:_zipCodeView];
    }
 
    
    /*  if([_addressTxt.text isEqualToString:@"Address"] || [_addressTxt.text isEqualToString:@""])
    {
        _addressTxt.text=@"";
        [self SetValidationSettingsTextView:_addressTxt errorIcon:_addressError indicationIcon:_addressIcon validationMessage:@"Please enter Address." imageIs:@"error-address" viewField:_addressView];
        [_addressTxt resignFirstResponder];
    }
    if([_licenceNumTxt.text isEqualToString:@""]){
        
         [self SetValidationSettinds:_licenceNumTxt errorIcon:_licenceNumError indicationIcon:_licenceNumIcon validationMessage:[[GlobalFunction sharedInstance].arrayOfAlerts objectAtIndex:123] imageIs:@"error-licence" viewField:_licenceNumView];
    }*/

    
  /*  if(!([self validatlicenseNumber:_licenceNumTxt.text]))
    {
        _licenceNumTxt.text=@"";
        
        [self SetValidationSettinds:_licenceNumTxt errorIcon:_licenceNumError indicationIcon:_licenceNumIcon validationMessage:[[GlobalFunction sharedInstance].arrayOfAlerts objectAtIndex:77] imageIs:@"error-licence" viewField:_licenceNumView];
    }*/
    
    if(/*!([_addressTxt.text isEqualToString:@"Address"])&&!([_addressTxt.text isEqualToString:@" "])&&!([_addressTxt.text isEqualToString:@"Please enter Address."])&& !([_stateLicensureTxt.text isEqualToString:@""])&& !([_stateTxt.text isEqualToString:@""])&& !([_qualificationTxt.text isEqualToString:@""])&&*/
       !([_addressText.text isEqualToString:@""])&& !([_zipCodeTxt.text isEqualToString:@""])&&  !([_cityTxt.text isEqualToString:@""]) && !([_stateTxt.text isEqualToString:@""]))
    {
        NSMutableDictionary *data=[[NSMutableDictionary alloc]initWithDictionary:_userProfileData];
        NSMutableDictionary *personalDetails=[[NSMutableDictionary alloc] init];
        NSMutableDictionary *providerInfoData=[[NSMutableDictionary alloc] init];
        
        personalDetails=[data valueForKey:@"personalDetails"];
        providerInfoData=[data valueForKey:@"providerInfoData"];
        
        //[personalDetails setObject:_userNameText.text forKey:@"userName"];
        //[personalDetails setObject:@"" forKey:@"lastName"];
                
        //[data setObject:_aboutUs forKey:@"aboutSelf"];
        [providerInfoData setObject:_addressText.text forKey:@"address"];
        
        [providerInfoData setObject:@"State" forKey:@"licensureState"];
        
        
        [providerInfoData setObject:@" I am a software developer" forKey:@"aboutSelf"];
        [providerInfoData setObject:@"Kannada" forKey:@"languageSpoken"];
        
        [providerInfoData setObject:[_cityTxt.text stringByTrimmingCharactersInSet:
                                     [NSCharacterSet whitespaceCharacterSet]] forKey:@"city"];
        
        [providerInfoData setObject:_stateTxt.text forKey:@"state"];
        [providerInfoData setObject:[_zipCodeTxt.text stringByTrimmingCharactersInSet:
                                     [NSCharacterSet whitespaceCharacterSet]] forKey:@"zipCode"];
        
        [data removeObjectForKey:@"providerInfo"];
        [data removeObjectForKey:@"providerInfoData"];
        [data removeObjectForKey:@"personalDetails"];

        [data setObject:personalDetails forKey:@"personalDetails"];
        [data setObject:providerInfoData forKey:@"providerInfo"];
        
        //Added by: zeenath
        //Added Date: 19/07/2016
        //Discription: Service call to update the provider profile
        
        AppDelegate *appdelegate=(AppDelegate *)[[UIApplication sharedApplication]delegate];
        
        NSString *Url=[appdelegate.serviceURL stringByAppendingString:@"api/Provider/ProviderInfo"];
        [self startLoadingIndicator];
        [[GlobalFunction sharedInstance]getServerResponseAfterLogin:Url method:@"POST" param:data withCallback:^(NSInteger statusCode, NSDictionary *response, NSError *error) {
            if(statusCode == 200)
            {
                [appdelegate.usersDetails removeObjectForKey:@"firstName"];
                [appdelegate.usersDetails setObject:[[_userProfileData objectForKey:@"personalDetails"] objectForKey:@"firstName"] forKey:@"firstName"];
                
                /*[appdelegate.usersDetails removeObjectForKey:@"lastName"];
                [appdelegate.usersDetails setObject:[[_userProfileData objectForKey:@"personalDetails"] objectForKey:@"lastName"] forKey:@"lastName"]; */
                
                [appdelegate.usersDetails removeObjectForKey:@"profilePicPath"];
                [appdelegate.usersDetails setObject:[[_userProfileData objectForKey:@"personalDetails"] objectForKey:@"profilePicPath"] forKey:@"profilePicPath"];
                
                [self stopLoadingIndicator];
                NSString *message=[[GlobalFunction sharedInstance].arrayOfAlerts objectAtIndex:88];
                _alertView = [UIAlertController
                              alertControllerWithTitle:@""
                              message:message
                              preferredStyle:UIAlertControllerStyleAlert];
                
                UIAlertAction* okButton = [UIAlertAction
                                           actionWithTitle:@"OK"
                                           style:UIAlertActionStyleDefault
                                           handler:^(UIAlertAction * action) {
                                               AppDelegate *appdelegate=(AppDelegate *)[[UIApplication sharedApplication]delegate];
                                               appdelegate.prepopulateImage=nil;
                                             /*  UINavigationController *navController = self.navigationController;
                                               [navController popViewControllerAnimated:NO];
                                            [navController popViewControllerAnimated:YES];*/
                                            
                                               [[[self presentingViewController]presentingViewController] dismissViewControllerAnimated:YES completion:nil];
                                           }];
                [_alertView addAction:okButton];
                UIViewController *top = [self topMostController];
                [top presentViewController:_alertView animated:YES completion: nil];
            }
            else{
                [self stopLoadingIndicator];
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
                
                _alertView = [UIAlertController
                              alertControllerWithTitle:@""
                              message:message
                              preferredStyle:UIAlertControllerStyleAlert];
                
                UIAlertAction* okButton = [UIAlertAction
                                           actionWithTitle:@"OK"
                                           style:UIAlertActionStyleDefault
                                           handler:^(UIAlertAction * action) {
                                               AppDelegate *appdelegate=(AppDelegate *)[[UIApplication sharedApplication]delegate];
                                               appdelegate.prepopulateImage=_aboutUs;
                                              // [self.navigationController popViewControllerAnimated:YES];
                                                [[[self presentingViewController]presentingViewController] dismissViewControllerAnimated:YES completion:nil];
                                           }];
                [_alertView addAction:okButton];
                UIViewController *top = [self topMostController];
                [top presentViewController:_alertView animated:YES completion: nil];
            }
            
        }];
    }
    
}

//To identify which view is present in top
- (UIViewController*) topMostController {
    UIViewController *topController = [UIApplication sharedApplication].keyWindow.rootViewController;
    
    while (topController.presentedViewController) {
        topController = topController.presentedViewController;
    }
    
    return topController;
}


//Added by: nalina
//Added Date: 07/07/2016
//Discription: Set validation design to the input

-(void)SetValidationSettinds:(UITextField *)textField errorIcon:(UIButton *)errorBtn indicationIcon:(UIImageView *)indicationIcon validationMessage:(NSString *)validationMessage imageIs:(NSString *)imageIs viewField:(UIView *)viewIs{
    
    [textField setValue:[UIColor redColor] forKeyPath:@"_placeholderLabel.textColor"];
    textField.placeholder=validationMessage;
    errorBtn.hidden=NO;
    UIImage *image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:imageIs ofType:@"png"]];
    indicationIcon.image = image;
    viewIs.layer.borderColor = [[UIColor redColor]CGColor];
    viewIs.layer.borderWidth = 1.0f;
    
}

//Added by: nalina
//Added Date: 07/07/2016
//Discription: Set validation design to the text view field

-(void)SetValidationSettingsTextView:(UITextView *)textView errorIcon:(UIButton *)errorBtn indicationIcon:(UIImageView *)indicationIcon validationMessage:(NSString *)validationMessage imageIs:(NSString *)imageIs viewField:(UIView *)viewIs{
    
    
    textView.text=validationMessage;
    errorBtn.hidden=NO;
    UIImage *image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:imageIs ofType:@"png"]];
    indicationIcon.image = image;
    textView.textColor=[UIColor redColor];
    viewIs.layer.borderColor = [[UIColor redColor]CGColor];
    viewIs.layer.borderWidth = 1.0f;
}

//Calls when text fields begins editing
/*- (BOOL) textViewShouldBeginEditing:(UITextView *)textView
{
    [self RemoveValidationSettingTextView:_addressTxt errorIcon:_addressError indicationIcon:_addressIcon HintText:@"" imageIs:@"address" viewField:_addressView];
    if([_addressTxt.text isEqualToString:@"Address"])
    {
        _addressTxt.text = @"";
    }
   // _addressTxt.text = @"";
    _addressTxt.textColor = [UIColor blackColor];
    return YES;
}*/

//Calls when text view begins editing
/*- (void)textViewDidBeginEditing:(UITextView *)textView{
    [self RemoveValidationSettingTextView:_addressTxt errorIcon:_addressError indicationIcon:_addressIcon HintText:@"" imageIs:@"address" viewField:_addressView];
}

-(void) textViewDidChange:(UITextView *)textView
{
    if(_addressTxt.text.length == 0){
    }
} */

//Calls when user clicks on back icon
- (IBAction)pageBackClick:(id)sender {
    AppDelegate *appdelegate=(AppDelegate *)[[UIApplication sharedApplication]delegate];
    appdelegate.prepopulateImage=_aboutUs;
    [self dismissViewControllerAnimated:YES completion:nil];
}


//  Added by:Zeenath
//  Added Date:2016-24-08.
//  Description:Function To focus the textfield and scroll back when keyboard is returned.
- (void)textFieldDidBeginEditing:(UITextField *)textField {
  //  svos = _scrollview.contentOffset;
    CGPoint pt;
    CGRect rc = [textField bounds];
    rc = [textField convertRect:rc toView:_scrollView];
    pt = rc.origin;
    pt.x = 0;
    pt.y -= -5;
    [_scrollView setContentOffset:pt animated:YES];
}


//  Added by:Zeenath
//  Added Date:2016-22-08.
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
//  Added Date:2016-22-08.
//  Description:To stop the activity indicator.

-(void)stopLoadingIndicator
{
    _loadingView.hidden=YES;
}


-(void)secondTotmClick:(UITapGestureRecognizer *)recognizer {
  
    
    pickerArray = [[NSMutableArray alloc]initWithObjects:@"Alabama",
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
    [self resignSoftKeyboard];
    [self.pickerView reloadAllComponents];
    _pickerBackView.hidden=NO;
    clickedbutton=@"secondTotime";
    [_stateTxt setValue:[UIColor  colorWithRed:(112/255.0) green:(112/255.0) blue:(112/255.0) alpha:1] forKeyPath:@"_placeholderLabel.textColor"];
    _stateTxt.placeholder=@"";
    
}


//Called when a row in the pickerview is selected
- (void)pickerView:(UIPickerView *)thePickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    //[_timePickerView selectRow:0 inComponent:0 animated:YES];
    
    [_stateTxt setText:[pickerArray objectAtIndex:row]];
    _pickerBackView.hidden=YES;
    [self.userNameText becomeFirstResponder];
    [self resignSoftKeyboard];
    
    
}

- (IBAction)userNameErrorClick:(id)sender {
     [self RemoveValidationSettings:_userNameText errorIcon:_userNameErrorClose indicationIcon:_userNameIcon HintText:@"Username" imageIs:@"username" viewField:nil];
}

-(void)resignSoftKeyboard{
    [_addressTxt resignFirstResponder];
    [_cityTxt resignFirstResponder];
    [_zipCodeTxt resignFirstResponder];
    [_userNameText resignFirstResponder];
    [_stateTxt resignFirstResponder];
    
}



- (IBAction)CancelBtnClick:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
