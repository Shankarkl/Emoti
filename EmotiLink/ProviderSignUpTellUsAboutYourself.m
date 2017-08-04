
/***************************************************************
 Page name:ProviderSignUpTellUsAboutYourself.m
 Created By:ZEENATH
 Created Date:11-07-16
 Description:Information about the provider implementation file
 ***************************************************************/

#import "ProviderSignUpTellUsAboutYourself.h"
#import "ThanksViewController.h"
#import "GlobalFunction.h"
#import "AppDelegate.h"
#import "TermsAndConditionViewController.h"
#define appdelegat (AppDelegate *)[[UIApplication sharedApplication]delegate]
#import <Google/Analytics.h>
#import "ProviderSignUpThankYou.h"
#import "PhotopopupViewController.h"

@interface ProviderSignUpTellUsAboutYourself ()<PhotopopupViewControllerDelegate>
{
    UIImage *bindimage;
}

@end

@implementation ProviderSignUpTellUsAboutYourself


- (void)dataFromController:(NSMutableArray *)data
{
    //bindimage = data;
    //_profilePicView.image = data;
    [self startLoadingIndicator];
    
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc] init];
    
    for (UIImage *asset in data) {
        
        [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        // or @"yyyy-MM-dd hh:mm:ss a" if you prefer the time with AM/PM
        NSLog(@"%@",[dateFormatter stringFromDate:[NSDate date]]);
        NSString *fileName = [dateFormatter stringFromDate:[NSDate date]];
        NSCharacterSet *doNotWant = [NSCharacterSet characterSetWithCharactersInString:@"/:- "];
        fileName = [[fileName componentsSeparatedByCharactersInSet: doNotWant] componentsJoinedByString: @""];
        NSLog(@"%@", fileName);
        
        AppDelegate *appDelegat=(AppDelegate *)[[UIApplication sharedApplication]delegate];
        [appDelegat uploadBlobToContainer:asset name:fileName path:1 withCallback:^(NSString *response, NSError *error) {
            if (error == nil)
            {
                NSLog(@"documentpathresponse%@", response);
                docPath=response;
                [providerDocument setValue:docPath forKey:@"documentPath"];
                [providerDocument setValue: [NSNumber numberWithInt:0]forKey:@"documentType"];
                //[userDetails setObject:response forKey:@"profilePicPath"];
                //self.profileImage.image = image;
            }
            else
            {
                docPath=@"";
                //[self stopLoadingIndicator];
                //[userDetails setObject:@"" forKey:@"profilePicPath"];
            }
            [self stopLoadingIndicator];
            
        }];
    }
    
}


//Called when the view controller is first time loaded to memory
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setBorderColor:25];
    [self setBorderColor:26];
    
    _iagreechkbox.frame = CGRectMake(25, 455, 30, 30);
    _iAgreeTxt.frame = CGRectMake(75, 455, 100, 18);
    _termAndconditionTxt.frame = CGRectMake(152, 455, 100, 18);
    
    // Do any additional setup after loading the view.
    //self.textView.layer.borderWidth = 1.0f;
    _textView.text = @"Tell us a litle about yourself what you write  here will be shared in your Bio!";
    _textView.textColor = [UIColor darkGrayColor];
    /*  self.textView.layer.borderColor = [[UIColor blackColor] CGColor];*/
    self.textView.delegate = self;
    myBool=NO;
    boolConsenttoTreat=NO;
    boolTermsCond=NO;
    clickedbutton=@"uncheck";
    
    //[self setBorder:_textView];
    _textView.editable=YES;
    [_applyReferralCodeText setHidden:YES];
    
    providerDocument= [[NSMutableDictionary alloc]init];
    
    UIImage *backgroundImage = [UIImage imageNamed:@"LoginBackground.png"];
    UIImageView *backgroundImageView=[[UIImageView alloc]initWithFrame:self.view.frame];
    backgroundImageView.image=backgroundImage;
    [self.view insertSubview:backgroundImageView atIndex:0];
    
    
}

