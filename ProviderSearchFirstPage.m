
/***************************************************************
 Page name:ProviderSearchFirstPage.m
 Created By:Zeenath
 Created Date:14/7/16
 Description:provider market search implementation file
 ***************************************************************/

#import "ProviderSearchFirstPage.h"
#include "GlobalFunction.h"
#import "ProviderMarketPlaceViewController.h"
#import "AppDelegate.h"
#import <Google/Analytics.h>
#import <HCSStarRatingView/HCSStarRatingView.h>
#import "ProviderDetailsViewController.h"

@interface ProviderSearchFirstPage ()

@end

@implementation ProviderSearchFirstPage
@synthesize availablepickerArray,availablepickerIDArray;


//Called when the view controller is first time loaded to memory
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIImage *backgroundImage = [UIImage imageNamed:@"LoginBackground.png"];
    UIImageView *backgroundImageView=[[UIImageView alloc]initWithFrame:self.view.frame];
    backgroundImageView.image=backgroundImage;
    [self.view insertSubview:backgroundImageView atIndex:0];
    
    [self setExpertiseButtonBorderColor:1];
    [self setExpertiseButtonBorderColor:2];
    [self setExpertiseButtonBorderColor:3];
    [self setExpertiseButtonBorderColor:4];
    [self setExpertiseButtonBorderColor:5];
    [self setExpertiseButtonBorderColor:6];
    [self setExpertiseButtonBorderColor:7];
    [self setExpertiseButtonBorderColor:8];
    [self setExpertiseButtonBorderColor:9];
    [self setExpertiseButtonBorderColor:10];
    [self setExpertiseButtonBorderColor:11];
    [self setExpertiseButtonBorderColor:12];
    [self setExpertiseButtonBorderColor:13];
    [self setExpertiseButtonBorderColor:14];
    [self setExpertiseButtonBorderColor:15];
    [self setExpertiseButtonBorderColor:16];
    [self setExpertiseButtonBorderColor:17];
    [self setExpertiseButtonBorderColor:18];
    [self setExpertiseButtonBorderColor:19];
    [self setExpertiseButtonBorderColor:20];
    [self setExpertiseButtonBorderColor:21];
    
    //  Added by:Zeenath
    //  Added Date:2016-24-07.
    //  Description:Added textfield delegates and control methods.
    _nameText.delegate=self;
    _genderText.delegate=self;
    _specializationText.delegate=self;
    _availableOnText.delegate=self;
    _dateText.delegate=self;
    _timeFromText.delegate=self;
    _timeToText.delegate=self;
    
    ratingSelectedValue=0;
    
    [self.nameText addTarget:self action:@selector(textFielddidChange:) forControlEvents:UIControlEventAllTouchEvents];
    [self.nameText addTarget:self action:@selector(textFielddidChange:) forControlEvents:UIControlEventEditingChanged];
    
    [self.genderText addTarget:self action:@selector(textFielddidChange:) forControlEvents:UIControlEventAllTouchEvents];
    [self.genderText addTarget:self action:@selector(textFielddidChange:) forControlEvents:UIControlEventEditingChanged];
    
    [self.specializationText addTarget:self action:@selector(textFielddidChange:) forControlEvents:UIControlEventAllTouchEvents];
    [self.specializationText addTarget:self action:@selector(textFielddidChange:) forControlEvents:UIControlEventEditingChanged];
    
    [self.availableOnText addTarget:self action:@selector(textFielddidChange:) forControlEvents:UIControlEventAllTouchEvents];
    [self.availableOnText addTarget:self action:@selector(textFielddidChange:) forControlEvents:UIControlEventEditingChanged];
    
    [self.dateText addTarget:self action:@selector(textFielddidChange:) forControlEvents:UIControlEventAllTouchEvents];
    [self.dateText addTarget:self action:@selector(textFielddidChange:) forControlEvents:UIControlEventEditingChanged];
    
    [self.timeFromText addTarget:self action:@selector(textFielddidChange:) forControlEvents:UIControlEventAllTouchEvents];
    [self.timeFromText addTarget:self action:@selector(textFielddidChange:) forControlEvents:UIControlEventEditingChanged];
    
    [self.timeToText addTarget:self action:@selector(textFielddidChange:) forControlEvents:UIControlEventAllTouchEvents];
    [self.timeToText addTarget:self action:@selector(textFielddidChange:) forControlEvents:UIControlEventEditingChanged];
    
    
    //  Added by:Zeenath
    //  Added Date:2016-24-07.
    //  Description:Array to show the timings in time picker.
    timePickerArray = [[NSArray alloc]initWithObjects:@"12:00 AM",
                       @"12:30 AM",@"1:00 AM",@"1:30 AM",@"2:00 AM",@"2:30 AM",@"3:00 AM",@"3:30 AM",@"4:00 AM",@"4:30 AM",@"5:00 AM",@"5:30 AM",@"6:00 AM",@"6:30 AM",@"7:00 AM",@"7:30 AM",@"8:00 AM",@"8:30 AM",@"9:00 AM",@"9:30  AM",@"10:00 AM",@"10:30 AM",@"11:00 AM",@"11:30 AM",@"12:00 PM",@"12:30 PM",@"1:00 PM",@"1:30 PM",@"2:00 PM",@"2:30 PM",@"3:00 PM",@"3:30 PM",@"4:00 PM",@"4:30 PM",@"5:00 PM",@"5:30 PM",@"6:00 PM",@"6:30 PM",@"7:00 PM",@"7:30 PM",@"8:00 PM",@"8:30 PM",@"9:00 PM",@"9:30 PM",@"10:00 PM",@"10:30 PM",@"11:00 PM",@"11:30 PM", nil];
    
    [_datePicker setBackgroundColor:[UIColor whiteColor]];
    UITapGestureRecognizer *singleFingerTap =
    [[UITapGestureRecognizer alloc] initWithTarget:self
                                            action:@selector(handleSingleTapped:)];
    [self.pickerBackView addGestureRecognizer:singleFingerTap];
    
    myBoolfamilyValue=NO;
    myBoolGroupValue=NO;
    myBooladoptionValue=NO;
    myBoolanxietyValue=NO;
    myBoolSocialanxietyValue=NO;
    myBoolchronicPainValue=NO;
    myBoolAngerManagementValue=NO;
    myBoolworkspaceValue=NO;
    myBoolPTSDValue=NO;
    myBoolFriendshipsValue=NO;
    myBooladdictionValue=NO;
    myBoolLGBTQValue=NO;
    myBoolDepressionValue=NO;
    myBoolLossGriefValue=NO;
    myBoolParentingValue=NO;
    myBoolStressValue=NO;
    
    myBoolTraumaValue=NO;
    myBoolDatingRomanceValue=NO;
    myBoolSeparationDivorceValue=NO;
    myBoolSubstanceAbuseValue=NO;
    myBoolSexualTraumaValue=NO;
    myBoolpracticeExpertiseValue=NO;
    available=NO;
    
    //  Added by:Nalina
    //  Added Date:2016-24-07.
    //  Description:Service call to get the provider expertise list.
    practiceExpertise= [[NSMutableArray alloc]init];
    
    AppDelegate *appdelegate=(AppDelegate *)[[UIApplication sharedApplication]delegate];
    NSString *Url=[appdelegate.serviceURL stringByAppendingString:@"/api/Expertise"];
    
    
    [[GlobalFunction sharedInstance]getServerResponseAfterLogin:Url method:@"GET" param:nil withCallback:^(NSInteger statusCode, NSDictionary *response, NSError *error) {
        
        
        NSMutableArray *array=[response mutableCopy];
        @autoreleasepool {
            
            for(int i=0;i<response.count;i++)
            {
                _ExpertseDict=[array objectAtIndex:i];
                
                if([[_ExpertseDict objectForKey:@"expertiseText"] isEqualToString:@"Family"])
                {
                    NSString *idValue=[_ExpertseDict valueForKey:@"id"];
                    familyValue=[idValue intValue];
                }
                if([[_ExpertseDict objectForKey:@"expertiseText"] isEqualToString:@"Group"])
                {
                    NSString *idValue=[_ExpertseDict valueForKey:@"id"];
                    GroupValue=[idValue intValue];
                }
                
                if([[_ExpertseDict objectForKey:@"expertiseText"] isEqualToString:@"Adoption"])
                {
                    NSString *idValue=[_ExpertseDict valueForKey:@"id"];
                    adoptionValue=[idValue intValue];
                }
                if([[_ExpertseDict objectForKey:@"expertiseText"] isEqualToString:@"Anxiety"])
                {
                    NSString *idValue=[_ExpertseDict valueForKey:@"id"];
                    anxietyValue=[idValue intValue];
                }
                if([[_ExpertseDict objectForKey:@"expertiseText"] isEqualToString:@"Social Anxiety"])
                {
                    NSString *idValue=[_ExpertseDict valueForKey:@"id"];
                    SocialanxietyValue=[idValue intValue];
                }
                if([[_ExpertseDict objectForKey:@"expertiseText"] isEqualToString:@"Chronic Pain"])
                {
                    NSString *idValue=[_ExpertseDict valueForKey:@"id"];
                    chronicPainValue=[idValue intValue];
                }
                if([[_ExpertseDict objectForKey:@"expertiseText"] isEqualToString:@"Anger Management"])
                {
                    NSString *idValue=[_ExpertseDict valueForKey:@"id"];
                    AngerManagementValue=[idValue intValue];
                }
                
                if([[_ExpertseDict objectForKey:@"expertiseText"] isEqualToString:@"Workplace"])
                {
                    NSString *idValue=[_ExpertseDict valueForKey:@"id"];
                    workspaceValue=[idValue intValue];
                }
                
                if([[_ExpertseDict objectForKey:@"expertiseText"] isEqualToString:@"PTSD"])
                {
                    NSString *idValue=[_ExpertseDict valueForKey:@"id"];
                    PTSDValue=[idValue intValue];
                }
                
                if([[_ExpertseDict objectForKey:@"expertiseText"] isEqualToString:@"Friendships"])
                {
                    NSString *idValue=[_ExpertseDict valueForKey:@"id"];
                    FriendshipsValue=[idValue intValue];
                }
                
                if([[_ExpertseDict objectForKey:@"expertiseText"] isEqualToString:@"Addiction"])
                {
                    NSString *idValue=[_ExpertseDict valueForKey:@"id"];
                    addictionValue=[idValue intValue];
                }
                if([[_ExpertseDict objectForKey:@"expertiseText"] isEqualToString:@"LGBTIQ"])
                {
                    NSString *idValue=[_ExpertseDict valueForKey:@"id"];
                    LGBTQValue=[idValue intValue];
                }
                if([[_ExpertseDict objectForKey:@"expertiseText"] isEqualToString:@"Depression"])
                {
                    NSString *idValue=[_ExpertseDict valueForKey:@"id"];
                    DepressionValue=[idValue intValue];
                }
                if([[_ExpertseDict objectForKey:@"expertiseText"] isEqualToString:@"Loss/Grief"])
                {
                    NSString *idValue=[_ExpertseDict valueForKey:@"id"];
                    LossGriefValue=[idValue intValue];
                }
                
                if([[_ExpertseDict objectForKey:@"expertiseText"] isEqualToString:@"Parenting"])
                {
                    NSString *idValue=[_ExpertseDict valueForKey:@"id"];
                    ParentingValue=[idValue intValue];
                }
                if([[_ExpertseDict objectForKey:@"expertiseText"] isEqualToString:@"Stress"])
                {
                    NSString *idValue=[_ExpertseDict valueForKey:@"id"];
                    StressValue=[idValue intValue];
                }
                if([[_ExpertseDict objectForKey:@"expertiseText"] isEqualToString:@"Trauma"])
                {
                    NSString *idValue=[_ExpertseDict valueForKey:@"id"];
                    TraumaValue=[idValue intValue];
                }
                if([[_ExpertseDict objectForKey:@"expertiseText"] isEqualToString:@"Dating and Romance"])
                {
                    NSString *idValue=[_ExpertseDict valueForKey:@"id"];
                    DatingRomanceValue=[idValue intValue];
                }
                if([[_ExpertseDict objectForKey:@"expertiseText"] isEqualToString:@"Separation/Divorce"])
                {
                    NSString *idValue=[_ExpertseDict valueForKey:@"id"];
                    SeparationDivorceValue=[idValue intValue];
                }
                if([[_ExpertseDict objectForKey:@"expertiseText"] isEqualToString:@"Substance Abuse"])
                {
                    NSString *idValue=[_ExpertseDict valueForKey:@"id"];
                    SubstanceAbuseValue=[idValue intValue];
                }
                
                if([[_ExpertseDict objectForKey:@"expertiseText"] isEqualToString:@"Sexual Trauma"])
                {
                    NSString *idValue=[_ExpertseDict valueForKey:@"id"];
                    SexualTraumaValue=[idValue intValue];
                }
            }
        }
    }];
    
    
    // Added By:Nalina
    // Added Date:18/08/16
    // Description: On click of text field picker will appear functionality
    
    UITapGestureRecognizer *genderTap =
    [[UITapGestureRecognizer alloc] initWithTarget:self
                                            action:@selector(genderViewClick:)];
    [self.GenderView addGestureRecognizer:genderTap];
    
    UITapGestureRecognizer *specializationTap =
    [[UITapGestureRecognizer alloc] initWithTarget:self
                                            action:@selector(specializationClick:)];
    [self.specializationView addGestureRecognizer:specializationTap];
    
    UITapGestureRecognizer *availableTap =
    [[UITapGestureRecognizer alloc] initWithTarget:self
                                            action:@selector(availableonClick:)];
    [self.availableOnView addGestureRecognizer:availableTap];
    
    UITapGestureRecognizer *dateTap =
    [[UITapGestureRecognizer alloc] initWithTarget:self
                                            action:@selector(DatesetClick:)];
    [self.dateView addGestureRecognizer:dateTap];
    
    UITapGestureRecognizer *timefromTap =
    [[UITapGestureRecognizer alloc] initWithTarget:self
                                            action:@selector(timeFromClick:)];
    [self.timeFromView addGestureRecognizer:timefromTap];
    
    UITapGestureRecognizer *timetoTap =
    [[UITapGestureRecognizer alloc] initWithTarget:self
                                            action:@selector(timetoClick:)];
    [self.timeToView addGestureRecognizer:timetoTap];
    
    [_availableSwitchBtn setImage:[UIImage imageNamed:@"onSwitch.png"] forState:UIControlStateNormal];
    
    HCSStarRatingView *starRatingView = [[HCSStarRatingView alloc] initWithFrame:CGRectMake(120, 220, 200, 70)];
    starRatingView.maximumValue = 5;
    starRatingView.minimumValue = 0;
    starRatingView.allowsHalfStars = YES;
    starRatingView.enabled=YES;
    starRatingView.value = 0; //rateValue;
    starRatingView.tintColor = [UIColor colorWithRed:118.0/255.0 green:183.0/255.0 blue:189.0/255.0 alpha:1];
    //starRatingView.BorderColor=[UIColor colorWithRed:118.0/255.0 green:183.0/255.0 blue:189.0/255.0 alpha:1];
    starRatingView.backgroundColor=[UIColor clearColor];
    
    [starRatingView addTarget:self action:@selector(didChangeValue:) forControlEvents:UIControlEventValueChanged];
    [_firstFilterView addSubview:starRatingView];
}

