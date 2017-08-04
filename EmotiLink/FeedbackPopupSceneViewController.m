//
//  FeedbackPopupSceneViewController.m
//  EmotiLink
//
//  Created by Star on 4/11/17.
//  Copyright © 2017 Stark. All rights reserved.
//

#import "FeedbackPopupSceneViewController.h"
#import "AppDelegate.h"
#import "SessionSummaryViewController.h"
#import "GlobalFunction.h"

@interface FeedbackPopupSceneViewController ()

@end

@implementation FeedbackPopupSceneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    questionArray=[[NSMutableArray alloc] init];
    
    _feedbackTextView.text = @"Notes";
    _feedbackTextView.textColor = [UIColor darkGrayColor];
    _feedbackTextView.editable=true;
    
    self.modalPresentationStyle = UIModalPresentationCurrentContext;
    // Do any additional setup after loading the view.
    [self.feedbackquestions addTarget:self action:@selector(feedbackClick:) forControlEvents:UIControlEventEditingDidBegin];
    
    AppDelegate *appdelegate= (AppDelegate *)[[UIApplication sharedApplication]delegate];
    NSString *getUrl=[appdelegate.serviceURL stringByAppendingString:@"api/Feedback/GetFeedbackQuestion"];
    
    [[GlobalFunction sharedInstance] getServerResponseAfterLogin:getUrl method:@"GET" param:nil withCallback:^(NSInteger statusCode, NSDictionary *response, NSError *error)
     {
         
         
    if (statusCode == 200)
         {
             questionArray=[response mutableCopy];
             dataSource=[[NSMutableArray alloc]init];
             
             for(int i=0;i<questionArray.count;i++)
             {
                [dataSource addObject:  [[questionArray objectAtIndex: i] objectForKey:@"questions"]];
             }
             

             [self.pickerView reloadAllComponents];
             
         }else if(statusCode==404){
             
             _alert = [UIAlertController
                       alertControllerWithTitle:@""
                       message:[[GlobalFunction sharedInstance].arrayOfAlerts objectAtIndex:85]
                       preferredStyle:UIAlertControllerStyleAlert];
             
             UIAlertAction* okButton = [UIAlertAction
                                        actionWithTitle:@"OK"
                                        style:UIAlertActionStyleDefault
                                        handler:^(UIAlertAction * action) {
                                            [self.navigationController popViewControllerAnimated:YES];
                                        }];
             [_alert addAction:okButton];
             [self presentViewController:_alert animated:YES completion:nil];
             
         }else{
             NSString *message;
             
             if(statusCode==403||statusCode==503){
                 
                 message=[[GlobalFunction sharedInstance].arrayOfAlerts objectAtIndex:74];
                 
             }else if(statusCode==401){
                 
                 message=[[GlobalFunction sharedInstance].arrayOfAlerts objectAtIndex:63];
                 
             }else{
                 NSDictionary *messagearray=[response objectForKey:@ "modelState"];
                 NSArray *dictValues=[messagearray allValues];
                 NSArray *msgarray=[dictValues objectAtIndex:0];
                 message=[msgarray objectAtIndex:0];
                 
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
             [self presentViewController:_alert animated:YES completion:nil];
         }
     }];
    
    _details=[[appdelegate usersDetails]valueForKey:@"nextScheduledAppointment"];
    
    
    
    NSLog(@"details%@",_details);
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
-(void)feedbackClick:(UITapGestureRecognizer *)recognizer {
    [self resignSoftKeyboard];
    /*dataSource=[[NSArray alloc]initWithObjects:@"Question 1",
     @"Question 2",@"Question 3",@"Question 4", nil];
     
     [self.pickerView reloadAllComponents];*/
    _pickerBackView.hidden=NO;
    
    [_feedbackquestions setValue:[UIColor  colorWithRed:(112/255.0) green:(112/255.0) blue:(112/255.0) alpha:1] forKeyPath:@"_placeholderLabel.textColor"];
    _feedbackquestions.placeholder=@"";
}


- (void)handleSingleTapped:(UITapGestureRecognizer *)recognizer {
    _pickerBackView.hidden=YES;
}

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
    [_feedbackquestions setText:[dataSource objectAtIndex:row]];
    [_FeedbackAnswer becomeFirstResponder];
     [questionArray objectAtIndex:row];
      _QuestionID=[[questionArray objectAtIndex: row] objectForKey:@"id"];
    NSLog(@"question%@",_QuestionID);
    
    
    _pickerBackView.hidden=YES;
    
}
- (IBAction)submitClick:(id)sender {
    
    
    
    AppDelegate *appdelegate=(AppDelegate *)[[UIApplication sharedApplication]delegate];
    _mainparamdict=[[NSMutableDictionary alloc]init];
    NSMutableDictionary *dict=[[NSMutableDictionary alloc]init];
    [dict setObject:[_details objectForKey:@"appointmentID"] forKey:@"appointmentsId"];
    [dict setObject: _feedbackTextView.text forKey:@"notes"];
    //[dict setObject:[_details objectForKey:@"providerID"] forKey:@"providerID"];
    //[dict setObject:[_details objectForKey:@"userID"] forKey:@"clientID"];
    NSLog(@"parameters sent42%@",dict);
    
    NSMutableDictionary *dict2=[[NSMutableDictionary alloc]init];
    //[dict2 setObject:@"18" forKey:@"providerFeedbackId"];
    [dict2 setObject:_QuestionID forKey:@"feedbackQuestionId"];
    [dict2 setObject:_FeedbackAnswer.text forKey:@"answers"];
    
    NSMutableArray *array=[[NSMutableArray alloc]init];
    [array addObject: dict2];
    
    NSLog(@"parameters sent43%@",array);
    [_mainparamdict setObject:dict forKey:@"providerFeedbackDetail"];
    [_mainparamdict setObject:array forKey:@"providerQuestionAnswers"];
    
    
    
    
    NSLog(@"parameters sent44%@",_mainparamdict);
    NSString *Url=[appdelegate.serviceURL stringByAppendingString:@"api/Feedback/PostProviderFeedback"];;
    [[GlobalFunction sharedInstance]getServerResponseAfterLogin:Url method:@"POST" param:_mainparamdict withCallback:^(NSInteger statusCode, NSDictionary *response, NSError *error) {
        if(statusCode == 200)
        {
            NSLog(@" success");
            
            UIStoryboard *storyboard = [UIStoryboard storyboardWithName: @"UserStoryboard" bundle:nil];
            
            SessionSummaryViewController *SessionSummaryView=[storyboard instantiateViewControllerWithIdentifier:@"SessionSummary"];
            
            SessionSummaryView.totalSessionTime=_timespent;
            SessionSummaryView.sessionDetails=_sessionDetails;
            self.modalPresentationStyle = UIModalPresentationFullScreen;
            SessionSummaryView.modalPresentationStyle = UIModalPresentationOverCurrentContext;
            
            [self presentViewController:SessionSummaryView animated:NO completion:nil];
            
        }
        
    }];
}

