/***************************************************************
 Page name: paymentInfoViewController.m
 Created By: nalina
 Created Date:06/07/16
 Description: Banking info implementation file
 ***************************************************************/

#import "paymentInfoViewController.h"
#import "GlobalFunction.h"
#import "CardIO.h"
#import "AppDelegate.h"
#import "CryptLib.h"
#import <Google/Analytics.h>

#define appdelegate (AppDelegate *)[[UIApplication sharedApplication]delegate]

@interface paymentInfoViewController ()

@end

@implementation paymentInfoViewController

//Loads for the first time when page appears
- (void)viewDidLoad {
    [super viewDidLoad];
    
    _dumyTextfield.hidden = YES;
   
    UIButton *cancelBtn = (UIButton *) [self.view viewWithTag:5];
    cancelBtn.layer.borderColor = [UIColor colorWithRed:246.0/255.0 green:108.0/255.0 blue:118.0/255.0 alpha:1].CGColor;

    
    
    
    dataSource = [[NSArray alloc] init];
    
    _cardHolderTxt.delegate = self;
    _creditCardTxt.delegate = self;
    _ccvTxt.delegate = self;
    _zipcodeTxt.delegate = self;
    
    [self.creditCardTxt addTarget:self action:@selector(validationRemove:) forControlEvents:UIControlEventAllTouchEvents];
    [self.creditCardTxt addTarget:self action:@selector(validationRemove:) forControlEvents:UIControlEventEditingChanged];
    
    [self.cardHolderTxt addTarget:self action:@selector(validationRemove:) forControlEvents:UIControlEventAllTouchEvents];
    [self.cardHolderTxt addTarget:self action:@selector(validationRemove:) forControlEvents:UIControlEventEditingChanged];
    
    [self.zipcodeTxt addTarget:self action:@selector(validationRemove:) forControlEvents:UIControlEventAllTouchEvents];
    [self.zipcodeTxt addTarget:self action:@selector(validationRemove:) forControlEvents:UIControlEventEditingChanged];
    
    [self.ccvTxt addTarget:self action:@selector(validationRemove:) forControlEvents:UIControlEventAllTouchEvents];
    [self.ccvTxt addTarget:self action:@selector(validationRemove:) forControlEvents:UIControlEventEditingChanged];
    
    
    UITapGestureRecognizer *singleFingerTap =
    [[UITapGestureRecognizer alloc] initWithTarget:self
                                            action:@selector(handleSingleTapped:)];
    [self.pickerBackView addGestureRecognizer:singleFingerTap];
    
    //Added by: Nalina
    //Added Date: 19/07/2016
    //Discription: To add the done button to the number keypad
    
    UIToolbar* numberToolbar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 50)];
    numberToolbar.barStyle = UIBarStyleBlackTranslucent;
    numberToolbar.items = @[
                            [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],
                            [[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(doneWithNumberPad)],[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil]];
    [numberToolbar sizeToFit];
    _creditCardTxt.inputAccessoryView = numberToolbar;
    _ccvTxt.inputAccessoryView = numberToolbar;
    
    //Added by: nalina
    //Added Date: 05/08/2016
    //Discription: Get details of user payment info service call
    
    NSString *UrlBankingInfo=[[appdelegate serviceURL] stringByAppendingString:@"api/User/PaymentInfo"];
    [self startLoadingIndicator];
    
    [[GlobalFunction sharedInstance]getServerResponseAfterLogin:UrlBankingInfo method:@"GET" param:nil withCallback:^(NSInteger statusCode, NSDictionary *response, NSError *error) {
        [self stopLoadingIndicator];
        
        if(statusCode==200)
        {
            if(![[response valueForKey:@"zipCode"] isEqual:[NSNull null]])
            {
            _zipcodeTxt.text=[response valueForKey:@"zipCode"];
            }
            if(![[response valueForKey:@"creditCardNumber"] isEqual:[NSNull null]])
            {
                _creditCardTxt.text=[response valueForKey:@"creditCardNumber"];
            }
            if(![[response valueForKey:@"expirationMonth"] isEqual:[NSNull null]] && ![[response valueForKey:@"expirationMonth"] isEqual:[NSNumber numberWithInt:0]])
            {
                _monthTxt.text=[response valueForKey:@"expirationMonth"];
            }
            if(![[response valueForKey:@"expirationYear"] isEqual:[NSNull null]] && ![[response valueForKey:@"expirationYear"] isEqual:[NSNumber numberWithInt:0]])
            {
                _yearTxt.text=[NSString stringWithFormat:@"%@%@",@"20",[response valueForKey:@"expirationYear"]];
            }
          
            if(![[response valueForKey:@"cardHolderName"] isEqual:[NSNull null]])
            {
                _cardHolderTxt.text=[response valueForKey:@"cardHolderName"];
            }
        
        }
        
        [self stopLoadingIndicator];
    }];
    
    /*UITapGestureRecognizer *month =
    [[UITapGestureRecognizer alloc] initWithTarget:self
                                            action:@selector(monthClick:)];
    [self.monthTxt.superview addGestureRecognizer:month];*/
    
    [self.monthTxt addTarget:self action:@selector(monthClick:) forControlEvents:UIControlEventEditingDidBegin];
    
    [self.yearTxt addTarget:self action:@selector(yearClick:) forControlEvents:UIControlEventEditingDidBegin];
    
}


