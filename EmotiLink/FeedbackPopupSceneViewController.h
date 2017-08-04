//
//  FeedbackPopupSceneViewController.h
//  EmotiLink
//
//  Created by Star on 4/11/17.
//  Copyright © 2017 Stark. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FeedbackPopupSceneViewController : UIViewController{
    NSMutableArray *dataSource;
    //NSString *timespent;
    NSMutableArray *questionArray;
    
}
@property (nonatomic,assign) NSInteger *Quesid;
@property (nonatomic,assign) NSString *timespent;
@property (strong, nonatomic) NSMutableDictionary * sessionDetails;
@property (weak, nonatomic) IBOutlet NSString *QuestionID;
@property (weak, nonatomic) IBOutlet UIView *pickerBackView;
@property (weak, nonatomic) IBOutlet UIPickerView *pickerView;
@property (strong, nonatomic) IBOutlet UILabel *requestLabel;
@property (weak, nonatomic) IBOutlet UITextField *FeedbackAnswer;
@property (weak, nonatomic) IBOutlet NSMutableDictionary *details;
@property (weak, nonatomic) IBOutlet NSMutableDictionary *questiondict;
@property (strong, nonatomic) IBOutlet NSMutableDictionary *mainparamdict;
@property (strong, nonatomic) UIView *loadingView;
@property (strong, nonatomic) UIAlertController *alert;
@property (weak, nonatomic) IBOutlet UITextField *feedbackquestions;


@property (strong, nonatomic) IBOutlet UITextView *feedbackTextView;


- (IBAction)submitClick:(id)sender;


- (IBAction)skipClick:(id)sender;








@end
