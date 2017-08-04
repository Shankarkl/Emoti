
/***************************************************************
 Page name:GlobalFunction.h
 Created By:Nalina
 Created Date:01-07-16
 Description:Added global Methods and variables implementation file
 ***************************************************************/

#import "GlobalFunction.h"
#import "AppDelegate.h"
#import "ForgotPasswordViewController.h"
#import "LoginViewController.h"
#import "ChangePasswordViewController.h"
#import "Reachability.h"
@implementation GlobalFunction


@synthesize userDetails;

void(^getServerResponseForUrlCallback)(NSInteger statusCode, NSDictionary *response, NSError *error);

+ (instancetype)sharedInstance {
    static GlobalFunction *_instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[GlobalFunction alloc] init];
    });
    
    return _instance;
}

// Added By:Nalina
// Added Date:03/07/16
// Description: Validation messages storing in an array and reusing it in application

- (NSMutableArray *)arrayOfAlerts{
    ArrayOfAlerts=[[NSMutableArray alloc]initWithObjects:@"Please enter Username.", //array 0
                   @"Please enter Password.",  //array 1
                   @"Please enter an Email.",  //array 2
                   @"Please enter First Name.",  //array 3
                   @"Please enter Last Name.",  //array 4
                   @"Please Confirm Password.",  //array 5
                   @"Please enter a valid Email.", //array 6
                   @"Please enter a valid Password.", //array 7
                   @"Both Passwords should match.", //array 8
                   @"Password should contain 1 capital letter, 1 special character, 1 numeric field and minimum 8 digit length.", //array 9
                   @"Please enter Old Password.", //array 10
                   @"Please enter Credit card number.", //array 11
                   @"Please enter Card holder name.", //array 12
                   @"Please enter Expiration Month.", //array 13
                   @"Please enter Expiration Year.", //array 14
                   @"Please enter the CVV.", //array 15
                   @"Please enter Zipcode.", //array 16
                   @"Please enter an Account number.", //array 17
                   @"Please enter an Institution number.", //array 18
                   @"Please enter a Swiftcode.", //array 19
                   @"Please select your State of Licensure.", //array 20
                   @"Please enter your Licence number.", //array 21
                   @"Please select your specialty.", //array 22
                   @"Please enter your City.", //array 23
                   @"Please select your State.", //array 24
                   @"Please enter your Address.", //array 25
                   @"Please enter Name.", //array 26
                   @"Please upload a photo." ,//array 27
                   @"Please enter a valid First Name.",//array 28
                   @"Please enter a valid Last Name.",//array 29
                   @"Please enter a valid Username.", //array 30
                   @"Please enter Username.",//array 31
                   @"Please enter a valid State of Licensure.",//array 32
                   @"Please agree to the Terms and Conditions.",//array 33
                   @"Please enter a valid Address.",//array 34
                   @"Please enter a valid ZipCode.",//array 35
                   @"Please enter a valid City.",//array 36
                   @"Please enter a valid State.",//array 37
                   @"Please enter a valid Username.",//array 38
                   @"You have scheduled an appointment today at 11.30AM. Please cancel that appointment to set as available",//array 39
                   @"Please select Available On.",//array 40
                   @"From time required.",//array 41
                   @"To time required.",
                   @"Please enter a valid Name.",//array 43
                   @"Please select Gender.",//array 44
                   @"Please select specialty.",//array 45
                   @"Please select Date.",//array 46
                   @"Your offer is less than the Provider Published rate.\n Do you want to continue?",//array 47
                   @"Please select security questions.",//array 48
                   @"Please enter an Answer for selected question.",//array 49
                   @"Please select atleast one area of expertise.",//array 50
                   @"Please tell us a little about yourself.",//array 51
                   @"Are you sure you want to logout?",//array 52
                   @"Please enter a valid Card holder name.", //array 53
                   @"Invalid card detected. Please use a valid card.", //array 54
                   @"Please enter an amount charged per hour.",//array 55
                   @"Are you sure to end the session? \n Cancellation Policy: you may be billed the total session duration cost. Based on your provider’s policy.",//array 56
                   @"Are you sure to delete this Provider?",//array 57
                   @"Are you sure to recommend this Provider?",//array 58
                   @"Are you sure you want to cancel an appointment?",//array 59
                   @"Are you sure?",//array 60
                   @"Are you sure to reject this request?",//array 61
                   @"Are you sure you want to delete this Client?",//array 62
                   @"Unauthorized access.",//array 63
                   @"Your password has successfully changed.",//array 64
                   @"Entered Email ID does not match our data. Please enter valid Email used in Registration process.",//array 65
                   @"Username has been sent to your email address. Please check and try again.",//array 66
                   
                   @"Please Check your internet connection. Try again later.",//array 67
                   @"Entered Username does not match our data. Please enter valid Username used in Registration process.",//array 68
                   @"Profile successfully updated.",//array 69
                   @"Please enter SSN",//array 70
                   @"Please enter a valid SSN",//array 71
                   @"Temporary password has been sent to your email address. Please check and try again.",//array 72
                   @"Your availability has been configured successfully.",//array73
                   @"System temporarily unavailable. Please try again later",//array74
                   @"Please upload a document to review and approval.",//array 75
                   @"Please enter a valid Answers.",//array 76
                   @"Please enter a valid license Number.",//array 77
                   @"No providers found.",//array 78
                   @"No recommendations found. \n You can search & add the counselor, or you can email one you know if they aren’t on the system already!",//array 79
                   @"You have successfully invited a provider.",//array 80
                   @"No client found.",//array 81
                   @"Rate per hour successfully updated.",//array 82
                   @"No appointments found.",//array 83
                   @"No request found.",//array 84
                   @"No sessions found.",//array 85
                   @"Provider not available for this day.",//array 86
                   @"Banking info successfully updated.",//array 87
                   @"Profile successfully updated.",//array 88
                   @"Please enter a valid Account number.", //array 89
                   @"From time must be less than To time in first session.",//array 90
                   @"Second session time must be greater than first session time.",//array 91
                   @"From time must be less than To time in second session.",//array 92
                   @"Third session time must be greater than second session time.",//array 93
                   @"From time must be less than To time in third session.",//array 94
                   @"To time must be greater than From time in third session.",//array 95
                   @"Practice expertise successfully updated.",//array 96
                   @"No cancelled appointments found.",//array 97
                   @"Please enter either name or email to search.",//array 98
                   @"Are you sure you want to end session?",//array 99
                   @"Please select a timespan to schedule an appointment.",//array 100
                   @"Are you sure you want to schedule an appointment?",//array 101
                   @"Availability limited to Days have been configured successfully.",//array 102
                   @"Please enter a valid CVV.",//array 103
                   @"Selected questions should not be same.",//array 104
                   @"You must select atleast one date to set unavailability.",//array 105
                   @"Please select time to set unavailability.",//array 106
                   @"Requested session is blocked by another User. Please select another session time.",//array 107
                   @"From time must be less than To time in fourth session.",//array 108
                   @"From time must be less than To time in fifth session.",//array 109
                   @"Fourth session time must be greater than second session time.",//array 110
                   @"Fifth session time must be greater than second session time.",//array 111
                   @"Password has been expired.Please change your password.",//array 112
                   @"Card info successfully updated.",//array 113
                   @"Please enter a valid Credit card number.", //array 114
                   @"Invalid Card info. Please check your card details." ,//array 115
                   @"Your session will be end in next 5 minutes.",//array 116
                   @"Your session will be end now.",//array 117
                   @"You can set only five unavailable times for the day.",//array 118
                   @"You already updated this info. \nAre you sure you want to update it again?",//array 119
                   @"Please set your availability before customizing the Days or hour.",//array 120
                   @"The connection of the session was dropped.Please check the network connectivity.",//array 121
                   @"Are you sure you want to be unavailable for appointments?",//array 122
                   @"Please enter license number.",//array 123
                   @"Swift Code is a unique identification code for a particular bank and it is a standard format of Bank Identifier Codes (BIC).\n\nSwift Code is 8 or 11 characters for a bank. If Swift Code is 8 character code then it points to the primary branch/office.\n\n1. First 4 characters represents bank code.\n2. Next 2 characters represents ISO 3166-1 alpha-2 country code.\n3. Next 2 characters represents location code. (letters and digits) (passive participant will have '1' in the second character).\n4. Last 3 characters represents branch code. These characters are optional. ('XXX' for primary office)\n\nSwift Codes are used for transferring money and messages between banks.",//array 124
                   @"Institution number is a 9 digit numeric code printed on the lower left corner of your checks. This number is used for the electronic routing of funds (ACH transfer) from one bank account to another.",//array 125
                   @"You can not deselect the timespan randomly.",//array 126
                   @"Please enter Phone number.",  //array 127
                   @"Please enter valid Phone number.",  //array 128
                   @"Please enter Display Name.",  //array 129
                   @"Please enter valid Display Name.",  //array 130
                   @"Please login/register before make an appointment.",  //array 131
                   @"Please enter DOB.",  //array 132
                   @"Please Register/Login to view Provider Details.",//133
                   @"Please enter OTP.",  //array 134
                   @"Are you sure you want to accept this appointment?",//135
                   @"You cannot add another session. Provider is not available for next immediate session, Please select other timings.",//136
                   @"Are you sure you want to delete this provider from the recommended list?.",//137
                    @"Are you sure you want to connect with the provider and start the session immediately?",//138
                   nil];
    
    return ArrayOfAlerts;
}