- (IBAction)didChangeValue:(HCSStarRatingView *)sender {
    NSLog(@"Changed rating to %.1f", sender.value);
    ratingSelectedValue=sender.value;
}

// Added By:Nalina
// Added Date:18/08/16
// Description: Function to resign the keyboard
-(void)resignSoftKeyboard{
    [_nameText resignFirstResponder];
    [_genderText resignFirstResponder];
    [_timeFromText resignFirstResponder];
    [_timeToText resignFirstResponder];
    [_dateText resignFirstResponder];
    [_specializationText resignFirstResponder];
    [_availableOnText resignFirstResponder];
}


// Added By:Nalina
// Added Date:18/08/16
// Description: Function to set the date selected from the datepicker on the textfield
- (void)DatesetClick:(UITapGestureRecognizer *)recognizer {
    [self resignSoftKeyboard];
    _pickerBackView.hidden=NO;
    _datePicker.hidden=NO;
    _pickerView.hidden=YES;
    _timePickerView.hidden=YES;
    clickedbutton=@"dateField";
    _datePicker.datePickerMode = UIDatePickerModeDate;
    _datePickerButtonsView.hidden=NO;
    [self RemoveValidationSetting:_dateText errorIcon:_dateCloseButton indicationIcon:_dateIcon HintText:@"Date" imageIs:@"dob" viewField:_dateView];
}