//Called when the textview editing is about to start
- (BOOL) textViewShouldBeginEditing:(UITextView *)textView
{
    [self RemoveValidationSettingTextView:_textView errorIcon:_errorClose HintText:@"" viewField:_textView];
    if([_textView.text isEqualToString:@"Tell us a litle about yourself what you write  here will be shared in your Bio!"] || [_textView.text isEqualToString:@"Please enter about yourself."])
    {
        _textView.text = @"";
    }
    // _textView.text = @"";
    _textView.textColor = [UIColor blackColor];
    return YES;
}


-(void) setBorderColor:(int)tagName{
    UIButton *cancelBtn = (UIButton *) [self.view viewWithTag:tagName];
    cancelBtn.layer.borderColor = [UIColor colorWithRed:246.0/255.0 green:108.0/255.0 blue:118.0/255.0 alpha:1].CGColor;
}

//Called when the textview editing is started editing
- (void)textViewDidBeginEditing:(UITextView *)textView{
    [self RemoveValidationSettingTextView:_textView errorIcon:_errorClose HintText:@"" viewField:_textView];
}

//Called when the textview text is changed
-(void) textViewDidChange:(UITextView *)textView
{
    if(_textView.text.length == 0){
        _textView.textColor = [UIColor lightGrayColor];
        _textView.text = @"Tell us a litle about yourself what you write  here will be shared in your Bio!";
        [_textView resignFirstResponder];
    }
}


// Dispose of any resources that can be recreated.
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

//called each time when the view appears
-(void) viewWillAppear:(BOOL)animated
{
    if([appdelegat prepopulateDataProviderAboutYourself] != nil)
    {
        
        
        if([[appdelegat prepopulateDataProviderAboutYourself] objectForKey:@"aboutYourself"] != nil || ![[[appdelegat prepopulateDataProviderAboutYourself] objectForKey:@"aboutYourself"] isEqualToString:@""])
        {
            _textView.text=[[appdelegat prepopulateDataProviderAboutYourself] objectForKey:@"aboutYourself"];
        }
        else{
            _textView.text = @"Tell us a litle about yourself what you write  here will be shared in your Bio!";
        }
        
        if([[appdelegat prepopulateDataProviderAboutYourself] objectForKey:@"documentPath"] != nil)
        {
            documentPath=[[appdelegat prepopulateDataProviderAboutYourself] objectForKey:@"documentPath"];
            [_providerDetails setObject:documentPath forKey:@"documentPath"];
        }
        else
        {
            
        }
    }
    
    
}


//Added bY:ZEENATH
//Added on:11-07-16
//Description:To show the popup to upload the document from camera or gallery
- (IBAction)uploadDocumentClick:(id)sender {
    //[_cameraBackView setHidden:NO];
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:
                                @"GeneralStoryboard" bundle:nil];
    
    PhotopopupViewController *photopopup=[storyboard instantiateViewControllerWithIdentifier:@"photopopup"];
    photopopup.delegate=self;
    
    photopopup.uploadType= @"Documents";
    
    self.modalPresentationStyle = UIModalPresentationFullScreen;
    
    photopopup.modalPresentationStyle = UIModalPresentationOverCurrentContext;
    
    [self presentViewController:photopopup animated:NO completion:nil];
    
}

//Added bY:ZEENATH
//Added on:11-07-16
//Description:To agree the terms and conditions
- (IBAction)termsAndConditionsBtnClick:(id)sender {
    [_textView resignFirstResponder];
    
    if (boolTermsCond==NO) {
        
        [_termConditionCheck setImage:[UIImage imageNamed:@"check.png"] forState:UIControlStateNormal];
        boolTermsCond=YES;
        clickedbutton=@"check";
    }
    else if(boolTermsCond==YES)
    {
        [_termConditionCheck setImage:[UIImage imageNamed:@"uncheck.png"] forState:UIControlStateNormal];
        boolTermsCond=NO;
        clickedbutton=@"uncheck";
        
    }
    
}

