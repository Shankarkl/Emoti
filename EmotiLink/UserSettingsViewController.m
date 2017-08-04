/***************************************************************
 Page name: UserSettingsViewController.m
 Created By:Nalina
 Created Date:20/07/16
 Description: usersettings implementation file
 ***************************************************************/

#import "UserSettingsViewController.h"
#import "GlobalFunction.h"
#import "LoginViewController.h"
#import "AppDelegate.h"
#import "UserProfileViewController.h"
@interface UserSettingsViewController ()

@end

@implementation UserSettingsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIImage *backgroundImage = [UIImage imageNamed:@"editProfileUser.png"];
    UIImageView *backgroundImageView=[[UIImageView alloc]initWithFrame:self.view.frame];
    backgroundImageView.frame = self.view.bounds;
    backgroundImageView.contentMode = UIViewContentModeScaleAspectFit;
    backgroundImageView.clipsToBounds = YES;
    backgroundImageView.image=backgroundImage;
    [self.view insertSubview:backgroundImageView atIndex:0];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

//Close the screen when we click on back icon on header icon
- (IBAction)pageBackClick:(id)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
  //  [self dismissModalViewControllerAnimated:YES];
    //[self dismissViewControllerAnimated:YES completion:nil];
}

//Loads the method each time when page appears
-(void)viewWillAppear:(BOOL)animated{
    
    [[self navigationController] setNavigationBarHidden:YES animated:YES];
    
    self.profilePicImage.layer.cornerRadius = 10;
    self.profilePicImage.clipsToBounds = YES;
    
    AppDelegate *app= (AppDelegate *)[[UIApplication sharedApplication]delegate];
    
    NSString *name=[[app usersDetails]valueForKey:@"profilePicPath"];
    
    if ([name isEqual:[NSNull null]]) {
        
        UIImage *image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"upload-profile" ofType:@"png"]];
        _profilePicImage.image=image;
    }else{
        
        NSString *imagename=[app.imageURL stringByAppendingString:name];
        dispatch_queue_t imagequeue =dispatch_queue_create("imageDownloader", nil);
        dispatch_async(imagequeue, ^{
            
            //download iamge
            NSData *imageData = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:imagename]];
            UIImage *image = [[UIImage alloc] initWithData:imageData];
            dispatch_async(dispatch_get_main_queue(), ^{
                
                if (image==NULL) {
                    UIImage *image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"upload-profile" ofType:@"png"]];
                    _profilePicImage.image  = image;
                    
                }
                else{
                    _profilePicImage.image  = image;
                }
            });
            
        });
        
    }
}


// Added By:Nalina
// Added Date:05/08/16
// Description: Redirect to the edit profile screen

- (IBAction)editProfileClick:(id)sender {
    
    AppDelegate *appdelegate= (AppDelegate *)[[UIApplication sharedApplication]delegate];
    
    BOOL internetCheck= [appdelegate testInternetConnection];
    
    if (internetCheck==NO) {
        [appdelegate displayNetworkAlert];
        [self presentViewController:appdelegate.alert animated:YES completion:nil];
    }else{
        UserProfileViewController *vc=[self.storyboard instantiateViewControllerWithIdentifier:@"userProfile"];
        [self.navigationController pushViewController:vc animated:YES];
    }
    
}




//Added by: Nalina
//Added Date: 05/08/2016
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
//Added Date: 05/08/2016
//Discription:To stop the activity indicator.
-(void)stopLoadingIndicator
{
    
    _loadingView.hidden=YES;
}
// About us button click
- (IBAction)aboutUsbtn:(id)sender {
    
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:
                                @"GeneralStoryboard" bundle:nil];
    
    [self presentViewController:[storyboard instantiateViewControllerWithIdentifier:@"Aboutusview"] animated:NO completion:nil];
    
    
    
    
}
//FAQ button click

- (IBAction)FAQbtn:(id)sender {
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:
                                @"GeneralStoryboard" bundle:nil];
    
    [self presentViewController:[storyboard instantiateViewControllerWithIdentifier:@"FAQViewController"] animated:NO completion:nil];
    
    
}
// Term and condition click
- (IBAction)TermandconditionBtn:(id)sender {
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:
                                @"GeneralStoryboard" bundle:nil];
    
    [self presentViewController:[storyboard instantiateViewControllerWithIdentifier:@"TermsConditionViewController"] animated:NO completion:nil];
}

