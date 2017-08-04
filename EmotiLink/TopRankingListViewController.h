//
//  TopRankingListViewController.h
//  EmotiLink
//
//  Created by Star on 4/18/17.
//  Copyright © 2017 Stark. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TopRankingListViewController : UIViewController<UITableViewDelegate, UITableViewDataSource>
{
    NSMutableDictionary *providerDetails;
}

- (IBAction)filterProvidersClick:(id)sender;
@property (strong, nonatomic) IBOutlet UITableView *providerTableView;
@property (weak, nonatomic) IBOutlet UIView *providerTableViewBackground;

@property (strong, nonatomic) UIAlertController *alert;
@property(nonatomic, strong)NSMutableArray *values;
@property(nonatomic, strong)NSString *ID;
@property(nonatomic, strong)NSMutableArray *providerDataArray;
@property (strong, nonatomic) UIView *loadingView;
@property (strong, nonatomic) UIAlertController *alertView;
- (IBAction)backArrowClick:(id)sender;

@end
