//
//  WeekendAvailabilitypopupSceneViewController.h
//  EmotiLink
//
//  Created by Star on 4/11/17.
//  Copyright © 2017 Stark. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WeekendAvailabilitypopupSceneViewController : UIViewController
{
    NSString *clickedbutton;
    NSArray *dataSource;
}



@property (strong, nonatomic) IBOutlet UILabel *fromTimeLabel;


@property (strong, nonatomic) IBOutlet UILabel *toTimeLabel;


- (IBAction)yesClick:(id)sender;


- (IBAction)noClick:(id)sender;


@property (weak, nonatomic) IBOutlet UIView *pickerBackView;
@property (weak, nonatomic) IBOutlet UIPickerView *pickerView;

@property (weak, nonatomic) IBOutlet UITextField *fromTime;

@property (weak, nonatomic) IBOutlet UITextField *toTime;





@end