// Added By: Zeenath
// Added Date:29/07/16
// Description: Service call functionality

- (void)getServerResponseForUrl:(NSString *)url method:(NSString *)method param:(NSDictionary *)param withCallback:(ASCompletionBlock)callback
{
    getServerResponseForUrlCallback = callback;
    
    NSURLSessionConfiguration *defaultConfigObject = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *defaultSession = [NSURLSession sessionWithConfiguration: defaultConfigObject delegate:self delegateQueue: [NSOperationQueue mainQueue]];
    
    
    NSMutableURLRequest * urlRequest = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]];
    
    urlRequest.timeoutInterval = 500.0;
    [urlRequest setHTTPMethod:method];
    [urlRequest setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [urlRequest setValue:@"application/json;charset=UTF-8" forHTTPHeaderField:@"Cookie"];
    
    
    // NSString *authValue = [NSString stringWithFormat:@"Bearer %@", appdelegate.accessToken];
    // [urlRequest setValue:authValue forHTTPHeaderField:@"Authorization"];
    
    
    if ([method isEqualToString:@"POST"]) {
        NSData* jsonData = [NSJSONSerialization dataWithJSONObject:param options:kNilOptions error:nil];
        [urlRequest setHTTPBody:jsonData];
    }
    
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
                                                                    
                                                                    [self onBackendResponse:array withSuccess:httpResponse.statusCode error:nil];
                                                                    
                                                                }else{
                                                                    
                                                                    NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *) response;
                                                                    
                                                                    
                                                                    NSLog(@"Response in error part and code = %ld",(long)httpResponse.statusCode);
                                                                    
                                                                    NSMutableDictionary *errorDict=[[NSMutableDictionary alloc]init];
                                                                    NSMutableDictionary *modelStatedict=[[NSMutableDictionary alloc]init];
                                                                    NSArray *modelStatearray=[[NSArray alloc]init];
                                                                    modelStatearray=[[NSMutableArray alloc]initWithObjects:@"Please Check your internet connection. Try again later.",nil];
                                                                    [modelStatedict setObject:modelStatearray forKey:@"errorMessage"];
                                                                    [errorDict setObject:modelStatedict forKey:@"modelState"];
                                                                    
                                                                    
                                                                    [self onBackendResponse:errorDict withSuccess:httpResponse.statusCode error:nil];
                                                                }
                                                                
                                                                
                                                                
                                                            }];
    [dataTaskBrief resume];
    [defaultSession finishTasksAndInvalidate];
    
}

