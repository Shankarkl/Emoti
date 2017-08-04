//
//  AccordionHeaderView.h
//  FZAccordionTableViewExample
//
//  Created by Krisjanis Gaidis on 6/7/15.
//  Copyright (c) 2015 Fuzz Productions, LLC. All rights reserved.
//

#import "FZAccordionTableView.h"

static const CGFloat kDefaultAccordionHeaderViewHeight = 44.0;
static NSString *const kAccordionHeaderViewReuseIdentifier = @"                                                                                                                                                                                                                                                 ";

@interface AccordionHeaderView : FZAccordionTableViewHeaderView
@property (weak, nonatomic) IBOutlet UILabel *headerLabel;
@property (weak, nonatomic) IBOutlet UIButton *ImageBtn;
@property (weak, nonatomic) IBOutlet UIButton *DownBtn;
@property (weak, nonatomic) IBOutlet UIView *HeaderView;

@end
