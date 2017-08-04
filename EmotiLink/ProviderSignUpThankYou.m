//
//  ProviderSignUpThankYou.m
//  EmotiLink
//
//  Created by Starsoft on 2017-04-10.
//  Copyright © 2017 Stark. All rights reserved.
//

#import "ProviderSignUpThankYou.h"
#import "FirstScreenViewController.h"
#import "AppDelegate.h"
#import "LoginViewController.h"

#define appdelegate (AppDelegate *)[[UIApplication sharedApplication]delegate]

@interface ProviderSignUpThankYou ()

@end

@implementation ProviderSignUpThankYou

- (void)viewDidLoad {
     [super viewDidLoad];
   // NSMutableDictionary *dict=[[NSMutableDictionary alloc]init];
    _personalinfo =_providerregister;
   // _user= [_personalinfo removeObjectForKey:@"userName"];
    
    NSLog(@"dictionary %@",_user);
    
    // Do any additional setup after loading the view.
    //NSString *userName=[[appdelegate usersDetails]valueForKey:@"userName"];
    //_thankYouLabel.text = [@"Thank you, " stringByAppendingString:userName] ;
    
    UIImage *backgroundImage = [UIImage imageNamed:@"04. Thanks & No Results.png"];
    UIImageView *backgroundImageView=[[UIImageView alloc]initWithFrame:self.view.frame];
    backgroundImageView.image=backgroundImage;
    [self.view insertSubview:backgroundImageView atIndex:0];
   
}

//called each time when the view appears
-(void)viewWillAppear:(BOOL)animated{
    if([_screenStatus isEqualToString:@"ProviderSignUp"])
    {
        _thanksContentLabel.text=@"Please allow us to review your application. We will be in touch.";
        
    } else{
        _thanksContentLabel.text=@"Thanks for registering with us. Please login and continue.";
    }
    
    _thankYouLabel.text=[@"Thank You, " stringByAppendingString:_userNametoDisplay];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)homeClick:(id)sender {
    
  /*    FirstScreenViewController *vc=[self.storyboard instantiateViewControllerWithIdentifier:@"LoginScreen"];
    [self presentViewController:vc animated:YES completion:nil]; */
    
   // [self.navigationController popToRootViewControllerAnimated:YES];
    
    //[self.parentViewController dismissViewControllerAnimated:YES  completion:nil];
    
    //[self dismissModalStackAnimated:YES  completion:nil];
    
    //[self dismissViewControllerAnimated:NO completion:nil];
    //[self dismissViewControllerAnimated:YES completion:nil];
    
    
    
    if([_screenStatus isEqualToString:@"ProviderSignUp"])
    {
        
        
        [[[[[[[[self presentingViewController]presentingViewController]presentingViewController]presentingViewController]presentingViewController]presentingViewController]presentingViewController]  dismissViewControllerAnimated:YES completion:nil];
        
        LoginViewController *vc=[self.storyboard instantiateViewControllerWithIdentifier:@"LoginScreen"];
         vc.screenStatus=@"providerSignupSuccess";
        [self presentViewController:vc animated:YES completion:nil];
       
        
    } else{
        
        [[[self presentingViewController]presentingViewController] dismissViewControllerAnimated:YES completion:nil];
        
        LoginViewController *vc=[self.storyboard instantiateViewControllerWithIdentifier:@"LoginScreen"];
        vc.screenStatus=@"userSignupSuccess";
        [self presentViewController:vc animated:YES completion:nil];
        
    }
    
}

- (void)dismissModalStackAnimated:(bool)animated completion:(void (^)(void))completion {
    UIView *fullscreenSnapshot = [[UIApplication sharedApplication].delegate.window snapshotViewAfterScreenUpdates:false];
    [self.presentedViewController.view insertSubview:fullscreenSnapshot atIndex:NSIntegerMax];
    [self dismissViewControllerAnimated:animated completion:completion];
}

@end