// Call back
- (void)onBackendResponse:(NSDictionary *)response withSuccess:(NSInteger)statusCode error:(NSError *)error
{
    getServerResponseForUrlCallback(statusCode, response, error);
}



// Added By:Nalina
// Added Date:29/07/16
// Description: Service call functionality after taking barer token

- (void)getServerResponseAfterLogin:(NSString *)url method:(NSString *)method param:(NSDictionary *)param withCallback:(ASCompletionBlock)callback
{
    getServerResponseForUrlCallback = callback;
    
    NSURLSessionConfiguration *defaultConfigObject = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *defaultSession = [NSURLSession sessionWithConfiguration: defaultConfigObject delegate:self delegateQueue: [NSOperationQueue mainQueue]];
    
    
    NSMutableURLRequest * urlRequest = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]];
    
    urlRequest.timeoutInterval = 500.0;
    [urlRequest setHTTPMethod:method];
    [urlRequest setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [urlRequest setValue:@"application/json;charset=UTF-8" forHTTPHeaderField:@"Cookie"];
    
    AppDelegate *appdelegate= (AppDelegate *)[[UIApplication sharedApplication]delegate];
    
    NSString *authValue = [NSString stringWithFormat:@"Bearer %@", appdelegate.accessToken];
    [urlRequest setValue:authValue forHTTPHeaderField:@"Authorization"];
    
    
    if ([method isEqualToString:@"POST"]) {
        NSData* jsonData = [NSJSONSerialization dataWithJSONObject:param options:kNilOptions error:nil];
        [urlRequest setHTTPBody:jsonData];
    }
    
    NSLog(@"URL %@",urlRequest);
    
    NSURLSessionDataTask * dataTaskBrief =[defaultSession dataTaskWithRequest:urlRequest
                                                            completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                                                NSLog(@"Response Data: %@ %@\n", data, error);
                                                                if(error == nil)
                                                                {
                                                                    NSDictionary *array = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&error];
                                                                    
                                                                    NSLog(@"jsonarray %@ \n", array);
                                                                    
                                                                    NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *) response;
                                                                    
                                                                    NSLog(@"Status code = %ld",(long)httpResponse.statusCode);
                                                                    
                                                                    [self callBackResponse:array withSuccess:httpResponse.statusCode error:nil];
                                                                    
                                                                    
                                                                }else{
                                                                    
                                                                    NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *) response;
                                                                    
                                                                    /*  "{
                                                                     "message": "The request is invalid.",
                                                                     "modelState": {
                                                                     "userModel.Email": [
                                                                     "Please enter correct email"
                                                                     ]
                                                                     }
                                                                     }"
                                                                     "*/
                                                                    
                                                                    NSMutableDictionary *errorDict=[[NSMutableDictionary alloc]init];
                                                                    NSMutableDictionary *modelStatedict=[[NSMutableDictionary alloc]init];
                                                                    NSArray *modelStatearray=[[NSArray alloc]init];
                                                                    modelStatearray=[[NSMutableArray alloc]initWithObjects:@"Please Check your internet connection. Try again later.",nil];
                                                                    [modelStatedict setObject:modelStatearray forKey:@"errorMessage"];
                                                                    [errorDict setObject:modelStatedict forKey:@"modelState"];
                                                                    
                                                                    
                                                                    [self onBackendResponse:errorDict withSuccess:httpResponse.statusCode error:nil];
                                                                    
                                                                    NSLog(@"Response in error part and code = %ld",(long)httpResponse.statusCode);
                                                                    
                                                                }
                                                                
                                                            }];
    [dataTaskBrief resume];
    [defaultSession finishTasksAndInvalidate];
    
}



