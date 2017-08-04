/***************************************************************
 Page name: ProviderSignUpMyPracticeExpertise.m
 Created By: zeenath
 Created Date:05/07/16
 Description: Provider sign up my practice expertise implementation file
 ***************************************************************/

#import <UIKit/UIKit.h>

@interface ProviderSignUpMyPracticeExpertise : UIViewController
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
    bool myBoolpracticeExpertiseValue;
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
    NSMutableArray *practiceExpertise;
  
}
@property (strong, nonatomic) UIView *loadingView;
@property (strong, nonatomic) NSMutableDictionary * providerDetails;
@property (strong, nonatomic) NSMutableDictionary * ExpertseDict;
@property (strong, nonatomic) UIAlertController *alert;
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

@property (weak, nonatomic) IBOutlet UIImageView *profilePicture;

@property (weak, nonatomic) IBOutlet UIImageView *footerimage;

- (IBAction)checkboxFamilyClick:(id)sender;

- (IBAction)checkboxGroupClick:(id)sender;

- (IBAction)checkboxAdoptionClick:(id)sender;

- (IBAction)checkboxAnxietyClick:(id)sender;

- (IBAction)checkboxSocialanxietyClick:(id)sender;

- (IBAction)checkboxChronicPainClick:(id)sender;

- (IBAction)checkboxAngerManagementClick:(id)sender;

- (IBAction)checkboxWorkplaceClick:(id)sender;

- (IBAction)checkboxPTSDClick:(id)sender;

- (IBAction)checkboxLGBTQClick:(id)sender;

- (IBAction)checkboxAddictionClick:(id)sender;

- (IBAction)checkboxSubstanceAbuseClick:(id)sender;

- (IBAction)checkboxStressClick:(id)sender;

- (IBAction)checkboxTraumaClick:(id)sender;

- (IBAction)checkboxLossGriefClick:(id)sender;

- (IBAction)checkboxDatingRomanceClick:(id)sender;

- (IBAction)checkboxDepressionClick:(id)sender;

- (IBAction)checkboxSeperationDivorceClick:(id)sender;

- (IBAction)checkboxParentingClick:(id)sender;

- (IBAction)checkboxFriendshipClick:(id)sender;

- (IBAction)checkboxSexualTraumaClick:(id)sender;

- (IBAction)backArrowClick:(id)sender;


- (IBAction)backButton:(id)sender;


- (IBAction)nextButton:(id)sender;




@end
