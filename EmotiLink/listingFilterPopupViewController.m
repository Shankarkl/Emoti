//
//  listingFilterPopupViewController.m
//  EmotiLink
//
//  Created by Star on 4/5/17.
//  Copyright © 2017 Stark. All rights reserved.
//

#import "listingFilterPopupViewController.h"

@interface listingFilterPopupViewController ()

@end

@implementation listingFilterPopupViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.modalPresentationStyle = UIModalPresentationCurrentContext;
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

- (IBAction)CancelBtn:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)SessionHistoryBtn:(id)sender {
}

- (IBAction)RejectAppointmentBtn:(id)sender {
}

- (IBAction)sessionApprovalbtn:(id)sender {
}

- (IBAction)CancelAppointmentBtn:(id)sender {
}
@end
