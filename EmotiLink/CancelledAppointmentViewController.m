/***************************************************************
 Page name: CancelledAppointmentViewController.m
 Created By:Nalina
 Created Date:11/07/16
 Description:cancelled appointment implementation file
 ***************************************************************/

#import "CancelledAppointmentViewController.h"
#import "CancelledAppointmentTableViewCell.h"
#import <Google/Analytics.h>
#include "AppDelegate.h"
#include "GlobalFunction.h"
@interface CancelledAppointmentViewController ()

@end

@implementation CancelledAppointmentViewController

//Loads first time when page appears
- (void)viewDidLoad {
    
    cancelledAppointments = [NSMutableArray array];
    
    //Added by: Zeenath
    //Added Date: 20/08/2016
    //Discription: service call to get the list of scheduled appointments
    
 //   GlobalFunction *[GlobalFunction sharedInstance]=[[GlobalFunction alloc]init];
    AppDelegate *appdelegate= (AppDelegate *)[[UIApplication sharedApplication]delegate];
    NSString *getUrl=[appdelegate.serviceURL stringByAppendingString:@"api/Appointments/CanceledAppointments"];
    [self startLoadingIndicator];
    [[GlobalFunction sharedInstance] getServerResponseAfterLogin:getUrl method:@"GET" param:nil withCallback:^(NSInteger statusCode, NSDictionary *response, NSError *error)
     {
         if (statusCode == 200)
         {
            
             cancelledAppointments=[response mutableCopy];
             [self stopLoadingIndicator];
             [_cancelledAppointmentsTable reloadData];
             
         }else if(statusCode==404){
             [self stopLoadingIndicator];
             _alert = [UIAlertController
                       alertControllerWithTitle:@""
                       message:[[GlobalFunction sharedInstance].arrayOfAlerts objectAtIndex:97]
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
                                            [self stopLoadingIndicator];
                                        }];
             [_alert addAction:okButton];
             [self presentViewController:_alert animated:YES completion:nil];
         }
     }];

    [super viewDidLoad];
}

//Loads each time when page appears
-(void)viewWillAppear:(BOOL)animated
{
    id<GAITracker> tracker = [[GAI sharedInstance] defaultTracker];
    [tracker set:kGAIScreenName value:@"CancelledAppointments"];
    [tracker send:[[GAIDictionaryBuilder createScreenView] build]];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


//Return number of section in table
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

//Return the number of rows count to display in table
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return cancelledAppointments.count;
}

//Return the data to display and cell in table
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //Added by: Zeenath
    //Added Date: 20/08/2016
    //Discription: Bind the data to the table cell
    
    CancelledAppointmentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cancelledCell" forIndexPath:indexPath];
     cell.profileImageView.layer.cornerRadius = cell.profileImageView.frame.size.width / 2;
     cell.profileImageView.clipsToBounds = YES;
    
    if (indexPath.row % 2) {
        cell.mainview.backgroundColor = [[UIColor alloc]initWithRed:51.0/255.0 green:51.0/255.0 blue:51.0/255.0 alpha:1];
    }else{
        cell.mainview.backgroundColor =[[UIColor alloc]initWithRed:62.0/255.0 green:62.0/255.0 blue:62.0/255.0 alpha:1];
    }
    
    NSDictionary *myJsonResponseIndividualElement = cancelledAppointments[indexPath.row];
    
    NSString *name=[myJsonResponseIndividualElement[@"clientFirstName"] stringByAppendingString:@" "];
    cell.firstNameLabel.text= [name stringByAppendingString:myJsonResponseIndividualElement[@"clientLastName"]];
    
    AppDelegate *appdelegate=(AppDelegate *)[[UIApplication sharedApplication]delegate];
    NSString *imagePath= myJsonResponseIndividualElement[@"clientProfilePicPath"];
    NSString *imagename=[appdelegate.imageURL stringByAppendingString:imagePath];
    dispatch_queue_t imagequeue =dispatch_queue_create("imageDownloader", nil);
    dispatch_async(imagequeue, ^{
        
        //download iamge
        NSData *imageData = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:imagename]];
        UIImage *image = [[UIImage alloc] initWithData:imageData];
        dispatch_async(dispatch_get_main_queue(), ^{
            
            if (image==NULL) {
                UIImage *image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"upload-profile" ofType:@"png"]];
                cell.profileImageView.image  = image;
            }
            else{
                cell.profileImageView.image  = image;
            }
        });
        
    });
    
    cell.amountOfferedLabel.text=myJsonResponseIndividualElement[@"offeredAmountCurrency"];
    
    NSString *getDate=myJsonResponseIndividualElement[@"appointmentDate"];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss"];
    NSDate *dateFromString = [[NSDate alloc] init];
    dateFromString = [dateFormatter dateFromString:getDate];
    
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    format.dateFormat = @"EEE dd MMM YYYY";
    NSString *date=[format stringFromDate:dateFromString];
    
    NSString *starttime=  [[GlobalFunction sharedInstance] Convert24FormatTo12Format:myJsonResponseIndividualElement[@"scheduledStartTime"]];
    NSString *endtime=  [[GlobalFunction sharedInstance] Convert24FormatTo12Format:myJsonResponseIndividualElement[@"scheduledEndTime"]];
    
    NSString *appointmentTime=[[date stringByAppendingString:@", from "] stringByAppendingString:starttime];
    
    
    cell.dateTimeLabel.text=[[appointmentTime stringByAppendingString:@" to "] stringByAppendingString:endtime];
    return cell;
}

//Close the screen on click of back icon
- (IBAction)backClick:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}


//  Added by:Zeenath
//  Added Date:2016-18-08.
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
//  Added Date:2016-18-08.
//  Description:To stop the activity indicator.

-(void)stopLoadingIndicator
{
    _loadingView.hidden=YES;
}


@end
