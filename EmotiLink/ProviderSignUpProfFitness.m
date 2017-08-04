
/***************************************************************
 Page name: ProviderSignUpProfFitness.m
 Created By: Zeenath
 Created Date:04/07/16
 Description: Professional fitness implementation file
 ***************************************************************/

#import "ProviderSignUpProfFitness.h"
#import "ProviderSignUpThirdViewController.h"
#import "ProviderSignUpMyPracticeExpertise.h"
#import "AppDelegate.h"
#import <Google/Analytics.h>

#define appdelegat (AppDelegate *)[[UIApplication sharedApplication]delegate]

@interface ProviderSignUpProfFitness ()

@end

@implementation ProviderSignUpProfFitness


//Called when the view controller is first time loaded to memory
- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton *subBtn = (UIButton *) [self.view viewWithTag:5];
    subBtn.layer.borderColor = [UIColor colorWithRed:246.0/255.0 green:108.0/255.0 blue:118.0/255.0 alpha:1].CGColor;
    // Do any additional setup after loading the view.
    
    myBoolfitnessfelony=NO;
    myBoolfitnesscriminalCharges=NO;
    myBoolfitnessLicensure=NO;
    myBoolfitnessLiabilityInsurance=NO;
    UIImageView *bgImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"LoginBackground.png"]];
    bgImageView.frame = self.view.bounds;
    bgImageView.contentMode = UIViewContentModeScaleAspectFill;
    bgImageView.clipsToBounds = YES;
    [_backgroundProfFitnessView addSubview:bgImageView];
    [_backgroundProfFitnessView sendSubviewToBack:bgImageView];

}

 // Dispose of any resources that can be recreated.
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
   
}

//called each time when the view appears
-(void)viewWillAppear:(BOOL)animated

{
    [self stopLoadingIndicator];
    //  Added by:Zeenath
    //  Added Date:2016-28-07.
    //  Description:To prepulate the selected values.
    AppDelegate *appdelegate= (AppDelegate *)[[UIApplication sharedApplication]delegate];
    
     if([[appdelegate.prepopulateDataProvider valueForKey:@"professionalFitness1"] isEqualToString:@"true"])
     {
         [_que1SwitchButton setImage:[UIImage imageNamed:@"onSwitch.png"] forState:UIControlStateNormal];
         myBoolfitnessfelony=YES;

     }
    if([[appdelegate.prepopulateDataProvider valueForKey:@"professionalFitness2"] isEqualToString:@"true"])
    {
        [_que2SwitchButton setImage:[UIImage imageNamed:@"onSwitch.png"] forState:UIControlStateNormal];
         myBoolfitnesscriminalCharges=YES;
        
    }
    if([[appdelegate.prepopulateDataProvider valueForKey:@"professionalFitness3"] isEqualToString:@"true"])
    {
        [_que3SwitchButton setImage:[UIImage imageNamed:@"onSwitch.png"] forState:UIControlStateNormal];
         myBoolfitnessLicensure=YES;
        
    }
    if([[appdelegate.prepopulateDataProvider valueForKey:@"professionalFitness4"] isEqualToString:@"true"])
    {
        [_que4SwitchButton setImage:[UIImage imageNamed:@"onSwitch.png"] forState:UIControlStateNormal];
          myBoolfitnessLiabilityInsurance=YES;
        
    }
    
    if (_imagePath!=nil) {
        appdelegate.prepopulateImage=_imagePath;
    }
    
}


