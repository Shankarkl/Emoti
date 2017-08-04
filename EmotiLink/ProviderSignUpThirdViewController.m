//
//  ProviderSignUpThirdViewController.m
//  
//
//  Created by Starsoft on 2017-03-18.
//
//

#import "ProviderSignUpThirdViewController.h"
#import "ProviderSignUpProfFitness.h"
#include "AppDelegate.h"
#import "GlobalFunction.h"
#import <Google/Analytics.h>

#define appdelegate (AppDelegate *)[[UIApplication sharedApplication]delegate]

@interface ProviderSignUpThirdViewController ()

@end

@implementation ProviderSignUpThirdViewController
@synthesize userDetails,prepopulateData;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton *subBtn = (UIButton *) [self.view viewWithTag:5];
    subBtn.layer.borderColor = [UIColor colorWithRed:246.0/255.0 green:108.0/255.0 blue:118.0/255.0 alpha:1].CGColor;
    
    
   /* UIImageView *bgImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"LoginBackground.png"]];
    bgImageView.frame = self.view.bounds;
    bgImageView.contentMode = UIViewContentModeScaleToFill;
    bgImageView.clipsToBounds = YES;
    
    [_backgroundThirdSignUpView addSubview:bgImageView];
    [_backgroundThirdSignUpView sendSubviewToBack:bgImageView];*/
    
    UIImage *backgroundImage = [UIImage imageNamed:@"LoginBackground.png"];
    UIImageView *backgroundImageView=[[UIImageView alloc]initWithFrame:self.view.frame];
    backgroundImageView.image=backgroundImage;
    [self.view insertSubview:backgroundImageView atIndex:0];
    
    
    [self setBorder:_qualificationView];
    [self setBorder:_licencenumberView];
    [self setBorder:_lanuguagespokenView];
     
     
    _qualificationTextField.delegate= self;
    _licenceTextField.delegate= self;
    _languagespokenTextField.delegate= self;
    
    
    [self.qualificationTextField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventAllTouchEvents];
    [self.qualificationTextField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    
    [self.licenceTextField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventAllTouchEvents];
    [self.licenceTextField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [self.languagespokenTextField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventAllTouchEvents];
    [self.languagespokenTextField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    

    // Do any additional setup after loading the view.
    
    
    
    UITapGestureRecognizer *singleFingerTap =
    [[UITapGestureRecognizer alloc] initWithTarget:self
                                            action:@selector(handleSingleTapped:)];
    [self.pickerBackView addGestureRecognizer:singleFingerTap];
    
    [self.qualificationtxt addTarget:self action:@selector(monthClick:) forControlEvents:UIControlEventEditingDidBegin];
    
    
    
}


- (void)monthClick:(UITapGestureRecognizer *)recognizer {
   
    dataSource=[[NSArray alloc]initWithObjects:@"Phd/MD",
                @"PSYD",@"MSW",@"LCSW",@"Licensed Counselor", nil];
    [self.pickerView reloadAllComponents];
    [self resignSoftKeyboard];
    _pickerBackView.hidden=NO;
    
    [self setBorder:_pickerView];
    [_qualificationtxt setValue:[UIColor  colorWithRed:(112/255.0) green:(112/255.0) blue:(112/255.0) alpha:1] forKeyPath:@"_placeholderLabel.textColor"];
    _qualificationtxt.placeholder=@"";
}


- (void)handleSingleTapped:(UITapGestureRecognizer *)recognizer {
    _pickerBackView.hidden=YES;
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
    
    
    [_qualificationtxt setText:[dataSource objectAtIndex:row]];
    _pickerBackView.hidden=YES;
    
    [self.licenceTextField becomeFirstResponder];
    [self resignSoftKeyboard];
}

-(void)resignSoftKeyboard{
    [_qualificationTextField resignFirstResponder];
    [_licenceTextField resignFirstResponder];
    [_languagespokenTextField resignFirstResponder];
    [_qualificationtxt resignFirstResponder];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//called each time when the view appears
-(void)viewWillAppear:(BOOL)animated
{

    _qualificationTextField.text=[[appdelegate prepopulateDataProviderReg] objectForKey:@"qualification"];
    _licenceTextField.text=[[appdelegate prepopulateDataProviderReg] objectForKey:@"licencenumber"];
    _languagespokenTextField.text=[[appdelegate prepopulateDataProviderReg] objectForKey:@"languagespoken"];
    
}

//  Description:To set the border for the views with textfield.
-(void)setBorder:(UIView *)img
{
    
    img.layer.borderColor = [[UIColor colorWithRed:228.0/255.0 green:109.0/255.0 blue:175.0/255.0 alpha:1.0]CGColor];
    img.layer.borderWidth = 1.0f;
    
}



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


//  Description:Function to focus the textfield and return the keyboard.
- (BOOL)textFieldShouldReturn:(UITextField *)theTextField {
    
    if (theTextField == self.qualificationTextField) {
        
        [self.licenceTextField becomeFirstResponder];
    }
    
    if (theTextField == self.licenceTextField) {
        
        //[self.languagespokenTextField becomeFirstResponder];
        [theTextField resignFirstResponder];

    }
    
    if (theTextField == self.languagespokenTextField) {
        [theTextField resignFirstResponder];
    }
    
    return YES;
}


-(void)RemoveValidationSetting:(UITextField *)textField errorIcon:(UIButton *)errorBtn indicationIcon:(UIImageView *)indicationIcon HintText:(NSString *)hintTextMessage imageIs:(NSString *)imageIs viewField:(UIView *)view{
    
    [textField setValue:[UIColor  colorWithRed:(112/255.0) green:(112/255.0) blue:(112/255.0) alpha:1] forKeyPath:@"_placeholderLabel.textColor"];
    textField.placeholder=hintTextMessage;
    errorBtn.hidden=YES;
    UIImage *image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:imageIs ofType:@"png"]];
    indicationIcon.image = image;
    [self setBorder:view];
    
}


//Discription: validate the pattern of licence number

- (BOOL)validatlicenseNumber:(NSString*)licenseNumber
{
    if(![_licenceTextField.text isEqualToString:@""])
    {
        NSString *licenceNumberRegex = @"(^[a-z0-9]*$)";
        NSPredicate *licenseNumberTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", licenceNumberRegex];
        return [licenseNumberTest evaluateWithObject:licenseNumber];
    }
    else if([_licenceTextField.placeholder isEqualToString:@"Please enter a valid license Number."])
    {
        return false;
    }
    else{
        return true;
    }
}


//Validate the pattern of Qualification

- (BOOL)validateQualificationField:(NSString*)qualification
{
    NSString *nameRegex = @"^[a-zA-Z ]*$";
    NSPredicate *nameTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", nameRegex];
    return [nameTest evaluateWithObject:qualification];
}

//Validate Language pattern
- (BOOL)validateLanguageField:(NSString*)language
{
    NSString *nameRegex = @"^[a-zA-Z ]*$";
    NSPredicate *nameTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", nameRegex];
   return [nameTest evaluateWithObject:language];
}




//  Description:Function called when the text in the textfield is changed.
-(void) textFieldDidChange:(UITextField *)theTextField
{
    // GlobalFunction *globalValues=[[GlobalFunction alloc]init];
    if([theTextField isEqual:_qualificationTextField])
    {
        [self RemoveValidationSetting:_qualificationTextField errorIcon:_qualificationCloseButton indicationIcon:_qualificationIcon HintText:@"Qualification" imageIs:@"qualification" viewField:_qualificationView];
        
    }
    if([theTextField isEqual:_licenceTextField])
    {
        [self RemoveValidationSetting:_licenceTextField errorIcon:_licencenumberCloseButton indicationIcon:_licenceIcon HintText:@"Licence number" imageIs:@"licence" viewField:_licencenumberView];
        
    }
    if([theTextField isEqual:_languagespokenTextField])
    {
        [self RemoveValidationSetting:_languagespokenTextField errorIcon:_languageCloseButton indicationIcon:_languageIcon HintText:@"Languages Spoken" imageIs:@"language" viewField:_lanuguagespokenView];
        
    }
}


    
    


- (IBAction)qualificationDropClick:(id)sender {
}

- (IBAction)backclick:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}
    
    
    

