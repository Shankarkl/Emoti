
/***************************************************************
 Page name:  ProviderSignUpSecondViewController.h
 Created By: Zeenath
 Created Date:01/07/16
 Description: Provider SignUp implementation file
 ***************************************************************/

#import "ProviderSignUpSecondViewController.h"
#import "GlobalFunction.h"
#import "UploadProfilePicture.h"
#import "AppDelegate.h"
#import <Google/Analytics.h>
#import "ProviderSignUpThirdViewController.h"

#define appdelegate (AppDelegate *)[[UIApplication sharedApplication]delegate]

@interface ProviderSignUpSecondViewController ()

@end

@implementation ProviderSignUpSecondViewController


//Called when the view controller is first time loaded to memory
- (void)viewDidLoad {
    [super viewDidLoad];
    
    _eyeIconBtn.hidden = YES;
    _eyeIconSecondBtn.hidden = YES;
    UIButton *subBtn = (UIButton *) [self.view viewWithTag:5];
    subBtn.layer.borderColor = [UIColor colorWithRed:246.0/255.0 green:108.0/255.0 blue:118.0/255.0 alpha:1].CGColor;
    // Do any additional setup after loading the view.
    
    //  Added by:Zeenath
    //  Added Date:2016-01-07.
    //  Description:To set the textfield delegate and control methods.
    
    [self setBorder:_addressView];
    [self setBorder:_cityView];
    [self setBorder:_stateView];
    [self setBorder:_zipcodeView];
    [self setBorder:_usernameView];
    [self setBorder:_passwordView];
    [self setBorder:_confirmPasswordView];
    
    _addressTextView.text = @"Address";
    _addressTextView.textColor = [UIColor darkGrayColor];
    _addressTextView.editable=true;
    _addressTextView.delegate = self;
    _cityTextField.delegate=self;
    _stateTextField.delegate=self;
    _zipcodeTextField.delegate=self;
    _usernameTextField.delegate=self;
    _passwordTextField.delegate=self;
    _confirmPasswordTextField.delegate=self;
    
    
    /* [self.addressTextView addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventAllTouchEvents];
     [self.addressTextView addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];*/
    
    
    [self.cityTextField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventAllTouchEvents];
    [self.cityTextField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    
    [self.stateTextField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventAllTouchEvents];
    [self.stateTextField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    
    [self.zipcodeTextField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventAllTouchEvents];
    [self.zipcodeTextField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    
    [self.usernameTextField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventAllTouchEvents];
    [self.usernameTextField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    
    [self.passwordTextField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventAllTouchEvents];
    [self.passwordTextField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    
    [self.confirmPasswordTextField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventAllTouchEvents];
    [self.confirmPasswordTextField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    
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
    [self resignSoftKeyboard];
    _pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 44, 0, 0)];
    
    [_pickerView setDataSource: self];
    [_pickerView setDelegate: self];
    _pickerView.showsSelectionIndicator = YES;
    
    //[self.view insertSubview:_pickerView atIndex:0];
    
    
    UITapGestureRecognizer *singleFingerTap =
    [[UITapGestureRecognizer alloc] initWithTarget:self
                                            action:@selector(handleSingleTapped:)];
    [self.pickerBackView addGestureRecognizer:singleFingerTap];
    
    
    UITapGestureRecognizer *stateTap =
    [[UITapGestureRecognizer alloc] initWithTarget:self
                                            action:@selector(handleStateTapped:)];
    [self.stateTextField addGestureRecognizer:stateTap];
    
    /*UIImageView *bgImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"LoginBackground.png"]];
     bgImageView.frame = self.mainViewBackground.bounds;
     [_mainViewBackground addSubview:bgImageView];
     [_mainViewBackground sendSubviewToBack:bgImageView];*/
    
    UIImage *backgroundImage = [UIImage imageNamed:@"LoginBackground.png"];
    UIImageView *backgroundImageView=[[UIImageView alloc]initWithFrame:self.view.frame];
    backgroundImageView.image=backgroundImage;
    [self.view insertSubview:backgroundImageView atIndex:0];
    
}


//  Added by:Zeenath
//  Added Date:2016-2-07.
//  Description:To hide the popup view.

- (void)handleSingleTapped:(UITapGestureRecognizer *)recognizer {
    
    //Do stuff here...
    _pickerBackView.hidden=YES;
     [self resignSoftKeyboard];
    
}


//  Added by:Zeenath
//  Added Date:2016-20-07.
//  Description:To show the picker view for state licensure.
- (void)handleStateTapped:(UITapGestureRecognizer *)recognizer {
    
   /* [_addressTextView resignFirstResponder];
    [_cityTextField resignFirstResponder];
    [_zipcodeTextField resignFirstResponder];
    [_usernameTextField resignFirstResponder];
    [_passwordTextField resignFirstResponder];
    [_confirmPasswordTextField resignFirstResponder];*/
    //Do stuff here...
     [self resignSoftKeyboard];
    _pickerBackView.hidden=NO;
    
    
    
}

//Returns number of components in pickerview
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)thePickerView {
    
    return 1;//Or return whatever as you intend
}

//Returns number of rows in pickerview
- (NSInteger)pickerView:(UIPickerView *)thePickerView numberOfRowsInComponent:(NSInteger)component {
    
    return [_pickerArray count];//Or, return as suitable for you...normally we use array for dynamic
}

//Set the title for each rows in pickerview
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:
(NSInteger)row forComponent:(NSInteger)component{
    return [_pickerArray objectAtIndex:row];
}


//Called when a row in the pickerview is selected
- (void)pickerView:(UIPickerView *)thePickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    
    [_pickerView selectRow:0 inComponent:0 animated:YES];
    
    [_stateTextField setText:[_pickerArray objectAtIndex:row]];
    
    [self RemoveValidationSetting:_stateTextField errorIcon:_stateCloseButton indicationIcon:_stateIcon HintText:@"State" imageIs:@"city" viewField:_stateView];
    
    _pickerBackView.hidden=YES;
     [self.zipcodeTextField becomeFirstResponder];
    [self resignSoftKeyboard];
   
}

// Description: Function to resign the keyboard
-(void)resignSoftKeyboard{
    [_stateTextField resignFirstResponder];
    [_zipcodeTextField resignFirstResponder];
    [_cityTextField resignFirstResponder];
    [_stateTextField resignFirstResponder];
    [_passwordTextField resignFirstResponder];
    [_confirmPasswordTextField resignFirstResponder];
    [_usernameTextField resignFirstResponder];
     [_addressTextView resignFirstResponder];
}

//  Added by:Zeenath
//  Added Date:2016-2-07.
//  Description:called when the textfield is about to begin editing.
- (BOOL) textFieldShouldBeginEditing:(UITextField *)textField
{
   
    if(textField == _stateTextField)
       
    {
        //textField.enabled = NO;
        _pickerBackView.hidden=NO;
        [self resignSoftKeyboard];
        return NO;
    }
    
    return YES;
}

// Dispose of any resources that can be recreated.
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


//called each time when the view appears
-(void)viewWillAppear:(BOOL)animated
{
    if([[appdelegate prepopulateDataProviderReg] objectForKey:@"address"] != nil)
    {
        _addressTextView.text=[[appdelegate prepopulateDataProviderReg] objectForKey:@"address"];
    }
    else
    {
        _addressTextView.text = @"Address";
    }
    _stateTextField.text=[[appdelegate prepopulateDataProviderReg] objectForKey:@"state"];
    _cityTextField.text=[[appdelegate prepopulateDataProviderReg] objectForKey:@"city"];
    _zipcodeTextField.text=[[appdelegate prepopulateDataProviderReg] objectForKey:@"zipCode"];
    _usernameTextField.text=[[appdelegate prepopulateDataProviderReg] objectForKey:@"username"];
    _passwordTextField.text=@"";
    _confirmPasswordTextField.text=[[appdelegate prepopulateDataProviderReg] objectForKey:@"confirmPassword"];
}


//  Added by:Zeenath
//  Added Date:2016-2-07.
//  Description:To set the border for the views with textfield.
-(void)setBorder:(UIView *)img
{
    
    img.layer.borderColor = [[UIColor colorWithRed:228.0/255.0 green:109.0/255.0 blue:175.0/255.0 alpha:1.0]CGColor];
    img.layer.borderWidth = 1.0f;
    
}

//  Added by:Zeenath
//  Added Date:2016-2-07.
//  Description:called when the textview is about to begin editing.
- (BOOL) textViewShouldBeginEditing:(UITextView *)textView
{
    [self RemoveValidationSettingTextView:_addressTextView errorIcon:_addressCloseButton indicationIcon:_addressIcon HintText:@"Address" imageIs:@"address" viewField:_addressView];
    if([_addressTextView.text isEqualToString:@"Address"] || [_addressTextView.text isEqualToString:@"Please enter your Address."])
    {
        _addressTextView.text = @"";
    }
    _addressTextView.textColor = [UIColor blackColor];
    return YES;
}


//  Added by:Zeenath
//  Added Date:2016-2-07.
//  Description:called when the text in the textview is changed.
-(void) textViewDidChange:(UITextView *)textView
{
    
    if(_addressTextView.text.length == 0){
        _addressTextView.textColor = [UIColor lightGrayColor];
        _addressTextView.text = @"Address";
        [_cityTextField becomeFirstResponder];
    }
}

//  Added by:Zeenath
//  Added Date:2016-2-07.
//  Description:Show the validation message for the textfield.
-(void)SetValidationSettings:(UITextField *)textField errorIcon:(UIButton *)errorBtn indicationIcon:(UIImageView *)indicationIcon validationMessage:(NSString *)validationMessage imageIs:(NSString *)imageIs viewField:(UIView *)viewIs{
    
    [textField setValue:[UIColor redColor] forKeyPath:@"_placeholderLabel.textColor"];
    textField.placeholder=validationMessage;
    errorBtn.hidden=NO;
    UIImage *image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:imageIs ofType:@"png"]];
    indicationIcon.image = image;
    viewIs.layer.borderColor = [[UIColor redColor]CGColor];
    viewIs.layer.borderWidth = 1.0f;
    
    
}