//Added bY:ZEENATH
//Added on:15-07-16
//Description:To navigate to about yourself page
- (IBAction)termsAndConditionsClick:(id)sender {
    AppDelegate *appdelegate= (AppDelegate *)[[UIApplication sharedApplication]delegate];
    NSMutableDictionary *dict=[[NSMutableDictionary alloc]init];
    
    [dict setObject:_textView.text forKey:@"aboutYourself"];
    if(documentPath != nil){
        [dict setObject:documentPath forKey:@"documentPath"];
    }
    
    
    
    appdelegate.prepopulateDataProviderAboutYourself=dict;
    TermsAndConditionViewController *vc=[self.storyboard instantiateViewControllerWithIdentifier:@"termsAndConditions"];
    vc.screenStatus=@"TellUsAboutYourself";
    [self presentViewController:vc animated:YES completion:nil];
}

//Added bY:ZEENATH
//Added on:11-07-16
//Description:Called when the back button is clicked
- (IBAction)backClick:(id)sender {
    AppDelegate *appdelegate= (AppDelegate *)[[UIApplication sharedApplication]delegate];
    NSMutableDictionary *dict=[[NSMutableDictionary alloc]init];
    
    [dict setObject:_textView.text forKey:@"aboutYourself"];
    if(documentPath != nil){
        [dict setObject:documentPath forKey:@"documentPath"];
    }
    
    
    
    appdelegate.prepopulateDataProviderAboutYourself=dict;
    //[[appdelegate prepopulateDataProviderAboutYourself] setObject:_ans3TextField.text forKey:@"thirdans"];
    
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)backArrowClick:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}


//  Added by:Zeenath
//  Added Date:2016-24-07.
//  Description:To set the validation message fot the textview.

-(void)SetValidationSettingsTextView:(UITextView *)textView errorIcon:(UIButton *)errorBtn validationMessage:(NSString *)validationMessage viewField:(UIView *)viewIs{
    
    textView.text=validationMessage;
    errorBtn.hidden=NO;
    textView.textColor=[UIColor redColor];
    viewIs.layer.borderColor = [[UIColor redColor]CGColor];
    viewIs.layer.borderWidth = 1.0f;
}

//  Added by:Zeenath
//  Added Date:2016-24-07.
//  Description:To clear the validation message fot the textview.
-(void)RemoveValidationSettingTextView:(UITextView *)textField errorIcon:(UIButton *)errorBtn HintText:(NSString *)hintTextMessage viewField:(UIView *)view{
    
    [textField setValue:[UIColor  colorWithRed:(112/255.0) green:(112/255.0) blue:(112/255.0) alpha:1] forKeyPath:@"_placeholderLabel.textColor"];
    
    if(! [hintTextMessage isEqualToString:@"" ]){
        textField.text=hintTextMessage;
    }
    
    errorBtn.hidden=YES;
    [self setBorder:view];
    
}


//  Added by:Zeenath
//  Added Date:2016-24-07.
//  Description:Function To set the border for the views around the textfields.
-(void)setBorder:(UIView *)view
{
    /* view.layer.borderColor = [[UIColor colorWithRed:228.0/255.0 green:109.0/255.0 blue:175.0/255.0 alpha:1.0]CGColor];
     view.layer.borderWidth = 1.0f;*/
}


