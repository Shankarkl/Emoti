/***************************************************************
 Page name: RecommendationStaticViewController.m
 Created By:Nalina
 Created Date:2016-07-19
 Description: Invite provider implementation Screen.
 ***************************************************************/

#import "RecommendationStaticViewController.h"
#import "GlobalFunction.h"
#import "AppDelegate.h"
#import <Google/Analytics.h>
#import "MyRecommendationsViewController.h"


@interface RecommendationStaticViewController ()

@end

@implementation RecommendationStaticViewController

//Loads first time when page appears
- (void)viewDidLoad {
    [super viewDidLoad];
    UIImage *backgroundImage = [UIImage imageNamed:@"06. Appointment Confirmation.png"];
    UIImageView *backgroundImageView=[[UIImageView alloc]initWithFrame:self.view.frame];
    backgroundImageView.image=backgroundImage;
    [self.view insertSubview:backgroundImageView atIndex:0];
    _emailTxt.delegate = self;
    
    [self.emailTxt addTarget:self action:@selector(textTouchRemove:) forControlEvents:UIControlEventAllTouchEvents];
    [self.emailTxt addTarget:self action:@selector(textTouchRemove:) forControlEvents:UIControlEventEditingChanged];
    
    _emailView.layer.borderColor = [[UIColor colorWithRed:228.0/255.0 green:109.0/255.0 blue:175.0/255.0 alpha:1.0]CGColor];
    _emailView.layer.borderWidth = 1.0f;
    
    [self setBorderColor:5];
    
}

-(void) setBorderColor:(int)tagName{
    UIButton *cancelBtn = (UIButton *) [self.view viewWithTag:tagName];
    cancelBtn.layer.borderColor = [UIColor colorWithRed:246.0/255.0 green:108.0/255.0 blue:118.0/255.0 alpha:1].CGColor;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


//Loads each time when page appears
-(void)viewWillAppear:(BOOL)animated
{
    if ([_emailContent isEqualToString:@""]||[_emailContent isEqual:[NSNull null]]) {
        _emailTxt.text=@"";
    }else{
        _emailTxt.text=_emailContent;
    }
    
    id<GAITracker> tracker = [[GAI sharedInstance] defaultTracker];
    [tracker set:kGAIScreenName value:@"RecommendationStatic"];
    [tracker send:[[GAIDictionaryBuilder createScreenView] build]];
}

//Return the soft keypad
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

//  Added by: Nalina
//  Added Date:2016-19-07.
//  Description:Remove validation design to the input fields

-(void)textTouchRemove :(UITextField *)theTextField
{
    [self.emailTxt setValue:[UIColor  colorWithRed:(112/255.0) green:(112/255.0) blue:(112/255.0) alpha:1] forKeyPath:@"_placeholderLabel.textColor"];
    _emailTxt.placeholder=@"Email";
    _emailErrorBtn.hidden=YES;
    UIImage *image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"email" ofType:@"png"]];
    _emailIcon.image = image;
    _emailView.layer.borderColor = [[UIColor colorWithRed:228.0/255.0 green:109.0/255.0 blue:175.0/255.0 alpha:1.0]CGColor];
    _emailView.layer.borderWidth = 1.0f;
}

- (IBAction)ProviderInviteClick:(id)sender {
}


//  Added by: Nalina
//  Added Date:2016-19-07.
//  Description:Close validation design on click of error icon in input fields

- (IBAction)emailErrorClose:(id)sender {
    [self.emailTxt setValue:[UIColor  colorWithRed:(112/255.0) green:(112/255.0) blue:(112/255.0) alpha:1] forKeyPath:@"_placeholderLabel.textColor"];
    _emailTxt.placeholder=@"Email";
    _emailErrorBtn.hidden=YES;
    UIImage *image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"email" ofType:@"png"]];
    _emailIcon.image = image;
    _emailView.layer.borderColor = [[UIColor colorWithRed:228.0/255.0 green:109.0/255.0 blue:175.0/255.0 alpha:1.0]CGColor];
    _emailView.layer.borderWidth = 1.0f;
    
}