//  Added by:Zeenath
//  Added Date:2016-2-07.
//  Description:Show the validation message for the textview.
-(void)SetValidationSettingsTextView:(UITextView *)textView errorIcon:(UIButton *)errorBtn indicationIcon:(UIImageView *)indicationIcon validationMessage:(NSString *)validationMessage imageIs:(NSString *)imageIs viewField:(UIView *)viewIs{
    
    
    textView.text=validationMessage;
    errorBtn.hidden=NO;
    UIImage *image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:imageIs ofType:@"png"]];
    indicationIcon.image = image;
    textView.textColor=[UIColor redColor];
    viewIs.layer.borderColor = [[UIColor redColor]CGColor];
    viewIs.layer.borderWidth = 1.0f;
}


//  Added by:Zeenath
//  Added Date:2016-2-07.
//  Description:Function to focus the textfield and return the keyboard.
- (BOOL)textFieldShouldReturn:(UITextField *)theTextField {
    
    
    if (theTextField == self.AddressTextField) {
        
        [self.cityTextField becomeFirstResponder];
    }
    
    if (theTextField == self.cityTextField) {
        
        //[self.stateTextField becomeFirstResponder];
        [theTextField resignFirstResponder];
        
    }
    
    if (theTextField == self.stateTextField) {
        [_stateDropIcon setHidden:NO];
        [self.zipcodeTextField becomeFirstResponder];
    }
    
    if (theTextField == self.zipcodeTextField) {
        [self.usernameTextField becomeFirstResponder];
    }if (theTextField == self.usernameTextField) {
        
        [self.passwordTextField becomeFirstResponder];
    }
    if (theTextField == self.passwordTextField) {
        [self.confirmPasswordTextField becomeFirstResponder];
    }   if (theTextField == self.confirmPasswordTextField) {
        [theTextField resignFirstResponder];
    }
    
    return YES;
}


