//
//  RejectAppointmentpopupViewController.h
//  EmotiLink
//
//  Created by Star on 4/11/17.
//  Copyright © 2017 Stark. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol RejectViewControllerDelegate <NSObject>
@required
- (void)dataFromController:(NSString *)data;
@end

@interface RejectAppointmentpopupViewController : UIViewController
{
    bool anotherAppointmentSelected;
    bool offerSelected;
    bool otherSelected;
    bool rescheduleSelected;
    bool donotEmotilinkSelected;
    bool otherRespSelected;
}
@property (nonatomic, weak) id<RejectViewControllerDelegate> delegate;
@property (nonatomic, retain) NSString *data;
@property (nonatomic, retain) NSString *headerTxt;
@property (strong, nonatomic) NSMutableDictionary * appointmentId;
@property (nonatomic, retain) NSMutableDictionary *providerIDValue;
@property (nonatomic, retain) NSString *AppointmentIDValue;
@property (nonatomic, retain) NSString *RescheduleAppointmentIDValue;
@property (strong, nonatomic) NSMutableArray * arrayValue;
@property (weak, nonatomic) IBOutlet UIButton *anotherappointment;
@property (strong, nonatomic) UIView *loadingView;
@property (strong, nonatomic) UIAlertController *alert;
@property (strong, nonatomic) NSString *comments;
@property (weak, nonatomic) IBOutlet UIButton *otherresponsibility;
@property (weak, nonatomic) IBOutlet UIButton *doesntmeet;
@property (weak, nonatomic) IBOutlet UIButton *donotemotilink;
@property (weak, nonatomic) IBOutlet UITableView *sessionHistoryTable;
@property (weak, nonatomic) IBOutlet UIButton *reschedule;

@property (weak, nonatomic) IBOutlet UIButton *otherbutton;

- (IBAction)CancelBtn:(id)sender;
- (IBAction)AnotherAppointmentBtn:(id)sender;
- (IBAction)OfferBtn:(id)sender;
- (IBAction)OtherBtn:(id)sender;
- (IBAction)RescheduleBtn:(id)sender;
- (IBAction)IdonotemotilinkBtn:(id)sender;

- (IBAction)ConfirmBtn:(id)sender;
- (IBAction)otherresponsibilityBtn:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *otheroption;

@end