// Added By:Nalina
// Added Date:18/08/16
// Description: Function to set the time selected from the timepicker on the textfield
- (void)timeFromClick:(UITapGestureRecognizer *)recognizer {
    [self resignSoftKeyboard];
    _pickerBackView.hidden=NO;
    _datePicker.hidden=YES;
    _pickerView.hidden=YES;
    _timePickerView.hidden=NO;
    clickedbutton=@"timeFromField";
    [self RemoveValidationSetting:_timeFromText errorIcon:_timeFromCloseButton indicationIcon:nil HintText:@"Time From" imageIs:nil viewField:_timeFromView];
}

- (void)timetoClick:(UITapGestureRecognizer *)recognizer {
    [self resignSoftKeyboard];
    _pickerBackView.hidden=NO;
    _datePicker.hidden=YES;
    _pickerView.hidden=YES;
    _timePickerView.hidden=NO;
    clickedbutton=@"timeToField";
    [self RemoveValidationSetting:_timeToText errorIcon:_timeToCloseButton indicationIcon:nil HintText:@"Time To" imageIs:nil viewField:_timeToView];
}


// Added By:Nalina
// Added Date:18/08/16
// Description: Function to set the days selected from the pickerview on the textfield
- (void)availableonClick:(UITapGestureRecognizer *)recognizer {
    [self resignSoftKeyboard];
    pickerArray = availablepickerArray;
    [self.pickerView reloadAllComponents];
    _pickerBackView.hidden=NO;
    _pickerView.hidden=NO;
    _datePickerButtonsView.hidden=YES;
    _datePicker.hidden=YES;
    _timePickerView.hidden=YES;
    clickedbutton=@"availableOnField";
    [self RemoveValidationSetting:_availableOnText errorIcon:_availableCloseButton indicationIcon: nil HintText:@"Available On" imageIs:nil viewField:_availableOnView];
}


// Added By:Nalina
// Added Date:18/08/16
// Description: Function to set the speciaization selected from the pickerview on the textfield
- (void)specializationClick:(UITapGestureRecognizer *)recognizer {
    [self resignSoftKeyboard];
    pickerArray = [[NSArray alloc]initWithObjects:@"Phd/MD",
                   @"PSYD",@"MSW",@"LCSW",@"Licensed Counselor", nil];
    [self.pickerView reloadAllComponents];
    _pickerBackView.hidden=NO;
    _pickerView.hidden=NO;
    _datePickerButtonsView.hidden=YES;
    _datePicker.hidden=YES;
    _timePickerView.hidden=YES;
    clickedbutton=@"specializationField";
    [self RemoveValidationSetting:_specializationText errorIcon:_specialisationCloseButton indicationIcon:_specialisationIcon HintText:@"Specialty" imageIs:@"user" viewField:_specializationView];
    
}


// Added By:Nalina
// Added Date:18/08/16
// Description: Function to set the gender selected from the pickerview on the textfield
- (void)genderViewClick:(UITapGestureRecognizer *)recognizer {
    [self resignSoftKeyboard];
    pickerArray = [[NSArray alloc]initWithObjects:@"Male",
                   @"Female",@"Either", nil];
    [self.pickerView reloadAllComponents];
    _pickerBackView.hidden=NO;
    _pickerView.hidden=NO;
    _datePickerButtonsView.hidden=YES;
    _datePicker.hidden=YES;
    _timePickerView.hidden=YES;
    
    clickedbutton=@"genderField";
    [self RemoveValidationSetting:_genderText errorIcon:_genderCloseButton indicationIcon:_genderIcon HintText:@"Gender" imageIs:@"user" viewField:_GenderView];
}


// Added By:Zeenath
// Added Date:18/07/16
// Description: Function to hide the picker view
- (void)handleSingleTapped:(UITapGestureRecognizer *)recognizer {
    //Do stuff here...
    _pickerBackView.hidden=YES;
}

// Dispose of any resources that can be recreated.
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//  Added by:Zeenath
//  Added Date:2016-24-07.
//  Description:Function To set the border for the views around the textfields.
-(void)setBorder:(UIView *)img
{
    
    img.layer.borderColor = [[UIColor colorWithRed:228.0/255.0 green:109.0/255.0 blue:175.0/255.0 alpha:1.0]CGColor];
    img.layer.borderWidth = 1.0f;
    
}


