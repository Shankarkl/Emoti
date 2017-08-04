/***************************************************************
 Page name: TermsAndConditionViewController.h
 Created By:Nalina
 Created Date:2016-07-12
 Description: Static page to display terms and condition declaration Screen.
 ***************************************************************/

#import <UIKit/UIKit.h>

@interface TermsAndConditionViewController : UIViewController<UITextViewDelegate>
{
      bool consentToTreatBool;
      bool consentRecieveEmailBool;
     NSString *clickedbutton;
    
}

@property(nonatomic,assign)NSString *screenStatus;

@property(nonatomic,assign)NSString *indiviualEntry;

@property (strong, nonatomic) NSMutableDictionary *indiviualRole;


- (IBAction)consentToTreatClick:(id)sender;

- (IBAction)consentEmailClick:(id)sender;

@property (strong, nonatomic) IBOutlet UIButton *consentBtn;

@property (strong, nonatomic) IBOutlet UIButton *consentEmailBtn;



@property (strong, nonatomic) IBOutlet UIView *consentView;

- (IBAction)backArrowClick:(id)sender;

@end
