/***************************************************************
 Page name:LoginViewController.h
 Created By:Nalina
 Created Date:29/6/16
 Description:Login view declaration of properties and methods file
 ***************************************************************/



#import <UIKit/UIKit.h>


@interface LoginViewController : UIViewController<UITextFieldDelegate,NSURLSessionDataDelegate>
{
    NSMutableArray *questionArray;
    NSMutableArray *questionId;
    NSMutableArray *userQutArray;
    NSMutableArray *userQutIdArray;
    NSInteger Data;
}
@property (strong, nonatomic) NSString *screenStatus;
@property(nonatomic, retain)NSString *emailText;
@property (strong, nonatomic) UIView *loadingView;
@property (strong, nonatomic) UIAlertController *alert;
@property(nonatomic,retain) NSMutableArray *questionArray;
@property(nonatomic,retain) NSMutableArray *questionId;
@property (strong, nonatomic) NSDictionary * userDetailsResponse;

@property (strong, nonatomic) IBOutlet UIView *usenameView;
@property (strong, nonatomic) IBOutlet UIView *passwordView;

    @property (weak, nonatomic) IBOutlet UIView *backgroundLoginView;

- (IBAction)loginClick:(id)sender;
@property (strong, nonatomic) IBOutlet UITextField *userNameTxt;
@property (strong, nonatomic) IBOutlet UITextField *passwordTxt;

@property (strong, nonatomic) IBOutlet UIImageView *userIcon;
@property (strong, nonatomic) IBOutlet UIImageView *passwordIcon;

- (IBAction)userErrorCloseBtn:(id)sender;
- (IBAction)passwordErrorCloseBtn:(id)sender;
@property (strong, nonatomic) IBOutlet UIImageView *userCloseBtn;
@property (strong, nonatomic) IBOutlet UIImageView *passwordCloseBtn;
- (IBAction)forgotPasword:(id)sender;

@property (strong, nonatomic) IBOutlet UIButton *infoIcon;
- (IBAction)infoIconClick:(id)sender;
- (void)CallLoginService:(NSString *)url loginParam:(NSString *)loginparams method:(NSString *)methods;

- (IBAction)callBack:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *eyeIconBtn;
- (IBAction)eyeBtnTouchUp:(id)sender;
- (IBAction)eyebtnTouchDown:(id)sender;

@end