//called each time when the view appears
-(void)viewWillAppear:(BOOL)animated{
    
    [self setBorder:_nameView];
    [self setBorder:_GenderView];
    [self setBorder:_specializationView];
    [self setBorder:_availableOnView];
    [self setBorder:_dateView];
    [self setBorder:_timeFromView];
    [self setBorder:_timeToView];
    
    id<GAITracker> tracker = [[GAI sharedInstance] defaultTracker];
    [tracker set:kGAIScreenName value:@"ProviderMarketSearch"];
    [tracker send:[[GAIDictionaryBuilder createScreenView] build]];
}


//  Added by:Zeenath
//  Added Date:2016-24-07.
//  Description:Function To swich the avialability.
- (IBAction)switchButtonClick:(id)sender {
    [self resignSoftKeyboard];
    
    if (available==NO) {
        
        [_availableSwitchBtn setImage:[UIImage imageNamed:@"onSwitch.png"] forState:UIControlStateNormal];
        available=YES;
        
        _availabilityFilterView.hidden=NO;
        
        /*_availabilityFilterView.frame = CGRectMake(self.availabilityFilterView.frame.origin.x, 82, _availabilityFilterView.bounds.size.width,_availabilityFilterView.bounds.size.height);
         
         _expertiseView.frame = CGRectMake(self.expertiseView.frame.origin.x, 550, _expertiseView.bounds.size.width,_expertiseView.bounds.size.height);
         
         _searchButtton.frame = CGRectMake(self.searchButtton.frame.origin.x, 910,
         _searchButtton.bounds.size.width, _searchButtton.bounds.size.height);*/
    }
    else if(available==YES)
    {
        [_availableSwitchBtn setImage:[UIImage imageNamed:@"offSwitch.png"] forState:UIControlStateNormal];
        available=NO;
        
        _availabilityFilterView.hidden=YES;
        
        /*_availabilityFilterView.frame = CGRectMake(self.availabilityFilterView.frame.origin.x, 82, _availabilityFilterView.bounds.size.width,0);
         
         _expertiseView.frame = CGRectMake(self.expertiseView.frame.origin.x, 400, _expertiseView.bounds.size.width,_expertiseView.bounds.size.height);
         
         _searchButtton.frame = CGRectMake(self.searchButtton.frame.origin.x, 710,
         _searchButtton.bounds.size.width, _searchButtton.bounds.size.height);*/
    }
    
}



//  Added by:Zeenath
//  Added Date:2016-24-07.
//  Description:Function called when the textfield begin editing.
- (BOOL) textFieldShouldBeginEditing:(UITextField *)textField
{
    if(textField == _genderText)
    {
        pickerArray = [[NSArray alloc]initWithObjects:@"Male",
                       @"Female",@"Either", nil];
        [self.pickerView reloadAllComponents];
        _pickerBackView.hidden=NO;
        _pickerView.hidden=NO;
        _datePickerButtonsView.hidden=YES;
        _datePicker.hidden=YES;
        _timePickerView.hidden=YES;
        
        clickedbutton=@"genderField";
        [self RemoveValidationSetting:_genderText errorIcon:_genderCloseButton indicationIcon:_genderIcon HintText:@"Gender" imageIs:@"user" viewField:_GenderView];
    }
    else if(textField == _specializationText)
    {
        pickerArray = [[NSArray alloc]initWithObjects:@"Phd/MD",
                       @"PSYD",@"MSW",@"LCSW",@"Licensed Counselor", nil];
        [self.pickerView reloadAllComponents];
        _pickerBackView.hidden=NO;
        _pickerView.hidden=NO;
        _datePickerButtonsView.hidden=YES;
        _datePicker.hidden=YES;
        _timePickerView.hidden=YES;
        
        clickedbutton=@"specializationField";
        [self RemoveValidationSetting:_specializationText errorIcon:_specialisationCloseButton indicationIcon:_specialisationIcon HintText:@"Specialty" imageIs:@"user" viewField:_specializationView];
        
    }
    else if(textField == _availableOnText)
    {
        pickerArray = availablepickerArray;
        [self.pickerView reloadAllComponents];
        _pickerBackView.hidden=NO;
        _pickerView.hidden=NO;
        _datePickerButtonsView.hidden=YES;
        _datePicker.hidden=YES;
        _timePickerView.hidden=YES;
        
        clickedbutton=@"availableOnField";
        [self RemoveValidationSetting:_availableOnText errorIcon:_availableCloseButton indicationIcon: nil HintText:@"Available On" imageIs:nil viewField:_availableOnView];
        
    }
    else if(textField == _dateText)
    {
        _pickerBackView.hidden=NO;
        _datePicker.hidden=NO;
        _pickerView.hidden=YES;
        _timePickerView.hidden=YES;
        clickedbutton=@"dateField";
        _datePicker.datePickerMode = UIDatePickerModeDate;
        _datePickerButtonsView.hidden=NO;
        [self RemoveValidationSetting:_dateText errorIcon:_dateCloseButton indicationIcon:_dateIcon HintText:@"Date" imageIs:@"dob" viewField:_dateView];
        
    }
    else if(textField == _timeFromText)
    {
        
        _pickerBackView.hidden=NO;
        _datePicker.hidden=YES;
        _pickerView.hidden=YES;
        _timePickerView.hidden=NO;
        clickedbutton=@"timeFromField";
        [self RemoveValidationSetting:_timeFromText errorIcon:_timeFromCloseButton indicationIcon:nil HintText:@"Time From" imageIs:nil viewField:_timeFromView];
        
        
    }
    else if(textField == _timeToText)
    {
        
        _pickerBackView.hidden=NO;
        _datePicker.hidden=YES;
        _pickerView.hidden=YES;
        _timePickerView.hidden=NO;
        clickedbutton=@"timeToField";
        [self RemoveValidationSetting:_timeToText errorIcon:_timeToCloseButton indicationIcon:nil HintText:@"Time To" imageIs:nil viewField:_timeToView];
        
        
    }
    
    return YES;
}


//Returns number of components in pickerview
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)thePickerView {
    
    return 1;//Or return whatever as you intend
}

//Returns number of rows in pickerview
- (NSInteger)pickerView:(UIPickerView *)thePickerView numberOfRowsInComponent:(NSInteger)component {
    if(thePickerView==_pickerView)
    {
        return [pickerArray count];//Or, return as suitable for you...normally we use array for dynamic
    }
    else{
        return [timePickerArray count];
    }
}

//Set the title for each rows in pickerview
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:
(NSInteger)row forComponent:(NSInteger)component{
    
    if(pickerView==_pickerView)
    {
        return [pickerArray objectAtIndex:row];
    }
    else{
        return [timePickerArray objectAtIndex:row];
    }
}