- (IBAction)changePasswordBtn:(id)sender {
    
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:
                                @"Main" bundle:nil];
    
    [self presentViewController:[storyboard instantiateViewControllerWithIdentifier:@"ChangePassword"] animated:NO completion:nil];
    
}


// Added By:Nalina
// Added Date:05/08/16
// Description: Logout click and alert user about the logout

- (IBAction)logoutBtn:(id)sender {
    
    //GlobalFunction *globalValues=[[GlobalFunction alloc]init];
    AppDelegate *appdelegate=(AppDelegate *)[[UIApplication sharedApplication]delegate];
    
    _alert = [UIAlertController
              alertControllerWithTitle:@""
              message:[[GlobalFunction sharedInstance].arrayOfAlerts objectAtIndex:52]
              preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* yesButton = [UIAlertAction
                                actionWithTitle:@"Yes"
                                style:UIAlertActionStyleDefault
                                handler:^(UIAlertAction * action) {
                                    appdelegate.accessToken=nil;
                                    appdelegate.usersDetails=nil;
                                    appdelegate.availabilityArray=nil;
                                    appdelegate.availabilityId=nil;
                                    appdelegate.availableData=nil;
                                    appdelegate.screenStatus=@"";
                                    
                                   // LoginViewController *loginView=[self.storyboard instantiateViewControllerWithIdentifier:@"login"];
                                   //[self presentViewController:loginView animated:YES completion:nil];
                                    [self dismissViewControllerAnimated:YES completion:nil];
                                }];
    
    UIAlertAction* noButton = [UIAlertAction
                               actionWithTitle:@"No"
                               style:UIAlertActionStyleDefault
                               handler:^(UIAlertAction * action) {
                                   //Handle your yes please button action here
                               }];
    
    [_alert addAction:yesButton];
    [_alert addAction:noButton];
    [self presentViewController:_alert animated:YES completion:nil];
    
}

- (IBAction)appshareBtn:(id)sender {
    
    //Added by: Bhargava
    //Added Date: 14/04/2017
    //Discription:  service call for the appshare.
    
    AppDelegate *appdelegate= (AppDelegate *)[[UIApplication sharedApplication]delegate];
    NSString *getUserInfoUrl=[appdelegate.serviceURL stringByAppendingString:@"api/ShareApp/GetShareAppKey"];
    [self startLoadingIndicator];
    [[GlobalFunction sharedInstance] getServerResponseAfterLogin:getUserInfoUrl method:@"GET" param:nil withCallback:^(NSInteger statusCode, NSDictionary *response, NSError *error)
     {
         
         NSString *message;
         //NSString *appSharedkey;
         
         if (statusCode == 200)
         {
             //appSharedkey = [response objectForKey:@"appSharedKey"];
             
             [self stopLoadingIndicator];
             NSLog(@"shareButton pressed");
             NSString *texttoshare = [@"AppURL" stringByAppendingString:[response objectForKey:@"appSharedKey"]];
             
             NSArray *activityItems = @[texttoshare];
             UIActivityViewController *activityVC = [[UIActivityViewController alloc] initWithActivityItems:activityItems applicationActivities:nil];
             activityVC.excludedActivityTypes = @[UIActivityTypeAssignToContact, UIActivityTypePrint, UIActivityTypePostToTwitter, UIActivityTypePostToWeibo];
             [self presentViewController:activityVC animated:TRUE completion:nil];
             
         }else{
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

- (IBAction)backArrowClick:(id)sender {
    
     [self.navigationController popViewControllerAnimated:YES];
   // [self dismissViewControllerAnimated:YES completion:nil];
    
    /* UIStoryboard *storyboard = [UIStoryboard storyboardWithName:
     @"UserStoryboard" bundle:nil];
     
     [self presentViewController:[storyboard instantiateViewControllerWithIdentifier:@"dashboardUsers"] animated:NO completion:nil]; */
    
    //[self dismissModalViewControllerAnimated:YES];
    
    
}
@end
