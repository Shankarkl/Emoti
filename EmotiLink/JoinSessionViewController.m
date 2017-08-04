/***************************************************************
 Page name:JoinSessionViewController.m
 Created By:Zeenath
 Created Date:22/7/16
 Description:To join the session implementation file
 ***************************************************************/

#import "JoinSessionViewController.h"
#import <Google/Analytics.h>
#import <OpenTok/OpenTok.h>
#import "AppDelegate.h"
#import "FeedbackPopupSceneViewController.h"
#import "RatingpopupViewController.h"
#import "GlobalFunction.h"
#import "SessionSummaryViewController.h"
#include <stdlib.h>
#import "EmergencyPopupSceneViewController.h"

#define appdelegate (AppDelegate *)[[UIApplication sharedApplication]delegate]

static NSString* const _apiKey = @"45826932";
static NSString*  _sessionId = @"2_MX40NTgyNjkzMn5-MTQ5Mjg0NTc1OTI0NX5DVGNFd01wYXhxeFh0bmJJRUhWT3ZBRnJ-fg";
static NSString*  _token = @"T1==cGFydG5lcl9pZD00NTgyNjkzMiZzaWc9NjY3OTkwZjNhNTA4MTA3Mjk1YjE5M2VlMGEwMjQwYjk4ODI5NDU2NjpzZXNzaW9uX2lkPTJfTVg0ME5UZ3lOamt6TW41LU1UUTVNamcwTlRjMU9USTBOWDVEVkdORmQwMXdZWGh4ZUZoMGJtSkpSVWhXVDNaQlJuSi1mZyZjcmVhdGVfdGltZT0xNDkyODQ1ODEwJm5vbmNlPTAuODM1NDA4MzQzMTEzMTM3MiZyb2xlPXB1Ymxpc2hlciZleHBpcmVfdGltZT0xNDk1NDM3Njg3";
static NSString* const _secretKey = @"234924733c93ce9d86a1972bb81821ce93133605";




@interface JoinSessionViewController ()<OTSessionDelegate, OTSubscriberDelegate, OTPublisherDelegate>
@property (strong, nonatomic) OTSession* session;
@property (strong, nonatomic) OTPublisher* publisher;
@property (strong, nonatomic) OTSubscriber* subscriber;
@property (strong, nonatomic) OTConnection* connection;
@property (nonatomic, strong) UIView *streamReconnectingView;
@property (nonatomic, strong) UIActivityIndicatorView *reconnectingSpinner;

@end

@implementation JoinSessionViewController
int timeSec;
int timeMin;
int timeHour;


//Called when the view controller is first time loaded to memory
- (void)viewDidLoad {
    NSLog(@"appointment%@",_appointmentID);
    //  [self dynamicSessionId];
    CurrentDateTime = [self getCurrentTime];
    timerAlertStatus=0;
    
    [self setBorderColor:5];
    
    endTimeString = [[GlobalFunction sharedInstance]Convert24FormatTo12Format:[[appdelegate todaysSchedules]objectForKey:@"scheduledEndTime"]];
    
    timeTickFormatter = [[NSDateFormatter alloc]init];
    [timeTickFormatter setDateFormat:@"hh:mm a"];
    
    endTime  = [self minutesSinceMidnight:[timeTickFormatter dateFromString:endTimeString]];
    AppDelegate *app= (AppDelegate *)[[UIApplication sharedApplication]delegate];
    app.checkIdelTimer=@"stopTimer";
    
    self.session = [[OTSession alloc] initWithApiKey:_apiKey
                                           sessionId:_sessionId
                                            delegate:self];
    [self.session connectWithToken:_token error:nil];
    _publisher.cameraPosition =AVCaptureDevicePositionFront;
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
}