//Called when a row in the pickerview is selected
- (void)pickerView:(UIPickerView *)thePickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    [_pickerView selectRow:0 inComponent:0 animated:YES];
    [_timePickerView selectRow:0 inComponent:0 animated:YES];
    
    if([clickedbutton isEqualToString:@"genderField"])
    {
        
        [_genderText setText:[pickerArray objectAtIndex:row]];
        
        
    }
    else if([clickedbutton isEqualToString:@"specializationField"])
    {
        
        [_specializationText setText:[pickerArray objectAtIndex:row]];
        
    }
    else if([clickedbutton isEqualToString:@"availableOnField"])
    {
        [_availableOnText setText:[pickerArray objectAtIndex:row]];
        availableID=[availablepickerIDArray objectAtIndex:row];
    }
    else if([clickedbutton isEqualToString:@"timeFromField"])
    {
        [_timeFromText setText:[timePickerArray objectAtIndex:row]];
    }
    
    else if([clickedbutton isEqualToString:@"timeToField"])
    {
        [_timeToText setText:[timePickerArray objectAtIndex:row]];
    }
    
    
    
    _pickerBackView.hidden=YES;
    
}


//  Added by:Zeenath
//  Added Date:2016-25-07.
//  Description:Function To focus the textfield and return the keyboard.
- (BOOL)textFieldShouldReturn:(UITextField *)theTextField {
    if (theTextField == self.nameText) {
        [self.genderText becomeFirstResponder];
        [theTextField resignFirstResponder];
    }
    if (theTextField == self.genderText) {
        [self.specializationText becomeFirstResponder];
        [theTextField resignFirstResponder];
    }   if (theTextField == self.specializationText) {
        [theTextField resignFirstResponder];
    }
    
    if (theTextField == self.dateText) {
        [self.timeFromText becomeFirstResponder];
        [theTextField resignFirstResponder];
    }   if (theTextField == self.timeFromText) {
        [self.timeToText becomeFirstResponder];
    }
    if (theTextField == self.timeToText) {
        [theTextField resignFirstResponder];
    }
    
    return YES;
}


//  Added by:Zeenath
//  Added Date:2016-25-07.
//  Description:Function To set the date from the time picker.
- (IBAction)setDateClick:(id)sender {
    [self resignSoftKeyboard];
    
    if([clickedbutton isEqualToString:@"dateField"])
    {
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"MM/dd/yyyy"];
        date = [dateFormatter stringFromDate:self.datePicker.date];
        _dateText.text=date;
        _pickerBackView.hidden=YES;
        _pickerView.hidden=YES;
        _datePicker.hidden=YES;
        _datePickerButtonsView.hidden=YES;
        
    }
    
}

//  Added by:Zeenath
//  Added Date:2016-25-07.
//  Description:Function To hide the datepicker.
- (IBAction)cancelDateClick:(id)sender {
    _pickerBackView.hidden=YES;
}


//  Added by:Nalina
//  Added Date:2016-02-08.
//  Description:Function To check and uncheck the checkboxes.
- (IBAction)checkboxFamilyClick:(id)sender {
    myBoolfamilyValue=[self setButtonColorOnSelected:1 boolValue:myBoolfamilyValue addDictValue:familyValue];
}
- (IBAction)checkboxGroupClick:(id)sender {
    myBoolGroupValue=[self setButtonColorOnSelected:2 boolValue:myBoolGroupValue addDictValue:GroupValue];
}
- (IBAction)checkboxAdoptionClick:(id)sender {
    myBooladoptionValue=[self setButtonColorOnSelected:3 boolValue:myBooladoptionValue addDictValue:adoptionValue];
}
- (IBAction)checkboxAnxietyClick:(id)sender {
    myBoolanxietyValue=[self setButtonColorOnSelected:4 boolValue:myBoolanxietyValue addDictValue:anxietyValue];
}
- (IBAction)checkboxSocialAnxiety:(id)sender {
    myBoolSocialanxietyValue=[self setButtonColorOnSelected:5 boolValue:myBoolSocialanxietyValue addDictValue:SocialanxietyValue];
}
- (IBAction)CheckboxChronicPainClick:(id)sender {
    myBoolchronicPainValue=[self setButtonColorOnSelected:6 boolValue:myBoolchronicPainValue addDictValue:chronicPainValue];
}
- (IBAction)checkboxAngerManagementClick:(id)sender {
    myBoolAngerManagementValue=[self setButtonColorOnSelected:7 boolValue:myBoolAngerManagementValue addDictValue:AngerManagementValue];
}
- (IBAction)checkboxWorkplaceClick:(id)sender {
    myBoolworkspaceValue=[self setButtonColorOnSelected:8 boolValue:myBoolworkspaceValue addDictValue:workspaceValue];
}
- (IBAction)checkboxPTSDClick:(id)sender {
    myBoolPTSDValue=[self setButtonColorOnSelected:9 boolValue:myBoolPTSDValue addDictValue:PTSDValue];
}
- (IBAction)checkboxFriendshipsClick:(id)sender {
    myBoolFriendshipsValue=[self setButtonColorOnSelected:10 boolValue:myBoolFriendshipsValue addDictValue:FriendshipsValue];
    
}


- (IBAction)checkboxAddictionClick:(id)sender {
    myBooladdictionValue=[self setButtonColorOnSelected:11 boolValue:myBooladdictionValue addDictValue:addictionValue];
    
}

- (IBAction)checkboxLGBTQClick:(id)sender {
    myBoolLGBTQValue=[self setButtonColorOnSelected:12 boolValue:myBoolLGBTQValue addDictValue:LGBTQValue];
}
- (IBAction)checkboxDepressionClick:(id)sender {
    myBoolDepressionValue=[self setButtonColorOnSelected:13 boolValue:myBoolDepressionValue addDictValue:DepressionValue];
}
- (IBAction)checkboxLossGriefClick:(id)sender {
    myBoolLossGriefValue=[self setButtonColorOnSelected:14 boolValue:myBoolLossGriefValue addDictValue:LossGriefValue];
}
- (IBAction)checkboxParentingClick:(id)sender {
    myBoolParentingValue=[self setButtonColorOnSelected:15 boolValue:myBoolParentingValue addDictValue:ParentingValue];
}
- (IBAction)checkboxStressClick:(id)sender {
    myBoolStressValue=[self setButtonColorOnSelected:16 boolValue:myBoolStressValue addDictValue:StressValue];
}
- (IBAction)checkboxTraumaClick:(id)sender {
    myBoolTraumaValue=[self setButtonColorOnSelected:17 boolValue:myBoolTraumaValue addDictValue:TraumaValue];
}
- (IBAction)checkboxDatingClick:(id)sender {
    myBoolDatingRomanceValue=[self setButtonColorOnSelected:18 boolValue:myBoolDatingRomanceValue addDictValue:DatingRomanceValue];
}
- (IBAction)checkboxSeparationDivorceClick:(id)sender {
    myBoolSeparationDivorceValue=[self setButtonColorOnSelected:19 boolValue:myBoolSeparationDivorceValue addDictValue:SeparationDivorceValue];
}
- (IBAction)checkboxSubstanceAbuseClick:(id)sender {
    myBoolSubstanceAbuseValue=[self setButtonColorOnSelected:20 boolValue:myBoolSubstanceAbuseValue addDictValue:SubstanceAbuseValue];
}
- (IBAction)checkboxSexualTraumaClick:(id)sender {
    myBoolSexualTraumaValue=[self setButtonColorOnSelected:21 boolValue:myBoolSexualTraumaValue addDictValue:SexualTraumaValue];
    
}


