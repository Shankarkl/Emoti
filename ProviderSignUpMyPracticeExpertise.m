
/***************************************************************
 Page name: ProviderSignUpMyPracticeExpertise.m
 Created By: zeenath
 Created Date:05/07/16
 Description: Provider sign up my practice expertise implementation file
 ***************************************************************/

#import "ProviderSignUpMyPracticeExpertise.h"
#import "ForgotPasswordViewController.h"
#import "GlobalFunction.h"
#import "AppDelegate.h"
#import <Google/Analytics.h>
#import "ProviderSignUpTellUsAboutYourself.h"

@interface ProviderSignUpMyPracticeExpertise ()

@end

@implementation ProviderSignUpMyPracticeExpertise

//Loads first time when page appears
- (void)viewDidLoad {
    [super viewDidLoad];
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
    
    AppDelegate *appdelegate=(AppDelegate *)[[UIApplication sharedApplication]delegate];
    NSString *Url=[appdelegate.serviceURL stringByAppendingString:@"api/Expertise"];
    [self startLoadingIndicator];
    
    
    
    
    
    //Added by: zeenath
    //Added Date: 06/07/2016
    //Discription: Get details of practice expertise and bind the ID
    
    [[GlobalFunction sharedInstance]getServerResponseAfterLogin:Url method:@"GET" param:nil withCallback:^(NSInteger statusCode, NSDictionary *response, NSError *error) {
        
        if(statusCode==200)
        {
            NSMutableArray *array=[response mutableCopy];
            @autoreleasepool {
                
                for(int i=0;i<response.count;i++)
                {
                    _ExpertseDict=[array objectAtIndex:i];
                    
                    if([[_ExpertseDict objectForKey:@"expertiseText"] isEqualToString:@"Family"])
                    {
                        NSString *idValue=[_ExpertseDict valueForKey:@"id"];
                        familyValue=[idValue intValue];
                    }
                    if([[_ExpertseDict objectForKey:@"expertiseText"] isEqualToString:@"Group"])
                    {
                        NSString *idValue=[_ExpertseDict valueForKey:@"id"];
                        GroupValue=[idValue intValue];
                    }
                    
                    if([[_ExpertseDict objectForKey:@"expertiseText"] isEqualToString:@"Adoption"])
                    {
                        NSString *idValue=[_ExpertseDict valueForKey:@"id"];
                        adoptionValue=[idValue intValue];
                    }
                    if([[_ExpertseDict objectForKey:@"expertiseText"] isEqualToString:@"Anxiety"])
                    {
                        NSString *idValue=[_ExpertseDict valueForKey:@"id"];
                        anxietyValue=[idValue intValue];
                    }
                    if([[_ExpertseDict objectForKey:@"expertiseText"] isEqualToString:@"Social Anxiety"])
                    {
                        NSString *idValue=[_ExpertseDict valueForKey:@"id"];
                        SocialanxietyValue=[idValue intValue];
                    }
                    if([[_ExpertseDict objectForKey:@"expertiseText"] isEqualToString:@"Chronic Pain"])
                    {
                        NSString *idValue=[_ExpertseDict valueForKey:@"id"];
                        chronicPainValue=[idValue intValue];
                    }
                    if([[_ExpertseDict objectForKey:@"expertiseText"] isEqualToString:@"Anger Management"])
                    {
                        NSString *idValue=[_ExpertseDict valueForKey:@"id"];
                        AngerManagementValue=[idValue intValue];
                    }
                    
                    if([[_ExpertseDict objectForKey:@"expertiseText"] isEqualToString:@"Workplace"])
                    {
                        NSString *idValue=[_ExpertseDict valueForKey:@"id"];
                        workspaceValue=[idValue intValue];
                    }
                    
                    if([[_ExpertseDict objectForKey:@"expertiseText"] isEqualToString:@"PTSD"])
                    {
                        NSString *idValue=[_ExpertseDict valueForKey:@"id"];
                        PTSDValue=[idValue intValue];
                    }
                    
                    if([[_ExpertseDict objectForKey:@"expertiseText"] isEqualToString:@"Friendships"])
                    {
                        NSString *idValue=[_ExpertseDict valueForKey:@"id"];
                        FriendshipsValue=[idValue intValue];
                    }
                    
                    if([[_ExpertseDict objectForKey:@"expertiseText"] isEqualToString:@"Addiction"])
                    {
                        NSString *idValue=[_ExpertseDict valueForKey:@"id"];
                        addictionValue=[idValue intValue];
                    }
                    if([[_ExpertseDict objectForKey:@"expertiseText"] isEqualToString:@"LGBTIQ"])
                    {
                        NSString *idValue=[_ExpertseDict valueForKey:@"id"];
                        LGBTQValue=[idValue intValue];
                    }
                    if([[_ExpertseDict objectForKey:@"expertiseText"] isEqualToString:@"Depression"])
                    {
                        NSString *idValue=[_ExpertseDict valueForKey:@"id"];
                        DepressionValue=[idValue intValue];
                    }
                    
                    if([[_ExpertseDict objectForKey:@"expertiseText"] isEqualToString:@"Loss/Grief"])
                    {
                        NSString *idValue=[_ExpertseDict valueForKey:@"id"];
                        LossGriefValue=[idValue intValue];
                    }
                    
                    if([[_ExpertseDict objectForKey:@"expertiseText"] isEqualToString:@"Parenting"])
                    {
                        NSString *idValue=[_ExpertseDict valueForKey:@"id"];
                        ParentingValue=[idValue intValue];
                    }
                    if([[_ExpertseDict objectForKey:@"expertiseText"] isEqualToString:@"Stress"])
                    {
                        NSString *idValue=[_ExpertseDict valueForKey:@"id"];
                        StressValue=[idValue intValue];
                    }
                    if([[_ExpertseDict objectForKey:@"expertiseText"] isEqualToString:@"Trauma"])
                    {
                        NSString *idValue=[_ExpertseDict valueForKey:@"id"];
                        TraumaValue=[idValue intValue];
                    }
                    if([[_ExpertseDict objectForKey:@"expertiseText"] isEqualToString:@"Dating and Romance"])
                    {
                        NSString *idValue=[_ExpertseDict valueForKey:@"id"];
                        DatingRomanceValue=[idValue intValue];
                    }
                    if([[_ExpertseDict objectForKey:@"expertiseText"] isEqualToString:@"Separation/Divorce"])
                    {
                        NSString *idValue=[_ExpertseDict valueForKey:@"id"];
                        SeparationDivorceValue=[idValue intValue];
                    }
                    if([[_ExpertseDict objectForKey:@"expertiseText"] isEqualToString:@"Substance Abuse"])
                    {
                        NSString *idValue=[_ExpertseDict valueForKey:@"id"];
                        SubstanceAbuseValue=[idValue intValue];
                    }
                    
                    if([[_ExpertseDict objectForKey:@"expertiseText"] isEqualToString:@"Sexual Trauma"])
                    {
                        NSString *idValue=[_ExpertseDict valueForKey:@"id"];
                        SexualTraumaValue=[idValue intValue];
                    }
                    
                }
            }
        }
        [self stopLoadingIndicator];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

//Loads each time when page appears
-(void)viewWillAppear:(BOOL)animated
{
    AppDelegate *appdelegate=(AppDelegate *)[[UIApplication sharedApplication]delegate];

    if([appdelegate.availabilityArray containsObject:[NSNumber numberWithInt:8]])
    {
        UIImage *image = [UIImage imageNamed: @"check.png"];
        _checkboxFamily.image=image;
    }
    if([appdelegate.availabilityArray containsObject:[NSNumber numberWithInt:1]])
    {
        UIImage *image = [UIImage imageNamed: @"check.png"];
        _checkboxAddiction.image=image;
    }
    if([appdelegate.availabilityArray containsObject:[NSNumber numberWithInt:2]])
    {
        UIImage *image = [UIImage imageNamed: @"check.png"];
        _checkboxAdoption.image=image;
    }
    if([appdelegate.availabilityArray containsObject:[NSNumber numberWithInt:3]])
    {
        UIImage *image = [UIImage imageNamed: @"check.png"];
        _checkboxAngerManagement.image=image;
    }
    if([appdelegate.availabilityArray containsObject:[NSNumber numberWithInt:4]])
    {
        UIImage *image = [UIImage imageNamed: @"check.png"];
        _checkboxAnxiety.image=image;
    }
    if([appdelegate.availabilityArray containsObject:[NSNumber numberWithInt:5]])
    {
        UIImage *image = [UIImage imageNamed: @"check.png"];
        _checkboxChronicPain.image=image;
    }
    if([appdelegate.availabilityArray containsObject:[NSNumber numberWithInt:6]])
    {
        UIImage *image = [UIImage imageNamed: @"check.png"];
        _checkboxDatingRomance.image=image;
    }
    if([appdelegate.availabilityArray containsObject:[NSNumber numberWithInt:7]])
    {
        UIImage *image = [UIImage imageNamed: @"check.png"];
        _checkboxDepression.image=image;
    }
    if([appdelegate.availabilityArray containsObject:[NSNumber numberWithInt:9]])
    {
        UIImage *image = [UIImage imageNamed: @"check.png"];
        _checkboxFriendships.image=image;
    }
    if([appdelegate.availabilityArray containsObject:[NSNumber numberWithInt:10]])
    {
        UIImage *image = [UIImage imageNamed: @"check.png"];
        _checkboxGroup.image=image;
    }
    if([appdelegate.availabilityArray containsObject:[NSNumber numberWithInt:11]])
    {
        UIImage *image = [UIImage imageNamed: @"check.png"];
        _checkboxLGBTQ.image=image;
    }
    if([appdelegate.availabilityArray containsObject:[NSNumber numberWithInt:12]])
    {
        UIImage *image = [UIImage imageNamed: @"check.png"];
        _checkboxLossGrief.image=image;
    }
    if([appdelegate.availabilityArray containsObject:[NSNumber numberWithInt:13]])
    {
        UIImage *image = [UIImage imageNamed: @"check.png"];
        _checkboxParenting.image=image;
    }
    if([appdelegate.availabilityArray containsObject:[NSNumber numberWithInt:14]])
    {
        UIImage *image = [UIImage imageNamed: @"check.png"];
        _checkboxPTSD.image=image;
    }
    if([appdelegate.availabilityArray containsObject:[NSNumber numberWithInt:15]])
    {
        UIImage *image = [UIImage imageNamed: @"check.png"];
        _checkboxSeparationDivorce.image=image;
    }
    if([appdelegate.availabilityArray containsObject:[NSNumber numberWithInt:16]])
    {
        UIImage *image = [UIImage imageNamed: @"check.png"];
        _checkboxSexualTrauma.image=image;
    }
    if([appdelegate.availabilityArray containsObject:[NSNumber numberWithInt:17]])
    {
        UIImage *image = [UIImage imageNamed: @"check.png"];
        _checkboxSocialAnxiety.image=image;
    }
    if([appdelegate.availabilityArray containsObject:[NSNumber numberWithInt:18]])
    {
        UIImage *image = [UIImage imageNamed: @"check.png"];
        _checkboxStress.image=image;
    }
    if([appdelegate.availabilityArray containsObject:[NSNumber numberWithInt:19]])
    {
        UIImage *image = [UIImage imageNamed: @"check.png"];
        _checkboxSubstanceAbuse.image=image;
    }
    if([appdelegate.availabilityArray containsObject:[NSNumber numberWithInt:20]])
    {
        UIImage *image = [UIImage imageNamed: @"check.png"];
        _checkboxTrauma.image=image;
    }if([appdelegate.availabilityArray containsObject:[NSNumber numberWithInt:21]])
    {
        UIImage *image = [UIImage imageNamed: @"check.png"];
        _checkboxWorkplace.image=image;
    }
    
    if(appdelegate.availabilityArray != nil)
    {
    practiceExpertise=appdelegate.availabilityArray;
    }
}

//Added by: zeenath
//Added Date: 06/07/2016
//Discription: check box clicks functionality

- (IBAction)checkboxFamilyClick:(id)sender {
    
    myBoolfamilyValue=[self setButtonColorOnSelected:1 boolValue:myBoolfamilyValue addDictValue:familyValue];
    
}

- (IBAction)checkboxGroupClick:(id)sender {
   
    myBoolGroupValue=[self setButtonColorOnSelected:2 boolValue:myBoolGroupValue addDictValue:GroupValue];
    
}

- (IBAction)checkboxAdoptionClick:(id)sender {
   
  myBooladoptionValue=[self setButtonColorOnSelected:3 boolValue:myBooladoptionValue addDictValue:adoptionValue];
   
}
- (IBAction)checkboxAnxietyClick:(id)sender {
    
   
   myBoolanxietyValue=[self setButtonColorOnSelected:4 boolValue:myBoolanxietyValue addDictValue:anxietyValue];
  
}
- (IBAction)checkboxSocialanxietyClick:(id)sender {
    
  myBoolSocialanxietyValue=[self setButtonColorOnSelected:5 boolValue:myBoolSocialanxietyValue addDictValue:SocialanxietyValue];
    
}

- (IBAction)checkboxChronicPainClick:(id)sender {
   
   myBoolchronicPainValue=[self setButtonColorOnSelected:6 boolValue:myBoolchronicPainValue addDictValue:chronicPainValue];
   
}

- (IBAction)checkboxAngerManagementClick:(id)sender {
    
  myBoolAngerManagementValue=[self setButtonColorOnSelected:7 boolValue:myBoolAngerManagementValue addDictValue:AngerManagementValue];
}

- (IBAction)checkboxWorkplaceClick:(id)sender {
    
myBoolworkspaceValue=[self setButtonColorOnSelected:8 boolValue:myBoolworkspaceValue addDictValue:workspaceValue];
    
}
- (IBAction)checkboxPTSDClick:(id)sender {
    
    myBoolPTSDValue=[self setButtonColorOnSelected:9 boolValue:myBoolPTSDValue addDictValue:PTSDValue];
  
}
- (IBAction)checkboxFriendshipClick:(id)sender {
    
    myBoolFriendshipsValue=[self setButtonColorOnSelected:10 boolValue:myBoolFriendshipsValue addDictValue:FriendshipsValue];
}

- (IBAction)checkboxAddictionClick:(id)sender {
    
  myBooladdictionValue=[self setButtonColorOnSelected:11 boolValue:myBooladdictionValue addDictValue:addictionValue];
  
}


- (IBAction)checkboxLGBTQClick:(id)sender {
   
   myBoolLGBTQValue=[self setButtonColorOnSelected:12 boolValue:myBoolLGBTQValue addDictValue:LGBTQValue];
    
}
- (IBAction)checkboxDepressionClick:(id)sender {
    
 myBoolDepressionValue=[self setButtonColorOnSelected:13 boolValue:myBoolDepressionValue addDictValue:DepressionValue];
   
}

- (IBAction)checkboxLossGriefClick:(id)sender {
    
   myBoolLossGriefValue=[self setButtonColorOnSelected:14 boolValue:myBoolLossGriefValue addDictValue:LossGriefValue];
  
}
- (IBAction)checkboxParentingClick:(id)sender {
   
    
   myBoolParentingValue=[self setButtonColorOnSelected:15 boolValue:myBoolParentingValue addDictValue:ParentingValue];
   
}
- (IBAction)checkboxStressClick:(id)sender {
    
  myBoolStressValue=[self setButtonColorOnSelected:16 boolValue:myBoolStressValue addDictValue:StressValue];
  
}
- (IBAction)checkboxTraumaClick:(id)sender {
    
   myBoolTraumaValue=[self setButtonColorOnSelected:17 boolValue:myBoolTraumaValue addDictValue:TraumaValue];
  
}
- (IBAction)checkboxDatingRomanceClick:(id)sender {
    
    
    myBoolDatingRomanceValue=[self setButtonColorOnSelected:18 boolValue:myBoolDatingRomanceValue addDictValue:DatingRomanceValue];

}
- (IBAction)checkboxSeperationDivorceClick:(id)sender {
   
    myBoolSeparationDivorceValue=[self setButtonColorOnSelected:19 boolValue:myBoolSeparationDivorceValue addDictValue:SeparationDivorceValue];
   
}

- (IBAction)checkboxSubstanceAbuseClick:(id)sender {
   
   
   myBoolSubstanceAbuseValue=[self setButtonColorOnSelected:20 boolValue:myBoolSubstanceAbuseValue addDictValue:SubstanceAbuseValue];
  
}
- (IBAction)checkboxSexualTraumaClick:(id)sender {
   
  myBoolSexualTraumaValue=[self setButtonColorOnSelected:21 boolValue:myBoolSexualTraumaValue addDictValue:SexualTraumaValue];
    
}

- (IBAction)backArrowClick:(id)sender {
    
   [self dismissViewControllerAnimated:YES completion:nil];    
}



//Added by: zeenath
//Added Date: 06/07/2016
//Discription: Click on back icon store data in appdelegateto prepopulate

- (IBAction)backButton:(id)sender {
    AppDelegate *appdelegate= (AppDelegate *)[[UIApplication sharedApplication]delegate];
    appdelegate.availabilityArray=practiceExpertise;
    [self dismissViewControllerAnimated:YES completion:nil];
}


//Added by: zeenath
//Added Date: 06/07/2016
//Discription: validate and redirect to the next screen

- (IBAction)nextButton:(id)sender {
    
    UIImage *image = [UIImage imageNamed: @"uncheck.png"];
    NSData *imgData1 = UIImagePNGRepresentation(_checkboxFamily.image);
    NSData *imgData2 = UIImagePNGRepresentation(_checkboxGroup.image);
    NSData *imgData3 = UIImagePNGRepresentation(_checkboxAdoption.image);
    NSData *imgData4 = UIImagePNGRepresentation(_checkboxAnxiety.image);
    NSData *imgData5 = UIImagePNGRepresentation(_checkboxSocialAnxiety.image);
    NSData *imgData6 = UIImagePNGRepresentation(_checkboxChronicPain.image);
    NSData *imgData7 = UIImagePNGRepresentation(_checkboxAngerManagement.image);
    NSData *imgData8 = UIImagePNGRepresentation(_checkboxLGBTQ.image);
    NSData *imgData9 = UIImagePNGRepresentation(_checkboxLossGrief.image);
    NSData *imgData10 = UIImagePNGRepresentation(_checkboxParenting.image);
    NSData *imgData11 = UIImagePNGRepresentation(_checkboxDepression.image);
    NSData *imgData12 = UIImagePNGRepresentation(_checkboxStress.image);
    NSData *imgData13 = UIImagePNGRepresentation(_checkboxTrauma.image);
    NSData *imgData14 = UIImagePNGRepresentation(_checkboxDatingRomance.image);
    NSData *imgData15 = UIImagePNGRepresentation(_checkboxWorkplace.image);
    NSData *imgData16 = UIImagePNGRepresentation(_checkboxPTSD.image);
    NSData *imgData17 = UIImagePNGRepresentation(_checkboxFriendships.image);
    NSData *imgData18 = UIImagePNGRepresentation(_checkboxAddiction.image);
    
    NSData *imgData19 = UIImagePNGRepresentation(_checkboxSeparationDivorce.image);
    NSData *imgData20 = UIImagePNGRepresentation(_checkboxSubstanceAbuse.image);
    NSData *imgData21 = UIImagePNGRepresentation(_checkboxSexualTrauma.image);
    
    NSData *imgData = UIImagePNGRepresentation(image);
    
    if([imgData1 isEqual:imgData] && [imgData2 isEqual:imgData] && [imgData3 isEqual:imgData] && [imgData4 isEqual:imgData] && [imgData5 isEqual:imgData] && [imgData6 isEqual:imgData] && [imgData7 isEqual:imgData] && [imgData8 isEqual:imgData] && [imgData9 isEqual:imgData] && [imgData10 isEqual:imgData] && [imgData10 isEqual:imgData] && [imgData11 isEqual:imgData] && [imgData12 isEqual:imgData] && [imgData13 isEqual:imgData] && [imgData14 isEqual:imgData] && [imgData15 isEqual:imgData] && [imgData16 isEqual:imgData]&& [imgData17 isEqual:imgData] && [imgData18 isEqual:imgData] && [imgData19 isEqual:imgData] && [imgData20 isEqual:imgData] && [imgData21 isEqual:imgData])
    {
      //  GlobalFunction *globalValues=[[GlobalFunction alloc]init];
        
        _alert = [UIAlertController
                  alertControllerWithTitle:@""
                  message:[[GlobalFunction sharedInstance].arrayOfAlerts objectAtIndex:50]
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
    else
    {
        AppDelegate *appdelegate= (AppDelegate *)[[UIApplication sharedApplication]delegate];

        //ForgotPasswordViewController *vc=[self.storyboard instantiateViewControllerWithIdentifier:@"forgotPassword"];
        //[_providerDetails setObject:practiceExpertise forKey:@"providerExpertise"];
        //vc.pickerArray=appdelegate.questionArray;
        //vc.questionID=appdelegate.questionIdArray;

        //[practiceExpertise addObject: [NSNumber numberWithInt: 1]];
        
        ProviderSignUpTellUsAboutYourself *vc=[self.storyboard instantiateViewControllerWithIdentifier:@"ProviderSignUpTellUsAboutYourself"];
        [_providerDetails setObject:practiceExpertise forKey:@"providerExpertise"];
        vc.providerDetails=_providerDetails;
        [self presentViewController:vc animated:YES completion:nil];
        //vc.screenStatus=@"ProviderSignup";
        //vc.providerDetails=_providerDetails;
    }
}


//  Added by: Nalina
//  Added Date:2016-09-10.
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

//  Added by: Nalina
//  Added Date:2016-09-10.
//  Description:To stop the activity indicator.

-(void)stopLoadingIndicator
{
    _loadingView.hidden=YES;
}

-(void) setBorderColor:(int)tagName{
    UIButton *cancelBtn = (UIButton *) [self.view viewWithTag:tagName];
    cancelBtn.layer.borderColor = [UIColor colorWithRed:246.0/255.0 green:108.0/255.0 blue:118.0/255.0 alpha:1].CGColor;
}

-(bool) setButtonColorOnSelected:(int)tagName boolValue:(bool)boolValue addDictValue:(int)addDictValue {
    
    
    UIButton *expertiseBtn = (UIButton *) [self.view viewWithTag:tagName];
    
    if(boolValue==YES){
        expertiseBtn.layer.backgroundColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0  alpha:1].CGColor;
        
        [expertiseBtn setTitleColor:[UIColor colorWithRed:118.0/255.0 green:183.0/255.0 blue:189.0/255.0  alpha:1] forState:UIControlStateNormal];
        
        UIImage *image = [UIImage imageNamed: @"plusIcon.png"];
        //cancelBtn.image=image;
        
        [expertiseBtn setImage:image forState:UIControlStateNormal];
        
        [practiceExpertise removeObject: [NSNumber numberWithInt: addDictValue]];

        return NO;
    }else{
        expertiseBtn.layer.backgroundColor = [UIColor colorWithRed:118.0/255.0 green:183.0/255.0 blue:189.0/255.0 alpha:1].CGColor;
        
        [expertiseBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
        UIImage *image = [UIImage imageNamed: @"rightMark.png"];
        
        [expertiseBtn setImage:image forState:UIControlStateNormal];
        
        [practiceExpertise addObject: [NSNumber numberWithInt: addDictValue]];
        
        
        return YES;

    }
}

@end
