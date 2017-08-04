
/***************************************************************
 Page name:AppDelegate.h
 Created By:ZEENATH
 Created Date:29-06-16
 Description:Called when the application is loaded
 ***************************************************************/

#import <UIKit/UIKit.h>
#import "Reachability.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>{
    
    NSString *urlPath;
    Reachability *internetReachableFoo;
    NSString * ApplicationInternet;
    BOOL internetStatus;
}

- (BOOL)testInternetConnection;
-(void)displayNetworkAlert;

//Declaration of variables
@property (strong, nonatomic) NSData *deviceToken;
@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) UIView *view;
@property (strong, nonatomic) NSString *serviceURL;
@property (strong, nonatomic) NSString *checkIdelTimer;
@property (strong, nonatomic) NSString *imageURL;
@property (strong, nonatomic) UIAlertController *alert;
@property(strong) Reachability * googleReach;
@property(strong) Reachability * localWiFiReach;
@property(strong) Reachability * internetConnectionReach;
@property (nonatomic, strong) UIView *indicatorView;

@property (strong, nonatomic) NSString *accessToken;
@property(nonatomic,strong) NSMutableDictionary *usersDetails;
@property(nonatomic,strong) NSMutableDictionary *userOnlineSessionDetails;
@property(nonatomic,strong) NSMutableArray *questionArray;
@property(nonatomic,strong) NSMutableArray *questionIdArray;
@property(nonatomic,strong) NSMutableArray *availabilityArray;
@property(nonatomic,strong) NSMutableArray *availabilityId;
@property(nonatomic,strong) NSDictionary *availableData;
@property(nonatomic,strong) NSMutableDictionary *prepopulateData;

@property(nonatomic,strong) NSMutableDictionary *prepopulateDataProviderReg;
@property(nonatomic,strong) NSMutableDictionary *prepopulateDataProvider;
@property(nonatomic,strong) NSMutableDictionary *prepopulateDataProviderAboutYourself;
@property(nonatomic,strong) NSString *screenStatus;
@property(nonatomic,strong) NSString *screenState;
@property(nonatomic,strong) NSString *prepopulateImage;
@property(nonatomic,strong) NSMutableDictionary *todaysSchedules;
-(void)MessageBox:(NSString *)title message:(NSString *)messageText;

@property (nonatomic, strong) UIImage *cropProfileImage;

/***
 Added bY:ZEENATH
 Added for:uplaod profile pic
 Added on:03-08-16
 ***/

typedef void (^ASCompletionBlockAppdelegate)(NSString *response, NSError *error);

- (void)uploadBlobToContainer:(UIImage *)image name:(NSString *)name path:(NSInteger)path withCallback:(ASCompletionBlockAppdelegate)callback;


@end