- (void)buildReconnectingViews
{
    
    self.streamReconnectingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.tokView.frame.size.width, self.tokView.frame.size.height)];
    self.streamReconnectingView.backgroundColor = [UIColor blackColor];
    self.reconnectingSpinner = [[UIActivityIndicatorView alloc]
                                initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    self.reconnectingSpinner.center = CGPointMake(self.tokView.frame.size.width / 2, self.tokView.frame.size.height / 3);
    [self.streamReconnectingView addSubview:self.reconnectingSpinner];
    UIFont * customFont =  [UIFont fontWithName:@"CenturyGothic" size:12];//custom font
    NSString * text = @"There is a network connectivity issue from other side. Please wait till we reconnect again.";
    
    
    
    UILabel *fromLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 15, self.tokView.frame.size.width/2, self.tokView.frame.size.height)];
    fromLabel.text = text;
    fromLabel.font = customFont;
    fromLabel.numberOfLines = 10;
    fromLabel.baselineAdjustment = UIBaselineAdjustmentAlignBaselines; // or UIBaselineAdjustmentAlignCenters, or UIBaselineAdjustmentNone
    fromLabel.adjustsFontSizeToFitWidth = YES;
    fromLabel.adjustsLetterSpacingToFitWidth = YES;
    fromLabel.minimumScaleFactor = 10.0f/12.0f;
    fromLabel.clipsToBounds = YES;
    fromLabel.backgroundColor = [UIColor clearColor];
    fromLabel.textColor = [UIColor whiteColor];
    fromLabel.textAlignment = NSTextAlignmentCenter;
    fromLabel.center=self.streamReconnectingView.center;
    [_streamReconnectingView addSubview:fromLabel];
}

-(int) minutesSinceMidnight:(NSDate *)date
{
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond fromDate:date];
    return 60 * (int)[components hour] + (int)[components minute];
}

// Dispose of any resources that can be recreated.
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

//  Added by:Nalina
//  Added Date:2016-12-08.
//  Description:Service call to get the current time in 24hour format.

-(NSString *)getCurrentTime{
    
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"MM/dd/yyyy"];
    
    NSDate *date = [NSDate date];
    NSDateFormatter *df =[[NSDateFormatter alloc]init];
    [df setDateFormat:@"HH:mm:ss"];
    return [df stringFromDate:date];
}

//called each time when the view appears
-(void)viewWillAppear:(BOOL)animated
{
    
    
    /* NSString *userName=[[appdelegate usersDetails]valueForKey:@"userName"];
     
     
     UIFont *font1 = [UIFont fontWithName:@"CenturyGothic" size:12];
     NSDictionary *arialDict = [NSDictionary dictionaryWithObject: font1 forKey:NSFontAttributeName];
     NSMutableAttributedString *aAttrString1 = [[NSMutableAttributedString alloc] initWithString:@"Hello, " attributes: arialDict];
     
     UIFont *font2 = [UIFont fontWithName:@"CenturyGothic-Bold" size:12];
     NSDictionary *arialDict2 = [NSDictionary dictionaryWithObject: font2 forKey:NSFontAttributeName];
     NSMutableAttributedString *aAttrString2 = [[NSMutableAttributedString alloc] initWithString:userName attributes: arialDict2];
     
     
     [aAttrString1 appendAttributedString:aAttrString2];
     _userName.attributedText = aAttrString1;*/
    
    _emergencyPopupMainView.hidden=YES;
    
    if ([[[appdelegate usersDetails]valueForKey:@"userRole"] isEqualToString:@"Provider"]){
        _emergenceButton.hidden=NO;
    }else{
        _emergenceButton.hidden=YES;
    }
    
    self.navigationItem.title = @"IN SESSION";
    
    [self.navigationController.navigationBar
     setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor colorWithRed:239.0/255.0 green:239.0/255.0 blue:239.0/255.0 alpha:1.0]}];
    
    self.navigationController.navigationBar.tintColor = [UIColor colorWithRed:239.0/255.0 green:239.0/255.0 blue:239.0/255.0 alpha:1.0];
    
    self.tabBarController.tabBar.hidden = YES;
    self.navigationItem.hidesBackButton = YES;
    id<GAITracker> tracker = [[GAI sharedInstance] defaultTracker];
    [tracker set:kGAIScreenName value:@"JoinSession"];
    [tracker send:[[GAIDictionaryBuilder createScreenView] build]];
    
}


