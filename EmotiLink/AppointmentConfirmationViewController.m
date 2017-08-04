
/***************************************************************
 Page name: AppointmentConfirmationViewController.m
 Created By: Nalina
 Created Date: 2016-07-20
 Description: Appointment Confirmation implementation file
 ***************************************************************/

#import "AppointmentConfirmationViewController.h"
#import "AppointmentConfirmSecondViewController.h"
#import "GlobalFunction.h"
#import "ThanksViewController.h"
#import "AppDelegate.h"
#import "MakeAnAppointmentViewController.h"
#import <Google/Analytics.h>


@interface AppointmentConfirmationViewController ()

@end

@implementation AppointmentConfirmationViewController

- (void)viewDidLoad {
    AppDelegate *appdelegate= (AppDelegate *)[[UIApplication sharedApplication]delegate];
    
    _nextpagedict= [[NSMutableDictionary alloc]init];
    //Added by: Zeenath
    //Added Date: 20/08/2016
    //Discription: Different fonts for the same label
   
  
    NSLog(@"details%@",_postScheduleDetails);
    _nextpagedict=[_postScheduleDetails mutableCopy];
    NSString *name=[[_postScheduleDetails objectForKey:@"providerfirstName"] stringByAppendingString:@" "];
    _providerNameLabel.text= [name stringByAppendingString:[_postScheduleDetails objectForKey:@"providerlastName"]];
    
    _timeFromLabel.text=[self Convert24FormatTo12Format:[_postScheduleDetails objectForKey:@"startTime"]];
    _timeToLabel.text=[self Convert24FormatTo12Format:[_postScheduleDetails objectForKey:@"endTime"]];
    NSString *time=[[_postScheduleDetails objectForKey:@"time"] stringByAppendingString:@" on "];
    _dateTimeLabel.text= [time stringByAppendingString:[_postScheduleDetails objectForKey:@"Date"]];
    NSString *amount=[_postScheduleDetails objectForKey:@"rate"];
    NSNumber *value=[NSNumber numberWithInteger:[amount integerValue]];
    NSNumber *estimate=[NSNumber numberWithInteger:[[_postScheduleDetails objectForKey:@"estimation"] integerValue]];
    NSNumber *estimatedvalue = [NSNumber numberWithInteger:([value integerValue] *[estimate integerValue])];
    
    NSString *estamount=@"Estimated Amount: ";
    _EstimatedAmount.text= [estamount stringByAppendingString:[NSString stringWithFormat: @"%@ %@ %@",@"$",[estimatedvalue stringValue],@" / hour"]];
    
    _rateText.text=[value stringValue];
    _sessionRateLabel.text=[NSString stringWithFormat: @"%@ %@ %@",@"$",[value stringValue],@" / hour"];
    
    
    
    // _minuteLabel.text=[_postScheduleDetails objectForKey:@"totalTime"];
    //_nameOfTheProviderLabel.text= [name stringByAppendingString:[_postScheduleDetails objectForKey:@"providerlastName"]];
    
    
    /*  _expertiseLabel.text=[_postScheduleDetails objectForKey:@"qualification"];
     
     
     if ([[_postScheduleDetails objectForKey:@"providerprofile"] isEqual:[NSNull null]]) {
     UIImage *image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"upload-profile" ofType:@"png"]];
     _profileImageView.image=image;
     }else{
     
     NSString *imagePath= [_postScheduleDetails objectForKey:@"providerprofile"];
     NSString *imagename=[appdelegate.imageURL stringByAppendingString:imagePath];
     dispatch_queue_t imagequeue =dispatch_queue_create("imageDownloader", nil);
     dispatch_async(imagequeue, ^{
     
     //download iamge
     NSData *imageData = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:imagename]];
     UIImage *image = [[UIImage alloc] initWithData:imageData];
     dispatch_async(dispatch_get_main_queue(), ^{
     if (image==NULL) {
     UIImage *image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"upload-profile" ofType:@"png"]];
     _profileImageView.image  = image;
     }
     else{
     _profileImageView.image  = image;
     }
     });
     
     });
     }
     
     
     NSString *amount=[_postScheduleDetails objectForKey:@"rate"];
     NSNumber *value=[NSNumber numberWithInteger:[amount integerValue]];
     
     _rateText.text=[value stringValue];
     _sessionRateLabel.text=[NSString stringWithFormat: @"%@ %@ %@",@"$",[value stringValue],@" / hour"];
     
     _rateText.layer.borderColor = [[UIColor colorWithRed:228.0/255.0 green:109.0/255.0 blue:175.0/255.0 alpha:1.0]CGColor];
     _rateText.layer.borderWidth = 1.0f;
     
     self.profileImageView.layer.cornerRadius = self.profileImageView.frame.size.width / 2;
     self.profileImageView.clipsToBounds = YES;
     
     
     //Added by: Nalina
     //Added Date: 20/07/2016
     //Discription: To add the done button to the number keypad
     
     UIToolbar* numberToolbar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 50)];
     numberToolbar.barStyle = UIBarStyleBlackTranslucent;
     numberToolbar.items = @[
     [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],
     [[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(doneWithNumberPad)],[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil]];
     [numberToolbar sizeToFit];
     _rateText.inputAccessoryView = numberToolbar;
     
     [self.rateText addTarget:self action:@selector(removeRateValidation:) forControlEvents:UIControlEventAllTouchEvents];
     [self.rateText addTarget:self action:@selector(removeRateValidation:) forControlEvents:UIControlEventEditingChanged];
     _rateText.delegate=self;*/
    
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}