// Added By:Zeenath
// Added Date:17/07/16
// Description:Show validation for the text fields
-(void)SetValidationSetting:(UITextField *)textField errorIcon:(UIButton *)errorBtn indicationIcon:(UIImageView *)indicationIcon validationMessage:(NSString *)validationMessage imageIs:(NSString *)imageIs viewField:(UIView *)viewIs{
    
    [textField setValue:[UIColor redColor] forKeyPath:@"_placeholderLabel.textColor"];
    textField.placeholder=validationMessage;
    errorBtn.hidden=NO;
    UIImage *image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:imageIs ofType:@"png"]];
    indicationIcon.image = image;
    viewIs.layer.borderColor = [[UIColor redColor]CGColor];
    viewIs.layer.borderWidth = 1.0f;
    
    
}

// Added By:Zeenath
// Added Date:17/07/16
// Description:Regular exprssion for the namefield
- (BOOL)validateNameField:(NSString*)name
{
    NSString *nameRegex = @"^[a-zA-Z ]*$";
    NSPredicate *nameTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", nameRegex];
    return [nameTest evaluateWithObject:name];
}

// Added By:Zeenath
// Added Date:17/07/16
// Description:Function Called when the text in the textfield is changed
-(void) textFielddidChange:(UITextField *)theTextField
{
    
    if([theTextField isEqual:_nameText])
    {
        [self RemoveValidationSetting:_nameText errorIcon:_nameCloseButton indicationIcon:_nameIcon HintText:@"Name" imageIs:@"user" viewField:_nameView];
        
    }
    else if([theTextField isEqual:_genderText]){
        [self RemoveValidationSetting:_genderText errorIcon:_genderCloseButton indicationIcon:_genderIcon HintText:@"Gender" imageIs:@"user" viewField:_GenderView];
    }
    else if([theTextField isEqual:_specializationText]){
        [self RemoveValidationSetting:_specializationText errorIcon:_specialisationCloseButton indicationIcon:_specialisationIcon HintText:@"Specialty" imageIs:@"user" viewField:_specializationView];
    }
    else if([theTextField isEqual:_availableOnText]){
        [self RemoveValidationSetting:_availableOnText errorIcon:_availableCloseButton indicationIcon: nil HintText:@"Available On" imageIs:nil viewField:_availableOnView];
    }
    else if([theTextField isEqual:_dateText]){
        [self RemoveValidationSetting:_dateText errorIcon:_dateCloseButton indicationIcon:_dateIcon HintText:@"Date" imageIs:@"dob" viewField:_dateView];
    }
    else if([theTextField isEqual:_timeFromText]){
        [self RemoveValidationSetting:_timeFromText errorIcon:_timeFromCloseButton indicationIcon:nil HintText:@"Time From" imageIs:nil viewField:_timeFromView];
    }
    
    else if([theTextField isEqual:_timeToText]){
        [self RemoveValidationSetting:_timeToText errorIcon:_timeToCloseButton indicationIcon:nil HintText:@"Time To" imageIs:nil viewField:_timeToView];
    }
    
    
    
}


// Added By:Zeenath
// Added Date:17/07/16
// Description:Remove validation for the text fields
-(void)RemoveValidationSetting:(UITextField *)textField errorIcon:(UIButton *)errorBtn indicationIcon:(UIImageView *)indicationIcon HintText:(NSString *)hintTextMessage imageIs:(NSString *)imageIs viewField:(UIView *)view{
    
    [textField setValue:[UIColor  colorWithRed:(112/255.0) green:(112/255.0) blue:(112/255.0) alpha:1] forKeyPath:@"_placeholderLabel.textColor"];
    textField.placeholder=hintTextMessage;
    errorBtn.hidden=YES;
    UIImage *image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:imageIs ofType:@"png"]];
    indicationIcon.image = image;
    [self setBorder:view];
    
}


// Added By:Zeenath
// Added Date:17/07/16
// Description:Remove validation for the text fields on click if close button in the textfield
- (IBAction)nameCloseClick:(id)sender {
    [self RemoveValidationSetting:_nameText errorIcon:_nameCloseButton indicationIcon:_nameIcon HintText:@"Name" imageIs:@"user" viewField:_nameView];
}
- (IBAction)genderCloseClick:(id)sender {
    [self RemoveValidationSetting:_genderText errorIcon:_genderCloseButton indicationIcon:_genderIcon HintText:@"Gender" imageIs:@"user" viewField:_GenderView];
}
- (IBAction)specialisationCloseClick:(id)sender {
    [self RemoveValidationSetting:_specializationText errorIcon:_specialisationCloseButton indicationIcon:_specialisationIcon HintText:@"Specialty" imageIs:@"user" viewField:_specializationView];
}
- (IBAction)availableOnCloseClick:(id)sender {
    [self RemoveValidationSetting:_availableOnText errorIcon:_availableCloseButton indicationIcon: nil HintText:@"Available On" imageIs:nil viewField:_availableOnView];
}
- (IBAction)dateCloseClick:(id)sender {
    [self RemoveValidationSetting:_dateText errorIcon:_dateCloseButton indicationIcon:_dateIcon HintText:@"Date" imageIs:@"dob" viewField:_dateView];
}

- (IBAction)timefromCloseClick:(id)sender {
    [self RemoveValidationSetting:_timeFromText errorIcon:_timeFromCloseButton indicationIcon:nil HintText:@"Time From" imageIs:nil viewField:_timeFromView];
}

- (IBAction)timetoCloseClick:(id)sender {
    [self RemoveValidationSetting:_timeToText errorIcon:_timeToCloseButton indicationIcon:nil HintText:@"Time To" imageIs:nil viewField:_timeToView
     ];
    
}


// Added By:Zeenath
// Added Date:17/07/16
// Description:Show the gender in the pickerview on click of dropdown click
- (IBAction)genderDropdownClick:(id)sender {
    [self resignSoftKeyboard];
    
    pickerArray = [[NSArray alloc]initWithObjects:@"Male",
                   @"Female",@"Either", nil];
    [self.pickerView reloadAllComponents];
    _pickerBackView.hidden=NO;
    _pickerView.hidden=NO;
    _datePickerButtonsView.hidden=YES;
    _datePicker.hidden=YES;
    _timePickerView.hidden=YES;
    
    clickedbutton=@"genderField";
    [self RemoveValidationSetting:_genderText errorIcon:_genderCloseButton indicationIcon:_genderIcon HintText:@"Gender" imageIs:@"user" viewField:_GenderView];
}