//  Added by: Nalina
//  Added Date:2016-19-07.
//  Description:SET validation for the input field

- (BOOL)validateEmail:(NSString*)email
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}

//Close the screen on click of back icon
- (IBAction)backClick:(id)sender {
   /* [self.navigationController popViewControllerAnimated:YES];*/
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

//  Added by: Nalina
//  Added Date:2016-20-08.
//  Description: Save button click and service call to send the invite

- (IBAction)saveClick:(id)sender {
   // GlobalFunction *globalValues=[[GlobalFunction alloc]init];
    AppDelegate *appdelegate= (AppDelegate *)[[UIApplication sharedApplication]delegate];
    
    if([_emailTxt.text isEqualToString:@""]){
        [self.emailTxt setValue:[UIColor redColor] forKeyPath:@"_placeholderLabel.textColor"];
        _emailTxt.placeholder=[[GlobalFunction sharedInstance].arrayOfAlerts objectAtIndex:2];
        _emailErrorBtn.hidden=NO;
        UIImage *image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"error-email" ofType:@"png"]];
        _emailIcon.image = image;
        _emailView.layer.borderColor = [[UIColor redColor]CGColor];
        _emailView.layer.borderWidth = 1.0f;
        
    }else  if(!([self validateEmail:_emailTxt.text])) {
        [self.emailTxt setValue:[UIColor redColor] forKeyPath:@"_placeholderLabel.textColor"];
        _emailTxt.placeholder=[[GlobalFunction sharedInstance].arrayOfAlerts objectAtIndex:6];
        _emailErrorBtn.hidden=NO;
        UIImage *image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"error-email" ofType:@"png"]];
        _emailIcon.image = image;
        _emailTxt.text=@"";
        _emailView.layer.borderColor = [[UIColor redColor]CGColor];
        _emailView.layer.borderWidth = 1.0f;
        
    }
    
    if(![_emailTxt.text isEqualToString:@""]&&([self validateEmail:_emailTxt.text])){
        NSString *Url=[appdelegate.serviceURL stringByAppendingString:@"api/Recommendations/InviteProviders"];
        NSMutableDictionary *inviteData = [[NSMutableDictionary alloc] init];
        [inviteData setObject:_emailTxt.text forKey:@"email"];
        [self startLoadingIndicator];
        [[GlobalFunction sharedInstance] getServerResponseAfterLogin:Url method:@"POST" param:inviteData withCallback:^(NSInteger statusCode, NSDictionary *response, NSError *error)
         {
             if (statusCode==200) {
                 _alert = [UIAlertController
                           alertControllerWithTitle:@""
                           message:[[GlobalFunction sharedInstance].arrayOfAlerts objectAtIndex:80]
                           preferredStyle:UIAlertControllerStyleAlert];
                 
                 UIAlertAction* okButton = [UIAlertAction
                                            actionWithTitle:@"OK"
                                            style:UIAlertActionStyleDefault
                                            handler:^(UIAlertAction * action) {
                                                [self stopLoadingIndicator];
                                         
                                    MyRecommendationsViewController *vc=[self.storyboard instantiateViewControllerWithIdentifier:@"MyRecommendation"];
                                                [self presentViewController:vc animated:YES completion:nil];
                                            }];
                 [_alert addAction:okButton];
                 [self presentViewController:_alert animated:YES completion: nil];
             }else{
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
                                            }];
                 [_alert addAction:okButton];
                 [self presentViewController:_alert animated:YES completion: nil];
             }
         }];
        
    }
    
}

//Close the screen on click of back icon
- (IBAction)pageBackClick:(id)sender {
   /* [self.navigationController popViewControllerAnimated:YES];*/
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

//Added by: Nalina
//Added Date: 20/08/2016
//Discription:To start the activity indicator.
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

//Added by: Nalina
//Added Date: 20/08/2016
//Discription:To stop the activity indicator.
-(void)stopLoadingIndicator
{
    
    _loadingView.hidden=YES;
}

@end
