/***************************************************************
 Page name: RecommendationSearchViewController.m
 Created By:Nalina
 Created Date:2016-07-12
 Description: Recommendation search implementation Screen.
 ***************************************************************/

#import "RecommendationSearchViewController.h"
#import "GlobalFunction.h"
#import "SearchedRecommendationsViewController.h"
#import "RecommendationStaticViewController.h"
#import "AppDelegate.h"
#import <Google/Analytics.h>
@interface RecommendationSearchViewController ()

@end

@implementation RecommendationSearchViewController

//Loads first time when page appears
- (void)viewDidLoad {
    UIImage *backgroundImage = [UIImage imageNamed:@"06. Appointment Confirmation.png"];
    UIImageView *backgroundImageView=[[UIImageView alloc]initWithFrame:self.view.frame];
    backgroundImageView.image=backgroundImage;
    [self.view insertSubview:backgroundImageView atIndex:0];

    _nameTxt.delegate = self;
    _emailTxt.delegate = self;
    
    [self.nameTxt addTarget:self action:@selector(validationRemove:) forControlEvents:UIControlEventAllTouchEvents];
    [self.nameTxt addTarget:self action:@selector(validationRemove:) forControlEvents:UIControlEventEditingChanged];
    
    [self.emailTxt addTarget:self action:@selector(validationRemove:) forControlEvents:UIControlEventAllTouchEvents];
    [self.emailTxt addTarget:self action:@selector(validationRemove:) forControlEvents:UIControlEventEditingChanged];
    [super viewDidLoad];
    [self setBorderColor:5];
}

-(void) setBorderColor:(int)tagName{
    UIButton *cancelBtn = (UIButton *) [self.view viewWithTag:tagName];
    cancelBtn.layer.borderColor = [UIColor colorWithRed:246.0/255.0 green:108.0/255.0 blue:118.0/255.0 alpha:1].CGColor;
}

//  Added by: Nalina
//  Added Date:2016-12-07.
//  Description: SET border to the input fields

-(void)setBorder:(UIView *)view
{
    view.layer.borderColor = [[UIColor colorWithRed:228.0/255.0 green:109.0/255.0 blue:175.0/255.0 alpha:1.0]CGColor];
    view.layer.borderWidth = 1.0f;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



//  Added by: Nalina
//  Added Date:2016-12-07.
//  Description: Remove the validatio design

-(void)validationRemove:(UITextField *)theTextField{
    if([theTextField isEqual: _nameTxt]){
        [self RemoveValidationSettings:_nameTxt errorIcon:_nameError indicationIcon:_nameIcon HintText:@"Name" imageIs:@"user" viewField:_nameView];
    }else if([theTextField isEqual: _emailTxt]){
        [self RemoveValidationSettings:_emailTxt errorIcon:_emailError indicationIcon:_emailIcon HintText:@"Email" imageIs:@"email" viewField:_emailView];
    }
}

-(void)RemoveValidationSettings:(UITextField *)textField errorIcon:(UIButton *)errorBtn indicationIcon:(UIImageView *)indicationIcon HintText:(NSString *)hintTextMessage imageIs:(NSString *)imageIs viewField:(UIView *)view{
    
    [textField setValue:[UIColor  colorWithRed:(112/255.0) green:(112/255.0) blue:(112/255.0) alpha:1] forKeyPath:@"_placeholderLabel.textColor"];
    textField.placeholder=hintTextMessage;
    errorBtn.hidden=YES;
    UIImage *image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:imageIs ofType:@"png"]];
    indicationIcon.image = image;
    [self setBorder:view];
    
}


//Loads each time when page appears
-(void)viewWillAppear:(BOOL)animated{
    [self setBorder:_nameView];
    [self setBorder:_emailView];
    
    id<GAITracker> tracker = [[GAI sharedInstance] defaultTracker];
    [tracker set:kGAIScreenName value:@"RecommendationSearch"];
    [tracker send:[[GAIDictionaryBuilder createScreenView] build]];
}


//Close the page on click of back button
- (IBAction)pageBackClick:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];

}


//  Added by: Nalina
//  Added Date:2016-12-07.
//  Description: Remove the validation design on click of error icons in input fields

- (IBAction)nameErrorClose:(id)sender {
    [self RemoveValidationSettings:_nameTxt errorIcon:_nameError indicationIcon:_nameIcon HintText:@"Name" imageIs:@"user" viewField:_nameView];
}

- (IBAction)emailErrorClose:(id)sender {
    [self RemoveValidationSettings:_emailTxt errorIcon:_emailError indicationIcon:_emailIcon HintText:@"Email" imageIs:@"email" viewField:_emailView];
}



//Close the screen on click of cancel button
- (IBAction)cancelClick:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];

}



//  Added by: Nalina
//  Added Date:2016-12-07.
//  Description: Set validation for the name field to validate only alphabets

- (BOOL)validateNameField:(NSString*)name
{
    NSString *nameRegex = @"^[a-zA-Z ]*$";
    NSPredicate *nameTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", nameRegex];
    return [nameTest evaluateWithObject:name];
}

//  Added by: Nalina
//  Added Date:2016-20-08.
//  Description: Submit click and service call to search the recommendies

