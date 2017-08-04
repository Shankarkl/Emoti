//
//  EmergencyPopupSceneViewController.h
//  EmotiLink
//
//  Created by Star on 4/11/17.
//  Copyright © 2017 Stark. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EmergencyPopupSceneViewController : UIViewController

@property (strong, nonatomic) IBOutlet UILabel *emergencyLabel;
@property (strong, nonatomic) IBOutlet UILabel *questionLabel;
@property (nonatomic,assign) NSString *timespent;
@property (strong, nonatomic) NSMutableDictionary * sessionDetails;

- (IBAction)yesClick:(id)sender;
- (IBAction)noClick:(id)sender;

@end
