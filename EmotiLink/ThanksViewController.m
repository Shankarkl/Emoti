
/***************************************************************
 Page name: ThanksViewController.m
 Created By:Zeenath
 Created Date:13/7/16
 Description:Thank you implementation file
 ***************************************************************/


#import "ThanksViewController.h"
#import "LoginViewController.h"
#import "AppDelegate.h"
#import "UserDashboardViewController.h"
#import "ProviderDashboard.h"
@interface ThanksViewController ()

@end

@implementation ThanksViewController

//Called when the view controller is first time loaded to memory
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
}
//called each time when the view appears
-(void)viewWillAppear:(BOOL)animated{
    if([_screenStatus isEqualToString:@"ProviderSignUp"])
    {
        _titleText.hidden=NO;
        _allowUsLabel.hidden=NO;
        _reviewLabel.hidden=NO;
        _updateViaEmailLabel.hidden=NO;
        _signingupLabel.hidden=NO;

        
    }else if([_screenStatus isEqualToString:@"AppointmentConfirm"])
    {
        _titleText.hidden=NO;
        _scheduleConfirmationText.hidden=NO;
        [_loginButton setTitle:@"OK" forState:UIControlStateNormal];
        
    }else{
        _titleText.hidden=NO;
        _loginAndContinueLabel.hidden=NO;
        _signingupLabel.hidden=NO;
    }
}

 // Dispose of any resources that can be recreated.
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
   }


//Added by: Zeenath
//Added Date: 29/07/2016
//Discription: To navigate back to login page checking the previous screen status
- (IBAction)loginButtonClick:(id)sender {
    AppDelegate *app= (AppDelegate *)[[UIApplication sharedApplication]delegate];
    if([app.screenState isEqualToString:@"userDashboard"]||[_screenStatus isEqualToString:@"AppointmentConfirm"])
    {
       // UserDashboardViewController *vc=[self.storyboard instantiateViewControllerWithIdentifier:@"UserDashboard"];
       // [self presentViewController:vc animated:YES completion:nil];
        
        [self dismissViewControllerAnimated:NO completion:nil];
        app.screenState=@"AppointmentConfirm";
        
        
    }
   else if([app.screenState isEqualToString:@"ProviderDashboard"])
    {
        ProviderDashboard *vc=[self.storyboard instantiateViewControllerWithIdentifier:@"ProviderDashboard"];
        [self presentViewController:vc animated:YES completion:nil];
        
    }
    
    else
    {
        LoginViewController *loginView=[self.storyboard instantiateViewControllerWithIdentifier:@"login"];
        [self presentViewController:loginView animated:YES completion:nil];
        
    }
}


@end