//Added by: nalina
//Added Date: 06/07/2016
//Discription: Picker pop on touch of input field

//For From Time
- (void)monthClick:(UITapGestureRecognizer *)recognizer {
    
    dataSource=[[NSArray alloc]initWithObjects:@"01",
                @"02",@"03",@"04",@"05", @"06",
                @"07",@"08",@"09",@"10",@"11",
                @"12", nil];
    [self.pickerView reloadAllComponents];
    _pickerBackView.hidden=NO;
    
    [self setBorder:_monthpickerView];
    [_monthTxt setValue:[UIColor  colorWithRed:(112/255.0) green:(112/255.0) blue:(112/255.0) alpha:1] forKeyPath:@"_placeholderLabel.textColor"];
    _monthTxt.placeholder=@"";
    [self.dumyTextfield becomeFirstResponder];
   [self resignSoftKeyBoard];

}

- (void)yearClick:(UITapGestureRecognizer *)recognizer {
    NSDate *today = [[NSDate alloc] init];
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *offsetComponents = [[NSDateComponents alloc] init];
    [offsetComponents setYear:1];
    NSDate *nextYear;
    nextYear=today;
    YearArray = [NSMutableArray array];
    @autoreleasepool {
        
    for(int i=0;i<=10;i++){
        nextYear  = [gregorian dateByAddingComponents:offsetComponents toDate:nextYear options:0];
        NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:nextYear];
        NSInteger year = [components year];
        
        [YearArray addObject:[NSString stringWithFormat:@"%li",(long)year]];
        
        [self setBorder:_yearpickerView];
        [_yearTxt setValue:[UIColor  colorWithRed:(112/255.0) green:(112/255.0) blue:(112/255.0) alpha:1] forKeyPath:@"_placeholderLabel.textColor"];
        _yearTxt.placeholder=@"";
    }
    }
    dataSource=YearArray;
   
    [self.dumyTextfield becomeFirstResponder];
    [self resignSoftKeyBoard];
   // [_dumyTextfield resignFirstResponder];
    [self.pickerView reloadAllComponents];
    _pickerBackView.hidden=NO;
}