//Added bY:ZEENATH
//Added on:11-07-16
//Description:Called when the submit button is clicked and register the provider
- (IBAction)nextClick:(id)sender {
    
    
    if([_textView.text isEqualToString:@"Tell us a litle about yourself what you write  here will be shared in your Bio!"])
    {
        [self SetValidationSettingsTextView:_textView errorIcon:_errorClose validationMessage:@"Please enter about yourself." viewField:_textView];
        
    }
    else
        
    {
        if([clickedbutton isEqualToString:@"uncheck"])
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
        else {
            
            AppDelegate *appdelegate= (AppDelegate *)[[UIApplication sharedApplication]delegate];
            
            BOOL internetCheck= [appdelegate testInternetConnection];
            
            if (internetCheck==NO) {
                [appdelegate displayNetworkAlert];
                [self presentViewController:appdelegate.alert animated:YES completion:nil];
            }
            [self startLoadingIndicator];
            ProviderSignUpThankYou *vc=[self.storyboard instantiateViewControllerWithIdentifier:@"ProviderSignUpThankYou"];
            [_providerDetails setObject:_textView.text forKey:@"aboutSelf"];
            
            NSMutableDictionary *dict=[[NSMutableDictionary alloc]initWithDictionary:_providerDetails];
            
            [dict removeObjectForKey:@"address"];
            [dict removeObjectForKey:@"city"];
            [dict removeObjectForKey:@"licenseNumber"];
            [dict removeObjectForKey:@"zipCode"];
            [dict removeObjectForKey:@"licensureState"];
            [dict removeObjectForKey:@"qualification"];
            [dict removeObjectForKey:@"aboutSelf"];
            [dict removeObjectForKey:@"licenseNumber"];
            [dict removeObjectForKey:@"professionalFitness1"];
            [dict removeObjectForKey:@"professionalFitness2"];
            [dict removeObjectForKey:@"professionalFitness3"];
            [dict removeObjectForKey:@"professionalFitness4"];
            [dict removeObjectForKey:@"documentPath"];
            [dict removeObjectForKey:@"providerExpertise"];
            [dict removeObjectForKey:@"state"];
            [dict removeObjectForKey:@"ssn"];
            [dict removeObjectForKey:@"licensureState"];
            [dict removeObjectForKey:@"languageSpoken"];
            [dict setObject:_applyReferralCodeText.text forKey:@"appSharedKey"];
            [dict removeObjectForKey:@"confirmPassword"];
            
            NSMutableDictionary *dict2=[[NSMutableDictionary alloc]initWithDictionary:_providerDetails];

            [dict2 removeObjectForKey:@"password"];
            [dict2 removeObjectForKey:@"firstName"];
            [dict2 removeObjectForKey:@"email"];
            [dict2 removeObjectForKey:@"dob"];
            [dict2 removeObjectForKey:@"lastName"];
            [dict2 removeObjectForKey:@"profilePicPath"];
            [dict2 removeObjectForKey:@"userSecurityQuestion"];
            [dict2 removeObjectForKey:@"providerExpertise"];
            [dict2 removeObjectForKey:@"phoneNumber"];
             [dict2 removeObjectForKey:@"confirmPassword"];
            [dict2 removeObjectForKey:@"username"];
            [dict2 setValue:[NSNumber numberWithBool:boolConsenttoTreat] forKey:@"isConsentToTreat"];
            //consentEmotilink = false;
            [dict2 setValue:[NSNumber numberWithBool:!(boolConsenttoTreat)] forKey:@"isConsentToTreatFromEmotilink"];
            
            
            NSMutableDictionary *dict3=[[NSMutableDictionary alloc]initWithDictionary:_providerDetails];
            
            NSMutableArray *array=[[NSMutableArray alloc]init];
            array=[dict3 valueForKey:@"providerExpertise"];
            
            /*[providerDocument setValue:docPath forKey:@"documentPath"];
            
            [providerDocument setValue:[NSNumber numberWithBool:boolConsenttoTreat] forKey:@"isConsentToTreat"];
            //consentEmotilink = false;
            [providerDocument setValue:[NSNumber numberWithBool:!(boolConsenttoTreat)] forKey:@"isConsentToTreatFromEmotilink"];*/
             NSMutableArray *arraymaindocument=[[NSMutableArray alloc]init];
             [arraymaindocument addObject: providerDocument];
            [_providerDetails setObject:arraymaindocument forKey:@"providerDocuments"];
            
            NSMutableDictionary *dict4=[[NSMutableDictionary alloc]initWithDictionary:_providerDetails];
            //  NSString * documentPath =@"";
            
            
            NSMutableArray *arraydocument=[[NSMutableArray alloc]init];
            arraydocument=[dict4 valueForKey:@"providerDocuments"];
            
            
            _providerDetails=[[NSMutableDictionary alloc]init];
            [_providerDetails setObject:dict forKey:@"personalInfo"];
            [_providerDetails setObject:dict2 forKey:@"providerInfo"];
            [_providerDetails setObject:array forKey:@"providerExpertise"];
            [_providerDetails setObject:arraydocument forKey:@"providerDocuments"];
            
            
            NSLog(@" _providerDetails %@",_providerDetails);
            vc.providerregister=_providerDetails;
            NSString *Url=[appdelegate.serviceURL stringByAppendingString:@"api/Account/RegisterProvider"];
            // [self startLoadingIndicator];
            
            [[GlobalFunction sharedInstance]getServerResponseAfterLogin:Url method:@"POST" param:_providerDetails withCallback:^(NSInteger statusCode, NSDictionary *response, NSError *error) {
                
                if(statusCode == 200){
                    
                    [self stopLoadingIndicator];
                    
                    /*    vc.screenStatus=@"ProviderSignUp";
                     
                     vc.userNametoDisplay=[[_providerDetails objectForKey:@"firstName"] stringByAppendingString:[_providerDetails objectForKey:@"lastName"]];
                     
                     [self presentViewController:vc animated:YES completion:nil];*/
                    
                    
                    NSDictionary *provderinfpmation=[_providerDetails valueForKey:@"personalInfo"];
                    NSLog(@" userNametoDisplay %@", vc.userNametoDisplay);
                    [self stopLoadingIndicator];
                    ProviderSignUpThankYou *vc=[self.storyboard instantiateViewControllerWithIdentifier:@"ProviderSignUpThankYou"];
                    vc.screenStatus=@"ProviderSignUp";
                    vc.userNametoDisplay=[[provderinfpmation objectForKey:@"firstName"] stringByAppendingString:[provderinfpmation objectForKey:@"lastName"]];
                    [self presentViewController:vc animated:YES completion:nil];
                    
                }else{
                    // GlobalFunction *globalValues=[[GlobalFunction alloc]init];
                    
                    NSString *message;
                    if (statusCode == 404){
                        
                        message=[[GlobalFunction sharedInstance].arrayOfAlerts objectAtIndex:65];
                        
                    } if(statusCode==403||statusCode==503){
                        
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
            
            // [self presentViewController:vc animated:YES completion:nil];
            //vc.screenStatus=@"ProviderSignUp";
            
            
            
            
        }
    }
}

//Added bY:ZEENATH
//Added on:11-07-16
//Description:To set the range for the characters in the textview
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    
    if([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return textView.text.length + (text.length - range.length) <= 250;
    }
    
    return YES;
}

//Added bY:ZEENATH
//Added on:11-07-16
//Description:called to pick the image from gallery
- (IBAction)galleryClick:(id)sender {
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc]init];
    imagePickerController.delegate = self;
    imagePickerController.sourceType =  UIImagePickerControllerSourceTypePhotoLibrary;
    
    [self presentViewController:imagePickerController animated:YES completion:nil];
}

//Added bY:ZEENATH
//Added on:11-07-16
//Description:called to pick the image from camera
- (IBAction)cameraClick:(id)sender {
    
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc]init];
    imagePickerController.delegate = self;
    imagePickerController.sourceType =  UIImagePickerControllerSourceTypeCamera;
    
    [self presentViewController:imagePickerController animated:YES completion:nil];
}


