/***************************************************************
 Page name: MyprovidersTableViewCell.h
 Created By:Nalina
 Created Date:12/07/16
 Description:my provider table methods and declaration file
 ***************************************************************/

#import <UIKit/UIKit.h>

@interface MyprovidersTableViewCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UIButton *AppointmentBtn;
- (IBAction)appointmentBtnClick:(id)sender;
@property (strong, nonatomic) IBOutlet UIImageView *profileImageView;
@property (strong, nonatomic) IBOutlet UILabel *firstNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *expertiseLabel;
@property (strong, nonatomic) IBOutlet UIButton *haveAnAppointment;

@property (strong, nonatomic) IBOutlet UIView *mainView;
@property (strong, nonatomic) IBOutlet UIButton *availableBtn;
@property (strong, nonatomic) IBOutlet UILabel *appointmentLabel;

@property (strong, nonatomic) IBOutlet UIButton *favoriteProviderIcon;
- (IBAction)favoriteProviderClick:(id)sender;
@property (strong, nonatomic) IBOutlet UIView *mainview;
@property (weak, nonatomic) IBOutlet UILabel *rateLabel;

@property (strong, nonatomic) IBOutlet UIView *providerInfoCellView;
@property (weak, nonatomic) IBOutlet UIView *availableBtnView;

@property (strong, nonatomic) IBOutlet UIImageView *forwardIcon;

@end
