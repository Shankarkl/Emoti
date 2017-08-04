
/***************************************************************
 Page name: ProfileSettingsViewController.m
 Created By: Nalina
 Created Date: 2016-07-20
 Description: Profile Setting implementation file
 ***************************************************************/

#import "ProfileSettingsViewController.h"
#import "AvailabilityViewController.h"
#import "AppDelegate.h"
#import "GlobalFunction.h"
@interface ProfileSettingsViewController ()

@end

@implementation ProfileSettingsViewController

//Loads for the first time when page appears
- (void)viewDidLoad {
    UIImage *backgroundImage = [UIImage imageNamed:@"01.PreLogin.png"];
    UIImageView *backgroundImageView=[[UIImageView alloc]initWithFrame:self.view.frame];
    backgroundImageView.frame = self.view.bounds;
    backgroundImageView.contentMode = UIViewContentModeScaleAspectFit;
    backgroundImageView.clipsToBounds = YES;
    backgroundImageView.image=backgroundImage;
    [self.view insertSubview:backgroundImageView atIndex:0];

    availabilityArray = [[NSMutableArray alloc] init];
    availabilityId= [[NSMutableArray alloc] init];
    availableData=[[NSMutableDictionary alloc]init];
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

//Loads each time when page appears
-(void)viewWillAppear:(BOOL)animated
{
    UIImage *image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"back-28x28" ofType:@"png"]];
    
    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithImage:image style:UIBarButtonItemStylePlain target:self action:@selector(goBack)];
    [self.navigationItem setLeftBarButtonItem:barButtonItem];
    
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

//close the setting screen
-(void)goBack{
    [self.navigationController popViewControllerAnimated:YES];
}

//close the setting screen on click of back icon on header
- (IBAction)backClick:(id)sender {
     [self dismissViewControllerAnimated:YES completion:nil];
}


//Added by: Nalina
//Added Date: 09/08/2016
//Discription: availability click to redirct to the screen and service call to get the details of availability

- (IBAction)availabilityButtonClick:(id)sender {
    
    AppDelegate *app= (AppDelegate *)[[UIApplication sharedApplication]delegate];
    
    BOOL internetCheck= [app testInternetConnection];
    
    if (internetCheck==NO) {
        [app displayNetworkAlert];
        [self presentViewController:app.alert animated:YES completion:nil];
        return;
    }

    [self startLoadingIndicator];
    
    NSString *securityQuestionUrl=[app.serviceURL stringByAppendingString:@"api/Availability/Availability"];
    AvailabilityViewController *vc=[self.storyboard instantiateViewControllerWithIdentifier:@"Availability"];

    [[GlobalFunction sharedInstance] getServerResponseAfterLogin:securityQuestionUrl method:@"GET" param:nil withCallback:^(NSInteger statusCode, NSDictionary *response, NSError *error)
     {
         NSDictionary *actualData;
         
         if (statusCode==200) {
             
             NSMutableArray *responseArray = [[NSMutableArray alloc] initWithObjects:response, nil];
             NSMutableArray *sortedArray =[responseArray objectAtIndex:0];
             @autoreleasepool {
                 
             for(int i=0;i<sortedArray.count;i++) {
                 actualData=[sortedArray objectAtIndex:i];
                 NSString *availableList=[actualData objectForKey:@"availabilityType"];
                 NSString *availableID=[actualData objectForKey:@"id"];
                 
                 [availabilityArray addObject:availableList];
                 [availabilityId addObject:availableID];
             }
             }
             vc.availablepickerArray=availabilityArray;
             vc.availablepickerIDArray=availabilityId;

             NSString *availableUrl=[app.serviceURL stringByAppendingString:@"api/Provider/ProviderAvailability"];
             
             [[GlobalFunction sharedInstance] getServerResponseAfterLogin:availableUrl method:@"GET" param:nil withCallback:^(NSInteger statusCode, NSDictionary *response, NSError *error)
              {
                  if (statusCode==200) {
                      
                      availableData=response;
                      vc.availableData=availableData;

                      [self.navigationController pushViewController:vc animated:YES];
                      [self stopLoadingIndicator];
                  }else{
                      if(statusCode==403||statusCode==503){
                      }else{
                          NSDictionary *messagearray=[response objectForKey:@ "modelState"];
                          NSArray *dictValues=[messagearray allValues];
                          NSArray *message=[dictValues objectAtIndex:0];
                          
                          
                          _alert = [UIAlertController
                                    alertControllerWithTitle:@""
                                    message:[message objectAtIndex:0]
                                    preferredStyle:UIAlertControllerStyleAlert];
                          
                          UIAlertAction* okbutton = [UIAlertAction
                                                     actionWithTitle:@"OK"
                                                     style:UIAlertActionStyleDefault
                                                     handler:^(UIAlertAction * action) {
                                                         [self stopLoadingIndicator];
                                                     }];
                          
                          [_alert addAction:okbutton];
                          [self presentViewController:_alert animated:YES completion: nil];
                          [self stopLoadingIndicator];
                      }
                  }
              }];
             
         }else{
             
             NSDictionary *messagearray=[response objectForKey:@ "modelState"];
             NSArray *dictValues=[messagearray allValues];
             NSArray *message=[dictValues objectAtIndex:0];
             
             
             _alert = [UIAlertController
                       alertControllerWithTitle:@""
                       message:[message objectAtIndex:0]
                       preferredStyle:UIAlertControllerStyleAlert];
             
             UIAlertAction* okbutton = [UIAlertAction
                                        actionWithTitle:@"OK"
                                        style:UIAlertActionStyleDefault
                                        handler:^(UIAlertAction * action) {
                                            [self stopLoadingIndicator];
                                        }];
             
             [_alert addAction:okbutton];
             [self presentViewController:_alert animated:YES completion: nil];
             [self stopLoadingIndicator];
         }
     }];
    
    

}

//Added by: Nalina
//Added Date: 09/08/2016
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
//Added Date: 09/08/2016
//Discription:To start the activity indicator.
-(void)stopLoadingIndicator
{
    
    _loadingView.hidden=YES;
}

- (IBAction)ChangePasswordBtn:(id)sender {
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:
                                @"Main" bundle:nil];
    
    [self presentViewController:[storyboard instantiateViewControllerWithIdentifier:@"ChangePassword"] animated:NO completion:nil];
    

}
- (IBAction)backclick:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
