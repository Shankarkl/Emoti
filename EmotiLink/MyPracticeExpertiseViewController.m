/***************************************************************
 Page name: MyPracticeExpertiseViewController.m
 Created By: Nalina
 Created Date: 2016-07-20
 Description: Practice expertise implementation file
 ***************************************************************/

#import "MyPracticeExpertiseViewController.h"
#import "GlobalFunction.h"
#import "AppDelegate.h"
#import <Google/Analytics.h>


@interface MyPracticeExpertiseViewController ()

@end

@implementation MyPracticeExpertiseViewController

//Loads when user focus the screen for the first time
- (void)viewDidLoad {
    myBoolfamilyValue=NO;
    myBoolGroupValue=NO;
    myBooladoptionValue=NO;
    myBoolanxietyValue=NO;
    myBoolSocialanxietyValue=NO;
    myBoolchronicPainValue=NO;
    myBoolAngerManagementValue=NO;
    myBoolworkspaceValue=NO;
    myBoolPTSDValue=NO;
    myBoolFriendshipsValue=NO;
    myBooladdictionValue=NO;
    myBoolLGBTQValue=NO;
    myBoolDepressionValue=NO;
    myBoolLossGriefValue=NO;
    myBoolParentingValue=NO;
    myBoolStressValue=NO;
    myBoolTraumaValue=NO;
    myBoolDatingRomanceValue=NO;
    myBoolSeparationDivorceValue=NO;
    myBoolSubstanceAbuseValue=NO;
    myBoolSexualTraumaValue=NO;
    myBoolpracticeExpertiseValue=NO;
    practiceExpertise= [[NSMutableArray alloc]init];
    
    [super viewDidLoad];
    [self setBorderColor:25];

    
    [self setExpertiseButtonBorderColor:1];
    [self setExpertiseButtonBorderColor:2];
    [self setExpertiseButtonBorderColor:3];
    [self setExpertiseButtonBorderColor:4];
    [self setExpertiseButtonBorderColor:5];
    [self setExpertiseButtonBorderColor:6];
    [self setExpertiseButtonBorderColor:7];
    [self setExpertiseButtonBorderColor:8];
    [self setExpertiseButtonBorderColor:9];
    [self setExpertiseButtonBorderColor:10];
    [self setExpertiseButtonBorderColor:11];
    [self setExpertiseButtonBorderColor:12];
    [self setExpertiseButtonBorderColor:13];
    [self setExpertiseButtonBorderColor:14];
    [self setExpertiseButtonBorderColor:15];
    [self setExpertiseButtonBorderColor:16];
    [self setExpertiseButtonBorderColor:17];
    [self setExpertiseButtonBorderColor:18];
    [self setExpertiseButtonBorderColor:19];
    [self setExpertiseButtonBorderColor:20];
    [self setExpertiseButtonBorderColor:21];
    
    //  Added by:Zeenath
    //  Added Date:2016-07-20.
    //  Description:Service call to GET and Bind the provider expertises.
    
    AppDelegate *appdelegate=(AppDelegate *)[[UIApplication sharedApplication]delegate];
    NSString *Url=[appdelegate.serviceURL stringByAppendingString:@"/api/Provider/ProviderExpertise"];
    [self startLoadingIndicator];
    [[GlobalFunction sharedInstance]getServerResponseAfterLogin:Url method:@"GET" param:nil withCallback:^(NSInteger statusCode, NSDictionary *response, NSError *error) {
        [self stopLoadingIndicator];
        NSMutableArray *array=[response mutableCopy];
        @autoreleasepool {
            
        for(int i=0;i<[array count];i++)
        {
            NSDictionary *dict=[array objectAtIndex:i];
            //[practiceExpertise addObject:dict];
            
            if([[dict valueForKey:@"expertiseID"] isEqualToNumber:[NSNumber numberWithInt:1]])
            {
                myBooladdictionValue=[self setButtonColorOnSelected:11 boolValue:myBooladdictionValue addDictValue:1];
            }
            if([[dict valueForKey:@"expertiseID"] isEqualToNumber:[NSNumber numberWithInt:2]])
            {
                myBooladoptionValue=[self setButtonColorOnSelected:3 boolValue:myBooladoptionValue addDictValue:2];

            }
            if([[dict valueForKey:@"expertiseID"] isEqualToNumber:[NSNumber numberWithInt:3]])
            {
                myBoolAngerManagementValue=[self setButtonColorOnSelected:7 boolValue:myBoolAngerManagementValue addDictValue:3];
            }
            if([[dict valueForKey:@"expertiseID"] isEqualToNumber:[NSNumber numberWithInt:4]])
            {
                  myBoolanxietyValue=[self setButtonColorOnSelected:4 boolValue:myBoolanxietyValue addDictValue:4];
            }
            if([[dict valueForKey:@"expertiseID"] isEqualToNumber:[NSNumber numberWithInt:5]])
            {
                myBoolchronicPainValue=[self setButtonColorOnSelected:6 boolValue:myBoolchronicPainValue addDictValue:5];
            }
            if([[dict valueForKey:@"expertiseID"] isEqualToNumber:[NSNumber numberWithInt:6]])
            {
                 myBoolDatingRomanceValue=[self setButtonColorOnSelected:18 boolValue:myBoolDatingRomanceValue addDictValue:6];
            }
            if([[dict valueForKey:@"expertiseID"] isEqualToNumber:[NSNumber numberWithInt:7]])
            {
                myBoolDepressionValue=[self setButtonColorOnSelected:13 boolValue:myBoolDepressionValue addDictValue:7];
            }
            if([[dict valueForKey:@"expertiseID"] isEqualToNumber:[NSNumber numberWithInt:8]])
            {
                myBoolfamilyValue=[self setButtonColorOnSelected:1 boolValue:myBoolfamilyValue addDictValue:8];
            }
            if([[dict valueForKey:@"expertiseID"] isEqualToNumber:[NSNumber numberWithInt:9]])
            {
                myBoolFriendshipsValue=[self setButtonColorOnSelected:10 boolValue:myBoolFriendshipsValue addDictValue:9];
            }
            if([[dict valueForKey:@"expertiseID"] isEqualToNumber:[NSNumber numberWithInt:10]])
            {
                myBoolGroupValue=[self setButtonColorOnSelected:2 boolValue:myBoolGroupValue addDictValue:10];
            }
            if([[dict valueForKey:@"expertiseID"] isEqualToNumber:[NSNumber numberWithInt:11]])
            {
                 myBoolLGBTQValue=[self setButtonColorOnSelected:12 boolValue:myBoolLGBTQValue addDictValue:11];
            }
            if([[dict valueForKey:@"expertiseID"] isEqualToNumber:[NSNumber numberWithInt:12]])
            {
                myBoolLossGriefValue=[self setButtonColorOnSelected:14 boolValue:myBoolLossGriefValue addDictValue:12];
            }
            if([[dict valueForKey:@"expertiseID"] isEqualToNumber:[NSNumber numberWithInt:13]])
            {
                myBoolParentingValue=[self setButtonColorOnSelected:15 boolValue:myBoolParentingValue addDictValue:13];
            }
            if([[dict valueForKey:@"expertiseID"] isEqualToNumber:[NSNumber numberWithInt:14]])
            {
               myBoolPTSDValue=[self setButtonColorOnSelected:9 boolValue:myBoolPTSDValue addDictValue:14];
            }
            if([[dict valueForKey:@"expertiseID"] isEqualToNumber:[NSNumber numberWithInt:15]])
            {
                   myBoolSeparationDivorceValue=[self setButtonColorOnSelected:19 boolValue:myBoolSeparationDivorceValue addDictValue:15];
            }
            if([[dict valueForKey:@"expertiseID"] isEqualToNumber:[NSNumber numberWithInt:16]])
            {
                myBoolSexualTraumaValue=[self setButtonColorOnSelected:21 boolValue:myBoolSexualTraumaValue addDictValue:16];
            }
            if([[dict valueForKey:@"expertiseID"] isEqualToNumber:[NSNumber numberWithInt:17]])
            {
                 myBoolSocialanxietyValue=[self setButtonColorOnSelected:5 boolValue:myBoolSocialanxietyValue addDictValue:17];
            }
            if([[dict valueForKey:@"expertiseID"] isEqualToNumber:[NSNumber numberWithInt:18]])
            {
                myBoolStressValue=[self setButtonColorOnSelected:16 boolValue:myBoolStressValue addDictValue:18];
            }
            if([[dict valueForKey:@"expertiseID"] isEqualToNumber:[NSNumber numberWithInt:19]])
                
            {
                myBoolSubstanceAbuseValue=[self setButtonColorOnSelected:20 boolValue:myBoolSubstanceAbuseValue addDictValue:19];
            }
            if([[dict valueForKey:@"expertiseID"] isEqualToNumber:[NSNumber numberWithInt:20]])
            {
                 myBoolTraumaValue=[self setButtonColorOnSelected:17 boolValue:myBoolTraumaValue addDictValue:20];
            }
            if([[dict valueForKey:@"expertiseID"] isEqualToNumber:[NSNumber numberWithInt:21]])
            {
                   myBoolworkspaceValue=[self setButtonColorOnSelected:8 boolValue:myBoolworkspaceValue addDictValue:21];
            }
            
        }
        }
    }];

}

