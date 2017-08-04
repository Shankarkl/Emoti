//
//  OnlineAvailabilityPopupViewController.m
//  EmotiLink
//
//  Created by Star on 4/11/17.
//  Copyright © 2017 Stark. All rights reserved.
//

#import "OnlineAvailabilityPopupViewController.h"
#import "AppDelegate.h"
#import "GlobalFunction.h"

@interface OnlineAvailabilityPopupViewController ()<UIPageViewControllerDelegate>

@end

@implementation OnlineAvailabilityPopupViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setBorderColor:5];
    
    _dumytextfield.hidden = YES;
    
    self.modalPresentationStyle = UIModalPresentationCurrentContext;
    // Do any additional setup after loading the view.
    pickerArray = [[NSArray alloc]initWithObjects:@"Half an hour",
                   @"One hour",@"One & half hour",@"Two hours",@"Two & half hours",@"Three hours",@"Three & half hours", nil];
    UITapGestureRecognizer *singleFingerTap =
    [[UITapGestureRecognizer alloc] initWithTarget:self
                                            action:@selector(handleSingleTapped:)];
    [self.pickerBackView addGestureRecognizer:singleFingerTap];
    
    [self.availabiltyTypeText addTarget:self action:@selector(monthClick:) forControlEvents:UIControlEventEditingDidBegin];
     availableTimeDict=[[NSMutableDictionary alloc]init];
     availableTimeDict=[self GetTimeSpan:30];
}

-(void) setBorderColor:(int)tagName{
    UIButton *cancelBtn = (UIButton *) [self.view viewWithTag:tagName];
    cancelBtn.layer.borderColor = [UIColor colorWithRed:246.0/255.0 green:108.0/255.0 blue:118.0/255.0 alpha:1].CGColor;
}


- (void)monthClick:(UITapGestureRecognizer *)recognizer {
    [self resignSoftKeyboard];
    dataSource=[[NSArray alloc]initWithObjects:@"Half an hour",
                @"One hour",@"One & half hour",@"Two hours",@"Two & half hours",@"Three hours",@"Three & half hours", nil];
    
    [self.pickerView reloadAllComponents];
    _pickerBackView.hidden=NO;
    
    [self setBorder:_pickerView];
    [_availabiltyTypeText setValue:[UIColor  colorWithRed:(112/255.0) green:(112/255.0) blue:(112/255.0) alpha:1] forKeyPath:@"_placeholderLabel.textColor"];
    _availabiltyTypeText.placeholder=@"";
}


- (void)handleSingleTapped:(UITapGestureRecognizer *)recognizer {
    _pickerBackView.hidden=YES;
    [self.dumytextfield becomeFirstResponder];
}

//Return number of section in picker
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)thePickerView {
    
    return 1;
}

//Return the number of rows count to display in picker
- (NSInteger)pickerView:(UIPickerView *)thePickerView numberOfRowsInComponent:(NSInteger)component {
    
    return dataSource.count;
    
}

//Return the data to display in picker
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:
(NSInteger)row forComponent:(NSInteger)component{
    return [dataSource objectAtIndex:row];
}

//Returns selected picker data
- (void)pickerView:(UIPickerView *)thePickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    [_pickerView selectRow:0 inComponent:0 animated:YES];
    [_availabiltyTypeText setText:[dataSource objectAtIndex:row]];
    if ([[dataSource objectAtIndex:row] isEqualToString:@"Half an hour"]) {
        availableTimeDict=[self GetTimeSpan:30];
    }else if ([[dataSource objectAtIndex:row] isEqualToString:@"One hour"]){
        availableTimeDict=[self GetTimeSpan:60];
    }else if ([[dataSource objectAtIndex:row] isEqualToString:@"One & half hour"]){
        availableTimeDict=[self GetTimeSpan:90];
    }else if ([[dataSource objectAtIndex:row] isEqualToString:@"Two hours"]){
        availableTimeDict=[self GetTimeSpan:120];
    }else if ([[dataSource objectAtIndex:row] isEqualToString:@"Two & half hours"]){
        availableTimeDict=[self GetTimeSpan:150];
    }else if ([[dataSource objectAtIndex:row] isEqualToString:@"Three hours"]){
        availableTimeDict=[self GetTimeSpan:180];
    }else if ([[dataSource objectAtIndex:row] isEqualToString:@"Three & half hours"]){
        availableTimeDict=[self GetTimeSpan:210];
    }
    
     [self.dumytextfield becomeFirstResponder];
    _pickerBackView.hidden=YES;
    [self resignSoftKeyboard];
    
}