//Added by: Zeenath
//Added Date: 22/07/2016
//Discription: Function to show the confirmation alert and call the service when the end session button is clicked
- (IBAction)EndSession:(id)sender {
    
    
    //  self.navigationItem.hidesBackButton = NO;
    
    GlobalFunction *globalValues=[[GlobalFunction alloc]init];
    
    
    _alert = [UIAlertController
              alertControllerWithTitle:@""
              message:[globalValues.arrayOfAlerts objectAtIndex:99]
              preferredStyle:UIAlertControllerStyleAlert];
    
    
    UIAlertAction* yesButton = [UIAlertAction
                                actionWithTitle:@"Yes"
                                style:UIAlertActionStyleDefault
                                handler:^(UIAlertAction * action) {
                                    
                                    OTError* error = nil;
                                    [_session signalWithType:nil string:@"SessionEnded" connection:_connection error:&error];
                                    if (error) {
                                        NSLog(@"signal error %@", error);
                                    } else {
                                        NSLog(@"signal sent");
                                    }
                                    
                                    
                                    _joinString=nil;
                                    
                                }];
    
    UIAlertAction* noButton = [UIAlertAction
                               actionWithTitle:@"No"
                               style:UIAlertActionStyleDefault
                               handler:^(UIAlertAction * action) {
                                   //Handle your yes please button action here
                                   self.tabBarController.tabBar.hidden = YES;
                                   self.navigationItem.hidesBackButton = YES;
                               }];
    
    [_alert addAction:yesButton];
    [_alert addAction:noButton];
    [self presentViewController:_alert animated:YES completion:nil];
    
}

-(void)viewDidAppear:(BOOL)animated
{
    [self buildReconnectingViews];
}//  Added by:Zeenath
//  Added Date:2016-23-08.
//  Description:Integration of tokbox.

- (void)sessionDidConnect:(OTSession*)session
{
    NSLog(@"sessionDidConnect");
    self.publisher = [[OTPublisher alloc]
                      initWithDelegate:self];
    NSLog(@" self.publisher %@", self.publisher );
    
    [self.streamReconnectingView removeFromSuperview];
    [self dismissReconnectingAlert];
    [session publish:self.publisher error:nil];
    [self.publisher.view setFrame:CGRectMake(10, self.view.bounds.size.height-220, 150, 150)];
    
    [self.publisher.view.layer setCornerRadius:10];
    [self.publisher.view.layer setMasksToBounds:YES];
    
    [self.tokView addSubview:self.publisher.view];
    [self.tokView bringSubviewToFront:self.publisher.view];
    
    [self.tokView bringSubviewToFront:_emergenceButton];
    [self.tokView bringSubviewToFront:_closeSessionButton];
}

- (void)session:(OTSession*)session
  streamCreated:(OTStream*)stream
{
    NSLog(@"streamCreated");
    self.subscriber = [[OTSubscriber alloc] initWithStream:stream
                                                  delegate:self];
    [session subscribe:self.subscriber error:nil];
    [self StartTimer];
}

- (void)subscriberVideoDataReceived:(OTSubscriber *)subscriber
{
    // NSLog(@" tokViewwidth1 = %f tokViewheight1 = %f", self.tokView.frame.size.width,self.tokView.frame.size.height);
    [self.subscriber.view setFrame:CGRectMake(0, 0, _tokView.frame.size.width, _tokView.frame.size.height)];
    [self.tokView addSubview:self.subscriber.view];
    [self.tokView sendSubviewToBack:self.subscriber.view];
}

- (void)sessionDidDisconnect:(OTSession*)session
{
    NSLog(@"Session disconnected %@",session);
    
    
    [session unpublish:self.publisher error:nil];
    [self.publisher.view removeFromSuperview];
    
    
}


-(void)disconnect:(OTError *)error
{
    NSLog(@" disconnected error %@",error);
}
- (void)session:(OTSession*)session
streamDestroyed:(OTStream*)stream
{
    
    NSLog(@"stream Destroyed description%d",session.sessionConnectionStatus);
    
    [session unsubscribe:self.subscriber error:nil];
    [self.subscriber.view removeFromSuperview];
    
    
    if(![signalString isEqualToString:@"SessionEnded"])
    {
        
        _joinString=@"joined";
        
        [self.reconnectingSpinner startAnimating];
        [self.tokView addSubview:self.streamReconnectingView];
        [self StopTimer];
        
        
        
    }
    else
    {
        [self callSessioEndService];
    }
    
}


- (void)session:(OTSession*)session
connectionDestroyed:(OTConnection *)connection
{
    NSLog(@"connection Destroyed data %@",connection.data);
    NSLog(@"connection Destroyed description %@",connection.description);
}