-(void)doneWithNumberPad{
    CGPoint pt;
    
    pt.x = 0;
    pt.y = 10;
    [_scrollView setContentOffset:pt animated:YES];
    [_rateText resignFirstResponder];
}

//Added by: Nalina
//Added Date: 20/07/2016
//Discription: To convert 24 hour format time into 12 hour format

-(NSString *)Convert24FormatTo12Format:(NSString *)time{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"HH:mm:ss"];
    
    NSDate *amPmDate = [formatter dateFromString:time];
    [formatter setDateFormat:@"hh:mm a"];
    
    NSString *HourString = [formatter stringFromDate:amPmDate];
    return HourString;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated
{
    AppDelegate *appdelegate= (AppDelegate *)[[UIApplication sharedApplication]delegate];
    id<GAITracker> tracker = [[GAI sharedInstance] defaultTracker];
    [tracker set:kGAIScreenName value:@"AppointmentConfirmation"];
    [tracker send:[[GAIDictionaryBuilder createScreenView] build]];
    if([appdelegate.screenState isEqualToString:@"AppointmentConfirm"] )
    {
        [self.navigationController popToRootViewControllerAnimated:NO];
        appdelegate.screenState=nil;
    }
    
}

//Close the appointment confirmation screen on click of cancel button
- (IBAction)BackClick:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)cancelClick:(id)sender {
    
   [self dismissViewControllerAnimated:YES completion:nil];
}


//Added by: Nalina
//Added Date: 20/07/2016
//Discription: To remove the validation field design functionality

-(void)removeRateValidation:(UITextField *)theTextField{
    [_rateText setValue:[UIColor  colorWithRed:(112/255.0) green:(112/255.0) blue:(112/255.0) alpha:1] forKeyPath:@"_placeholderLabel.textColor"];
    _rateText.placeholder=@"";
    _rateError.hidden=YES;
    _rateText.layer.borderColor = [[UIColor colorWithRed:228.0/255.0 green:109.0/255.0 blue:175.0/255.0 alpha:1.0]CGColor];
    _rateText.layer.borderWidth = 1.0f;
}


//Added by: Nalina
//Added Date: 20/07/2016
//Discription: Confirm button click with validation of input fields

- (IBAction)confirmationClick:(id)sender {
    
    //GlobalFunction *globalValues=[[GlobalFunction alloc]init];
    [self serviceCallToMakeAnAppointment];
  /*  if ([_rateText.text isEqualToString:@""]) {
        _rateText.layer.borderColor = [[UIColor redColor]CGColor];
        _rateText.layer.borderWidth = 1.0f;
        _rateError.hidden=NO;
        [_rateText setValue:[UIColor redColor] forKeyPath:@"_placeholderLabel.textColor"];
        _rateText.placeholder=@" Rate required.";
        
    }else{
        
        NSString *providerRate=[_postScheduleDetails objectForKey:@"rate"];
        NSString *offeredAmount=_rateText.text;
        
        if([offeredAmount floatValue]<[providerRate floatValue]) {
            _alert = [UIAlertController
                      alertControllerWithTitle:@""
                      message:[[GlobalFunction sharedInstance].arrayOfAlerts objectAtIndex:47]
                      preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction* yesButton = [UIAlertAction
                                        actionWithTitle:@"Yes"
                                        style:UIAlertActionStyleDefault
                                        handler:^(UIAlertAction * action) {
                                            [self startLoadingIndicator];
                                            ;
                                        }];
            
            [_alert addAction:yesButton];
            UIAlertAction* noButton = [UIAlertAction
                                       actionWithTitle:@"No"
                                       style:UIAlertActionStyleDefault
                                       handler:^(UIAlertAction * action) {
                                       }];
            [_alert addAction:noButton];
            
            [self presentViewController:_alert animated:YES completion:nil];
            
        }else{
            [self startLoadingIndicator];
            [self serviceCallToMakeAnAppointment];
        }
        
    }*/
}


//  Added by:Zeenath
//  Added Date:2016-24-08.
//  Description:Function To focus the textfield and scroll back when keyboard is returned.
- (void)textFieldDidBeginEditing:(UITextField *)textField {
    // svos = _scrollView.contentOffset;
    CGPoint pt;
    CGRect rc = [textField bounds];
    rc = [textField convertRect:rc toView:_scrollView];
    pt = rc.origin;
    pt.x = 0;
    pt.y -= 150;
    [_scrollView setContentOffset:pt animated:YES];
}