-(void)resignSoftKeyboard{
    [_dumytextfield resignFirstResponder];
    [_availabiltyTypeText resignFirstResponder];
    
}

-(void)setBorder:(UIView *)img
{
    
    img.layer.borderColor = [[UIColor colorWithRed:228.0/255.0 green:109.0/255.0 blue:175.0/255.0 alpha:1.0]CGColor];
    img.layer.borderWidth = 1.0f;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)ConfirmBtn:(id)sender {
    AppDelegate *app= (AppDelegate *)[[UIApplication sharedApplication]delegate];
    
    /************** Set online available service ******************/
    NSString *onlineAvailableUrl=[app.serviceURL stringByAppendingString:@"api/Provider/OnlineAvailability"];
    [[GlobalFunction sharedInstance] getServerResponseAfterLogin:onlineAvailableUrl method:@"POST" param:availableTimeDict withCallback:^(NSInteger statusCode, NSDictionary *response, NSError *error)
     {
         
         //   GlobalFunction *globalValues=[[GlobalFunction alloc]init];
         NSString *message;
         
         if (statusCode == 200)
         {
            
             
             NSMutableDictionary *data=[[NSMutableDictionary alloc]initWithDictionary:[app usersDetails]];
             
             NSMutableDictionary *dataStatus = [[data valueForKey:@"providerStatus"] mutableCopy];
             
             [dataStatus setObject:[availableTimeDict objectForKey:@"startTime"] forKey:@"availableFrom"];
             [dataStatus setObject:[availableTimeDict objectForKey:@"endTime"] forKey:@"availableTill"];
             
             
             [app.usersDetails removeObjectForKey:@"providerStatus"];
             [app.usersDetails setObject:dataStatus forKey:@"providerStatus"];
             
             if ([_delegate respondsToSelector:@selector(dataFromController:)])
             {
                 [_delegate dataFromController:@"200"];
             }
             

             
             [self dismissViewControllerAnimated:YES completion:nil];
                         /*  message=[globalValues.arrayOfAlerts objectAtIndex:64];
              
              _alert = [UIAlertController
              alertControllerWithTitle:@""
              message:message
              preferredStyle:UIAlertControllerStyleAlert];
              
              UIAlertAction* okButton = [UIAlertAction
              actionWithTitle:@"OK"
              style:UIAlertActionStyleDefault
              handler:^(UIAlertAction * action) {
              
              }];
              [_alert addAction:okButton];
              [self presentViewController:_alert animated:YES completion: nil];*/
             
         }
         else {
             
             
             if(statusCode==403||statusCode==503||statusCode == 404){
                 
                 message=[[GlobalFunction sharedInstance].arrayOfAlerts objectAtIndex:74];
                 
             }else if(statusCode==401){
                 
                 message=[[GlobalFunction sharedInstance].arrayOfAlerts objectAtIndex:63];
                 
             }else{
                 
                 NSDictionary *messagearray=[response objectForKey:@ "modelState"];
                 NSArray *dictValues=[messagearray allValues];
                 NSArray *array=[dictValues objectAtIndex:0];
                 message=[array objectAtIndex:0];
             }
             
             _alert = [UIAlertController
                       alertControllerWithTitle:@""
                       message:message
                       preferredStyle:UIAlertControllerStyleAlert];
             
             UIAlertAction* okButton = [UIAlertAction
                                        actionWithTitle:@"OK"
                                        style:UIAlertActionStyleDefault
                                        handler:^(UIAlertAction * action) {
                                            
                                        }];
             [_alert addAction:okButton];
             [self presentViewController:_alert animated:YES completion: nil];
         }
         
     }];

}
-(NSMutableDictionary *)GetTimeSpan:(float)timetoadd{
    NSString *CurrentTime;
    NSString *newTime;
    NSDate *date = [NSDate date];
    NSDateFormatter *timeformat = [[NSDateFormatter alloc] init];
    timeformat.dateFormat = @"HH:mm:ss";
    CurrentTime = [timeformat stringFromDate:date];
    
    float hoursToAdd = timetoadd;
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *components = [[NSDateComponents alloc] init];
    [components setMinute:hoursToAdd];
    NSDate *newDate= [calendar dateByAddingComponents:components toDate:date options:0];
    newTime = [timeformat stringFromDate:newDate];
    
    NSMutableDictionary *onlineAvailableData = [[NSMutableDictionary alloc] init];
    [onlineAvailableData setObject:CurrentTime forKey:@"startTime"];
    [onlineAvailableData setObject:newTime forKey:@"endTime"];
    
    return onlineAvailableData;
}

- (IBAction)CancelBtn:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