//  Added by:Zeenath
//  Added Date:2016-23-08.
//  Description:To send the session details to service.
-(void)callSessioEndService
{
    sessionDetails=[[NSMutableDictionary alloc]init];
    NSMutableDictionary *dict=[[NSMutableDictionary alloc]init];
    GlobalFunction *globalValues=[[GlobalFunction alloc]init];
    timeSpent=_timeLabel.text;
    
    
    [dict setObject:_appointmentID forKey:@"sessionID"];
    [dict setObject:CurrentDateTime forKey:@"startTime"];
    [dict setObject:[self getCurrentTime] forKey:@"endTime"];
    
    
    NSLog(@" Parameter Dictionary %@",dict);
    [self StopTimer];
    [self.session disconnect:nil];
    
    AppDelegate *app=(AppDelegate *)[[UIApplication sharedApplication]delegate];
    
    NSString *Url=[app.serviceURL stringByAppendingString:@"api/Appointments/CloseAppointment"];
    [self startLoadingIndicator];
    [[GlobalFunction sharedInstance]getServerResponseAfterLogin:Url method:@"POST" param:dict withCallback:^(NSInteger statusCode, NSDictionary *response, NSError *error) {
        if(statusCode == 200)
        {
            sessionDetails=[response mutableCopy];
            /*SessionSummaryViewController *View=[self.storyboard instantiateViewControllerWithIdentifier:@"SessionSummary"];
            NSLog(@" Parameter response %@",response);
            View.sessionDetails=[response mutableCopy];
            NSLog(@" Parameter timeSpent %@",timeSpent);
            View.totalSessionTime=timeSpent;
            self.tabBarController.tabBar.hidden = NO;
            //  self.navigationItem.hidesBackButton = NO;
            [self.navigationController pushViewController:View animated:YES];*/
            
            if (![[[appdelegate usersDetails]valueForKey:@"userRole"] isEqualToString:@"Provider"]){
                UIStoryboard *storyboard = [UIStoryboard storyboardWithName:
                                            @"GeneralStoryboard" bundle:nil];
                
                RatingpopupViewController *RatingViewController=[storyboard instantiateViewControllerWithIdentifier:@"RatingPopup"];
                RatingViewController.timespent=timeSpent;
                RatingViewController.sessionDetails=sessionDetails;
                
                self.modalPresentationStyle = UIModalPresentationFullScreen;
                RatingViewController.modalPresentationStyle = UIModalPresentationOverCurrentContext;
                
                [self presentViewController:RatingViewController animated:NO completion:nil];
                
            }else{
                UIStoryboard *storyboard = [UIStoryboard storyboardWithName:
                                            @"ProviderStoryboard" bundle:nil];
                
                FeedbackPopupSceneViewController *FeedbackPopuVC=[storyboard instantiateViewControllerWithIdentifier:@"Feedbackpopup"];
                
                FeedbackPopuVC.sessionDetails=sessionDetails;
                FeedbackPopuVC.timespent=timeSpent;
                
                self.modalPresentationStyle = UIModalPresentationFullScreen;
                FeedbackPopuVC.modalPresentationStyle = UIModalPresentationOverCurrentContext;
                
                [self presentViewController:FeedbackPopuVC animated:NO completion:nil];
                
            }
            
        }
        else{
            NSString *message;
            
            if(statusCode==403||statusCode==503||statusCode == 404){
                
                message=[globalValues.arrayOfAlerts objectAtIndex:74];
                
            }else if(statusCode==401){
                
                message=[globalValues.arrayOfAlerts objectAtIndex:63];
                
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
                                           
                                           [self.navigationController popViewControllerAnimated:YES];
                                           
                                       }];
            [_alert addAction:okButton];
            
            [self presentViewController:_alert animated:YES completion: nil];
        }
        
    }];
    
    
}

//  Added by:Nalina
//  Added Date:2016-28-08.
//  Description:Function To get the alert messages from the global array.
-(NSString *)getAlertMessage:(int)number{
    GlobalFunction *globalValues=[[GlobalFunction alloc]init];
    return [globalValues.arrayOfAlerts objectAtIndex:number];
}