- (IBAction)submitClick:(id)sender {
    //GlobalFunction *globalValues=[[GlobalFunction alloc]init];
    AppDelegate *appdelegate= (AppDelegate *)[[UIApplication sharedApplication]delegate];
    
    if(([_nameTxt.text isEqualToString:@""] )&&([_emailTxt.text isEqualToString:@""])){
        
        _alert = [UIAlertController
                  alertControllerWithTitle:@""
                  message:[[GlobalFunction sharedInstance].arrayOfAlerts objectAtIndex:98]
                  preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* okButton = [UIAlertAction
                                   actionWithTitle:@"OK"
                                   style:UIAlertActionStyleDefault
                                   handler:^(UIAlertAction * action) {
                                       [self stopLoadingIndicator];
                                   }];
        [_alert addAction:okButton];
        [self presentViewController:_alert animated:YES completion: nil];
        
    }else
        
        if(!([self validateNameField:_nameTxt.text])&&!([_nameTxt.text isEqualToString:@""])) {
            _nameTxt.text=@"";
            [self SetValidationSettinds:_nameTxt errorIcon:_nameError indicationIcon:_nameIcon validationMessage:[[GlobalFunction sharedInstance].arrayOfAlerts objectAtIndex:43] imageIs:@"error-user" viewField:_nameView];
        }
        else if(!([self validateEmail:_emailTxt.text])&&!([_emailTxt.text isEqualToString:@""])) {
            _emailTxt.text=@"";
            [self SetValidationSettinds:_emailTxt errorIcon:_emailError indicationIcon:_emailIcon validationMessage:[[GlobalFunction sharedInstance].arrayOfAlerts objectAtIndex:6] imageIs:@"error-email" viewField:_emailView];
        }else
        {
            
            NSString *searchRecommendUrl=[appdelegate.serviceURL stringByAppendingString:@"api/Recommendations/SearchProviders"];
            NSMutableDictionary *searchRecommendData = [[NSMutableDictionary alloc] init];
            [searchRecommendData setObject:_nameTxt.text forKey:@"name"];
            [searchRecommendData setObject:_emailTxt.text forKey:@"email"];
            NSLog(@"data=%@",searchRecommendData);
            [self startLoadingIndicator];
            [[GlobalFunction sharedInstance] getServerResponseAfterLogin:searchRecommendUrl method:@"POST" param:searchRecommendData withCallback:^(NSInteger statusCode, NSDictionary *response, NSError *error)
             {
                 NSString *message;
                 
                 if (statusCode == 200)
                 {
                     
                     SearchedRecommendationsViewController *vc=[self.storyboard instantiateViewControllerWithIdentifier:@"SearchedRecommendations"];
                     NSMutableArray *responseArray=[response mutableCopy];
                     vc.searchedRecommendationArray=responseArray;
                     //[self.navigationController pushViewController:vc animated:YES];
                     [self presentViewController:vc animated:NO completion:nil];
                     [self stopLoadingIndicator];
                     
                     
                 }else if(statusCode == 404){
                     /*RecommendationStaticViewController *vc=[self.storyboard instantiateViewControllerWithIdentifier:@"inviteProvider"];
                     vc.emailContent=_emailTxt.text;
                     [self.navigationController pushViewController:vc animated:YES];*/
                     UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"ProviderStoryboard" bundle:nil];
                     RecommendationStaticViewController *viewcontrol=[storyboard instantiateViewControllerWithIdentifier:@"inviteProvider"];
                     [self presentViewController:[storyboard instantiateViewControllerWithIdentifier:@"inviteProvider"] animated:NO completion:nil];
                       viewcontrol.emailContent=_emailTxt.text;
                     [self stopLoadingIndicator];
                     
                 }else{
                     if(statusCode==403||statusCode==503){
                         
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
            
        }
}

//  Added by: Nalina
//  Added Date:2016-12-07.
//  Description: Set validation for the email field to validate email patteren

- (BOOL)validateEmail:(NSString*)email
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}

//  Added by: Nalina
//  Added Date:2016-12-07.
//  Description: Set validation design for the input fields

-(void)SetValidationSettinds:(UITextField *)textField errorIcon:(UIButton *)errorBtn indicationIcon:(UIImageView *)indicationIcon validationMessage:(NSString *)validationMessage imageIs:(NSString *)imageIs viewField:(UIView *)viewIs{
    
    [textField setValue:[UIColor redColor] forKeyPath:@"_placeholderLabel.textColor"];
    textField.placeholder=validationMessage;
    errorBtn.hidden=NO;
    UIImage *image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:imageIs ofType:@"png"]];
    indicationIcon.image = image;
    viewIs.layer.borderColor = [[UIColor redColor]CGColor];
    viewIs.layer.borderWidth = 1.0f;
}


//Return the soft keypad
- (BOOL)textFieldShouldReturn:(UITextField *)theTextField {
    if (theTextField == self.nameTxt) {
        [self.emailTxt becomeFirstResponder];
    }
    if (theTextField == self.emailTxt) {
        [theTextField resignFirstResponder];
    }
    return YES;
}

//  Added by: Nalina
//  Added Date:2016-20-08.
//  Description: Start the loading indicator

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
//  Added Date:2016-20-08.
//  Description: Stop the loading indicator

-(void)stopLoadingIndicator
{
    
    _loadingView.hidden=YES;
}


@end