- (IBAction)skipClick:(id)sender {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName: @"UserStoryboard" bundle:nil];
    
    SessionSummaryViewController *SessionSummaryView=[storyboard instantiateViewControllerWithIdentifier:@"SessionSummary"];
    SessionSummaryView.totalSessionTime=_timespent;
    SessionSummaryView.sessionDetails=_sessionDetails;
    self.modalPresentationStyle = UIModalPresentationFullScreen;
    SessionSummaryView.modalPresentationStyle = UIModalPresentationOverCurrentContext;
    
    [self presentViewController:SessionSummaryView animated:NO completion:nil];
    
}
-(void)resignSoftKeyboard{
    [_feedbackquestions resignFirstResponder];
    [_FeedbackAnswer resignFirstResponder];
    
}

- (BOOL) textViewShouldBeginEditing:(UITextView *)textView
{
    if([_feedbackTextView.text isEqualToString:@"Notes"])
    {
        _feedbackTextView.text = @"";
    }
    _feedbackTextView.textColor = [UIColor blackColor];
    return YES;
}
-(void) textViewDidChange:(UITextView *)textView
{
    
    if(_feedbackTextView.text.length == 0){
        _feedbackTextView.textColor = [UIColor lightGrayColor];
        _feedbackTextView.text = @"Notes";
        
    }
}

@end
