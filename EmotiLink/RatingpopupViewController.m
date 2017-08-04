//
//  RatingpopupViewController.m
//  EmotiLink
//
//  Created by Star on 4/11/17.
//  Copyright © 2017 Stark. All rights reserved.
//

#import "RatingpopupViewController.h"
#include "GlobalFunction.h"
#import "AppDelegate.h"
#import "SessionSummaryViewController.h"
#import <HCSStarRatingView/HCSStarRatingView.h>

@interface RatingpopupViewController ()

@end

@implementation RatingpopupViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.modalPresentationStyle = UIModalPresentationCurrentContext;
    [self setBorderColor:5];
    [self setBorderColor:1];
    
    ratingSelectedValue=0;
    HCSStarRatingView *starRatingView = [[HCSStarRatingView alloc] initWithFrame:CGRectMake(80, 0, 210, 61)];
    starRatingView.maximumValue = 5;
    starRatingView.minimumValue = 0;
    starRatingView.allowsHalfStars = YES;
    starRatingView.enabled=YES;
    starRatingView.value = 0; //rateValue;
    starRatingView.tintColor = [UIColor colorWithRed:118.0/255.0 green:183.0/255.0 blue:189.0/255.0 alpha:1];
    //starRatingView.BorderColor=[UIColor colorWithRed:118.0/255.0 green:183.0/255.0 blue:189.0/255.0 alpha:1];
    starRatingView.backgroundColor=[UIColor clearColor];
    
    [starRatingView addTarget:self action:@selector(didChangeValue:) forControlEvents:UIControlEventValueChanged];
    [_firstFilterView addSubview:starRatingView];
    // Do any additional setup after loading the view.
    
    _RatingTextView.text = @"Comments";
    _RatingTextView.textColor = [UIColor darkGrayColor];
}
- (IBAction)didChangeValue:(HCSStarRatingView *)sender {
    NSLog(@"Changed rating to %.1f", sender.value);
    ratingSelectedValue=sender.value;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void) setBorderColor:(int)tagName{
    UIButton *cancelBtn = (UIButton *) [self.view viewWithTag:tagName];
    cancelBtn.layer.borderColor = [UIColor colorWithRed:246.0/255.0 green:108.0/255.0 blue:118.0/255.0 alpha:1].CGColor;
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

- (IBAction)Skipbtn:(id)sender {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:
                                @"UserStoryboard" bundle:nil];
    
    SessionSummaryViewController *SessionSummaryView=[storyboard instantiateViewControllerWithIdentifier:@"SessionSummary"];
    
    SessionSummaryView.totalSessionTime=_timespent;
    SessionSummaryView.sessionDetails=_sessionDetails;
    self.modalPresentationStyle = UIModalPresentationFullScreen;
    SessionSummaryView.modalPresentationStyle = UIModalPresentationOverCurrentContext;
    
    [self presentViewController:SessionSummaryView animated:NO completion:nil];
    
    
}

- (IBAction)SubmitBtn:(id)sender {
    AppDelegate *appdelegate=(AppDelegate *)[[UIApplication sharedApplication]delegate];
    
    _details=[[appdelegate usersDetails]valueForKey:@"nextScheduledAppointment"];
    
    
    NSMutableDictionary *dict=[[NSMutableDictionary alloc]init];
    [dict setObject:[_details objectForKey:@"appointmentID"] forKey:@"appointmentsId"];
    [dict setObject: _RatingTextView.text forKey:@"comments"];
    [dict setObject: [NSNumber numberWithFloat:ratingSelectedValue] forKey:@"rating"];
    
    
    
    NSLog(@"parameters sent2%@",dict);
    NSString *Url=[appdelegate.serviceURL stringByAppendingString:@"api/Feedback/PostUserFeedback"];;
    [[GlobalFunction sharedInstance]getServerResponseAfterLogin:Url method:@"POST" param:dict withCallback:^(NSInteger statusCode, NSDictionary *response, NSError *error) {
        if(statusCode == 200)
        {
            UIStoryboard *storyboard = [UIStoryboard storyboardWithName:
                                        @"UserStoryboard" bundle:nil];
            
            SessionSummaryViewController *SessionSummaryView=[storyboard instantiateViewControllerWithIdentifier:@"SessionSummary"];
            SessionSummaryView.sessionDetails=_sessionDetails;
            SessionSummaryView.totalSessionTime=_timespent;
            self.modalPresentationStyle = UIModalPresentationFullScreen;
            SessionSummaryView.modalPresentationStyle = UIModalPresentationOverCurrentContext;
            
            [self presentViewController:SessionSummaryView animated:NO completion:nil];
        }
    }];
    }

- (BOOL) textViewShouldBeginEditing:(UITextView *)textView
{
    
    if([_RatingTextView.text isEqualToString:@"Comments"])
    {
        _RatingTextView.text = @"";
    }
    _RatingTextView.textColor = [UIColor blackColor];
    return YES;
}

@end
