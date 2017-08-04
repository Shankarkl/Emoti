
/***************************************************************
 Page name:ProviderSettingsViewController.m
 Created By:Nalina
 Created Date:19/6/16
 Description:Provider Settings implementation file
 ***************************************************************/

#import "ProviderSettingsViewController.h"
#import "GlobalFunction.h"
#import "SessionHistoryViewController.h"
#import "LoginViewController.h"
#import "AppDelegate.h"
#import "MyClientsViewController.h"


@interface ProviderSettingsViewController ()

@end

@implementation ProviderSettingsViewController

//Loads for the first time when page appears
- (void)viewDidLoad {
    UIImage *backgroundImage = [UIImage imageNamed:@"01.PreLogin.png"];
    UIImageView *backgroundImageView=[[UIImageView alloc]initWithFrame:self.view.frame];
    backgroundImageView.frame = self.view.bounds;
    backgroundImageView.contentMode = UIViewContentModeScaleAspectFit;
    backgroundImageView.clipsToBounds = YES;
    backgroundImageView.image=backgroundImage;
    
    [self.view insertSubview:backgroundImageView atIndex:0];

    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

//Loads each time when page appears
-(void)viewWillAppear:(BOOL)animated{
   [[self navigationController] setNavigationBarHidden:YES animated:YES];
    
    self.profilePicView.layer.cornerRadius = 10;
    self.profilePicView.clipsToBounds = YES;
    
    AppDelegate *app= (AppDelegate *)[[UIApplication sharedApplication]delegate];
    
    NSString *name=[[app usersDetails]valueForKey:@"profilePicPath"];
    
    if ([name isEqual:[NSNull null]]) {
        
        UIImage *image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"upload-profile" ofType:@"png"]];
        _profilePicView.image=image;
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
                    _profilePicView.image  = image;
                    
                }
                else{
                    _profilePicView.image  = image;
                }
            });
            
        });
        
    }
}

//Close the screen when we click on back button on header
- (IBAction)backClick:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

// Added By:Nalina
// Added Date:05/08/16
// Description: Logout click and alert user about the logout

- (IBAction)logoutClick:(id)sender {
   // GlobalFunction *globalValues=[[GlobalFunction alloc]init];
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
                                   // [self presentViewController:loginView animated:YES completion:nil];
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

- (IBAction)SesionHistoryBtn:(id)sender {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:
                                @"GeneralStoryboard" bundle:nil];
    
    SessionHistoryViewController*viewcontrol=[storyboard instantiateViewControllerWithIdentifier:@"sessionhistory"];
    
    viewcontrol.userRole = @"Provider";
    
    [self presentViewController:[storyboard instantiateViewControllerWithIdentifier:@"sessionhistory"] animated:NO completion:nil];
}

- (IBAction)myClientsBtn:(id)sender {
    
    
    MyClientsViewController *vc=[self.storyboard instantiateViewControllerWithIdentifier:@"myclients"];
    vc.providerclients=@"myclients";
    [self presentViewController:vc animated:YES completion:nil];
}

- (IBAction)AboutUsbtn:(id)sender {
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:
                                @"GeneralStoryboard" bundle:nil];
    
    [self presentViewController:[storyboard instantiateViewControllerWithIdentifier:@"Aboutusview"] animated:NO completion:nil];
    

}

- (IBAction)FAQsBtn:(id)sender {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:
                                @"GeneralStoryboard" bundle:nil];
    
    [self presentViewController:[storyboard instantiateViewControllerWithIdentifier:@"FAQViewController"] animated:NO completion:nil];
}

- (IBAction)TermsBtn:(id)sender {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:
                                @"GeneralStoryboard" bundle:nil];
    
    [self presentViewController:[storyboard instantiateViewControllerWithIdentifier:@"TermsConditionViewController"] animated:NO completion:nil];
}

- (IBAction)LogoutBtn:(id)sender {
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

- (IBAction)AppshareBtn:(id)sender {
    //Added by: Jithesh
    //Added Date: 17/04/2017
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

- (IBAction)AmountEarnedBtn:(id)sender {
}
@end