//Loads each time when screen appears
-(void)viewWillAppear:(BOOL)animated
{
    id<GAITracker> tracker = [[GAI sharedInstance] defaultTracker];
    [tracker set:kGAIScreenName value:@"MyPracticeExpertise"];
    [tracker send:[[GAIDictionaryBuilder createScreenView] build]];
}

-(void) setBorderColor:(int)tagName{
    UIButton *cancelBtn = (UIButton *) [self.view viewWithTag:tagName];
    cancelBtn.layer.borderColor = [UIColor colorWithRed:246.0/255.0 green:108.0/255.0 blue:118.0/255.0 alpha:1].CGColor;
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


//  Added by:Nalina
//  Added Date:2016-07-20
//  Description: Add click events to the radio button to check and uncheck

// Modified by:Zeenath
// Modified Date:2016-07-20
// Description:To get the ID of the field bind it from service

- (IBAction)checkboxFamilyClick:(id)sender {
   myBoolfamilyValue=[self setButtonColorOnSelected:1 boolValue:myBoolfamilyValue addDictValue:8];
}
- (IBAction)checkboxGroupClick:(id)sender {
  myBoolGroupValue=[self setButtonColorOnSelected:2 boolValue:myBoolGroupValue addDictValue:10];
}
- (IBAction)checkboxAdoptionClick:(id)sender {
   myBooladoptionValue=[self setButtonColorOnSelected:3 boolValue:myBooladoptionValue addDictValue:2];
}
- (IBAction)checkboxAnxietyClick:(id)sender {
  myBoolanxietyValue=[self setButtonColorOnSelected:4 boolValue:myBoolanxietyValue addDictValue:4];
}
- (IBAction)checkboxSocialAnxiety:(id)sender {
   myBoolSocialanxietyValue=[self setButtonColorOnSelected:5 boolValue:myBoolSocialanxietyValue addDictValue:17];
}
- (IBAction)CheckboxChronicPainClick:(id)sender {
   myBoolchronicPainValue=[self setButtonColorOnSelected:6 boolValue:myBoolchronicPainValue addDictValue:5];
}
- (IBAction)checkboxAngerManagementClick:(id)sender {
  myBoolAngerManagementValue=[self setButtonColorOnSelected:7 boolValue:myBoolAngerManagementValue addDictValue:3];
}
- (IBAction)checkboxWorkplaceClick:(id)sender {
   myBoolworkspaceValue=[self setButtonColorOnSelected:8 boolValue:myBoolworkspaceValue addDictValue:21];
}
- (IBAction)checkboxPTSDClick:(id)sender {
  myBoolPTSDValue=[self setButtonColorOnSelected:9 boolValue:myBoolPTSDValue addDictValue:14];
}
- (IBAction)checkboxFriendshipsClick:(id)sender {
   myBoolFriendshipsValue=[self setButtonColorOnSelected:10 boolValue:myBoolFriendshipsValue addDictValue:9];
    
}


- (IBAction)checkboxAddictionClick:(id)sender {
  myBooladdictionValue=[self setButtonColorOnSelected:11 boolValue:myBooladdictionValue addDictValue:1];
    
}

- (IBAction)checkboxLGBTQClick:(id)sender {
    myBoolLGBTQValue=[self setButtonColorOnSelected:12 boolValue:myBoolLGBTQValue addDictValue:11];
}
- (IBAction)checkboxDepressionClick:(id)sender {
  myBoolDepressionValue=[self setButtonColorOnSelected:13 boolValue:myBoolDepressionValue addDictValue:7];
}
- (IBAction)checkboxLossGriefClick:(id)sender {
    myBoolLossGriefValue=[self setButtonColorOnSelected:14 boolValue:myBoolLossGriefValue addDictValue:12];
}
- (IBAction)checkboxParentingClick:(id)sender {
     myBoolParentingValue=[self setButtonColorOnSelected:15 boolValue:myBoolParentingValue addDictValue:13];
}
- (IBAction)checkboxStressClick:(id)sender {
  myBoolStressValue=[self setButtonColorOnSelected:16 boolValue:myBoolStressValue addDictValue:18];
}
- (IBAction)checkboxTraumaClick:(id)sender {
   myBoolTraumaValue=[self setButtonColorOnSelected:17 boolValue:myBoolTraumaValue addDictValue:20];
}
- (IBAction)checkboxDatingClick:(id)sender {
  myBoolDatingRomanceValue=[self setButtonColorOnSelected:18 boolValue:myBoolDatingRomanceValue addDictValue:6];
}
- (IBAction)checkboxSeparationDivorceClick:(id)sender {
    myBoolSeparationDivorceValue=[self setButtonColorOnSelected:19 boolValue:myBoolSeparationDivorceValue addDictValue:15];
}
- (IBAction)checkboxSubstanceAbuseClick:(id)sender {
   myBoolSubstanceAbuseValue=[self setButtonColorOnSelected:20 boolValue:myBoolSubstanceAbuseValue addDictValue:19];
}
- (IBAction)checkboxSexualTraumaClick:(id)sender {
    myBoolSexualTraumaValue=[self setButtonColorOnSelected:21 boolValue:myBoolSexualTraumaValue addDictValue:16];
    
}

//Close the screen function
- (IBAction)backClick:(id)sender {
     [self dismissViewControllerAnimated:YES completion:nil];
}

//To update the practice expertice
- (IBAction)nextButtonClick:(id)sender {
    
    
    if(!(myBoolPTSDValue) && !(myBoolGroupValue) && !(myBooladoptionValue) && !(myBoolfamilyValue) && !(myBoolanxietyValue) && !(myBoolSocialanxietyValue) &&!(myBoolchronicPainValue) && !(myBoolworkspaceValue) && !(myBoolAngerManagementValue)&& !(myBoolLGBTQValue) && !(myBooladdictionValue) && !(myBoolLossGriefValue) && !(myBoolTraumaValue) && !(myBoolDatingRomanceValue) && !(myBoolSeparationDivorceValue) && !(myBoolStressValue) && !(myBoolDepressionValue)&& !(myBoolFriendshipsValue) && !(myBoolSexualTraumaValue) && !(myBoolParentingValue) && !(myBoolSubstanceAbuseValue))
    {
        
        
    //    GlobalFunction *globalValues=[[GlobalFunction alloc]init];
        
        _alert = [UIAlertController
                  alertControllerWithTitle:@""
                  message:[[GlobalFunction sharedInstance].arrayOfAlerts objectAtIndex:50]
                  preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* okButton = [UIAlertAction
                                   actionWithTitle:@"Ok"
                                   style:UIAlertActionStyleDefault
                                   handler:^(UIAlertAction * action) {
                                       //Handle your yes please button action here
                                   }];
        [_alert addAction:okButton];
        [self presentViewController:_alert animated:YES completion:nil];
    }
    else
    {
        NSDictionary *dict = [practiceExpertise mutableCopy];
        AppDelegate *appdelegate=(AppDelegate *)[[UIApplication sharedApplication]delegate];
        NSString *Url=[appdelegate.serviceURL stringByAppendingString:@"api/Provider/ProviderExpertise"];
       // GlobalFunction *globalValues=[[GlobalFunction alloc]init];
        [self startLoadingIndicator];
        [[GlobalFunction sharedInstance]getServerResponseAfterLogin:Url method:@"POST" param:dict withCallback:^(NSInteger statusCode, NSDictionary *response, NSError *error) {
                      if(statusCode==200){
                [self stopLoadingIndicator];
                NSString *message=[[GlobalFunction sharedInstance].arrayOfAlerts objectAtIndex:96];
                _alertView = [UIAlertController
                              alertControllerWithTitle:@""
                              message:message
                              preferredStyle:UIAlertControllerStyleAlert];
                
                UIAlertAction* okButton = [UIAlertAction
                                           actionWithTitle:@"OK"
                                           style:UIAlertActionStyleDefault
                                           handler:^(UIAlertAction * action) {
                                             
                                             // [self.navigationController popViewControllerAnimated:YES];
                                                [self dismissViewControllerAnimated:YES completion:nil];
                                               
                                           }];
                [_alertView addAction:okButton];
                UIViewController *top = [self topMostController];
                [top presentViewController:_alertView animated:YES completion: nil];
                
            }
            else if(statusCode == 500)
            {
                [self stopLoadingIndicator];
                NSString *message=[[GlobalFunction sharedInstance].arrayOfAlerts objectAtIndex:50];
                _alertView = [UIAlertController
                              alertControllerWithTitle:@""
                              message:message
                              preferredStyle:UIAlertControllerStyleAlert];
                
                UIAlertAction* okButton = [UIAlertAction
                                           actionWithTitle:@"OK"
                                           style:UIAlertActionStyleDefault
                                           handler:^(UIAlertAction * action) {
                                               [self dismissViewControllerAnimated:YES completion:nil];
                                           }];
                [_alertView addAction:okButton];
                UIViewController *top = [self topMostController];
                [top presentViewController:_alertView animated:YES completion: nil];
            }
            else{
                 [self stopLoadingIndicator];
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
                
                _alertView = [UIAlertController
                              alertControllerWithTitle:@""
                              message:message
                              preferredStyle:UIAlertControllerStyleAlert];
                
                UIAlertAction* okButton = [UIAlertAction
                                           actionWithTitle:@"OK"
                                           style:UIAlertActionStyleDefault
                                           handler:^(UIAlertAction * action) {
                                               
                                               [self.navigationController popViewControllerAnimated:YES];
                                               
                                           }];
                [_alertView addAction:okButton];
                UIViewController *top = [self topMostController];
                [top presentViewController:_alertView animated:YES completion: nil];
            }
            
        }];
        
    }
}

- (UIViewController*) topMostController {
    UIViewController *topController = [UIApplication sharedApplication].keyWindow.rootViewController;
    
    while (topController.presentedViewController) {
        topController = topController.presentedViewController;
    }
    
    return topController;
}

//Close the screen when we click on cancel button
- (IBAction)cancelClick:(id)sender {
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


//  Description:To stop the activity indicator.

-(void)stopLoadingIndicator
{
    _loadingView.hidden=YES;
}


-(bool) setButtonColorOnSelected:(int)tagName boolValue:(bool)boolValue addDictValue:(int)addDictValue {
    
    
    NSMutableDictionary *dict=[[NSMutableDictionary alloc] init];
    
    [dict setObject:[NSNumber numberWithInt: addDictValue] forKey:@"expertiseID"];
    
    UIButton *expertiseBtn = (UIButton *) [self.view viewWithTag:tagName];
    
    if(boolValue==YES){
        expertiseBtn.layer.backgroundColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0  alpha:1].CGColor;
        
        [expertiseBtn setTitleColor:[UIColor colorWithRed:118.0/255.0 green:183.0/255.0 blue:189.0/255.0  alpha:1] forState:UIControlStateNormal];
        
        UIImage *image = [UIImage imageNamed: @"plusIcon.png"];
        //cancelBtn.image=image;
        
        [expertiseBtn setImage:image forState:UIControlStateNormal];
        
        [practiceExpertise removeObject: dict];
        
        return NO;
    }else{
        expertiseBtn.layer.backgroundColor = [UIColor colorWithRed:118.0/255.0 green:183.0/255.0 blue:189.0/255.0 alpha:1].CGColor;
        
        [expertiseBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
        UIImage *image = [UIImage imageNamed: @"rightMark.png"];
        
        [expertiseBtn setImage:image forState:UIControlStateNormal];
        
        [practiceExpertise addObject: dict];
        
        
        return YES;
        
    }
}


- (IBAction)backArrowclick:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}


-(void) setExpertiseButtonBorderColor:(int)tagName{
    UIButton *cancelBtn = (UIButton *) [self.view viewWithTag:tagName];
    cancelBtn.layer.borderColor = [UIColor colorWithRed:197.0/255.0 green:224.0/255.0 blue:224.0/255.0 alpha:1].CGColor;
}

@end