// Added By:Zeenath
// Added Date:17/07/16
// Description:Show the specialisation in the pickerview on click of dropdown click
- (IBAction)specialisationDropdownClick:(id)sender {
    [self resignSoftKeyboard];
    
    pickerArray = [[NSArray alloc]initWithObjects:@"Phd/MD",
                   @"PSYD",@"MSW",@"LCSW",@"Licensed Counselor", nil];
    [self.pickerView reloadAllComponents];
    _pickerBackView.hidden=NO;
    _pickerView.hidden=NO;
    _datePickerButtonsView.hidden=YES;
    _datePicker.hidden=YES;
    _timePickerView.hidden=YES;
    
    clickedbutton=@"specializationField";
    [self RemoveValidationSetting:_specializationText errorIcon:_specialisationCloseButton indicationIcon:_specialisationIcon HintText:@"Specialty" imageIs:@"user" viewField:_specializationView];
}

// Added By:Zeenath
// Added Date:17/07/16
// Description:Show the availability in the pickerview on click of dropdown click
- (IBAction)availableOnDropdownClick:(id)sender {
    [self resignSoftKeyboard];
    
    pickerArray = availablepickerArray;
    [self.pickerView reloadAllComponents];
    _pickerBackView.hidden=NO;
    _pickerView.hidden=NO;
    _datePickerButtonsView.hidden=YES;
    _datePicker.hidden=YES;
    _timePickerView.hidden=YES;
    
    clickedbutton=@"availableOnField";
    [self RemoveValidationSetting:_availableOnText errorIcon:_availableCloseButton indicationIcon: nil HintText:@"Available On" imageIs:nil viewField:_availableOnView];
    
}

// Added By:Zeenath
// Added Date:17/07/16
// Description:Show the datepicker on click of dropdown click
- (IBAction)dateDropdownClick:(id)sender {
    [self resignSoftKeyboard];
    
    _pickerBackView.hidden=NO;
    _datePicker.hidden=NO;
    _pickerView.hidden=YES;
    _timePickerView.hidden=YES;
    clickedbutton=@"dateField";
    _datePicker.datePickerMode = UIDatePickerModeDate;
    _datePickerButtonsView.hidden=NO;
    [self RemoveValidationSetting:_dateText errorIcon:_dateCloseButton indicationIcon:_dateIcon HintText:@"Date" imageIs:@"dob" viewField:_dateView];
}

// Added By:Zeenath
// Added Date:17/07/16
// Description:Show the timepicker on click of dropdown click
- (IBAction)timeFromDropdownClick:(id)sender {
    [self resignSoftKeyboard];
    
    _pickerBackView.hidden=NO;
    _datePicker.hidden=YES;
    _pickerView.hidden=YES;
    _timePickerView.hidden=NO;
    clickedbutton=@"timeFromField";
    [self RemoveValidationSetting:_timeFromText errorIcon:_timeFromCloseButton indicationIcon:nil HintText:@"Time From" imageIs:nil viewField:_timeFromView];
}
- (IBAction)timeToDropdownClick:(id)sender {
    [self resignSoftKeyboard];
    
    _pickerBackView.hidden=NO;
    _datePicker.hidden=YES;
    _pickerView.hidden=YES;
    _timePickerView.hidden=NO;
    clickedbutton=@"timeToField";
    [self RemoveValidationSetting:_timeToText errorIcon:_timeToCloseButton indicationIcon:nil HintText:@"Time To" imageIs:nil viewField:_timeToView
     ];
}


// Added By:Nalina
// Added Date:17/08/16
// Description: convert the time format from 12 hours to 24 hours
-(NSString *)Convert12FormatTo24Format:(NSString *)time{
    NSString *HourString;
    if (![time isEqualToString:@""]) {
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"hh:mm a"];
        NSDate *amPmDate = [formatter dateFromString:time];
        [formatter setDateFormat:@"HH:mm"];
        HourString = [formatter stringFromDate:amPmDate];
    }else{
        HourString = @"";
    }
    
    return HourString;
}

// Added By:Nalina
// Added Date:17/08/16
// Description: validation and service call functionality

- (IBAction)searchClick:(id)sender {
    [self resignSoftKeyboard];
    
    //GlobalFunction *globalValues=[[GlobalFunction alloc]init];
    NSMutableDictionary *searchproviderData = [[NSMutableDictionary alloc] init];
    
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"MM/dd/yyyy"];
    NSString *todayDate= [dateFormatter stringFromDate:[NSDate date]];
    
    NSString *CurrentDateTime;
    NSString *NewDateTime;
    NSDate *date = [NSDate date];
    NSDateFormatter *df =[[NSDateFormatter alloc]init];
    [df setDateFormat:@"HH:mm:ss"];
    CurrentDateTime = [df stringFromDate:date];
    
    
    if(!([self validateNameField:_nameText.text])) {
        
        _nameText.text=@"";
        [self SetValidationSetting:_nameText errorIcon:_nameCloseButton indicationIcon:_nameIcon validationMessage:[[GlobalFunction sharedInstance].arrayOfAlerts objectAtIndex:43] imageIs:@"error-user" viewField:_nameView];
    }
    if (![_nameText.text isEqualToString:@""]) {
        
        // Added By:Zeenath
        // Added Date:15/09/16
        // Description: trimming the text to remove the space from start and end of the text
        [searchproviderData setObject:[_nameText.text stringByTrimmingCharactersInSet:
                                       [NSCharacterSet whitespaceCharacterSet]] forKey:@"name"];
    }
    if (![_genderText.text isEqualToString:@""]) {
        [searchproviderData setObject:_genderText.text forKey:@"gender"];
    }
    if (![_specializationText.text isEqualToString:@""]) {
        [searchproviderData setObject:_specializationText.text forKey:@"specialization"];
    }
    
    [searchproviderData setValue:[NSNumber numberWithInt:0] forKey:@"ratingFrom"];
    
    [searchproviderData setValue:[NSNumber numberWithInt:ratingSelectedValue] forKey:@"ratingTo"];
    
    
    if (practiceExpertise.count>0) {
        [searchproviderData setObject:practiceExpertise forKey:@"expertise"];
    }
    
    if (available==NO) {
        if(![_nameText.placeholder isEqualToString:@"Please enter a valid Name."])
        {
            if(availableID != nil)
            {
                [searchproviderData setObject:availableID forKey:@"availableOn"];
            }
            
            if (![_dateText.text isEqualToString:@""]) {
                [searchproviderData setObject:_dateText.text forKey:@"availableDate"];
            }else{
                [searchproviderData setObject:todayDate forKey:@"availableDate"];
            }
            
            if (![_timeFromText.text isEqualToString:@""]) {
                [searchproviderData setObject:[self Convert12FormatTo24Format:_timeFromText.text] forKey:@"availableStartDate"];
            }else{
                
                [searchproviderData setObject:CurrentDateTime forKey:@"availableStartDate"];
            }
            
            if (![_timeToText.text isEqualToString:@""]) {
                [searchproviderData setObject:[self Convert12FormatTo24Format:_timeToText.text] forKey:@"availableEndDate"];
            }
            
            
            
            [self ServiceCall:searchproviderData];
        }
    }
    else
    {
        
        int hoursToAdd = 1;
        NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
        NSDateComponents *components = [[NSDateComponents alloc] init];
        [components setHour:hoursToAdd];
        NSDate *newDate= [calendar dateByAddingComponents:components toDate:date options:0];
        NewDateTime = [df stringFromDate:newDate];
        
        if(![_nameText.placeholder isEqualToString:@"Please enter a valid Name."]){
            //[searchproviderData setObject:@"false" forKey:@"availableNow"];
            
            [searchproviderData setObject:todayDate forKey:@"availableDate"];
            [searchproviderData setObject:CurrentDateTime forKey:@"availableStartDate"];
            [searchproviderData setObject:NewDateTime forKey:@"availableEndDate"];
            
            
            [self ServiceCall:searchproviderData];
            
        }
    }
    
}

