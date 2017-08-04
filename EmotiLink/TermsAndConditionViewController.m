/***************************************************************
 Page name: TermsAndConditionViewController.m
 Created By:Nalina
 Created Date:2016-07-12
 Description: Static page to display terms and condition implementation Screen.
 ***************************************************************/

#import "TermsAndConditionViewController.h"
#import "AppDelegate.h"

#define appdelegate (AppDelegate *)[[UIApplication sharedApplication]delegate]


@interface TermsAndConditionViewController ()

@end

@implementation TermsAndConditionViewController
@synthesize screenStatus;

//Loads for the first time when page appears
- (void)viewDidLoad {
    [super viewDidLoad];
    consentToTreatBool=YES;
    consentRecieveEmailBool=YES;
    clickedbutton=@"uncheck";
    UIImage *backgroundImage = [UIImage imageNamed:@"06. Appointment Confirmation.png"];
    UIImageView *backgroundImageView=[[UIImageView alloc]initWithFrame:self.view.frame];
    backgroundImageView.image=backgroundImage;
    [self.view insertSubview:backgroundImageView atIndex:0];
        
    NSString *userName=[[appdelegate usersDetails]valueForKey:@"userRole"];
    
    
    if ([userName isEqualToString:@"Provider"]){
        
        _consentView.hidden = NO;
    }else{
        
        _consentView.hidden = YES;
    }

    
}

//Loads every time when page appears
-(void)viewWillAppear:(BOOL)animated
{
    UIImage *image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"back-28x28" ofType:@"png"]];
    
    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithImage:image style:UIBarButtonItemStylePlain target:self action:@selector(goBack)];
    [self.navigationItem setLeftBarButtonItem:barButtonItem];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

//Close the screen
-(void)goBack{
    [self.navigationController popViewControllerAnimated:YES];
}


//Close the screen depends on various conditions
- (IBAction)backClick:(id)sender {
    if ([screenStatus isEqualToString:@"forgotPassword"]|| [screenStatus isEqualToString:@"TellUsAboutYourself"]) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }else{
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (IBAction)backArrowClick:(id)sender {
     [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)consentToTreatClick:(id)sender {
    
    if (consentToTreatBool==YES) {
        
        [_consentBtn setImage:[UIImage imageNamed:@"check.png"] forState:UIControlStateNormal];
        consentToTreatBool=NO;
        clickedbutton=@"check";
    }
    else if(consentToTreatBool==NO)
    {
        [_consentBtn setImage:[UIImage imageNamed:@"uncheck.png"] forState:UIControlStateNormal];
        consentToTreatBool=YES;
        clickedbutton=@"uncheck";
      
    }
}

- (IBAction)consentEmailClick:(id)sender {
    
    if (consentRecieveEmailBool==YES) {
        
        [_consentEmailBtn setImage:[UIImage imageNamed:@"check.png"] forState:UIControlStateNormal];
        consentRecieveEmailBool=NO;
        clickedbutton=@"check";
    }
    else if(consentRecieveEmailBool==NO)
    {
        [_consentEmailBtn setImage:[UIImage imageNamed:@"uncheck.png"] forState:UIControlStateNormal];
        consentRecieveEmailBool=YES;
        clickedbutton=@"uncheck";
    }
}

@end