//  Added by:Zeenath
//  Added Date:2016-28-07.
//  Description:To toggle the swith images.
- (IBAction)que1SwitchButtonAction:(id)sender {
    AppDelegate *appdelegate= (AppDelegate *)[[UIApplication sharedApplication]delegate];
    if (myBoolfitnessfelony==NO) {
        
        [_que1SwitchButton setImage:[UIImage imageNamed:@"onSwitch.png"] forState:UIControlStateNormal];
        
        myBoolfitnessfelony=YES;
        fitnessfelony=@"true";
        [_providerDetails setObject:fitnessfelony forKey:@"professionalFitness1"];
        
        
        
    }
    else if(myBoolfitnessfelony==YES)
    {
        
        [_que1SwitchButton setImage:[UIImage imageNamed:@"offSwitch.png"] forState:UIControlStateNormal];
        myBoolfitnessfelony=NO;
        fitnessfelony=@"false";
        [_providerDetails setObject:fitnessfelony forKey:@"professionalFitness1"];
        
    }
    appdelegate.prepopulateDataProvider=_providerDetails;
  //  clicked1=@"fitnessfelony";
}
- (IBAction)que2SwitchButtonAction:(id)sender {
    AppDelegate *appdelegate= (AppDelegate *)[[UIApplication sharedApplication]delegate];
    if (myBoolfitnesscriminalCharges==NO) {
        
        [_que2SwitchButton setImage:[UIImage imageNamed:@"onSwitch.png"] forState:UIControlStateNormal];
        
        myBoolfitnesscriminalCharges=YES;
        fitnesscriminalCharges=@"true";
        [_providerDetails setObject:fitnesscriminalCharges forKey:@"professionalFitness2"];
    }
    else if(myBoolfitnesscriminalCharges==YES)
    {
        
        [_que2SwitchButton setImage:[UIImage imageNamed:@"offSwitch.png"] forState:UIControlStateNormal];
        myBoolfitnesscriminalCharges=NO;
        fitnesscriminalCharges=@"false";
         [_providerDetails setObject:fitnesscriminalCharges forKey:@"professionalFitness2"];
        
    }
    appdelegate.prepopulateDataProvider=_providerDetails;
  //  clicked2=@"fitnesscriminalCharges";
}
- (IBAction)que3SwitchButtonAction:(id)sender {
    AppDelegate *appdelegate= (AppDelegate *)[[UIApplication sharedApplication]delegate];
    if (myBoolfitnessLicensure==NO) {
        
        [_que3SwitchButton setImage:[UIImage imageNamed:@"onSwitch.png"] forState:UIControlStateNormal];
        
        myBoolfitnessLicensure=YES;
        fitnessLicensure=@"true";
        [_providerDetails setObject:fitnessLicensure forKey:@"professionalFitness3"];

    }
    else if(myBoolfitnessLicensure==YES)
    {
        
        [_que3SwitchButton setImage:[UIImage imageNamed:@"offSwitch.png"] forState:UIControlStateNormal];
        myBoolfitnessLicensure=NO;
        fitnessLicensure=@"false";
       [_providerDetails setObject:fitnessLicensure forKey:@"professionalFitness3"];
        
    }
   appdelegate.prepopulateDataProvider=_providerDetails;
  // clicked3=@"fitnessLicensure";
}
- (IBAction)que4SwitchButtonAction:(id)sender {
AppDelegate *appdelegate= (AppDelegate *)[[UIApplication sharedApplication]delegate];
    if (myBoolfitnessLiabilityInsurance==NO) {
        
        [_que4SwitchButton setImage:[UIImage imageNamed:@"onSwitch.png"] forState:UIControlStateNormal];
        
        myBoolfitnessLiabilityInsurance=YES;
        fitnessLiabilityInsurance=@"true";
        [_providerDetails setObject:fitnessLiabilityInsurance forKey:@"professionalFitness4"];
    }
    else if(myBoolfitnessLiabilityInsurance==YES)
    {
        
        [_que4SwitchButton setImage:[UIImage imageNamed:@"offSwitch.png"] forState:UIControlStateNormal];
        myBoolfitnessLiabilityInsurance=NO;
        fitnessLiabilityInsurance=@"false";
        [_providerDetails setObject:fitnessLiabilityInsurance forKey:@"professionalFitness4"];
        
    }
    appdelegate.prepopulateDataProvider=_providerDetails;
    //clicked4=@"fitnessLiabilityInsurance";
}