//Added bY:ZEENATH
//Added on:11-07-16
//Description:called when the view to bind image from gallery or camera is dimissed
- (void)imagePickerControllerDidCancel:(UIImagePickerController *) Picker {
    
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
    
}

//Added bY:ZEENATH
//Added on:11-07-16
//Description:Bind the image and store it to Azure blob after picking the image from camera or gallery
- (void) imagePickerController:(UIImagePickerController *)picker
         didFinishPickingImage:(UIImage *)image
                   editingInfo:(NSDictionary *)editingInfo
{
    [self startLoadingIndicator];
    [_cameraBackView setHidden:YES];
    //self.profileImage.image = image;
    
    AppDelegate *appDelegat=(AppDelegate *)[[UIApplication sharedApplication]delegate];
    NSString *name=[[_providerDetails valueForKey:@"firstName"] stringByAppendingString:@"Document"];
    [appDelegat uploadBlobToContainer:image name:name path:2 withCallback:^(NSString *response, NSError *error) {
        if (error == nil)
        {
            documentPath=response;
            [_providerDetails setObject:response forKey:@"documentPath"];
            
            [self stopLoadingIndicator];
        }
        else{
            [_providerDetails setObject:@"" forKey:@"documentPath"];
            [self stopLoadingIndicator];
        }
    }];
    
    AppDelegate *appdelegate= (AppDelegate *)[[UIApplication sharedApplication]delegate];
    NSMutableDictionary *dict=[[NSMutableDictionary alloc]init];
    
    [dict setObject:[_textView.text stringByTrimmingCharactersInSet:
                     [NSCharacterSet whitespaceCharacterSet]] forKey:@"aboutYourself"];
    if(documentPath != nil){
        [dict setObject:documentPath forKey:@"documentPath"];
    }
    
    
    
    appdelegate.prepopulateDataProviderAboutYourself=dict;
    [self dismissModalViewControllerAnimated:YES];
    
    
}


