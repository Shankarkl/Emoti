/***************************************************************
 Page name: SessionSummaryViewController.m
 Created By:Nalina
 Created Date:2016-07-14
 Description:Session summary implementation Screen.
 ***************************************************************/

#import "SessionSummaryViewController.h"
#import "AppDelegate.h"
#import "GlobalFunction.h"
#import "MakeAnAppointmentViewController.h"
#import <Google/Analytics.h>

@interface SessionSummaryViewController ()

@end

@implementation SessionSummaryViewController

//Loads when page appears for the first time
- (void)viewDidLoad {
    AppDelegate *appdelegate= (AppDelegate *)[[UIApplication sharedApplication]delegate];
    appdelegate.screenStatus=@"fromJoinsession";
    appdelegate.checkIdelTimer=@"startTimer";
    providerDetails=[[NSMutableDictionary alloc]init];
    [super viewDidLoad];
    
    UIImageView *bgImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"05. List-View.png"]];
    bgImageView.frame = self.view.bounds;
    bgImageView.contentMode = UIViewContentModeScaleAspectFit;
    bgImageView.clipsToBounds = YES;
    [self.view insertSubview:bgImageView atIndex:0];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

//Loads when page appears each time
-(void)viewWillAppear:(BOOL)animated{
    self.tabBarController.tabBar.hidden = NO;
    self.profile.layer.cornerRadius = self.profile.frame.size.width / 2;
    self.profile.clipsToBounds = YES;
    
    //Added by: Nalina
    //Added Date: 26/08/2016
    //Discription: To display user information in summary screen call service and get the details
    
    AppDelegate *appdelegate= (AppDelegate *)[[UIApplication sharedApplication]delegate];
    NSString *userRole=[appdelegate.usersDetails objectForKey:@"userRole"];
    
    _details=[[appdelegate usersDetails] valueForKey:@"nextScheduledAppointment"];
    
    
    //Added by: Nalina
    //Added Date: 26/08/2016
    //Discription: Display data on screen by checking for the user
    
    
    if ([userRole isEqualToString:@"User"]) {
        // _patientName.text=[_details objectForKey:@"userFirstName"];
        _providerName.text=[NSString stringWithFormat:@"%@ %@",[_details objectForKey:@"providerFirstName"],[_details objectForKey:@"providerLastName"]];
        _username.text=[NSString stringWithFormat:@"%@ %@ %@",@"Your Session with ",[_details objectForKey:@"providerFirstName"],[_details objectForKey:@"providerLastName"]];
        
        if ([[_details objectForKey:@"providerProfilePicPath"] isEqual:[NSNull null]]) {
            
            UIImage *image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"upload-profile" ofType:@"png"]];
            _profile.image=image;
            
        }else{
            
            NSString *name=[_details objectForKey:@"providerProfilePicPath"];
            NSString *imagename=[appdelegate.imageURL stringByAppendingString:name];
            dispatch_queue_t imagequeue =dispatch_queue_create("imageDownloader", nil);
            dispatch_async(imagequeue, ^{
                
                //download iamge
                NSData *imageData = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:imagename]];
                UIImage *image = [[UIImage alloc] initWithData:imageData];
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    if (image==NULL) {
                        UIImage *image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"upload-profile" ofType:@"png"]];
                        _profile.image  = image;
                    }
                    else{
                        _profile.image  = image;
                    }
                });
                
            });
        }
        
    }else{
        // _patientName.text=[_details objectForKey:@"providerFirstName"];
        _providerName.text=[NSString stringWithFormat:@"%@",[_details objectForKey:@"userDisplayName"]];
        _username.text=[NSString stringWithFormat:@"%@ %@",@"Your Session with ",[_details objectForKey:@"userFirstName"]];
        
        if ([[_details objectForKey:@"userProfilePicPath"] isEqual:[NSNull null]]) {
            
            UIImage *image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"upload-profile" ofType:@"png"]];
            _profile.image=image;
            
        }else{
            
            NSString *name=[_details objectForKey:@"userProfilePicPath"];
            NSString *imagename=[appdelegate.imageURL stringByAppendingString:name];
            dispatch_queue_t imagequeue =dispatch_queue_create("imageDownloader", nil);
            dispatch_async(imagequeue, ^{
                
                //download iamge
                NSData *imageData = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:imagename]];
                UIImage *image = [[UIImage alloc] initWithData:imageData];
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    if (image==NULL) {
                        UIImage *image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"upload-profile" ofType:@"png"]];
                        _profile.image  = image;
                    }
                    else{
                        _profile.image  = image;
                    }
                });
                
            });
        }
        
    }
    
    
    if ([[appdelegate.usersDetails objectForKey:@"profilePicPath"] isEqual:[NSNull null]]) {
        
        UIImage *image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"upload-profile" ofType:@"png"]];
        _profile.image=image;
        
    }else{
        
        NSString *name=[appdelegate.usersDetails objectForKey:@"profilePicPath"];
        NSString *imagename=[appdelegate.imageURL stringByAppendingString:name];
        dispatch_queue_t imagequeue =dispatch_queue_create("imageDownloader", nil);
        dispatch_async(imagequeue, ^{
            
            //download iamge
            NSData *imageData = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:imagename]];
            UIImage *image = [[UIImage alloc] initWithData:imageData];
            dispatch_async(dispatch_get_main_queue(), ^{
                
                if (image==NULL) {
                    UIImage *image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"upload-profile" ofType:@"png"]];
                    _profile.image  = image;
                }
                else{
                    _profile.image  = image;
                }
            });
            
        });
    }
    
    if ([[_sessionDetails valueForKey:@"sessionCostCurrency"] isEqual:[NSNull null]] || [_totalSessionTime isEqual:[NSNull null]]) {
        
        _timeLabel.text=[NSString stringWithFormat:@"%@ %@ %@ %@",@"For ",@"00:00:00",@"at a total cost of ",@"$ 0"];
        
    }else if ([_totalSessionTime isEqualToString:@""]){
        _timeLabel.text=[NSString stringWithFormat:@"%@ %@ %@ %@",@"For ",@"00:00:00",@"at a total cost of ",@"$ 0"];
    }else{
        _timeLabel.text=[NSString stringWithFormat:@"%@ %@ %@ %@",@"For ",_totalSessionTime,@"at a total cost of ",[_sessionDetails valueForKey:@"sessionCostCurrency"]];
        
        
    }
    if ([_totalSessionTime isEqualToString:@""]){
        //_timeLabel.text=@"00:00:00";
        _timeLabel.text=[NSString stringWithFormat:@"%@ %@ %@ %@",@"For ",@"00:00:00",@"at a total cost of ",[_sessionDetails valueForKey:@"sessionCostCurrency"]];
        
        
    }else{
        //_timeLabel.text=_totalSessionTime;
        _timeLabel.text=[NSString stringWithFormat:@"%@ %@ %@ %@",@"For ",_totalSessionTime,@"at a total cost of ",[_sessionDetails valueForKey:@"sessionCostCurrency"]];
        
        
    }
    
    self.providerProfileImage.layer.cornerRadius = self.providerProfileImage.frame.size.width / 2;
    self.providerProfileImage.clipsToBounds = YES;
    
    id<GAITracker> tracker = [[GAI sharedInstance] defaultTracker];
    [tracker set:kGAIScreenName value:@"SessionSummary"];
    [tracker send:[[GAIDictionaryBuilder createScreenView] build]];
    
}

//Added by: Nalina
//Added Date: 24/08/2016
//Discription: Redirect to the make an appointment screen on click of make an appointment button

- (IBAction)makeAnAppointmentClick:(id)sender {
    MakeAnAppointmentViewController *vc=[self.storyboard instantiateViewControllerWithIdentifier:@"makeanappointment"];
    vc.screenStatus=@"appointment";
    vc.postScheduleDetails=providerDetails;
    [self.navigationController pushViewController:vc animated:YES];
}

//Added by: Nalina
//Added Date: 24/08/2016
//Discription: Close the navigation screens to go back to the dashboard screen

- (IBAction)homeClick:(id)sender {
    AppDelegate *app= (AppDelegate *)[[UIApplication sharedApplication]delegate];
    
    [[app usersDetails] setObject:[NSNull null] forKey:@"nextScheduledAppointment"];
   
    
    [[[[[self presentingViewController]presentingViewController]presentingViewController]presentingViewController] dismissViewControllerAnimated:YES completion:nil];
}

@end
