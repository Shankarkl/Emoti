//
//  AppointmentRequestOptionsPopUpViewController.h
//  EmotiLink
//
//  Created by Star on 5/5/17.
//  Copyright © 2017 Stark. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppointmentRequestOptionsPopUpViewController : UIViewController
{
      NSMutableDictionary *providerDetails;
     NSMutableDictionary *sendAppointmentData;
     NSMutableDictionary *sessionHistoryDictionary;
    NSNumber *appointmentID;
    NSMutableDictionary *onlineAvailableDict;
}


@property (strong, nonatomic) UIView *loadingView;
@property (strong, nonatomic) UIAlertController *alert;
@property(nonatomic, strong)NSMutableDictionary *providerDictionary;
@property(nonatomic,strong) NSMutableDictionary *postScheduleDetails;
- (IBAction)nowButtonClick:(id)sender;

- (IBAction)anotherDayButtonClick:(id)sender;

- (IBAction)cancelButtonClick:(id)sender;







@end
