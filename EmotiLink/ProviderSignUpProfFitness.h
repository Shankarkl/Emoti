

/***************************************************************
 Page name: ProviderSignUpProfFitness.h
 Created By: Zeenath
 Created Date:04/07/16
 Description: Professional fitness decalaration file
 ***************************************************************/

#import <UIKit/UIKit.h>

@interface ProviderSignUpProfFitness : UIViewController
{
     bool myBoolfitnessfelony;
     bool myBoolfitnesscriminalCharges;
     bool myBoolfitnessLicensure;
     bool myBoolfitnessLiabilityInsurance;
     NSString *fitnessfelony;
     NSString *fitnesscriminalCharges;
     NSString *fitnessLicensure;
     NSString *fitnessLiabilityInsurance;
     //NSString *clicked1;
     //NSString *clicked2;
     //NSString *clicked3;
     //NSString *clicked4;
}

//Declaration of global methods and properties
@property (strong, nonatomic) UIView *loadingView;
@property (strong,nonatomic) NSString *imagePath;
@property (strong, nonatomic) NSMutableDictionary * providerDetails;
@property (weak, nonatomic) IBOutlet UIButton *backButton;
@property (weak, nonatomic) IBOutlet UIButton *nextButton;
    @property (weak, nonatomic) IBOutlet UIView *backgroundProfFitnessView;

@property (weak, nonatomic) IBOutlet UIButton *que1SwitchButton;
@property (weak, nonatomic) IBOutlet UIButton *que4SwitchButton;
@property (weak, nonatomic) IBOutlet UIButton *que2SwitchButton;
@property (weak, nonatomic) IBOutlet UIButton *que3SwitchButton;
- (IBAction)backArrowClick:(id)sender;

- (IBAction)nextClick:(id)sender;

- (IBAction)backClick:(id)sender;



@end