//  Added by:Zeenath
//  Added Date:2016-2-07.
//  Description:Function called when the text in the textfield is changed.
-(void) textFieldDidChange:(UITextField *)theTextField
{
    // GlobalFunction *globalValues=[[GlobalFunction alloc]init];
    if([theTextField isEqual:_addressTextView])
    {
        [self RemoveValidationSettingTextView:_addressTextView errorIcon:_addressCloseButton indicationIcon:_addressIcon HintText:@"Address " imageIs:@"address" viewField:_addressView];
        
    }    if([theTextField isEqual:_cityTextField])
    {
        [self RemoveValidationSetting:_cityTextField errorIcon:_cityCloseButton indicationIcon:_cityIcon HintText:@"city" imageIs:@"city" viewField:_cityView];
        
    }
    
    if([theTextField isEqual:_stateTextField])
    {
        [_pickerBackView setHidden:NO];
        [self RemoveValidationSetting:_stateTextField errorIcon:_stateCloseButton indicationIcon:_stateIcon HintText:@"State" imageIs:@"city" viewField:_stateView];
        
    }
    if([theTextField isEqual:_zipcodeTextField])
    {
        [self RemoveValidationSetting:_zipcodeTextField errorIcon:_zipcodeCloseButton indicationIcon:_zipcodeIcon HintText:@"Zipcode" imageIs:@"password" viewField:_zipcodeView];
        
    }
    if([theTextField isEqual:_usernameTextField])
    {
        [self RemoveValidationSetting:_usernameTextField errorIcon:_usernameCloseButton indicationIcon:_usernameIcon HintText:@"Username" imageIs:@"username" viewField:_usernameView];
        
    }
    if([theTextField isEqual:_passwordTextField])
    {
        _InfoIcon.hidden=NO;
        [self RemoveValidationSetting:_passwordTextField errorIcon:_passwordCloseButton indicationIcon:_passwordIcon HintText:@"Password" imageIs:@"password" viewField:_passwordView];
        
        if([theTextField isEqual: _passwordTextField]){
            
            _InfoIcon.hidden = YES;
            _eyeIconBtn.hidden = NO;
        }
        if([_passwordTextField.text isEqualToString:@""]){
            
            _InfoIcon.hidden = NO;
            _eyeIconBtn.hidden = YES;
        }
        
        
        
    }
    if([theTextField isEqual:_confirmPasswordTextField])
    {
        [self RemoveValidationSetting:_confirmPasswordTextField errorIcon:_confirmPasswordCloseButton indicationIcon:_confirmPasswordIcon HintText:@"Confirm Password" imageIs:@"password" viewField:_confirmPasswordView];
        
        if([theTextField isEqual: _confirmPasswordTextField]){
            
            _confirmPassWordInfoIcon.hidden = YES;
            _eyeIconSecondBtn.hidden = NO;
        }
        if([_confirmPasswordTextField.text isEqualToString:@""]){
            
            _confirmPassWordInfoIcon.hidden = NO;
            _eyeIconSecondBtn.hidden = YES;
        }
    }
    
    
    
}


