/***************************************************************
 Page name: AboutUsViewController.m
 Created By: nalina
 Created Date:06/07/16
 Description: about us implementation file
 ***************************************************************/

#import "AboutUsViewController.h"

@interface AboutUsViewController ()

@end

@implementation AboutUsViewController

//Loads first time when page appears
- (void)viewDidLoad {
    UIImage *backgroundImage = [UIImage imageNamed:@"06. Appointment Confirmation.png"];
    UIImageView *backgroundImageView=[[UIImageView alloc]initWithFrame:self.view.frame];
    backgroundImageView.image=backgroundImage;
    [self.view insertSubview:backgroundImageView atIndex:0];

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
}

-(void)goBack{
    [self.navigationController popViewControllerAnimated:YES];
}

//calls on click of back icon
- (IBAction)backClick:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)backArrowClick:(id)sender {
     [self dismissViewControllerAnimated:YES completion:nil];
}
@end
