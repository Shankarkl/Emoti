//
//  ProviderSignUpThirdViewController.h
//  
//
//  Created by Star-K on 2017-03-18.
//
//

#import <UIKit/UIKit.h>

@interface ProviderSignUpThirdViewController : UIViewController
{
    NSArray *dataSource;
}

@property (weak, nonatomic) IBOutlet UIView *backgroundThirdSignUpView;

@property (weak, nonatomic) IBOutlet UIView *qualificationView;
@property (weak, nonatomic) IBOutlet UIView *licencenumberView;
@property (weak, nonatomic) IBOutlet UIView *lanuguagespokenView;

@property (strong, nonatomic) NSMutableDictionary * userDetails;

@property (strong, nonatomic) NSMutableDictionary * prepopulateData;
@property (weak, nonatomic) IBOutlet UITextField *qualificationTextField;

@property (weak, nonatomic) IBOutlet UITextField *licenceTextField;

@property (weak, nonatomic) IBOutlet UITextField *qualificationtxt;

- (IBAction)qualicationCloseButton:(id)sender;

- (IBAction)licencenumberCloseButton:(id)sender;

- (IBAction)languageCloseButton:(id)sender;

@property (strong, nonatomic) IBOutlet UIButton *languagesSpokenClick;



@property (weak, nonatomic) IBOutlet UITextField *languagespokenTextField;

@property (weak, nonatomic) IBOutlet UIImageView *qualificationIcon;
@property (weak, nonatomic) IBOutlet UIImageView *licenceIcon;
@property (weak, nonatomic) IBOutlet UIImageView *languageIcon;

@property (weak, nonatomic) IBOutlet UIButton *qualificationCloseButton;

@property (weak, nonatomic) IBOutlet UIButton *licencenumberCloseButton;


@property (weak, nonatomic) IBOutlet UIButton *languageCloseButton;


@property (strong, nonatomic) IBOutlet UIButton *qualificationDropIcon;

- (IBAction)qualificationDropClick:(id)sender;


- (IBAction)backclick:(id)sender;
- (IBAction)nextclick:(id)sender;
- (IBAction)backarrow:(id)sender;

@property (weak, nonatomic) IBOutlet UIView *pickerBackView;
@property (weak, nonatomic) IBOutlet UIPickerView *pickerView;

@end