//  Added by:Zeenath
//  Added Date:2016-2-07.
//  Description:Regular expression for the validation of name field.

- (BOOL)validateNameField:(NSString*)name
{
    NSString *nameRegex = @"^[a-zA-Z ]*$";
    NSPredicate *nameTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", nameRegex];
    return [nameTest evaluateWithObject:name];
}


//  Added by:Zeenath
//  Added Date:2016-2-07.
//  Description:Regular expression for the validation of number field.
- (BOOL)validateNumberField:(NSString*)number
{
    NSString *nameRegex = @"^[a-zA-Z0-9 ]*$";
    NSPredicate *nameTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", nameRegex];
    return [nameTest evaluateWithObject:number];
}

//  Added by:Zeenath
//  Added Date:2016-2-07.
//  Description:Regular expression for the validation of zipcode field.
- (BOOL)validateZipcodeField:(NSString*)number
{
    NSString *nameRegex = @"^[a-zA-Z0-9]*$";
    NSPredicate *nameTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", nameRegex];
    return [nameTest evaluateWithObject:number];
}

//  Added by:Zeenath
//  Added Date:2016-2-07.
//  Description:Function to remove validation for the textfields.
-(void)RemoveValidationSetting:(UITextField *)textField errorIcon:(UIButton *)errorBtn indicationIcon:(UIImageView *)indicationIcon HintText:(NSString *)hintTextMessage imageIs:(NSString *)imageIs viewField:(UIView *)view{
    
    [textField setValue:[UIColor  colorWithRed:(112/255.0) green:(112/255.0) blue:(112/255.0) alpha:1] forKeyPath:@"_placeholderLabel.textColor"];
    textField.placeholder=hintTextMessage;
    errorBtn.hidden=YES;
    UIImage *image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:imageIs ofType:@"png"]];
    indicationIcon.image = image;
    [self setBorder:view];
    
}