//  Added by:Zeenath
//  Added Date:2016-23-08.
//  Description:Function called when the session encounters an error.
- (void) session:(OTSession*)session
didFailWithError:(OTError*)error
{
    
    NSLog(@"didFailWithError: (%@)", error.description);
    _joinString=@"joined";
    [self StopTimer];
    _alert = [UIAlertController
              alertControllerWithTitle:@""
              message:[self getAlertMessage:121]
              preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* okbutton = [UIAlertAction
                               actionWithTitle:@"OK"
                               style:UIAlertActionStyleDefault
                               handler:^(UIAlertAction * action) {
                                   self.tabBarController.tabBar.hidden = NO;
                                   [self.navigationController popViewControllerAnimated:YES];
                               }];
    
    [_alert addAction:okbutton];
    [self presentViewController:_alert animated:YES completion: nil];
    
}
- (void)publisher:(OTPublisherKit*)publisher
 didFailWithError:(OTError*) error
{
    NSLog(@"publisher didFailWithError %@", error);
    
}
- (void)subscriberDidConnectToStream:(OTSubscriberKit*)subscriber
{
    NSLog(@"subscriberDidConnectToStream (%@)",subscriber.stream.connection.connectionId);
}
- (void)subscriber:(OTSubscriberKit*)subscriber
  didFailWithError:(OTError*)error
{
    NSLog(@"subscriber %@ didFailWithError %@", subscriber.stream.streamId, error);
}

- (void)subscriberVideoDisabled:(OTSubscriber *)subscriber
                         reason:(OTSubscriberVideoEventReason)reason
{
    NSLog(@"subscriber video disabled.");
    NSLog(@"Reason %d",reason);
}

-(void)subscriberDidDisconnectFromStream:(OTSubscriberKit *)subscriber
{
    NSLog(@"subscriberDidDisconnected %@",subscriber);
    
}




-(void)session:(OTSession *)session receivedSignalType:(NSString *)type fromConnection:(OTConnection *)connection withString:(NSString *)string
{
    signalString=string;
    NSLog(@"signal recieved %@", string);
    [self callSessioEndService];
}

//  Added by:Zeenath
//  Added Date:2016-27-08.
//  Description:Function To start the timer.
-(void) StartTimer
{
    if(![timer isValid]){
        timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timerTick:) userInfo:nil repeats:YES];
        [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSDefaultRunLoopMode];
    }
}


//  Added by:Nalina
//  Added Date:2016-27-08.
//  Description:Function To convert the time format to 12hours.
-(NSDate *)convertTimeFormat:(NSString *)time{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"hh:mm a"];
    NSDate *amPmDate = [formatter dateFromString:time];
    [formatter setDateFormat:@"HH:mm"];
    return amPmDate;
}


