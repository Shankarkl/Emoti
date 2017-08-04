/***************************************************************
 Page name: FAQ.h
 Created By:Nalina
 Created Date:21/07/16
 Description:FAQ methods and properties declaration file
 ***************************************************************/

#import <UIKit/UIKit.h>
#import "AccordionView.h"
@interface FAQ : UIViewController{
    AccordionView *accordion;
    UIButton *questionBtn;
    UIImageView *arrowImg;
    UIView *expandableView;
    UIView *lineView;
    UITextView *answerText;
    NSMutableArray *faqArray;
    NSInteger selectSectionValue;
}

@property (strong, nonatomic) IBOutlet UIView *faqBackView;
@property (strong, nonatomic) UIAlertController *alert;
@property (strong, nonatomic) UIView *loadingView;
- (IBAction)backArrowClick:(id)sender;


@end