//  Added by:Zeenath
//  Added Date:2016-28-07.
//  Description:Called when the back buttton is clicked and to store the current switch values.
- (IBAction)backClick:(id)sender {
    
    [self startLoadingIndicator];
  UIImage *imageToCheckFor = [UIImage imageNamed:@"onSwitch.png"];
    if ([_que1SwitchButton.currentImage isEqual:imageToCheckFor]) {
        [_providerDetails setObject:@"true" forKey:@"professionalFitness1"];
       myBoolfitnessfelony=YES;
    }
    
    if ([_que2SwitchButton.currentImage isEqual:imageToCheckFor]) {
        [_providerDetails setObject:@"true" forKey:@"professionalFitness2"];
         myBoolfitnesscriminalCharges=YES;
       
    }
    
    if ([_que3SwitchButton.currentImage isEqual:imageToCheckFor]) {
        [_providerDetails setObject:@"true" forKey:@"professionalFitness3"];
          myBoolfitnessLicensure=YES;
    }
    
    if ([_que4SwitchButton.currentImage isEqual:imageToCheckFor]) {
        [_providerDetails setObject:@"true" forKey:@"professionalFitness4"];
        myBoolfitnessLiabilityInsurance=YES;
    }
    
    AppDelegate *appdelegate= (AppDelegate *)[[UIApplication sharedApplication]delegate];
    if(_imagePath != nil)
    {
        appdelegate.prepopulateImage=_imagePath;
    }
    
    appdelegate.prepopulateDataProvider=_providerDetails;
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

//  Added by:Zeenath
//  Added Date:2016-28-07.
//  Description:Called when the next buttton is clicked and to store the current switch values.
- (IBAction)nextClick:(id)sender {
    UIImage *image = [UIImage imageNamed: @"onSwitch.png"];
    if([_que1SwitchButton.currentImage isEqual:image])
    {
   
        [_providerDetails setObject:@"true" forKey:@"professionalFitness1"];
    }
    else{
      [_providerDetails setObject:@"false" forKey:@"professionalFitness1"];
    }
    
    if([_que2SwitchButton.currentImage isEqual:image])
    {
      
        [_providerDetails setObject:@"true" forKey:@"professionalFitness2"];

   
    }
    else{
       [_providerDetails setObject:@"false" forKey:@"professionalFitness2"];
    }
    
    if([_que3SwitchButton.currentImage isEqual:image])
    {
       
        [_providerDetails setObject:@"true" forKey:@"professionalFitness3"];
    }
    else{
      [_providerDetails setObject:@"false" forKey:@"professionalFitness3"];
    }
    if([_que4SwitchButton.currentImage isEqual:image])
    {
        [_providerDetails setObject:@"true" forKey:@"professionalFitness4"];
       
    }
    else{
     [_providerDetails setObject:@"false" forKey:@"professionalFitness4"];
    }
   
   
   
    
    ProviderSignUpMyPracticeExpertise *vc=[self.storyboard instantiateViewControllerWithIdentifier:@"practiceExpertice"];
    vc.providerDetails=_providerDetails;
    
    [self presentViewController:vc animated:YES completion:nil];
}


//  Added by:Zeenath
//  Added Date:2016-28-07.
//  Description:Called when the page navigates through segues.
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    if ([[segue identifier] isEqualToString:@"practiceExpertice"])
    {
        ProviderSignUpMyPracticeExpertise *vc=[[ProviderSignUpMyPracticeExpertise alloc]init];
       
         vc.providerDetails=_providerDetails;
    
        
    }
}


//Added by: Zeenath
//Added Date: 28/07/2016
//Discription: To start the loading indicator
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


//Added by: Zeenath
//Added Date: 28/07/2016
//Discription: To stop the loading indicator
-(void)stopLoadingIndicator
{
    
    _loadingView.hidden=YES;
}
     
- (IBAction)backArrowClick:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

     @end