//Event called every time the NSTimer ticks.
- (void)timerTick:(NSTimer *)timer
{
    
    timeSec++;
    if (timeSec == 60)
    {
        timeSec = 0;
        timeMin++;
    }
    
    if(timeMin==60)
    {
        timeMin=0;
        timeHour++;
    }
    //Format the string 00:00:00
    NSString* timeNow = [NSString stringWithFormat:@"%02d:%02d:%02d", timeHour,timeMin, timeSec];
    //Display on your label
    //[timeLabel setStringValue:timeNow];
    _timeLabel.text= timeNow;
    
    nowTime = [self minutesSinceMidnight:[timeTickFormatter dateFromString:[timeTickFormatter stringFromDate:[NSDate date]]]];
    
    if (endTime-nowTime==5&&timerAlertStatus!=1) {
        timerAlertStatus=1;
        _alert = [UIAlertController
                  alertControllerWithTitle:@""
                  message:[self getAlertMessage:116]
                  preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* okbutton = [UIAlertAction
                                   actionWithTitle:@"OK"
                                   style:UIAlertActionStyleDefault
                                   handler:^(UIAlertAction * action) {
                                   }];
        
        [_alert addAction:okbutton];
        [self presentViewController:_alert animated:YES completion: nil];
    }
    
    if (endTime-nowTime==0&&timerAlertStatus!=2) {
        timerAlertStatus=2;
        [self StopTimer];
        _alert = [UIAlertController
                  alertControllerWithTitle:@""
                  message:[self getAlertMessage:117]
                  preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* okbutton = [UIAlertAction
                                   actionWithTitle:@"OK"
                                   style:UIAlertActionStyleDefault
                                   handler:^(UIAlertAction * action) {
                                       
                                       
                                       OTError* error = nil;
                                       [_session signalWithType:nil string:@"SessionEnded" connection:_connection error:&error];
                                       if (error) {
                                           NSLog(@"signal error %@", error);
                                       } else {
                                           NSLog(@"signal sent");
                                       }
                                       
                                       
                                   }];
        
        [_alert addAction:okbutton];
        [self presentViewController:_alert animated:YES completion: nil];
    }
    
    
    if ([[appdelegate accessToken] isEqualToString:@""]||[[appdelegate screenStatus]isEqualToString:@"fromJoinsession"]) {
        [self StopTimer];
    }
    
}

//Call this to stop the timer event(could use as a 'Pause' or 'Reset')
- (void) StopTimer
{
    [timer invalidate];
    timer=nil;
    
    if(![_joinString isEqualToString:@"joined"])
    {
        timeSec = 0;
        timeMin = 0;
        timeHour=0;
    }
    
}


//  Added by:Zeenath
//  Added Date:2016-23-08.
//  Description:To start the activity indicator.
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

//  Added by:Zeenath
//  Added Date:2016-23-08.
//  Description:To stop the activity indicator.

-(void)stopLoadingIndicator
{
    _loadingView.hidden=YES;
}

-(void)dynamicSessionId
{
    NSURLSessionConfiguration *defaultConfigObject = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *defaultSession = [NSURLSession sessionWithConfiguration: defaultConfigObject delegate:self delegateQueue: [NSOperationQueue mainQueue]];
    
    
    NSMutableURLRequest * urlRequest = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"http://policiapopularpush.azurewebsites.net/Service1.svc/getTokenDetails"]];
    
    urlRequest.timeoutInterval = 500.0;
    [urlRequest setHTTPMethod:@"GET"];
    [urlRequest setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [urlRequest setValue:@"application/json;charset=UTF-8" forHTTPHeaderField:@"Cookie"];
    
    
    NSLog(@"URL %@",urlRequest);
    
    NSURLSessionDataTask * dataTaskBrief =[defaultSession dataTaskWithRequest:urlRequest
                                                            completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                                                NSLog(@"Response Data and Error Part: %@ %@\n", data, error);
                                                                if(error == nil)
                                                                {
                                                                    NSDictionary *array = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&error];
                                                                    
                                                                    NSLog(@"jsonarray %@ \n", array);
                                                                    
                                                                    NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *) response;
                                                                    
                                                                    NSLog(@"Status code = %ld",(long)httpResponse.statusCode);
                                                                    
                                                                    _sessionId=[array objectForKey:@"sessID"];
                                                                    _token=[array objectForKey:@"tokenID"];
                                                                    
                                                                    self.session = [[OTSession alloc] initWithApiKey:_apiKey
                                                                                                           sessionId:_sessionId
                                                                                                            delegate:self];
                                                                    [self.session connectWithToken:_token error:nil];
                                                                    
                                                                }
                                                                
                                                                
                                                            }];
    [dataTaskBrief resume];
    [defaultSession finishTasksAndInvalidate];
    
}

- (void)sessionDidBeginReconnecting:(OTSession *)session
{
    [self showReconnectingAlert];
}

- (void)showReconnectingAlert
{
    [self showAlertWithMessage:@"Session is reconnecting"
                         title:@""
            showDissmissButton:NO];
    // NSLog(@"Session is reconnecting ");
}
- (void)sessionDidReconnect:(OTSession *)session
{
    [self dismissReconnectingAlert];
}

- (void)dismissReconnectingAlert
{
    if (self.alert) {
        [self.alert dismissViewControllerAnimated:YES completion:nil];
    }
}
- (void)showAlertWithMessage:(NSString *)message
                       title:(NSString *)title
          showDissmissButton:(BOOL)showButton
{
    dispatch_async(dispatch_get_main_queue(), ^{
        self.alert = [UIAlertController alertControllerWithTitle:title
                                                         message:message
                                                  preferredStyle:UIAlertControllerStyleAlert];
        if (showButton) {
            UIAlertAction *action = [UIAlertAction actionWithTitle:@"OK"
                                                             style:UIAlertActionStyleCancel
                                                           handler:^(UIAlertAction * _Nonnull action) {
                                                               [self.alert dismissViewControllerAnimated:YES completion:nil];
                                                               
                                                           }];
            [self.alert addAction:action];
            
        }
        
        [self presentViewController:self.alert animated:YES completion:nil];
    });
}
- (IBAction)cameraclick:(id)sender {
    if(_publisher.cameraPosition == AVCaptureDevicePositionFront){// front camera
        _publisher.cameraPosition = AVCaptureDevicePositionBack; // back camera
    }else{
        _publisher.cameraPosition =AVCaptureDevicePositionFront;
    }
    
}