//Hides the number keypad
-(void)doneWithNumberPad{
    [_creditCardTxt resignFirstResponder];
    [_ccvTxt resignFirstResponder];
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

    if([dataSource count]==12){
        [_monthTxt setText:[dataSource objectAtIndex:row]];
        [self resignSoftKeyBoard];
        _pickerBackView.hidden=YES;
    }else{
        [_yearTxt setText:[dataSource objectAtIndex:row]];
        _pickerBackView.hidden=YES;
    }
    [self.dumyTextfield becomeFirstResponder];
    [self resignSoftKeyBoard];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

//Return the data to display and cell in table
-(void)setBorder:(UIView *)view
{
    view.layer.borderColor = [[UIColor colorWithRed:228.0/255.0 green:109.0/255.0 blue:175.0/255.0 alpha:1.0]CGColor];
    view.layer.borderWidth = 1.0f;
}

//Loads each time on page appears
-(void)viewWillAppear:(BOOL)animated{
    [CardIOUtilities preload];
    [self setBorder:_cardnumberView];
    [self setBorder:_scancardView];
    [self setBorder:_cardholdernameView];
    [self setBorder:_monthpickerView];
    [self setBorder:_yearpickerView];
    [self setBorder:_ccvView];
    [self setBorder:_zipcodeView];
    
    id<GAITracker> tracker = [[GAI sharedInstance] defaultTracker];
    [tracker set:kGAIScreenName value:@"PaymentInformation"];
    [tracker send:[[GAIDictionaryBuilder createScreenView] build]];
}

//Added by: nalina
//Added Date: 05/08/2016
//Discription: Remove validation in text fields

-(void)validationRemove:(UITextField *)theTextField{
    if([theTextField isEqual: _creditCardTxt]){
        [self setBorder:_scancardView];
        [self RemoveValidationSettings:_creditCardTxt errorIcon:_creditCardError indicationIcon:_creditCardIcon HintText:@"Credit card number" imageIs:@"creditcard" viewField:_cardnumberView];
    }else if([theTextField isEqual: _cardHolderTxt]){
        [self RemoveValidationSettings:_cardHolderTxt errorIcon:_cardHolderError indicationIcon:_cardHolderIcon HintText:@"Card holder name" imageIs:@"creditcard" viewField:_cardholdernameView];
    }else if([theTextField isEqual: _zipcodeTxt]){
        [self RemoveValidationSettings:_zipcodeTxt errorIcon:_zipcodeError indicationIcon:_zipcodeIcon HintText:@"Zipcode" imageIs:@"password" viewField:_zipcodeView];
    }else if([theTextField isEqual:_ccvTxt]){
        [self setBorder:_ccvView];
        [_ccvTxt setValue:[UIColor  colorWithRed:(112/255.0) green:(112/255.0) blue:(112/255.0) alpha:1] forKeyPath:@"_placeholderLabel.textColor"];
        _ccvTxt.placeholder=@"CVV";
    }else if([theTextField isEqual:_monthTxt]){
        [self setBorder:_monthpickerView];
        [_monthTxt setValue:[UIColor  colorWithRed:(112/255.0) green:(112/255.0) blue:(112/255.0) alpha:1] forKeyPath:@"_placeholderLabel.textColor"];
        _monthTxt.placeholder=@"";
    }else if([theTextField isEqual:_yearTxt]){
        [self setBorder:_yearpickerView];
        [_yearTxt setValue:[UIColor  colorWithRed:(112/255.0) green:(112/255.0) blue:(112/255.0) alpha:1] forKeyPath:@"_placeholderLabel.textColor"];
        _yearTxt.placeholder=@"";
    }
}

//Added by: nalina
//Added Date: 05/08/2016
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
//Added Date: 05/08/2016
//Discription: text view on change functionality

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if([textField isEqual:_ccvTxt]){
        NSString *currentString = [textField.text stringByReplacingCharactersInRange:range withString:string];
        NSUInteger length = [currentString length];
        if (length > 3) {
            return NO;
        }
    }
    
    if([textField isEqual:_creditCardTxt]){
        NSString *currentString = [textField.text stringByReplacingCharactersInRange:range withString:string];
        NSUInteger length = [currentString length];
        if (length > 16) {
            return NO;
        }
    }
    
    return YES;
}

//Close the page on click of back button
- (IBAction)backClick:(id)sender {
    [self resignSoftKeyBoard];
    [self.navigationController popViewControllerAnimated:YES];
}



//Added by: nalina
//Added Date: 05/08/2016
//Discription: Remove validation on click of error button in input fields