//  Added by:Zeenath
//  Added Date:2016-2-07.
//  Description:Function to remove validation for the textview.
-(void)RemoveValidationSettingTextView:(UITextView *)textField errorIcon:(UIButton *)errorBtn indicationIcon:(UIImageView *)indicationIcon HintText:(NSString *)hintTextMessage imageIs:(NSString *)imageIs viewField:(UIView *)view{
    
    [textField setValue:[UIColor  colorWithRed:(112/255.0) green:(112/255.0) blue:(112/255.0) alpha:1] forKeyPath:@"_placeholderLabel.textColor"];
    if(! [hintTextMessage isEqualToString:@"" ]){
        textField.text=hintTextMessage;
    }
    
    errorBtn.hidden=YES;
    UIImage *image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:imageIs ofType:@"png"]];
    indicationIcon.image = image;
    [self setBorder:view];
    
}


//  Added by:Zeenath
//  Added Date:2016-2-07.
//  Description:Function called when the textview is begin editing.
- (void)textViewDidBeginEditing:(UITextView *)textView{
    [self RemoveValidationSettingTextView:_addressTextView errorIcon:_addressCloseButton indicationIcon:_addressIcon HintText:@"" imageIs:@"address" viewField:_addressView];
}



//  Added by:Zeenath
//  Added Date:2016-2-07.
//  Description:Functions To remove the validation message on click of close button.
- (IBAction)addressCloseAction:(id)sender {
    
    _addressTextView.textColor = [UIColor darkGrayColor];
    [self RemoveValidationSettingTextView:_addressTextView errorIcon:_addressCloseButton indicationIcon:_addressIcon HintText:@"Address" imageIs:@"address" viewField:_addressView];
}

- (IBAction)cityCloseAction:(id)sender {
    
    [self RemoveValidationSetting:_cityTextField errorIcon:_cityCloseButton indicationIcon:_cityIcon HintText:@"city" imageIs:@"city" viewField:_cityView];
}

- (IBAction)stateCloseAction:(id)sender {
    [_stateDropIcon setHidden:NO];
    [self RemoveValidationSetting:_stateTextField errorIcon:_stateCloseButton indicationIcon:_stateIcon HintText:@"State" imageIs:@"city" viewField:_stateView];
}

- (IBAction)zipcodeCloseAction:(id)sender {
    
    [self RemoveValidationSetting:_zipcodeTextField errorIcon:_zipcodeCloseButton indicationIcon:_zipcodeIcon HintText:@"Zip code" imageIs:@"password" viewField:_zipcodeView];
}

- (IBAction)usernameCloseButton:(id)sender {
    
    [self RemoveValidationSetting:_usernameTextField errorIcon:_usernameCloseButton indicationIcon:_zipcodeIcon HintText:@"Username" imageIs:@"password" viewField:_usernameView];
}

- (IBAction)passwordCloseAction:(id)sender {
    _InfoIcon.hidden=NO;
    [self RemoveValidationSetting:_passwordTextField errorIcon:_passwordCloseButton indicationIcon:_passwordIcon HintText:@"Password" imageIs:@"password" viewField:_passwordView];
}

- (IBAction)confirmpasswordCloseAction:(id)sender {
    _confirmPassWordInfoIcon.hidden=NO;
    [self RemoveValidationSetting:_confirmPasswordTextField errorIcon:_confirmPasswordCloseButton indicationIcon:_confirmPasswordIcon HintText:@"Confirm Password" imageIs:@"password" viewField:_confirmPasswordView];
    
    
}


//  Added by:Zeenath
//  Added Date:2016-2-07.
//  Description:Regular expression for the validation of password field.
- (BOOL)validatePassword:(NSString*)password
{
    NSString *passwordRegex = @"^(?=.*[A-Z])(?=.*[0-9])(?=.*[$@$!%*#?&])[A-Za-z0-9$@$!%*#?&]{8,12}$";
    NSPredicate *passwordTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", passwordRegex];
    return [passwordTest evaluateWithObject:password];
}

//  Added by:Zeenath
//  Added Date:2016-2-07.
//  Description:To show the state dropdown on click of arrow.
- (IBAction)stateArrowAction:(id)sender {
    
    _pickerBackView.hidden=NO;
}


