/***************************************************************
 Page name: MyPracticeExpertiseViewController.h
 Created By: Nalina
 Created Date: 2016-07-20
 Description: Practice expertise methods and functionality declaration file
 ***************************************************************/

#import <UIKit/UIKit.h>

@interface MyPracticeExpertiseViewController : UIViewController
{
    bool myBoolfamilyValue;
    bool myBoolGroupValue;
    bool myBooladoptionValue;
    bool myBoolanxietyValue;
    bool myBoolSocialanxietyValue;
    bool myBoolchronicPainValue;
    bool myBoolAngerManagementValue;
    bool myBoolworkspaceValue;
    bool myBoolPTSDValue;
    bool myBoolFriendshipsValue;
    bool myBooladdictionValue;
    bool myBoolLGBTQValue;
    bool myBoolDepressionValue;
    bool myBoolLossGriefValue;
    bool myBoolParentingValue;
    bool myBoolStressValue;
    
    bool myBoolTraumaValue;
    bool myBoolDatingRomanceValue;
    bool myBoolSeparationDivorceValue;
    bool myBoolSubstanceAbuseValue;
    bool myBoolSexualTraumaValue;
    
    int familyValue;
    int GroupValue;
    int adoptionValue;
    int anxietyValue;
    int SocialanxietyValue;
    int chronicPainValue;
    int AngerManagementValue;
    int workspaceValue;
    int PTSDValue;
    int FriendshipsValue;
    int addictionValue;
    int LGBTQValue;
    int DepressionValue;
    int LossGriefValue;
    int ParentingValue;
    int StressValue;
    int TraumaValue;
    int DatingRomanceValue;
    int SeparationDivorceValue;
    int SubstanceAbuseValue;
    int SexualTraumaValue;
    int practiceExpertiseValue;
    bool myBoolpracticeExpertiseValue;
    NSMutableArray *practiceExpertise;

}


@property (strong, nonatomic) UIAlertController *alertView;
@property (strong, nonatomic) UIAlertController *alert;
@property (strong, nonatomic) UIView *loadingView;

@property (weak, nonatomic) IBOutlet UIImageView *checkboxFamily;
@property (weak, nonatomic) IBOutlet UIImageView *checkboxAdoption;
@property (weak, nonatomic) IBOutlet UIImageView *checkboxGroup;
@property (weak, nonatomic) IBOutlet UIImageView *checkboxAnxiety;
@property (weak, nonatomic) IBOutlet UIImageView *checkboxSocialAnxiety;
@property (weak, nonatomic) IBOutlet UIImageView *checkboxChronicPain;
@property (weak, nonatomic) IBOutlet UIImageView *checkboxAngerManagement;
@property (weak, nonatomic) IBOutlet UIImageView *checkboxWorkplace;
@property (weak, nonatomic) IBOutlet UIImageView *checkboxPTSD;
@property (weak, nonatomic) IBOutlet UIImageView *checkboxFriendships;
@property (weak, nonatomic) IBOutlet UIImageView *checkboxAddiction;



@property (weak, nonatomic) IBOutlet UIImageView *checkboxLGBTQ;
@property (weak, nonatomic) IBOutlet UIImageView *checkboxDepression;
@property (weak, nonatomic) IBOutlet UIImageView *checkboxLossGrief;
@property (weak, nonatomic) IBOutlet UIImageView *checkboxParenting;
@property (weak, nonatomic) IBOutlet UIImageView *checkboxStress;
@property (weak, nonatomic) IBOutlet UIImageView *checkboxTrauma;
@property (weak, nonatomic) IBOutlet UIImageView *checkboxDatingRomance;
@property (weak, nonatomic) IBOutlet UIImageView *checkboxSeparationDivorce;
@property (weak, nonatomic) IBOutlet UIImageView *checkboxSubstanceAbuse;
@property (weak, nonatomic) IBOutlet UIImageView *checkboxSexualTrauma;


- (IBAction)checkboxFamilyClick:(id)sender;

- (IBAction)checkboxGroupClick:(id)sender;

- (IBAction)checkboxAdoptionClick:(id)sender;

- (IBAction)checkboxAnxietyClick:(id)sender;

- (IBAction)checkboxSocialAnxiety:(id)sender;

- (IBAction)CheckboxChronicPainClick:(id)sender;

- (IBAction)checkboxAngerManagementClick:(id)sender;

- (IBAction)checkboxWorkplaceClick:(id)sender;

- (IBAction)checkboxPTSDClick:(id)sender;

- (IBAction)checkboxLGBTQClick:(id)sender;

- (IBAction)checkboxAddictionClick:(id)sender;

- (IBAction)checkboxSubstanceAbuseClick:(id)sender;

- (IBAction)checkboxStressClick:(id)sender;

- (IBAction)checkboxTraumaClick:(id)sender;

- (IBAction)checkboxLossGriefClick:(id)sender;

- (IBAction)checkboxDatingClick:(id)sender;

- (IBAction)checkboxDepressionClick:(id)sender;

- (IBAction)checkboxSeparationDivorceClick:(id)sender;

- (IBAction)checkboxParentingClick:(id)sender;

- (IBAction)checkboxFriendshipsClick:(id)sender;

- (IBAction)checkboxSexualTraumaClick:(id)sender;
@end