- (IBAction)creditCardErrorClose:(id)sender {
    [self setBorder:_scancardView];
    [self RemoveValidationSettings:_creditCardTxt errorIcon:_creditCardError indicationIcon:_creditCardIcon HintText:@"Credit card number" imageIs:@"creditcard" viewField:_cardnumberView];
}
- (IBAction)cardHolderErrorClose:(id)sender {
    [self RemoveValidationSettings:_cardHolderTxt errorIcon:_cardHolderError indicationIcon:_cardHolderIcon HintText:@"Card holder name" imageIs:@"creditcard" viewField:_cardholdernameView];
}
- (IBAction)zipcodeErrorClose:(id)sender {
    [self RemoveValidationSettings:_zipcodeTxt errorIcon:_zipcodeError indicationIcon:_zipcodeIcon HintText:@"Zipcode" imageIs:@"password" viewField:_zipcodeView];
}

- (IBAction)monthPickerClick:(id)sender {
    [self resignSoftKeyBoard];

    dataSource=[[NSArray alloc]initWithObjects:@"01",
                @"02",@"03",@"04",@"05", @"06",
                @"07",@"08",@"09",@"10",@"11",
                @"12", nil];
    [self.pickerView reloadAllComponents];
    _pickerBackView.hidden=NO;
    
    [self setBorder:_monthpickerView];
    [_monthTxt setValue:[UIColor  colorWithRed:(112/255.0) green:(112/255.0) blue:(112/255.0) alpha:1] forKeyPath:@"_placeholderLabel.textColor"];
    _monthTxt.placeholder=@"";
    
}

- (IBAction)yearPickerClick:(id)sender {
    [self resignSoftKeyBoard];

    NSDate *today = [[NSDate alloc] init];
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *offsetComponents = [[NSDateComponents alloc] init];
    [offsetComponents setYear:1];
    NSDate *nextYear;
    nextYear=today;
    YearArray = [NSMutableArray array];
    @autoreleasepool {
        
    for(int i=0;i<=10;i++){
        nextYear  = [gregorian dateByAddingComponents:offsetComponents toDate:nextYear options:0];
        NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:nextYear];
        NSInteger year = [components year];
        
        [YearArray addObject:[NSString stringWithFormat:@"%li",(long)year]];
        
        [self setBorder:_yearpickerView];
        [_yearTxt setValue:[UIColor  colorWithRed:(112/255.0) green:(112/255.0) blue:(112/255.0) alpha:1] forKeyPath:@"_placeholderLabel.textColor"];
        _yearTxt.placeholder=@"";
    }
    }
    dataSource=YearArray;
    
    [self.pickerView reloadAllComponents];
    _pickerBackView.hidden=NO;
}

//To hide all input fields keypad
-(void)resignSoftKeyBoard{
    [_creditCardTxt resignFirstResponder];
    [_monthTxt resignFirstResponder];
    [_yearTxt resignFirstResponder];
    [_cardHolderTxt resignFirstResponder];
    [_zipcodeTxt resignFirstResponder];
    [_ccvTxt resignFirstResponder];
    [_dumyTextfield resignFirstResponder];
}

//Close the screen on click of cancel button
- (IBAction)cancelClick:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

//Added by: nalina
//Added Date: 05/08/2016
//Discription: Set border to the input fields

-(void)setRedBorder:(UIView *)view
{
    view.layer.borderColor = [[UIColor redColor]CGColor];
    view.layer.borderWidth = 1.0f;
}

//Added by: nalina
//Added Date: 05/08/2016
//Discription: validation patterns for input fields

- (BOOL)validateNameField:(NSString*)name
{
    NSString *nameRegex = @"^[a-zA-Z ]*$";
    NSPredicate *nameTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", nameRegex];
    return [nameTest evaluateWithObject:name];
}

- (BOOL)validateZipcodeField:(NSString*)number
{
    NSString *nameRegex = @"^[a-zA-Z0-9]*$";
    NSPredicate *nameTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", nameRegex];
    return [nameTest evaluateWithObject:number];
}

- (BOOL)validateAccountField:(NSString*)account
{
    NSString *accountRegex = @"^[0-9]{4,17}$";
    NSPredicate *accountTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", accountRegex];
    return [accountTest evaluateWithObject:account];
}