//  Added by:Zeenath
//  Added Date:2016-2-07.
//  Description:To show the validation message for a valid password.
- (IBAction)infoButton:(id)sender {
    
    //  GlobalFunction *globalValues=[[GlobalFunction alloc]init];
    [self RemoveValidationSetting:_passwordTextField errorIcon:_passwordCloseButton indicationIcon:_passwordIcon HintText:@"Password" imageIs:@"password" viewField:_passwordView];
    _InfoIcon.hidden=NO;
    
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

//  Added by:Zeenath
//  Added Date:2016-8-07.
//  Description:To focus the textfield.
- (void)textFieldDidBeginEditing:(UITextField *)textField {
    svos = _scrollView.contentOffset;
    CGPoint pt;
    CGRect rc = [textField bounds];
    rc = [textField convertRect:rc toView:_scrollView];
    pt = rc.origin;
    pt.x = 0;
    pt.y -= -5;
    [_scrollView setContentOffset:pt animated:YES];
}


//  Added by:Zeenath
//  Added Date:2016-8-07.
//  Description:Called when the back button is clicked and to store the data entered for prepopulation.
- (IBAction)PasswordInfoIcon:(id)sender {
}

- (IBAction)stateDropClick:(id)sender {
}

- (IBAction)backClick:(id)sender {
    
    AppDelegate *appdelegat= (AppDelegate *)[[UIApplication sharedApplication]delegate];
    //if([appdelegate prepopulateDataProviderReg].count >0
    //   )
    //{
    [_providerDetails setObject:[_addressTextView.text stringByTrimmingCharactersInSet:
                                 [NSCharacterSet whitespaceCharacterSet]] forKey:@"address"];
    [_providerDetails setObject:[_stateTextField.text stringByTrimmingCharactersInSet:
                                 [NSCharacterSet whitespaceCharacterSet]] forKey:@"state"];
    
    
    /* [_providerDetails setObject:[_stateTextField.text stringByTrimmingCharactersInSet:
     [NSCharacterSet whitespaceCharacterSet]] forKey:@"licensureState"];*/
    [_providerDetails setObject:[_cityTextField.text stringByTrimmingCharactersInSet:
                                 [NSCharacterSet whitespaceCharacterSet]] forKey:@"city"];
    [_providerDetails setObject:[_zipcodeTextField.text stringByTrimmingCharactersInSet:
                                 [NSCharacterSet whitespaceCharacterSet]] forKey:@"zipCode"];
    
    NSString *phone = @"1234587867";
    [_providerDetails setObject:[phone stringByTrimmingCharactersInSet:
                                 [NSCharacterSet whitespaceCharacterSet]] forKey:@"phoneNumber"];
    
    [_providerDetails setObject:_usernameTextField.text forKey:@"userName"];
    [_providerDetails setObject:_passwordTextField.text forKey:@"password"];
    [_providerDetails setObject:_confirmPasswordTextField.text forKey:@"confirmPassword"];
    appdelegat.prepopulateDataProviderReg =_providerDetails;
    // }
    
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)backArrowClick:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}