//Added by: Nalina
//Added Date: 20/08/2016
//Discription: Service call to book an appointment and redirect to the thank you screen

-(void)serviceCallToMakeAnAppointment{
    AppDelegate *appdelegate= (AppDelegate *)[[UIApplication sharedApplication]delegate];
    
    NSString *scheduleAppointmentUrl=[appdelegate.serviceURL stringByAppendingString:@"api/Appointments/ScheduleAppointment"];
    NSMutableDictionary *createScheduleData = [[NSMutableDictionary alloc] init];
    [createScheduleData setObject:[_postScheduleDetails objectForKey:@"providerID"] forKey:@"providerID"];
    [createScheduleData setObject:[_postScheduleDetails objectForKey:@"Date"] forKey:@"scheduledDate"];
    [createScheduleData setObject:[_postScheduleDetails objectForKey:@"startTime"] forKey:@"scheduledStartTime"];
    [createScheduleData setObject:[_postScheduleDetails objectForKey:@"endTime"] forKey:@"scheduledEndTime"];
    [createScheduleData setObject:[_postScheduleDetails objectForKey:@"rate"] forKey:@"offeredRate"];
    NSLog(@"PARAMS%@",createScheduleData);
    [[GlobalFunction sharedInstance] getServerResponseAfterLogin:scheduleAppointmentUrl method:@"POST" param:createScheduleData withCallback:^(NSInteger statusCode, NSDictionary *response, NSError *error)
     {
         //    GlobalFunction *globalValues=[[GlobalFunction alloc]init];
         NSString *message;
         
         if (statusCode == 200)
         {
             NSLog(@"SUCCESS%@",_postScheduleDetails);
             AppointmentConfirmSecondViewController *vc=[self.storyboard instantiateViewControllerWithIdentifier:@"AppointmentConfirmationsecondViewController"];
              vc.providerDetails=_nextpagedict;
             [self presentViewController:vc animated:YES completion:nil];
            
             [self stopLoadingIndicator];
             
         }else if(statusCode==400){
             [self stopLoadingIndicator];
             _alert = [UIAlertController
                       alertControllerWithTitle:@""
                       message:[response objectForKey:@"message"]
                       preferredStyle:UIAlertControllerStyleAlert];
             
             UIAlertAction* okButton = [UIAlertAction
                                        actionWithTitle:@"OK"
                                        style:UIAlertActionStyleDefault
                                        handler:^(UIAlertAction * action) {
                                            [self.navigationController popViewControllerAnimated:YES];
                                        }];
             [_alert addAction:okButton];
             [self presentViewController:_alert animated:YES completion:nil];
             
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
                       alertControllerWithTitle:@"You have already Scheduled an Appointment for the same time"
                       message:message
                       preferredStyle:UIAlertControllerStyleAlert];
             
             UIAlertAction* okButton = [UIAlertAction
                                        actionWithTitle:@"OK"
                                        style:UIAlertActionStyleDefault
                                        handler:^(UIAlertAction * action) {
                                            [self stopLoadingIndicator];
                                            
                                        }];
             [_alert addAction:okButton];
             [self presentViewController:_alert animated:YES completion: nil];
         }
         
     }];
}


//Added by: Nalina
//Added Date: 20/07/2016
//Discription: Rate error click and clear the field from validation

- (IBAction)rateErrorClose:(id)sender {
    [_rateText setValue:[UIColor  colorWithRed:(112/255.0) green:(112/255.0) blue:(112/255.0) alpha:1] forKeyPath:@"_placeholderLabel.textColor"];
    _rateText.placeholder=@"";
    _rateError.hidden=YES;
    _rateText.layer.borderColor = [[UIColor colorWithRed:228.0/255.0 green:109.0/255.0 blue:175.0/255.0 alpha:1.0]CGColor];
    _rateText.layer.borderWidth = 1.0f;
}


//Added by: Nalina
//Added Date: 20/08/2016
//Discription:To start the activity indicator.
-(void)startLoadingIndicator
{
    
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGFloat screenWidth = screenRect.size.width;
    CGFloat screenHeight = screenRect.size.height;
    _loadingView= [[UIView alloc] initWithFrame: CGRectMake ( 0, 20, screenWidth, screenHeight)];
    _loadingView.backgroundColor = [UIColor colorWithRed:0.0/255.0 green:0.0/255.0 blue:0.0/255.0 alpha:0.25];
    [self.view addSubview:_loadingView];
    UIActivityIndicatorView *spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    spinner.color=[UIColor whiteColor];
    [self.loadingView addSubview:spinner];
    [self.loadingView bringSubviewToFront:spinner];
    spinner.hidesWhenStopped = YES;
    spinner.center = self.loadingView.center;
    
    [spinner startAnimating];
    
}

//Added by: Nalina
//Added Date: 20/08/2016
//Discription:To stop the activity indicator.

-(void)stopLoadingIndicator
{
    
    _loadingView.hidden=YES;
}

@end
