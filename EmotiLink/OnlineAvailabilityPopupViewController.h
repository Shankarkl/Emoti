//
//  OnlineAvailabilityPopupViewController.h
//  EmotiLink
//
//  Created by Star on 4/11/17.
//  Copyright © 2017 Stark. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol onlineavailpopupViewControllerDelegate <NSObject>
@required
- (void)dataFromController:(NSString *)data;
@end
@interface OnlineAvailabilityPopupViewController : UIViewController
{
    NSArray *pickerArray;
    NSArray *dataSource;
    NSMutableDictionary *availableTimeDict;
    NSString *data;
}


@property (nonatomic, weak) id<onlineavailpopupViewControllerDelegate> delegate;

- (IBAction)ConfirmBtn:(id)sender;

- (IBAction)CancelBtn:(id)sender;
@property (weak, nonatomic) IBOutlet UIView *pickerBackView;
@property (weak, nonatomic) IBOutlet UIPickerView *pickerView;
@property (strong, nonatomic) UIView *loadingView;
@property (strong, nonatomic) UIAlertController *alert;
@property (weak, nonatomic) IBOutlet UITextField *availabiltyTypeText;
@property (weak, nonatomic) IBOutlet UITextField *dumytextfield;

@end
