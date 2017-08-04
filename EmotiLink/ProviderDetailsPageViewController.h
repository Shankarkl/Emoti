//
//  ProviderDetailsPageViewController.h
//  EmotiLink
//
//  Created by Star on 4/25/17.
//  Copyright © 2017 Stark. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProviderDetailsPageViewController : UIViewController

@property (strong, nonatomic) NSMutableDictionary *providerBasicInfo;

@property NSUInteger pageIndex;
@property (strong, nonatomic) NSMutableArray*contentLabel;
@property (strong, nonatomic) NSMutableArray*ExpertiseArray;


@property (strong, nonatomic) IBOutlet UIImageView *profilePictures;

@property (strong, nonatomic) IBOutlet UILabel *providerName;

@property (strong, nonatomic) IBOutlet UILabel *providerExpertise;
@property (strong, nonatomic) IBOutlet UILabel *noImage;


@property (strong, nonatomic) IBOutlet UILabel *noRecommendationLabel;


@end
