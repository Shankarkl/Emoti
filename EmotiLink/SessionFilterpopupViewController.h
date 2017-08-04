//
//  SessionFilterpopupViewController.h
//  EmotiLink
//
//  Created by Star on 4/18/17.
//  Copyright © 2017 Stark. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SessionFilterpopupViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIButton *sessionHistoryView;
- (IBAction)CancelBtn:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *ScheduledApointments;
@property (weak, nonatomic) IBOutlet UIButton *SessionApproval;
@property (weak, nonatomic) IBOutlet UIButton *CancelAppointment;
@property (weak, nonatomic) IBOutlet UIButton *RejectAppointment;
- (IBAction)SessionHistoryBtn:(id)sender;
- (IBAction)ScheduleAppointmentBtn:(id)sender;
- (IBAction)sessionApprovalBtn:(id)sender;
- (IBAction)CancelAppointmentBtn:(id)sender;
- (IBAction)RejectAppointmentBtn:(id)sender;


@end
