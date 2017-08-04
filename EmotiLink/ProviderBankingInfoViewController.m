//
//  ProviderBankingInfoViewController.m
//  EmotiLink
//
//  Created by Starsoft on 2017-03-09.
//  Copyright © 2017 Stark. All rights reserved.
//

#import "ProviderBankingInfoViewController.h"

@interface ProviderBankingInfoViewController ()

@end

@implementation ProviderBankingInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setBorderColor:5];
    // Do any additional setup after loading the view.
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

-(void) setBorderColor:(int)tagName{
    UIButton *cancelBtn = (UIButton *) [self.view viewWithTag:tagName];
    cancelBtn.layer.borderColor = [UIColor colorWithRed:246.0/255.0 green:108.0/255.0 blue:118.0/255.0 alpha:1].CGColor;
}

- (IBAction)CancelBtn:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)SubmitBtn:(id)sender {
}
- (IBAction)backArrow:(id)sender {
     [self dismissViewControllerAnimated:YES completion:nil];
}
@end