//  Added by:Zeenath
//  Added Date:2016-8-07.
//  Description:Called when the next button is clicked, validating all the textfiekds  and to store the data entered for prepopulation.
- (IBAction)nextClick:(id)sender {
    CGPoint pt;
    
    pt.x = 0;
    pt.y = 10;
    [_scrollView setContentOffset:pt animated:YES];
    //  GlobalFunction *globalValues=[[GlobalFunction alloc]init];
    if([_addressTextView.text isEqualToString:@"Address"] || [_addressTextView.text isEqualToString:@""])
    {
        [self SetValidationSettingsTextView:_addressTextView errorIcon:_addressCloseButton indicationIcon:_addressIcon validationMessage:[[GlobalFunction sharedInstance].arrayOfAlerts objectAtIndex:25] imageIs:@"error-address" viewField:_addressView];
    }
    
    if([_cityTextField.text isEqualToString:@""])
    {
        [self SetValidationSettings:_cityTextField errorIcon:_cityCloseButton indicationIcon:_cityIcon validationMessage:[[GlobalFunction sharedInstance].arrayOfAlerts objectAtIndex:23] imageIs:@"error-city" viewField:_cityView];
    }
    else if(!([self validateNameField:_cityTextField.text])) {
        _cityTextField.text=@"";
        [self SetValidationSettings:_cityTextField errorIcon:_cityCloseButton indicationIcon:_cityIcon validationMessage:[[GlobalFunction sharedInstance].arrayOfAlerts objectAtIndex:36] imageIs:@"error-city" viewField:_cityView];
    }
    
    if([_stateTextField.text isEqualToString:@""])
    {
        [_stateDropIcon setHidden:YES];
        [self SetValidationSettings:_stateTextField errorIcon:_stateCloseButton indicationIcon:_stateIcon validationMessage:[[GlobalFunction sharedInstance].arrayOfAlerts objectAtIndex:24] imageIs:@"error-city" viewField:_stateView];
    }
    else if(!([self validateNameField:_stateTextField.text])) {
        [_stateDropIcon setHidden:YES];
        [self SetValidationSettings:_stateTextField errorIcon:_stateCloseButton indicationIcon:_stateIcon validationMessage:[[GlobalFunction sharedInstance].arrayOfAlerts objectAtIndex:37] imageIs:@"error-city" viewField:_stateView];
    }
    if([_zipcodeTextField.text isEqualToString:@""])
    {
        [self SetValidationSettings:_zipcodeTextField errorIcon:_zipcodeCloseButton indicationIcon:_zipcodeIcon validationMessage:[[GlobalFunction sharedInstance].arrayOfAlerts objectAtIndex:16] imageIs:@"error-password" viewField:_zipcodeView];
    }
    else if(!([self validateZipcodeField:_zipcodeTextField.text])) {
        [self SetValidationSettings:_zipcodeTextField errorIcon:_zipcodeCloseButton indicationIcon:_zipcodeIcon validationMessage:[[GlobalFunction sharedInstance].arrayOfAlerts objectAtIndex:35] imageIs:@"error-password" viewField:_zipcodeView];
    }
    
    if([_usernameTextField.text isEqualToString:@""])
    {
        [self SetValidationSettings:_usernameTextField errorIcon:_usernameCloseButton indicationIcon:_usernameIcon validationMessage:@"Please enter username." imageIs:@"error-username" viewField:_passwordView];
    }
    else if(!([self validateNameField:_usernameTextField.text])) {
        
        //_usernameTextField.text=@"";
        _usernameTextField.text=@"";
        [self SetValidationSettings:_usernameTextField errorIcon:_usernameCloseButton indicationIcon:_usernameIcon validationMessage:[[GlobalFunction sharedInstance].arrayOfAlerts objectAtIndex:31] imageIs:@"error-username" viewField:_usernameView];
        
    }
    
    if([_passwordTextField.text isEqualToString:@""])
    {
        [_InfoIcon setHidden:YES];
        [self SetValidationSettings:_passwordTextField errorIcon:_passwordCloseButton indicationIcon:_passwordIcon validationMessage:@"Please enter Password." imageIs:@"error-password" viewField:_passwordView];
    }
    else if(!([self validatePassword:_passwordTextField.text])) {
        [_InfoIcon setHidden:YES];
        _passwordTextField.text=@"";
        _confirmPasswordTextField.text=@"";
        [self SetValidationSettings:_passwordTextField errorIcon:_passwordCloseButton indicationIcon:_passwordIcon validationMessage:[[GlobalFunction sharedInstance].arrayOfAlerts objectAtIndex:7] imageIs:@"error-password" viewField:_passwordView];
        
    }
    if([_confirmPasswordTextField.text isEqualToString:@""])
    {
        [_confirmPassWordInfoIcon setHidden:YES];
        
        [self SetValidationSettings:_confirmPasswordTextField errorIcon:_confirmPasswordCloseButton indicationIcon:_confirmPasswordIcon validationMessage:@"Please enter Confirm password." imageIs:@"error-password" viewField:_confirmPasswordView];
    }
    if(!([_confirmPasswordTextField.text isEqualToString:_passwordTextField.text])){
        [_confirmPassWordInfoIcon setHidden:YES];
        _confirmPasswordTextField.text=@"";
        [self SetValidationSettings:_confirmPasswordTextField errorIcon:_confirmPasswordCloseButton indicationIcon:_confirmPasswordIcon validationMessage:[[GlobalFunction sharedInstance].arrayOfAlerts objectAtIndex:8] imageIs:@"error-password" viewField:_confirmPasswordView];
    }
    
    if(!([_addressTextView.text isEqualToString:@"Address"])&& !([_addressTextView.text isEqualToString:@""]) && !([_cityTextField.text isEqualToString:@""])&& !([_stateTextField.text isEqualToString:@""])&& !([_zipcodeTextField.text isEqualToString:@""])&& !([_usernameTextField.text isEqualToString:@""])&& !([_passwordTextField.text isEqualToString:@""])&& ([self validatePassword:_passwordTextField.text])&& !([_confirmPasswordTextField.text isEqualToString:@""])&& ([_confirmPasswordTextField.text isEqual:_passwordTextField.text])){
        
        
        //UploadProfilePicture *vc=[self.storyboard instantiateViewControllerWithIdentifier:@"uploadProfilePic"];
        
        //Added by: Manohar
        //Date: 21/04/2017
        //Description: Service Call to check duplicate user name
        
        BOOL internetCheck= [appdelegate testInternetConnection];
        AppDelegate *appdeleg= (AppDelegate *)[[UIApplication sharedApplication]delegate];
        
        
        NSString *duplicatuserUrl=[appdeleg.serviceURL stringByAppendingString:@"api/Account/CheckUser"];
        NSMutableDictionary *duplicateuserData = [[NSMutableDictionary alloc] init];
        [duplicateuserData setObject:[_usernameTextField.text stringByTrimmingCharactersInSet:
                                      [NSCharacterSet whitespaceCharacterSet]] forKey:@"userNameOrEmail"];
        [duplicateuserData setObject:@"UserName" forKey:@"checkType"];
        if (internetCheck) {
            [self startLoadingIndicator];
        }
        [[GlobalFunction sharedInstance] getServerResponseForUrl:duplicatuserUrl method:@"POST" param:duplicateuserData withCallback:^(NSInteger statusCode, NSDictionary *response, NSError *error)
         {
             NSString *message;
             
             if (statusCode == 200)
             {
                 ProviderSignUpThirdViewController *vc=[self.storyboard instantiateViewControllerWithIdentifier:@"ProviderSignUpThirdView"];
                 
                 [_providerDetails setObject:[_addressTextView.text stringByTrimmingCharactersInSet:
                                              [NSCharacterSet whitespaceCharacterSet]] forKey:@"address"];
                 [_providerDetails setObject:[_stateTextField.text stringByTrimmingCharactersInSet:
                                              [NSCharacterSet whitespaceCharacterSet]] forKey:@"state"];
                 [_providerDetails setObject:[_cityTextField.text stringByTrimmingCharactersInSet:
                                              [NSCharacterSet whitespaceCharacterSet]] forKey:@"city"];
                 [_providerDetails setObject:[_zipcodeTextField.text stringByTrimmingCharactersInSet:
                                              [NSCharacterSet whitespaceCharacterSet]] forKey:@"zipCode"];
                 
                 
                 
                 //Adding username and confirm password to dictionary
                 
                 [_providerDetails setObject:[_usernameTextField.text stringByTrimmingCharactersInSet:
                                              [NSCharacterSet whitespaceCharacterSet]] forKey:@"username"];
                 
                 [_providerDetails setObject:_passwordTextField.text forKey:@"password"];
                 
                 vc.userDetails=_providerDetails;
                 
                 [_providerDetails setObject:[_confirmPasswordTextField.text stringByTrimmingCharactersInSet:
                                              [NSCharacterSet whitespaceCharacterSet]] forKey:@"confirmPassword"];
                 
                 appdeleg.prepopulateDataProviderReg= _providerDetails;
                 [self presentViewController:vc animated:YES completion:nil];
                 
                 [self stopLoadingIndicator];
                 
                 
             } else {
                 
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

- (IBAction)confirmPassowrdInfoClick:(id)sender {
    [self RemoveValidationSetting:_passwordTextField errorIcon:_passwordCloseButton indicationIcon:_passwordIcon HintText:@"Password" imageIs:@"password" viewField:_passwordView];
    _InfoIcon.hidden=NO;
    
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




- (IBAction)eyeBtnTouchUpClick:(id)sender {
    _passwordTextField.secureTextEntry = YES;
    
}

- (IBAction)eyeBtnDownClick:(id)sender {
    _passwordTextField.secureTextEntry = NO;

}
- (IBAction)eyeIconSecTouchUp:(id)sender {
    _confirmPasswordTextField.secureTextEntry = YES;

}

- (IBAction)eyeIconTouchDown:(id)sender {
    _confirmPasswordTextField.secureTextEntry = NO;
}
@end