//Added by: nalina
//Added Date: 05/08/2016
//Discription: validation and service call on click of submit button

- (IBAction)submitClick:(id)sender {
    [self resignSoftKeyBoard];

  //  GlobalFunction *globalValues=[[GlobalFunction alloc]init];
    AppDelegate *app= (AppDelegate *)[[UIApplication sharedApplication]delegate];

    
    if([_creditCardTxt.text isEqualToString:@""]){
        
        [self setRedBorder:_scancardView];
        [self SetValidationSettinds:_creditCardTxt errorIcon:_creditCardError indicationIcon:_creditCardIcon validationMessage:[[GlobalFunction sharedInstance].arrayOfAlerts objectAtIndex:11] imageIs:@"error-creditCard" viewField:_cardnumberView];
        return;
        
    }else if (_creditCardTxt.text.length<16){
        _creditCardTxt.text=@"";
        _alert = [UIAlertController
                  alertControllerWithTitle:@""
                  message:[[GlobalFunction sharedInstance].arrayOfAlerts objectAtIndex:114]
                  preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* okButton = [UIAlertAction
                                   actionWithTitle:@"OK"
                                   style:UIAlertActionStyleDefault
                                   handler:^(UIAlertAction * action) {
                                       [self stopLoadingIndicator];
                                   }];
        [_alert addAction:okButton];
        [self presentViewController:_alert animated:YES completion: nil];
        return;
    }
    if([_cardHolderTxt.text isEqualToString:@""]){
        
        [self SetValidationSettinds:_cardHolderTxt errorIcon:_cardHolderError indicationIcon:_cardHolderIcon validationMessage:[[GlobalFunction sharedInstance].arrayOfAlerts objectAtIndex:12] imageIs:@"error-creditCard" viewField:_cardholdernameView];
        return;
        
    }else if(!([self validateNameField:_cardHolderTxt.text])) {
        _cardHolderTxt.text=@"";
        [self SetValidationSettinds:_cardHolderTxt errorIcon:_cardHolderError indicationIcon:_cardHolderIcon validationMessage:[[GlobalFunction sharedInstance].arrayOfAlerts objectAtIndex:43] imageIs:@"error-creditCard" viewField:_cardholdernameView];
        return;
        
    }
    
    
    if([_monthTxt.text isEqualToString:@""]){
        
        [_monthTxt setValue:[UIColor redColor] forKeyPath:@"_placeholderLabel.textColor"];
        _monthTxt.placeholder=@"MM";
        [self setRedBorder:_monthpickerView];
        return;
        
    }
    
    if([_yearTxt.text isEqualToString:@""]){
        [_yearTxt setValue:[UIColor redColor] forKeyPath:@"_placeholderLabel.textColor"];
        _yearTxt.placeholder=@"YYYY";
        [self setRedBorder:_yearpickerView];
        return;
        
    }
    
    if([_ccvTxt.text isEqualToString:@""]){
        [_ccvTxt setValue:[UIColor redColor] forKeyPath:@"_placeholderLabel.textColor"];
        _ccvTxt.placeholder=@"CVV";
        [self setRedBorder:_ccvView];
        return;
        
    }else if (_ccvTxt.text.length <3){
        _ccvTxt.text=@"";
        _alert = [UIAlertController
                  alertControllerWithTitle:@""
                  message:[[GlobalFunction sharedInstance].arrayOfAlerts objectAtIndex:103]
                  preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* okButton = [UIAlertAction
                                   actionWithTitle:@"OK"
                                   style:UIAlertActionStyleDefault
                                   handler:^(UIAlertAction * action) {
                                       [self stopLoadingIndicator];
                                   }];
        [_alert addAction:okButton];
        [self presentViewController:_alert animated:YES completion: nil];
        return;
        
    }
    
    
    if([_zipcodeTxt.text isEqualToString:@""]){
        
        [self SetValidationSettinds:_zipcodeTxt errorIcon:_zipcodeError indicationIcon:_zipcodeIcon validationMessage:[[GlobalFunction sharedInstance].arrayOfAlerts objectAtIndex:16] imageIs:@"error-password" viewField:_zipcodeView];
        return;
        
    }else if(!([self validateZipcodeField:_zipcodeTxt.text])) {
        _zipcodeTxt.text=@"";
        [self SetValidationSettinds:_zipcodeTxt errorIcon:_zipcodeError indicationIcon:_zipcodeIcon validationMessage:[[GlobalFunction sharedInstance].arrayOfAlerts objectAtIndex:35] imageIs:@"error-password" viewField:_zipcodeView];
        return;

    }
    
    NSMutableDictionary *dict=[[NSMutableDictionary alloc]init];

    // BELOW CODE IS TO ENCRYPT THE DATA
    CryptLib *cryptLib=[[CryptLib alloc]init];
    NSString * _key = @"emotilinkKey";
    _key = [cryptLib sha256:_key length:32];

    NSString * iv =   [[[[CryptLib alloc] generateRandomIV:11] base64EncodingWithLineLength:0] substringToIndex:16];
    
    [dict setObject:[[cryptLib encrypt:[_creditCardTxt.text dataUsingEncoding:NSUTF8StringEncoding] key:_key iv:iv] base64EncodingWithLineLength:0]  forKey:@"creditCardNumber"];
    [dict setObject:[[cryptLib encrypt:[_cardHolderTxt.text dataUsingEncoding:NSUTF8StringEncoding] key:_key iv:iv] base64EncodingWithLineLength:0]  forKey:@"cardHolderName"];
    [dict setObject:[[cryptLib encrypt:[_monthTxt.text dataUsingEncoding:NSUTF8StringEncoding] key:_key iv:iv] base64EncodingWithLineLength:0]  forKey:@"expirationMonth"];
    [dict setObject:[[cryptLib encrypt:[[_yearTxt.text substringFromIndex:[_yearTxt.text length]-2] dataUsingEncoding:NSUTF8StringEncoding] key:_key iv:iv] base64EncodingWithLineLength:0]  forKey:@"expirationYear"];
    [dict setObject:[[cryptLib encrypt:[_ccvTxt.text dataUsingEncoding:NSUTF8StringEncoding] key:_key iv:iv] base64EncodingWithLineLength:0] forKey:@"ccv"];
    [dict setObject:[[cryptLib encrypt:[_zipcodeTxt.text dataUsingEncoding:NSUTF8StringEncoding] key:_key iv:iv] base64EncodingWithLineLength:0] forKey:@"zipCode"];
    [dict setObject:iv forKey:@"intVectorValue"];
    
    [self startLoadingIndicator];
    
    NSString *Url=[[appdelegate serviceURL] stringByAppendingString:@"api/User/PaymentInfo"];
    
    //Added by: zeenath
    //Added Date: 25/08/2016
    //Discription: Service call to update payment info
    
    [[GlobalFunction sharedInstance]getServerResponseAfterLogin:Url method:@"POST" param:dict withCallback:^(NSInteger statusCode, NSDictionary *response, NSError *error) {
        NSString *message;
        if(statusCode == 200)
        {
            
            NSMutableDictionary *data=[[NSMutableDictionary alloc]initWithDictionary:[appdelegate usersDetails]];
            NSMutableDictionary *dataStatus = [[data valueForKey:@"userStatus"] mutableCopy];
            
            [dataStatus setObject:[NSNumber numberWithInt:1] forKey:@"isPaymentInfoUpdated"];
            [app.usersDetails removeObjectForKey:@"userStatus"];
            [app.usersDetails setObject:dataStatus forKey:@"userStatus"];
            
            message=[[GlobalFunction sharedInstance].arrayOfAlerts objectAtIndex:113];
            [self stopLoadingIndicator];
            _alertView = [UIAlertController
                          alertControllerWithTitle:@""
                          message:message
                          preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction* okButton = [UIAlertAction
                                       actionWithTitle:@"OK"
                                       style:UIAlertActionStyleDefault
                                       handler:^(UIAlertAction * action) {
                                           
                                           //[self.navigationController popViewControllerAnimated:YES];
                                           [self dismissViewControllerAnimated:YES completion:nil];
                                           
                                       }];
            [_alertView addAction:okButton];
            UIViewController *top = [self topMostController];
            [top presentViewController:_alertView animated:YES completion: nil];
        }
        
       else if(statusCode == 401)
        {
            message=[[GlobalFunction sharedInstance].arrayOfAlerts objectAtIndex:63];
            _alertView = [UIAlertController
                          alertControllerWithTitle:@""
                          message:message
                          preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction* okButton = [UIAlertAction
                                       actionWithTitle:@"Ok"
                                       style:UIAlertActionStyleDefault
                                       handler:^(UIAlertAction * action) {
                                           [self stopLoadingIndicator];
                                       }];
            [_alertView addAction:okButton];
            UIViewController *top = [self topMostController];
            [top presentViewController:_alertView animated:YES completion: nil];
        }
        else
        {
            message=[[GlobalFunction sharedInstance].arrayOfAlerts objectAtIndex:115];
            [self stopLoadingIndicator];
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

//Added by: nalina
//Added Date: 05/08/2016
//Discription: set validation for input fields

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
    if (theTextField == self.creditCardTxt) {
        [self.cardHolderTxt becomeFirstResponder];
    }
    if (theTextField == self.cardHolderTxt) {
        [self.ccvTxt becomeFirstResponder];
    }   if (theTextField == self.ccvTxt) {
        [self.zipcodeTxt becomeFirstResponder];
    }    if (theTextField == self.zipcodeTxt) {
        [theTextField resignFirstResponder];
    }
    return YES;
}


//Added by: zeenath
//Added Date: 12/08/2016
//Discription: Scan the card and collect the user information

- (IBAction)scancardClick:(id)sender {
    [self resignSoftKeyBoard];
    CardIOPaymentViewController *scanViewController = [[CardIOPaymentViewController alloc] initWithPaymentDelegate:self];
    scanViewController.modalPresentationStyle = UIModalPresentationFormSheet;
    scanViewController.disableManualEntryButtons=YES;
    
    [self presentViewController:scanViewController animated:YES completion:nil];
}

#pragma mark - CardIOPaymentViewControllerDelegate

- (void)userDidProvideCreditCardInfo:(CardIOCreditCardInfo *)info inPaymentViewController:(CardIOPaymentViewController *)paymentViewController {
    // Do whatever needs to be done to deliver the purchased items.
    [self dismissViewControllerAnimated:YES completion:nil];
    
    _creditCardTxt.text=info.redactedCardNumber;
    NSNumber *month=[NSNumber numberWithInteger:info.expiryMonth];
    _monthTxt.text=[month stringValue] ;
    NSNumber *year=[NSNumber numberWithInteger:info.expiryYear];
    _yearTxt.text=[year stringValue] ;
    _ccvTxt.text=info.cvv;
    _zipcodeTxt.text=info.postalCode;
    _cardHolderTxt.text=info.cardholderName;
    
    
}

- (void)userDidCancelPaymentViewController:(CardIOPaymentViewController *)paymentViewController {
    [self dismissViewControllerAnimated:YES completion:nil];
}


//  Added by:Zeenath
//  Added Date:2016-10-08.
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
//  Added Date:2016-10-08.
//  Description:To stop the activity indicator.

-(void)stopLoadingIndicator
{
    
    _loadingView.hidden=YES;
}


- (UIViewController*) topMostController {
    UIViewController *topController = [UIApplication sharedApplication].keyWindow.rootViewController;
    
    while (topController.presentedViewController) {
        topController = topController.presentedViewController;
    }
    
    return topController;
}
- (IBAction)backArrow:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

//  Added by:Zeenath    _yearTxt
//  Added Date:2016-2-07.
//  Description:called when the textfield is about to begin editing.
- (BOOL) textFieldShouldBeginEditing:(UITextField *)textField
{
    
    if(textField == _monthTxt)
        
    {
        //textField.enabled = NO;
        _pickerBackView.hidden=NO;
        [self resignSoftKeyBoard];
        return NO;
        
    }
    
    return YES;
}



@end
