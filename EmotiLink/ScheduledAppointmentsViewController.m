/***************************************************************
 Page name: ScheduledAppointmentsViewController.m
 Created By:Nalina
 Created Date:11/07/16
 Description: scheduled appointment implementation file
 ***************************************************************/

#import "ScheduledAppointmentsViewController.h"
#import "ScheduledAppointmentTableViewCell.h"
#import "GlobalFunction.h"
#import "ClientDetailsViewController.h"
#import <Google/Analytics.h>
#include "AppDelegate.h"
#import <HCSStarRatingView/HCSStarRatingView.h>
#define appdelegat (AppDelegate *)[[UIApplication sharedApplication]delegate]
@interface ScheduledAppointmentsViewController (){
    NSArray *_sections;
    NSMutableArray *_testArray;
}
@property (nonatomic) BOOL useCustomCells;
@property (nonatomic, weak) UIRefreshControl *refreshControl;


@end

@implementation ScheduledAppointmentsViewController


//Loads first time when page appears
- (void)viewDidLoad {
    
    UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
    [refreshControl addTarget:self action:@selector(toggleCells:) forControlEvents:UIControlEventValueChanged];
    refreshControl.tintColor = [UIColor blueColor];
    
    self.refreshControl = refreshControl;
    

    scheduledAppointmentArray = [NSMutableArray array];
    _searchText.delegate=self;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldChange:) name:UITextFieldTextDidChangeNotification object:_searchText];
    
    [super viewDidLoad];
    UIImageView *bgImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"05. List-View.png"]];
    bgImageView.frame = self.view.bounds;
    bgImageView.contentMode = UIViewContentModeScaleAspectFill;
    bgImageView.clipsToBounds = YES;
    [self.view addSubview:bgImageView];
    [self.view sendSubviewToBack:bgImageView];
    
}

