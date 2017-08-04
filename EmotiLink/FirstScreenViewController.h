//
//  FirstScreenViewController.h
//  EmotiLink
//
//  Created by Starsoft on 2017-02-27.
//  Copyright © 2017 Stark. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FirstScreenViewController : UIViewController
@property (strong, nonatomic) IBOutlet UIButton *userBtn;
@property (strong, nonatomic) IBOutlet UIButton *providerBtn;

@property (strong, nonatomic) NSString *screenStatus;
@property (weak, nonatomic) IBOutlet UIView *mainViewBackground;

- (IBAction)searchProviderClick:(id)sender;

@property (strong, nonatomic) UIView *loadingView;
@property (strong, nonatomic) UIAlertController *alert;
- (IBAction)tcClick:(id)sender;
- (IBAction)ppClick:(id)sender;

@end
