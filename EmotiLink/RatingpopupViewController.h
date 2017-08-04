//
//  RatingpopupViewController.h
//  EmotiLink
//
//  Created by Star on 4/11/17.
//  Copyright © 2017 Stark. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RatingpopupViewController : UIViewController{
    float ratingSelectedValue;
    
}

@property (nonatomic,assign) NSString *timespent;
@property (strong, nonatomic) NSMutableDictionary * sessionDetails;
- (IBAction)Skipbtn:(id)sender;
- (IBAction)SubmitBtn:(id)sender;
@property (weak, nonatomic) IBOutlet NSMutableDictionary *details;
@property (weak, nonatomic) IBOutlet UIImageView *RatingImageView;
@property (weak, nonatomic) IBOutlet UIView *firstFilterView;
@property (weak, nonatomic) IBOutlet UITextView *RatingTextView;

@end