- (IBAction)volumeclick:(id)sender {
    _publisher.publishAudio = !_publisher.publishAudio;
    UIImage *buttonImage;
    if (_publisher.publishAudio) {
        buttonImage = [UIImage imageNamed: @"volume.png"];
    } else {
        buttonImage = [UIImage imageNamed: @"volume_mute.png"];
    }
    [_publishAudioBtn setImage:buttonImage forState:UIControlStateNormal];
}

- (IBAction)cancelcallclick:(id)sender {
    GlobalFunction *globalValues=[[GlobalFunction alloc]init];
    
    _popupText.text=[globalValues.arrayOfAlerts objectAtIndex:99];
    _popupHeading.text=@"End Session";
    
    _emergencyPopupMainView.hidden=NO;
    
    /*_alert = [UIAlertController
              alertControllerWithTitle:@""
              message:[globalValues.arrayOfAlerts objectAtIndex:99]
              preferredStyle:UIAlertControllerStyleAlert];
    
    
    UIAlertAction* yesButton = [UIAlertAction
                                actionWithTitle:@"Yes"
                                style:UIAlertActionStyleDefault
                                handler:^(UIAlertAction * action) {
                                    
                                    OTError* error = nil;
                                    [_session signalWithType:nil string:@"SessionEnded" connection:_connection error:&error];
                                    if (error) {
                                        NSLog(@"signal error %@", error);
                                    } else {
                                        NSLog(@"signal sent");
                                    }
                                    _joinString=nil;
                                    
                                }];
    
    UIAlertAction* noButton = [UIAlertAction
                               actionWithTitle:@"No"
                               style:UIAlertActionStyleDefault
                               handler:^(UIAlertAction * action) {
                                   //Handle your yes please button action here
                                   self.tabBarController.tabBar.hidden = YES;
                                   self.navigationItem.hidesBackButton = YES;
                               }];
    
    [_alert addAction:yesButton];
    [_alert addAction:noButton];
    [self presentViewController:_alert animated:YES completion:nil];*/
    
}

- (IBAction)emergencyClick:(id)sender {
    NSLog(@"emergency");
    
    _popupText.text=@"Are you sure you want to call an emergency number-911?";
    _popupHeading.text=@"Emergency";
    
    _emergencyPopupMainView.hidden=NO;
    
    /*UIStoryboard *storyboard = [UIStoryboard storyboardWithName:
                                @"ProviderStoryboard" bundle:nil];
    
    EmergencyPopupSceneViewController *emergencyPopuVC=[storyboard instantiateViewControllerWithIdentifier:@"emergencyPopup"];
    
    emergencyPopuVC.sessionDetails=sessionDetails;
    emergencyPopuVC.timespent=timeSpent;
    
    self.modalPresentationStyle = UIModalPresentationFullScreen;
    emergencyPopuVC.modalPresentationStyle = UIModalPresentationOverCurrentContext;
    
    [self presentViewController:emergencyPopuVC animated:NO completion:nil];*/
    
}

-(void) setBorderColor:(int)tagName{
    UIButton *cancelBtn = (UIButton *) [self.view viewWithTag:tagName];
    cancelBtn.layer.borderColor = [UIColor colorWithRed:246.0/255.0 green:108.0/255.0 blue:118.0/255.0 alpha:1].CGColor;
}


- (IBAction)yesClick:(id)sender {
    
    OTError* error = nil;
    [_session signalWithType:nil string:@"SessionEnded" connection:_connection error:&error];
    if (error) {
        NSLog(@"signal error %@", error);
    } else {
        NSLog(@"signal sent");
    }
    _joinString=nil;
    
    _emergencyPopupMainView.hidden=YES;
    
}

- (IBAction)noClick:(id)sender {
    self.tabBarController.tabBar.hidden = YES;
    self.navigationItem.hidesBackButton = YES;
    _emergencyPopupMainView.hidden=YES;
}

@end