//Added bY:ZEENATH
//Added on:28-07-16
//Description:Called when the cancel button is clicked
- (IBAction)cancelClick:(id)sender {
    [_cameraBackView setHidden:YES];
}


//  Added by:Zeenath
//  Added Date:2016-24-07.
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
//  Added Date:2016-24-07.
//  Description:To stop the activity indicator.
-(void)stopLoadingIndicator
{
    
    _loadingView.hidden=YES;
}

- (IBAction)consentToTreatClick:(id)sender {
    [_textView resignFirstResponder];
    
    if (boolConsenttoTreat==YES) {
        
        [_consentToTreat setImage:[UIImage imageNamed:@"uncheck.png"] forState:UIControlStateNormal];
        boolConsenttoTreat=NO;
        clickedbutton=@"uncheck";
    }
    else if(boolConsenttoTreat==NO)
    {
        [_consentToTreat setImage:[UIImage imageNamed:@"check.png"] forState:UIControlStateNormal];
        boolConsenttoTreat=YES;
        clickedbutton=@"check";
        
    }
}

- (IBAction)applyReferralCode:(id)sender {
    [_textView resignFirstResponder];
    if (myBool==NO) {
        
        [_applyReferralCode setImage:[UIImage imageNamed:@"check.png"] forState:UIControlStateNormal];
        myBool=YES;
        clickedbutton=@"check";
        [_applyReferralCodeText setHidden:NO];
        
        
        
        _iagreechkbox.frame = CGRectMake(25, 505, 30, 30);
        _iAgreeTxt.frame = CGRectMake(75, 509, 100, 18);
        _termAndconditionTxt.frame = CGRectMake(152, 509, 160, 18);
    }
    else if(myBool==YES)
    {
        [_applyReferralCode setImage:[UIImage imageNamed:@"uncheck.png"] forState:UIControlStateNormal];
        myBool=NO;
        clickedbutton=@"uncheck";
        [_applyReferralCodeText setHidden:YES];
        
        _iagreechkbox.frame = CGRectMake(25, 461, 30, 30);
        _iAgreeTxt.frame = CGRectMake(75, 466, 100, 18);
        _termAndconditionTxt.frame = CGRectMake(152, 466, 160, 18);
        
        
    }
}


- (IBAction)termsAndConditionLable:(id)sender {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:
                                @"GeneralStoryboard" bundle:nil];
    
    [self presentViewController:[storyboard instantiateViewControllerWithIdentifier:@"TermsConditionViewController"] animated:NO completion:nil];
}
@end