-(void)viewDidAppear:(BOOL)animated{
    //Added by: Zeenath
    //Added Date: 20/08/2016
    //Discription: service call to get the list of scheduled appointments
    
    // GlobalFunction *globalValues=[[GlobalFunction alloc]init];
    AppDelegate *appdelegate= (AppDelegate *)[[UIApplication sharedApplication]delegate];
    NSString *getUrl=[appdelegate.serviceURL stringByAppendingString:@"api/Appointments/ScheduleAppointment"];
    [self startLoadingIndicator];
    [[GlobalFunction sharedInstance] getServerResponseAfterLogin:getUrl method:@"GET" param:nil withCallback:^(NSInteger statusCode, NSDictionary *response, NSError *error)
     {
         if (statusCode == 200)
         {
             scheduledAppointmentArray=[response mutableCopy];
             myProvidersAllDataArray=scheduledAppointmentArray;
             [self stopLoadingIndicator];
             [_scheduledTable reloadData];
             
         }
         else if(statusCode==404){
             [self stopLoadingIndicator];
             [_scheduledTable reloadData];
             _alert = [UIAlertController
                       alertControllerWithTitle:@""
                       message:[[GlobalFunction sharedInstance].arrayOfAlerts objectAtIndex:83]
                       preferredStyle:UIAlertControllerStyleAlert];
             
             UIAlertAction* okButton = [UIAlertAction
                                        actionWithTitle:@"OK"
                                        style:UIAlertActionStyleDefault
                                        handler:^(UIAlertAction * action) {
                                            //[self.navigationController popViewControllerAnimated:YES];
                                            [self dismissViewControllerAnimated:YES completion:nil];
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
    
}

//Added by: Zeenath
//Added Date: 20/08/2016
//Discription: function to reload the table the content that matches the search text

- (void)textFieldChange:(NSNotification *)notification {
    if(_searchText == nil)
    {
        
    }
    else if([_searchText.text isEqualToString:@""])
    {
        scheduledAppointmentArray=myProvidersAllDataArray;
        
    }
    else{
        NSMutableArray  *resultObjectsArray = [NSMutableArray array];
        @autoreleasepool {
            
            for(NSDictionary *myProvider in scheduledAppointmentArray)
            {
                NSString *providerName = [[myProvider objectForKey:@"providerFirstName"] stringByAppendingString:[myProvider objectForKey:@"providerLastName"]];
                
                NSRange range = [providerName rangeOfString:_searchText.text options:NSCaseInsensitiveSearch];
                if(range.location != NSNotFound)
                    [resultObjectsArray addObject:myProvider];
                
            }
        }
        scheduledAppointmentArray=resultObjectsArray;
    }
    [_scheduledTable reloadData];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

//Loads each time when page appears
-(void)viewWillAppear:(BOOL)animated
{
    
    id<GAITracker> tracker = [[GAI sharedInstance] defaultTracker];
    [tracker set:kGAIScreenName value:@"ScheduledAppointments"];
    [tracker send:[[GAIDictionaryBuilder createScreenView] build]];
    
}

//Close screen
-(void)goBack{
    [self.navigationController popViewControllerAnimated:YES];
}

//Return number of section in table
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

//Return the number of rows count to display in table
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return scheduledAppointmentArray.count;
}

//Return the data to display and cell in table
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //Added by: Zeenath
    //Added Date: 20/08/2016
    //Discription: Bind the data to the table cell
    
    ScheduledAppointmentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"scheduledCell" forIndexPath:indexPath];
    [cell setRightUtilityButtons:[self rightButtons] WithButtonWidth:58.0f];
    
    
    //cell.profileImageView.layer.cornerRadius = cell.profileImageView.frame.size.width / 2;
    cell.profileImageView.clipsToBounds = YES;
    
    cell.delegate = self;
    NSString *item = scheduledAppointmentArray[indexPath.row];
    cell.itemText = item;
    if ([self.cellsCurrentlyEditing containsObject:indexPath]) {
    }
    
    cell.cancelBtn.tag = indexPath.row;
    [cell.cancelBtn addTarget:self action:@selector(AcceptClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    NSDictionary *myJsonResponseIndividualElement = scheduledAppointmentArray[indexPath.row];
    
    if ([[[appdelegat usersDetails] objectForKey:@"userRole"] isEqualToString:@"Provider"]) {
        //NSString *name=[myJsonResponseIndividualElement[@"clientDisplayName"] stringByAppendingString:@" "];
        cell.firstnameLabel.text= myJsonResponseIndividualElement[@"clientDisplayName"]; //[name stringByAppendingString:myJsonResponseIndividualElement[@"clientLastName"]];
        
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
    }
    
    else{
        NSString *name=[myJsonResponseIndividualElement[@"providerFirstName"] stringByAppendingString:@" "];
        cell.firstnameLabel.text= [name stringByAppendingString:myJsonResponseIndividualElement[@"providerLastName"]];
        
        AppDelegate *appdelegate=(AppDelegate *)[[UIApplication sharedApplication]delegate];
        NSString *imagePath= myJsonResponseIndividualElement[@"providerProfilePicPath"];
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
    }
    
    
    cell.amountLabel.text=myJsonResponseIndividualElement[@"offeredAmountCurrency"];
    
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
    
    
    cell.dayLabel.text=date;
    
    cell.dateTimeLabel.text=[[starttime stringByAppendingString:@" - "] stringByAppendingString:endtime];
    
    NSString *rateValue=myJsonResponseIndividualElement[@"rating"];
    HCSStarRatingView *starRatingView = [[HCSStarRatingView alloc] initWithFrame:CGRectMake(90, 0, 100, 50)];
    starRatingView.maximumValue = 5;
    starRatingView.minimumValue = 0;
    starRatingView.allowsHalfStars = YES;
    starRatingView.enabled=false;
    starRatingView.value = [rateValue floatValue];
    
    starRatingView.tintColor = [UIColor colorWithRed:118.0/255.0 green:183.0/255.0 blue:189.0/255.0 alpha:1];
    //starRatingView.BorderColor=[UIColor colorWithRed:118.0/255.0 green:183.0/255.0 blue:189.0/255.0 alpha:1];
    starRatingView.backgroundColor=[UIColor clearColor];
    
    [starRatingView addTarget:self action:@selector(didChangeValue:) forControlEvents:UIControlEventValueChanged];
    [cell addSubview:starRatingView];
    
    return cell;
}

- (IBAction)didChangeValue:(HCSStarRatingView *)sender {
    NSLog(@"Changed rating to %.1f", sender.value);
}

//Return selected row in table
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    /*ClientDetailsViewController *vc=[self.storyboard instantiateViewControllerWithIdentifier:@"clientDetails"];
    vc.detailsDict=scheduledAppointmentArray[indexPath.row];
    vc.screenStatus=@"scheduledAppointment";
    [self.navigationController pushViewController:vc animated:YES];*/
}


//Added by: Zeenath
//Added Date: 20/08/2016
//Discription: To cancel the cheduled appointment

- (void)AcceptClicked:(UIButton*)sender{
    UIButton *btn=(UIButton *)sender;
    AppDelegate *appdelegate=(AppDelegate *)[[UIApplication sharedApplication]delegate];
    NSDictionary *myJsonResponseIndividualElement = scheduledAppointmentArray[btn.tag];
    NSDictionary *appointmentID =  myJsonResponseIndividualElement[@"appointmentID"];
    NSMutableDictionary *dict=[[NSMutableDictionary alloc]init];
    [dict setObject:appointmentID forKey:@"appointmentID"];
    [dict setObject:@"" forKey:@"comments"];
    
    // GlobalFunction *globalValues=[[GlobalFunction alloc]init];
    
    _alert = [UIAlertController
              alertControllerWithTitle:@""
              message:[[GlobalFunction sharedInstance].arrayOfAlerts objectAtIndex:59]
              preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* yesButton = [UIAlertAction
                                actionWithTitle:@"Yes"
                                style:UIAlertActionStyleDefault
                                handler:^(UIAlertAction * action) {
                                    CGPoint touchPoint = [sender convertPoint:CGPointZero toView:self.scheduledTable];
                                    NSIndexPath *indexPath = [self.scheduledTable indexPathForRowAtPoint:touchPoint];
                                    [scheduledAppointmentArray removeObjectAtIndex:indexPath.row];
                                    [self.scheduledTable reloadData];
                                    NSString *Url=[appdelegate.serviceURL stringByAppendingString:@"api/Appointments/CancelAppointment"];
                                    [self startLoadingIndicator];
                                    [[GlobalFunction sharedInstance]getServerResponseAfterLogin:Url method:@"POST" param:dict withCallback:^(NSInteger statusCode, NSDictionary *response, NSError *error) {
                                        if(statusCode == 200)
                                        {
                                            
                                        }
                                        [self stopLoadingIndicator];
                                        
                                    }];
                                    
                                    
                                }];
    
    UIAlertAction* noButton = [UIAlertAction
                               actionWithTitle:@"No"
                               style:UIAlertActionStyleDefault
                               handler:^(UIAlertAction * action) {
                                   //Handle your yes please button action here
                               }];
    
    [_alert addAction:yesButton];
    [_alert addAction:noButton];
    [self presentViewController:_alert animated:YES completion:nil];
}


- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [scheduledAppointmentArray removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else {
        NSLog(@"Unhandled editing style!");
    }
}


- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return NO;
}

#pragma mark - SwipeableCellDelegate
- (void)buttonOneActionForItemText:(NSString *)itemText {
    // NSLog(@"In the delegate, Clicked button one for %@", itemText);
}

- (void)buttonTwoActionForItemText:(NSString *)itemText {
    // NSLog(@"In the delegate, Clicked button two for %@", itemText);
}


//Close the screen on click of back icon
- (IBAction)backClick:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
}

//Hides the textpad
- (BOOL)textFieldShouldReturn:(UITextField *)theTextField {
    [_searchText resignFirstResponder];
    return YES;
}


//Added by: Zeenath
//Added Date: 20/08/2016
//Discription:To start the indicator

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

//Added by: Zeenath
//Added Date: 20/08/2016
//Discription:To stop the indicator

-(void)stopLoadingIndicator
{
    
    _loadingView.hidden=YES;
}


//Added by: Nalina
//Added Date: 11/07/2016
//Discription:Search button click to show search bar

- (IBAction)searchButtonClick:(id)sender {
    _scheduleAppointmentView.hidden = YES;
    _searchView.hidden=NO;
    scheduledAppointmentArray=myProvidersAllDataArray;
    [_scheduledTable reloadData];
}


//Added by: Nalina
//Added Date: 11/07/2016
//Discription:Search close button click to hide search bar

- (IBAction)searchCloseClick:(id)sender {
    _scheduleAppointmentView.hidden = NO;
    _searchView.hidden=YES;
    
}

- (IBAction)backArrowClick:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - UIRefreshControl Selector

- (void)toggleCells:(UIRefreshControl*)refreshControl
{
    [refreshControl beginRefreshing];
    self.useCustomCells = !self.useCustomCells;
    if (self.useCustomCells)
    {
        self.refreshControl.tintColor = [UIColor yellowColor];
    }
    else
    {
        self.refreshControl.tintColor = [UIColor blueColor];
    }
    [_scheduledTable reloadData];
    [refreshControl endRefreshing];
}



- (NSArray *)rightButtons
{
    NSMutableArray *rightUtilityButtons = [NSMutableArray new];
            [rightUtilityButtons sw_addUtilityButtonWithColor:
         [UIColor colorWithRed:247.0/255.0 green:123.0/255.0 blue:132.0/255.0 alpha:1]
                                                     icon:[UIImage imageNamed:@"deleted.png"]];
   return rightUtilityButtons;
}

// Set row height on an individual basis

//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
//    return [self rowHeightForIndexPath:indexPath];
//}
//
//- (CGFloat)rowHeightForIndexPath:(NSIndexPath *)indexPath {
//    return ([indexPath row] * 10) + 60;
//}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    // Set background color of cell here if you don't want default white
}

#pragma mark - SWTableViewDelegate

- (void)swipeableTableViewCell:(SWTableViewCell *)cell scrollingToState:(SWCellState)state
{
    switch (state) {
        case 0:
            NSLog(@"utility buttons closed");
            break;
        case 1:
            NSLog(@"left utility buttons open");
            break;
        case 2:
            NSLog(@"right utility buttons open");
            break;
        default:
            break;
    }
}

- (void)swipeableTableViewCell:(SWTableViewCell *)cell didTriggerLeftUtilityButtonWithIndex:(NSInteger)index
{
    switch (index) {
        case 0:
            NSLog(@"left button 0 was pressed");
            break;
        case 1:
            NSLog(@"left button 1 was pressed");
            break;
        case 2:
            NSLog(@"left button 2 was pressed");
            break;
        case 3:
            NSLog(@"left btton 3 was pressed");
        default:
            break;
    }
}

- (void)swipeableTableViewCell:(SWTableViewCell *)cell didTriggerRightUtilityButtonWithIndex:(NSInteger)index
{
   
    switch (index) {
            
        case 0:
        {
            NSLog(@"delete button was pressed");
            // Delete button was pressed
            // Delete button was pressed
            /*NSIndexPath *cellIndexPath = [_sessionHistoryTable indexPathForCell:cell];
             [sessionHistoryArray removeObjectAtIndex:cellIndexPath.row];
             //[_testArray[cellIndexPath.section] removeObjectAtIndex:cellIndexPath.row];
             [_sessionHistoryTable deleteRowsAtIndexPaths:@[cellIndexPath] withRowAnimation:UITableViewRowAnimationLeft];*/
            AppDelegate *appdelegate=(AppDelegate *)[[UIApplication sharedApplication]delegate];
            NSDictionary *myJsonResponseIndividualElement = scheduledAppointmentArray[index];
            NSDictionary *appointmentID =  myJsonResponseIndividualElement[@"appointmentID"];
            NSMutableDictionary *dict=[[NSMutableDictionary alloc]init];
            [dict setObject:appointmentID forKey:@"appointmentID"];
            [dict setObject:@"" forKey:@"comments"];
            [dict setObject:@"2" forKey:@"rating"];
            
            // GlobalFunction *globalValues=[[GlobalFunction alloc]init];
            
            _alert = [UIAlertController
                      alertControllerWithTitle:@""
                      message:[[GlobalFunction sharedInstance].arrayOfAlerts objectAtIndex:59]
                      preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction* yesButton = [UIAlertAction
                                        actionWithTitle:@"Yes"
                                        style:UIAlertActionStyleDefault
                                        handler:^(UIAlertAction * action) {
                                            
                                            NSString *Url=[appdelegate.serviceURL stringByAppendingString:@"api/Appointments/CancelAppointment"];
                                            [self startLoadingIndicator];
                                            [[GlobalFunction sharedInstance]getServerResponseAfterLogin:Url method:@"POST" param:dict withCallback:^(NSInteger statusCode, NSDictionary *response, NSError *error) {
                                                if(statusCode == 200)
                                                {
                                                    NSIndexPath *indexPath =[_scheduledTable indexPathForCell:cell];
                                                    [scheduledAppointmentArray removeObjectAtIndex:indexPath.row];
                                                    [self.scheduledTable reloadData];
                                                    
                                                }
                                                [self stopLoadingIndicator];
                                                
                                            }];
                                            
                                            
                                        }];
            
            UIAlertAction* noButton = [UIAlertAction
                                       actionWithTitle:@"No"
                                       style:UIAlertActionStyleDefault
                                       handler:^(UIAlertAction * action) {
                                           //Handle your yes please button action here
                                       }];
            
            [_alert addAction:yesButton];
            [_alert addAction:noButton];
            [self presentViewController:_alert animated:YES completion:nil];
            break;
        }
            
            
        default:
            break;
            
    }
}

- (BOOL)swipeableTableViewCellShouldHideUtilityButtonsOnSwipe:(SWTableViewCell *)cell
{
    // allow just one cell's utility button to be open at once
    return YES;
}

- (BOOL)swipeableTableViewCell:(SWTableViewCell *)cell canSwipeToState:(SWCellState)state
{
    switch (state) {
        case 1:
            // set to NO to disable all left utility buttons appearing
            return YES;
            break;
        case 2:
            // set to NO to disable all right utility buttons appearing
            return YES;
            break;
        default:
            break;
    }
    
    return YES;
}

@end
