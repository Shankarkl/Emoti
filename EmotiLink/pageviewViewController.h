//
//  pageviewViewController.h
//  swibeViewSample
//
//  Created by Starsoft on 2016-11-15.
//  Copyright © 2016 StarKnowledge. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface pageviewViewController : UIViewController
@property (strong, nonatomic) IBOutlet UILabel *label;
@property (strong, nonatomic) NSMutableArray*contentLabel;
@property (strong, nonatomic) NSMutableDictionary *contentsbind;

@property NSUInteger pageIndex;
@property (weak, nonatomic) IBOutlet UIImageView *profilepic;
@property (weak, nonatomic) IBOutlet UILabel *UserName;
@property (weak, nonatomic) IBOutlet UILabel *timelbl;
@property (weak, nonatomic) IBOutlet UILabel *offeredamount;
@property (weak, nonatomic) IBOutlet UILabel *noappointmentlabel;

@end