// Added By:Nalina
// Added Date:17/08/16
// Description:  service to send the availability
-(void)ServiceCall:(NSDictionary *)searchProviderData{
    
    [self startLoadingIndicator];
    AppDelegate *appdelegate= (AppDelegate *)[[UIApplication sharedApplication]delegate];
    
    NSString *marketSearchUrl=[appdelegate.serviceURL stringByAppendingString:@"api/ProviderSearch/MarketSerach"];
    [[GlobalFunction sharedInstance] getServerResponseAfterLogin:marketSearchUrl method:@"POST" param:searchProviderData withCallback:^(NSInteger statusCode, NSDictionary *response, NSError *error)
     {
         
         // GlobalFunction *globalValues=[[GlobalFunction alloc]init];
         NSString *message;
         
         if (statusCode == 200)
         {
             [self stopLoadingIndicator];
             ProviderMarketPlaceViewController *vc=[self.storyboard instantiateViewControllerWithIdentifier:@"ProviderMarketPlace"];
             NSMutableArray *responseArray=[response mutableCopy];
             vc.providerDataArray=responseArray;
             //[self.navigationController pushViewController:vc animated:YES];
             [self presentViewController:vc animated:NO completion:nil];
             
         }else if(statusCode==404){
             
             _alert = [UIAlertController
                       alertControllerWithTitle:@""
                       message:[[GlobalFunction sharedInstance].arrayOfAlerts objectAtIndex:78]
                       preferredStyle:UIAlertControllerStyleAlert];
             
             UIAlertAction* okButton = [UIAlertAction
                                        actionWithTitle:@"OK"
                                        style:UIAlertActionStyleDefault
                                        handler:^(UIAlertAction * action) {
                                            [self stopLoadingIndicator];
                                        }];
             [_alert addAction:okButton];
             [self presentViewController:_alert animated:YES completion:nil];
             
         }else{
             
             if(statusCode==403||statusCode==503){
                 
                 message=[[GlobalFunction sharedInstance].arrayOfAlerts objectAtIndex:74];
                 
             }else if(statusCode==401){
                 
                 message=[[GlobalFunction sharedInstance].arrayOfAlerts objectAtIndex:63];
                 
             }else{
                 NSDictionary *messagearray=[response objectForKey:@ "modelState"];
                 NSArray *dictValues=[messagearray allValues];
                 NSArray *msgarray=[dictValues objectAtIndex:0];
                 message=[msgarray objectAtIndex:0];
                 
             }
             
             _alert = [UIAlertController
                       alertControllerWithTitle:@""
                       message:message
                       preferredStyle:UIAlertControllerStyleAlert];
             
             UIAlertAction* okButton = [UIAlertAction
                                        actionWithTitle:@"OK"
                                        style:UIAlertActionStyleDefault
                                        handler:^(UIAlertAction * action) {
                                            [self stopLoadingIndicator];
                                        }];
             [_alert addAction:okButton];
             [self presentViewController:_alert animated:YES completion:nil];
         }
     }];
    
}



// Added By:Zeenath
// Added Date:17/08/16
// Description:  Called on click of back button
- (IBAction)backClick:(id)sender {
    [self resignSoftKeyboard];
    
    //[self.navigationController popViewControllerAnimated:YES];
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

//Added by: Nalina
//Added date: 18/08/16
//Description: To start and stop the activity indicator.

-(void)startLoadingIndicator
{
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGFloat screenWidth = screenRect.size.width;
    CGFloat screenHeight = screenRect.size.height;
    _loadingView= [[UIView alloc] initWithFrame: CGRectMake ( 0, 20, screenWidth, screenHeight)];
    _loadingView.backgroundColor = [UIColor colorWithRed:0.0/255.0 green:0.0/255.0 blue:0.0/255.0 alpha:0.25];
    [self.view addSubview:_loadingView];
    UIActivityIndicatorView *spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    spinner.color=[UIColor whiteColor];
    [self.loadingView addSubview:spinner];
    [self.loadingView bringSubviewToFront:spinner];
    spinner.hidesWhenStopped = YES;
    spinner.center = self.loadingView.center;
    [spinner startAnimating];
}

-(void)stopLoadingIndicator
{
    _loadingView.hidden=YES;
}

-(void) setBorderColor:(int)tagName{
    UIButton *cancelBtn = (UIButton *) [self.view viewWithTag:tagName];
    cancelBtn.layer.borderColor = [UIColor colorWithRed:246.0/255.0 green:108.0/255.0 blue:118.0/255.0 alpha:1].CGColor;
}

-(bool) setButtonColorOnSelected:(int)tagName boolValue:(bool)boolValue addDictValue:(int)addDictValue {
    
    
    UIButton *expertiseBtn = (UIButton *) [self.view viewWithTag:tagName];
    
    if(boolValue==YES){
        expertiseBtn.layer.backgroundColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0  alpha:1].CGColor;
        
        [expertiseBtn setTitleColor:[UIColor colorWithRed:118.0/255.0 green:183.0/255.0 blue:189.0/255.0  alpha:1] forState:UIControlStateNormal];
        
        UIImage *image = [UIImage imageNamed: @"plusIcon.png"];
        //cancelBtn.image=image;
        
        [expertiseBtn setImage:image forState:UIControlStateNormal];
        
        [practiceExpertise removeObject: [NSNumber numberWithInt: addDictValue]];
        
        return NO;
    }else{
        expertiseBtn.layer.backgroundColor = [UIColor colorWithRed:118.0/255.0 green:183.0/255.0 blue:189.0/255.0 alpha:1].CGColor;
        
        [expertiseBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
        UIImage *image = [UIImage imageNamed: @"rightMark.png"];
        
        [expertiseBtn setImage:image forState:UIControlStateNormal];
        
        [practiceExpertise addObject: [NSNumber numberWithInt: addDictValue]];
        
        
        return YES;
        
    }
}

-(void) setExpertiseButtonBorderColor:(int)tagName{
    UIButton *cancelBtn = (UIButton *) [self.view viewWithTag:tagName];
    cancelBtn.layer.borderColor = [UIColor colorWithRed:197.0/255.0 green:224.0/255.0 blue:224.0/255.0 alpha:1].CGColor;
}

@end
