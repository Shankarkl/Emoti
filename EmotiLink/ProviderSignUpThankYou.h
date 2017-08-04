//
//  ProviderSignUpThankYou.h
//  EmotiLink
//
//  Created by Starsoft on 2017-04-10.
//  Copyright © 2017 Stark. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProviderSignUpThankYou : UIViewController


@property (strong, nonatomic) NSString *screenStatus;
@property (strong, nonatomic) NSString *userNametoDisplay;

@property (weak, nonatomic) IBOutlet UILabel *thankYouLabel;


@property (strong, nonatomic) NSMutableDictionary *providerregister;
@property (strong, nonatomic) NSMutableDictionary *personalinfo;
@property (weak, nonatomic) NSString *user;

@property (weak, nonatomic) IBOutlet UILabel *thanksContentLabel;


- (IBAction)homeClick:(id)sender;




@end
