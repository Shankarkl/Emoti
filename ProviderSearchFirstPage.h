
/***************************************************************
 Page name:ProviderSearchFirstPage.h
 Created By:Zeenath
 Created Date:14/7/16
 Description:provider market search declaration file
 ***************************************************************/

#import <UIKit/UIKit.h>

@interface ProviderSearchFirstPage : UIViewController<UITextFieldDelegate>
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
    bool available;

    NSString *clickedbutton;
    NSArray *pickerArray;
    NSArray *timePickerArray;
    NSString *date;
    id availableID;
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
    
    float ratingSelectedValue;
}


//Declaration of global methods and variables
@property (nonatomic,assign) NSMutableArray *availablepickerArray;
@property (nonatomic,assign) NSMutableArray *availablepickerIDArray;
@property (strong, nonatomic) NSMutableDictionary * ExpertseDict;
@property (strong, nonatomic) UIAlertController *alert;
@property (strong, nonatomic) UIView *loadingView;

@property (weak, nonatomic) IBOutlet UIView *nameView;
@property (weak, nonatomic) IBOutlet UIView *GenderView;
@property (weak, nonatomic) IBOutlet UIView *specializationView;
@property (weak, nonatomic) IBOutlet UIView *availableOnView;
@property (weak, nonatomic) IBOutlet UIView *dateView;
@property (weak, nonatomic) IBOutlet UIView *timeFromView;
@property (weak, nonatomic) IBOutlet UIView *timeToView;
@property (weak, nonatomic) IBOutlet UIView *expertiseView;
@property (weak, nonatomic) IBOutlet UIView *availabilityView;

@property (weak, nonatomic) IBOutlet UIButton *availableSwitchBtn;
@property (weak, nonatomic) IBOutlet UIView *pickerBackView;
@property (weak, nonatomic) IBOutlet UIPickerView *pickerView;

@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;
@property (weak, nonatomic) IBOutlet UIView *datePickerButtonsView;
@property (weak, nonatomic) IBOutlet UIPickerView *timePickerView;

@property (weak, nonatomic) IBOutlet UITextField *nameText;
@property (weak, nonatomic) IBOutlet UITextField *genderText;
@property (weak, nonatomic) IBOutlet UITextField *specializationText;
@property (weak, nonatomic) IBOutlet UITextField *availableOnText;
@property (weak, nonatomic) IBOutlet UITextField *dateText;
@property (weak, nonatomic) IBOutlet UITextField *timeFromText;
@property (weak, nonatomic) IBOutlet UITextField *timeToText;


@property (weak, nonatomic) IBOutlet UIImageView *checkBoxFamily;
@property (weak, nonatomic) IBOutlet UIImageView *checkboxAdoption;

@property (weak, nonatomic) IBOutlet UIImageView *checkboxAnxiety;
@property (weak, nonatomic) IBOutlet UIImageView *checkboxSocialAnxiety;
@property (weak, nonatomic) IBOutlet UIImageView *checkboxChronicPain;
@property (weak, nonatomic) IBOutlet UIImageView *checkboxAngerManagement;
@property (weak, nonatomic) IBOutlet UIImageView *checkboxAddiction;
@property (weak, nonatomic) IBOutlet UIImageView *checkboxGroup;
@property (weak, nonatomic) IBOutlet UIImageView *checkboxWorkplace;
@property (weak, nonatomic) IBOutlet UIImageView *checkboxFriendships;
@property (weak, nonatomic) IBOutlet UIImageView *checkboxPTSD;

@property (weak, nonatomic) IBOutlet UIImageView *checkboxLGBTIQ;
@property (weak, nonatomic) IBOutlet UIImageView *checkboxDepression;
@property (weak, nonatomic) IBOutlet UIImageView *checkboxLossGrief;
@property (weak, nonatomic) IBOutlet UIImageView *checkboxParenting;
@property (weak, nonatomic) IBOutlet UIImageView *checkboxStress;
@property (weak, nonatomic) IBOutlet UIImageView *checkboxTrauma;
@property (weak, nonatomic) IBOutlet UIImageView *checkboxDatingRomaceClick;
@property (weak, nonatomic) IBOutlet UIImageView *checkboxSeparationDivorce;
@property (weak, nonatomic) IBOutlet UIImageView *checkboxSubstanceAbuse;
@property (weak, nonatomic) IBOutlet UIImageView *checkboxSexualTrauma;

@property (weak, nonatomic) IBOutlet UIImageView *nameIcon;
@property (weak, nonatomic) IBOutlet UIButton *nameCloseButton;

@property (weak, nonatomic) IBOutlet UIImageView *genderIcon;
@property (weak, nonatomic) IBOutlet UIButton *genderCloseButton;

@property (weak, nonatomic) IBOutlet UIImageView *specialisationIcon;
@property (weak, nonatomic) IBOutlet UIButton *specialisationCloseButton;

@property (weak, nonatomic) IBOutlet UIButton *availableCloseButton;

@property (weak, nonatomic) IBOutlet UIImageView *dateIcon;
@property (weak, nonatomic) IBOutlet UIButton *dateCloseButton;
@property (weak, nonatomic) IBOutlet UIButton *timeToCloseButton;

@property (weak, nonatomic) IBOutlet UIButton *timeFromCloseButton;

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
@property (strong, nonatomic) IBOutlet UIButton *searchButtton;
@property (weak, nonatomic) IBOutlet UIView *availabilityFilterView;

@property (weak, nonatomic) IBOutlet UIView *firstFilterView;


@end