// Callback
- (void)callBackResponse:(NSDictionary *)response withSuccess:(NSInteger)statusCode error:(NSError *)error
{
    getServerResponseForUrlCallback(statusCode, response, error);
}

// Added By:Nalina
// Added Date:29/07/16
// Description: Show the alert
- (UIViewController*) topMostController {
    UIViewController *topController = [UIApplication sharedApplication].keyWindow.rootViewController;
    
    while (topController.presentedViewController) {
        topController = topController.presentedViewController;
    }
    
    return topController;
}


// Added By:Zeenath
// Added Date:20/08/16
// Description: Function to convert the time format from 24hours to 12hours
-(NSString *)Convert24FormatTo12Format:(NSString *)time{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"HH:mm:ss"];
    
    NSDate *amPmDate = [formatter dateFromString:time];
    [formatter setDateFormat:@"hh:mm a"];
    
    NSString *HourString = [formatter stringFromDate:amPmDate];
    return HourString;
}


// Added By:Zeenath
// Added Date:20/08/16
// Description: Function to convert the time format from 12hours to 24hours
-(NSString *)Convert12FormatTo24Format:(NSString *)time{
    NSString *HourString;
    if (![time isEqualToString:@""]) {
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"hh:mm a"];
        NSDate *amPmDate = [formatter dateFromString:time];
        [formatter setDateFormat:@"HH:mm"];
        HourString = [formatter stringFromDate:amPmDate];
    }else{
        HourString = @"";
    }
    
    return HourString;
}

-(void) redirectToNextPage{
    
    /*UIStoryboard *storyboard = [UIStoryboard storyboardWithName:
     @"myOtherStoryboard" bundle:nil];
     [self presentViewController:[storyboard instantiateViewControllerWithIdentifier:
     @"myViewOfOtherStoryaboard"] animated:NO completion:nil];*/
}

@end