- (IBAction)nextclick:(id)sender {
    
    CGPoint pt;
    
    pt.x = 0;
    pt.y = 13;
    //[_scrollView setContentOffset:pt animated:YES];
    
    
    
    if([_qualificationTextField.text isEqualToString:@""])
    {
        [_qualificationDropIcon setHidden:YES];
        [self SetValidationSettings:_qualificationTextField errorIcon:_qualificationCloseButton indicationIcon:_qualificationIcon validationMessage:@"Please enter Qualification." imageIs:@"error-qualification" viewField:_qualificationView];
    }
    else if(!([self validateLanguageField:_qualificationTextField.text])) {
        _qualificationTextField.text=@"";
        [self SetValidationSettings:_qualificationTextField errorIcon:_qualificationCloseButton indicationIcon:_qualificationIcon validationMessage:[[GlobalFunction sharedInstance].arrayOfAlerts objectAtIndex:7] imageIs:@"error-qualification" viewField:_qualificationView];
        
    }
   
    
    if([_licenceTextField.text isEqualToString:@""]){
        [self SetValidationSettings:_licenceTextField errorIcon:_licencenumberCloseButton indicationIcon:_licenceIcon validationMessage:[[GlobalFunction sharedInstance].arrayOfAlerts objectAtIndex:123] imageIs:@"error-licence" viewField:_licencenumberView];
    }
    
    else if(!([self validatlicenseNumber:_licenceTextField.text]))
    {
        _licenceTextField.text=@"";
        [self SetValidationSettings:_licenceTextField errorIcon:_licencenumberCloseButton indicationIcon:_licenceIcon validationMessage:[[GlobalFunction sharedInstance].arrayOfAlerts objectAtIndex:77] imageIs:@"error-licence" viewField:_licencenumberView];
    }
    
    if([_languagespokenTextField.text isEqualToString:@""])
    {
        
        [self SetValidationSettings:_languagespokenTextField errorIcon:_languageCloseButton indicationIcon:_languageIcon validationMessage:@"Please enter Languages spoken." imageIs:@"error-language" viewField:_lanuguagespokenView];
    }
    else if(!([self validateLanguageField:_languagespokenTextField.text])) {
        _languagespokenTextField.text=@"";
        [self SetValidationSettings:_languagespokenTextField errorIcon:_languageCloseButton indicationIcon:_languageIcon validationMessage:[[GlobalFunction sharedInstance].arrayOfAlerts objectAtIndex:7] imageIs:@"error-language" viewField:_lanuguagespokenView];
        
    }
         
         
         if(!([_qualificationTextField.text isEqualToString:@""])&& !([_licenceTextField.text isEqualToString:@""])&& !([_languagespokenTextField.text isEqualToString:@""])){
             
             
             AppDelegate *appdelegat= (AppDelegate *)[[UIApplication sharedApplication]delegate];
             
             
             ProviderSignUpProfFitness *vc=[self.storyboard instantiateViewControllerWithIdentifier:@"ProviderMyFitnessView"];
             
             //Adding to dictionary
            
             [userDetails setObject:[_qualificationTextField.text stringByTrimmingCharactersInSet:
                                          [NSCharacterSet whitespaceCharacterSet]] forKey:@"qualification"];
             
             
             [userDetails setObject:[_licenceTextField.text stringByTrimmingCharactersInSet:
                                     [NSCharacterSet whitespaceCharacterSet]] forKey:@"licenseNumber"];
             
             //NSString *licencesureState = @"Khansas";
             
             [userDetails setObject:[[userDetails valueForKey:@"state"] stringByTrimmingCharactersInSet:
                                     [NSCharacterSet whitespaceCharacterSet]] forKey:@"licensureState"];
             
             
             [userDetails setObject:[_languagespokenTextField.text stringByTrimmingCharactersInSet:
                                      [NSCharacterSet whitespaceCharacterSet]] forKey:@"languageSpoken"];
             
             
             
             [self presentViewController:vc animated:YES completion:nil];
             
             vc.providerDetails=userDetails;
             
             appdelegat.prepopulateDataProviderReg= userDetails;
             
         }
    
    
}
    
    

- (IBAction)backarrow:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}
    
    
- (IBAction)qualicationCloseButton:(id)sender {
    [_qualificationDropIcon setHidden:NO];
[self RemoveValidationSetting:_qualificationTextField errorIcon:_qualificationCloseButton indicationIcon:_qualificationIcon HintText:@"Qualification" imageIs:@"qualification" viewField:_qualificationView];
}
    
    

- (IBAction)licencenumberCloseButton:(id)sender {
    
    
    [self RemoveValidationSetting:_licenceTextField errorIcon:_licencenumberCloseButton indicationIcon:_licenceIcon HintText:@"Licence number" imageIs:@"licence" viewField:_licencenumberView];
}
    

- (BOOL) textFieldShouldBeginEditing:(UITextField *)textField
{
  
    if(textField == _qualificationtxt )
    
    {
        _pickerBackView.hidden=NO;
        [self resignSoftKeyboard];
    
    }
    
    return YES;
}



- (IBAction)languageCloseButton:(id)sender {
    
    [self RemoveValidationSetting:_languagespokenTextField errorIcon:_languageCloseButton indicationIcon:_languageIcon HintText:@"Languages spoken" imageIs:@"language" viewField:_lanuguagespokenView];
}
    
    
   
    @end
         

