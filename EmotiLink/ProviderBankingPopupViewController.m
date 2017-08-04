//
//  ProviderBankingPopupViewController.m
//  EmotiLink
//
//  Created by Star on 4/11/17.
//  Copyright © 2017 Stark. All rights reserved.
//

#import "ProviderBankingPopupViewController.h"

@interface ProviderBankingPopupViewController ()

@end

@implementation ProviderBankingPopupViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.modalPresentationStyle = UIModalPresentationCurrentContext;
    
    [self setBorderColor:1];
    [self setBorderColor:2];
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


- (IBAction)NextBtn:(id)sender {
}

- (IBAction)LogoutBtn:(id)sender {
}

- (IBAction)BackBtn:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];

}
@end
