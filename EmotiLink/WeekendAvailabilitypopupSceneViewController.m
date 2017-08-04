//
//  WeekendAvailabilitypopupSceneViewController.m
//  EmotiLink
//
//  Created by Star on 4/11/17.
//  Copyright © 2017 Stark. All rights reserved.
//

#import "WeekendAvailabilitypopupSceneViewController.h"

@interface WeekendAvailabilitypopupSceneViewController ()

@end

@implementation WeekendAvailabilitypopupSceneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.modalPresentationStyle = UIModalPresentationCurrentContext;
    // Do any additional setup after loading the view.
    
    [self setBorderColor:5];
    
    UITapGestureRecognizer *singleFingerTap =
    [[UITapGestureRecognizer alloc] initWithTarget:self
                                            action:@selector(handleSingleTapped:)];
    [self.pickerBackView addGestureRecognizer:singleFingerTap];
    
    [self.fromTime addTarget:self action:@selector(monthClick:) forControlEvents:UIControlEventEditingDidBegin];
    
     [self.toTime addTarget:self action:@selector(toTimeClick:) forControlEvents:UIControlEventEditingDidBegin];
    
}

-(void) setBorderColor:(int)tagName{
    UIButton *cancelBtn = (UIButton *) [self.view viewWithTag:tagName];
    cancelBtn.layer.borderColor = [UIColor colorWithRed:246.0/255.0 green:108.0/255.0 blue:118.0/255.0 alpha:1].CGColor;
}




- (void)monthClick:(UITapGestureRecognizer *)recognizer {
    [self resignSoftKeyboard];
    dataSource=[[NSArray alloc]initWithObjects:@"01",
                @"02",@"03",@"04",@"05", @"06",
                @"07",@"08",@"09",@"10",@"11",
                @"12", nil];
    [self.pickerView reloadAllComponents];
    _pickerBackView.hidden=NO;
    clickedbutton=@"FromTime";
    [self setBorder:_pickerView];
    [_fromTime setValue:[UIColor  colorWithRed:(112/255.0) green:(112/255.0) blue:(112/255.0) alpha:1] forKeyPath:@"_placeholderLabel.textColor"];
    _fromTime.placeholder=@"";
    
}

- (void)toTimeClick:(UITapGestureRecognizer *)recognizer {
    [self resignSoftKeyboard];
    dataSource=[[NSArray alloc]initWithObjects:@"01",
                @"02",@"03",@"04",@"05", @"06",
                @"07",@"08",@"09",@"10",@"11",
                @"12", nil];
    [self.pickerView reloadAllComponents];
    _pickerBackView.hidden=NO;
    clickedbutton=@"totime";
    [_toTime setValue:[UIColor  colorWithRed:(112/255.0) green:(112/255.0) blue:(112/255.0) alpha:1] forKeyPath:@"_placeholderLabel.textColor"];
    _toTime.placeholder=@"";
    
}







- (void)handleSingleTapped:(UITapGestureRecognizer *)recognizer {
    _pickerBackView.hidden=YES;
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
    
    
    if([clickedbutton isEqualToString:@"FromTime"])
    {
         [_fromTime setText:[dataSource objectAtIndex:row]];
    }
    
    else if([clickedbutton isEqualToString:@"totime"]){
         [_toTime setText:[dataSource objectAtIndex:row]];
    }

 _pickerBackView.hidden=YES;
    [self resignSoftKeyboard];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)resignSoftKeyboard{
    [_fromTime resignFirstResponder];
     [_toTime resignFirstResponder];
}




-(void)setBorder:(UIView *)img
{
    
    img.layer.borderColor = [[UIColor colorWithRed:228.0/255.0 green:109.0/255.0 blue:175.0/255.0 alpha:1.0]CGColor];
    img.layer.borderWidth = 1.0f;
    
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)yesClick:(id)sender {
}

- (IBAction)noClick:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
