/***************************************************************
 Page name: MyProvidersViewController.h
 Created By:Nalina
 Created Date:12/07/16
 Description:my provider implementation file
 ***************************************************************/

#import "MyProvidersViewController.h"
#import "MyprovidersTableViewCell.h"
#import "AppDelegate.h"
#import "GlobalFunction.h"
#import "MakeAnAppointmentViewController.h"
#import "ProviderDetailsViewController.h"
#import <Google/Analytics.h>
#import <HCSStarRatingView/HCSStarRatingView.h>
#import "paymentInfoViewController.h"
#import "AppointmentRequestOptionsPopUpViewController.h"
@interface MyProvidersViewController ()

@end

@implementation MyProvidersViewController

//Loads first time when page appears
- (void)viewDidLoad {
    myProvidersArray = [NSMutableArray array];
    providerDetails= [[NSMutableDictionary alloc]init];
    _values=[[NSMutableArray alloc] init];
    
    _searchTxt.delegate=self;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldDidChange:) name:UITextFieldTextDidChangeNotification object:_searchTxt];
    [super viewDidLoad];
    UIImageView *bgImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"05. List-View.png"]];
    bgImageView.frame = self.view.bounds;
    bgImageView.contentMode = UIViewContentModeScaleAspectFit;
    bgImageView.clipsToBounds = YES;
    [_myProviderViewBackground addSubview:bgImageView];
    [_myProviderViewBackground sendSubviewToBack:bgImageView];
    
}

//Loads each time when page appears completes
-(void)viewDidAppear:(BOOL)animated{
    
    //Added by: Nalina
    //Added Date: 16/08/2016
    //Discription: service call to get the list of the providers and the details
    
    if (![_screenStatus isEqualToString:@"fromDashboard"]) {
        [[[[self.tabBarController tabBar]items]objectAtIndex:0]setEnabled:FALSE];
        [[[[self.tabBarController tabBar]items]objectAtIndex:1]setEnabled:FALSE];
        [[[[self.tabBarController tabBar]items]objectAtIndex:3]setEnabled:FALSE];
    }
    //GlobalFunction *globalValues=[[GlobalFunction alloc]init];
    AppDelegate *appdelegate= (AppDelegate *)[[UIApplication sharedApplication]delegate];
    NSString *getProviderUrl=[appdelegate.serviceURL stringByAppendingString:@"api/ProviderSearch/MyFavorites"];
    [self startLoadingIndicator];
    [[GlobalFunction sharedInstance] getServerResponseAfterLogin:getProviderUrl method:@"GET" param:nil withCallback:^(NSInteger statusCode, NSDictionary *response, NSError *error)
     {
         NSLog(@"response data=%@",response);
         if (![_screenStatus isEqualToString:@"fromDashboard"]) {
             [[[[self.tabBarController tabBar]items]objectAtIndex:0]setEnabled:TRUE];
             [[[[self.tabBarController tabBar]items]objectAtIndex:1]setEnabled:TRUE];
             [[[[self.tabBarController tabBar]items]objectAtIndex:3]setEnabled:TRUE];
         }
         if (statusCode == 200)
         {
             myProvidersArray=[response mutableCopy];
             myProvidersAllDataArray=myProvidersArray;
             [self stopLoadingIndicator];
             [_providerTable reloadData];
             
         }else if(statusCode==404){
             [self stopLoadingIndicator];
             _alert = [UIAlertController
                       alertControllerWithTitle:@""
                       message:[[GlobalFunction sharedInstance].arrayOfAlerts objectAtIndex:78]
                       preferredStyle:UIAlertControllerStyleAlert];
             
             UIAlertAction* okButton = [UIAlertAction
                                        actionWithTitle:@"OK"
                                        style:UIAlertActionStyleDefault
                                        handler:^(UIAlertAction * action) {
                                            /*[self.navigationController popViewControllerAnimated:YES];*/
                                            [self.tabBarController setSelectedIndex:0];
                                            
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
                                            [self dismissViewControllerAnimated:YES completion:nil];
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

- (void)textFieldDidChange:(NSNotification *)notification {
    if([_searchTxt.text isEqualToString:@""])
    {
        myProvidersArray=myProvidersAllDataArray;
        
    }
    else{
        NSMutableArray  *resultObjectsArray = [NSMutableArray array];
        @autoreleasepool {
            
            for(NSDictionary *myProvider in myProvidersArray)
            {
                NSString *providerName = [[myProvider objectForKey:@"firstName"] stringByAppendingString:[myProvider objectForKey:@"lastName"]];
                
                NSRange range = [providerName rangeOfString:_searchTxt.text options:NSCaseInsensitiveSearch];
                if(range.location != NSNotFound)
                    [resultObjectsArray addObject:myProvider];
                
            }
        }
        myProvidersArray=resultObjectsArray;
    }
    [_providerTable reloadData];
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
    @autoreleasepool {
        
        for(int i=0;i<myProvidersArray.count;i++){
            ToggleButton *obj=[[ToggleButton alloc] init];
            [_values addObject:obj];
        }
    }
    
    return myProvidersArray.count;
}

//Return the data to display and cell in table
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    MyprovidersTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"myProviderCell" forIndexPath:indexPath];
    
    //cell.profileImageView.layer.cornerRadius = cell.profileImageView.frame.size.width / 2;
    cell.profileImageView.clipsToBounds = YES;
    
    NSDictionary *myJsonResponseIndividualElement = myProvidersArray[indexPath.row];
    
    NSString *name=[myJsonResponseIndividualElement[@"firstName"] stringByAppendingString:@" "];
    cell.firstNameLabel.text= [name stringByAppendingString:myJsonResponseIndividualElement[@"lastName"]];
    AppDelegate *appdelegate=(AppDelegate *)[[UIApplication sharedApplication]delegate];
    
    if ([myJsonResponseIndividualElement[@"profilePicPath"] isEqual:[NSNull null]]) {
        
    }else{
        
        NSString *imagePath= myJsonResponseIndividualElement[@"profilePicPath"];
        NSString *imagename=[appdelegate.imageURL stringByAppendingString:imagePath];
        dispatch_queue_t imagequeue =dispatch_queue_create("imageDownloader", nil);
        dispatch_async(imagequeue, ^{
            
            //download iamge
            NSData *imageData = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:imagename]];
            UIImage *image = [[UIImage alloc] initWithData:imageData];
            dispatch_async(dispatch_get_main_queue(), ^{
                if (image==NULL) {
                    UIImage *image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"imagePlaceholder" ofType:@"png"]];
                    cell.profileImageView.image  = image;
                }
                else{
                    cell.profileImageView.image  = image;
                }
            });
            
        });
    }
    
    if ([myJsonResponseIndividualElement[@"nextScheduledAppointment"] isEqual:[NSNull null]]) {
        cell.AppointmentBtn.hidden=NO;
        cell.haveAnAppointment.hidden=YES;
        //cell.appointmentLabel.hidden=YES;
        cell.appointmentLabel.text=@"book appointment";
        UIImage *image=[UIImage imageNamed:@"Forward-1.png"];
        [cell.forwardIcon setImage:image];
        
        cell.appointmentLabel.textColor =[UIColor  colorWithRed:(0/255.0) green:(0/255.0) blue:(0/255.0) alpha:1];
        
    }else{
        
        cell.haveAnAppointment.hidden=NO;
        cell.AppointmentBtn.hidden=YES;
        //cell.appointmentLabel.hidden=NO;
        UIImage *image=[UIImage imageNamed:@"Forward-Red.png"];
        [cell.forwardIcon setImage:image];
        
        NSString *getDate=[myJsonResponseIndividualElement[@"nextScheduledAppointment"] objectForKey:@"appointmentDate"];
        
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss"];
        NSDate *dateFromString = [[NSDate alloc] init];
        dateFromString = [dateFormatter dateFromString:getDate];
        
        NSDateFormatter *format = [[NSDateFormatter alloc] init];
        format.dateFormat = @"EEE,MMM YYYY";
        
        
        NSString *date=[format stringFromDate:dateFromString];
        
        cell.appointmentLabel.textColor =[UIColor  colorWithRed:(246/255.0) green:(108/255.0) blue:(115/255.0) alpha:1];
        
        
        cell.appointmentLabel.text = date;
        
        /* NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
         [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss"];
         NSDate *dateFromString = [[NSDate alloc] init];
         dateFromString = [dateFormatter dateFromString:getDate];
         NSDateFormatter *format = [[NSDateFormatter alloc] init];
         format.dateFormat = @"dd-MM-yyyy";
         
         NSString *nextAppointment=[NSString stringWithFormat:@"%@ %@ %@ %@",@"Next appointment on",[format stringFromDate:dateFromString],@"at",[self Convert24FormatTo12Format:[myJsonResponseIndividualElement[@"nextScheduledAppointment"] objectForKey:@"scheduledStartTime"]]];
         cell.appointmentLabel.text=nextAppointment;*/
    }
    
    if(![myJsonResponseIndividualElement[@"qualification"] isEqual:[NSNull null]])
    {
        cell.expertiseLabel.text=myJsonResponseIndividualElement[@"qualification"];
    }
    else{
        cell.expertiseLabel.text=@"";
    }
    
    NSNumber *availablity=myJsonResponseIndividualElement[@"isAvailable"];
    if([availablity isEqual:[NSNumber numberWithInt:0]]) {
        UIImage *image=[UIImage imageNamed:@"not-available.png"];
        [cell.availableBtn setImage:image forState:UIControlStateNormal];
    }else{
        UIImage *image=[UIImage imageNamed:@"available.png"];
        [cell.availableBtn setImage:image forState:UIControlStateNormal];
    }
    
    cell.rateLabel.text=[myJsonResponseIndividualElement[@"rateCurrency"] stringByAppendingString:@"/hour"];
    
    cell.AppointmentBtn.tag=indexPath.row;
    [cell.AppointmentBtn addTarget:self action:@selector(MakeAnAppointment:) forControlEvents:UIControlEventTouchUpInside];
    
    cell.favoriteProviderIcon.tag=indexPath.row;
    
    cell.availableBtn.tag=indexPath.row;
    cell.providerInfoCellView.tag=indexPath.row;
    cell.availableBtnView.tag=indexPath.row;
    
    UITapGestureRecognizer *cellViewTap =
    [[UITapGestureRecognizer alloc] initWithTarget:self
                                            action:@selector(redirectToProviderDetails:)];
    [cell.providerInfoCellView addGestureRecognizer:cellViewTap];
    
    UITapGestureRecognizer *availBtnViewTap =
    [[UITapGestureRecognizer alloc] initWithTarget:self
                                            action:@selector(bookAppointmentClick:)];
    [cell.availableBtnView addGestureRecognizer:availBtnViewTap];
    
    ToggleButton *obj=[_values objectAtIndex:indexPath.row];
    cell.favoriteProviderIcon.selected=obj.selected;
    
    
    [cell.favoriteProviderIcon addTarget:self action:@selector(addToFavorites:) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    HCSStarRatingView *starRatingView = [[HCSStarRatingView alloc] initWithFrame:CGRectMake(90, 0, 100, 50)];
    starRatingView.maximumValue = 5;
    starRatingView.minimumValue = 0;
    starRatingView.allowsHalfStars = YES;
    starRatingView.enabled=false;
    starRatingView.value = 2; //rateValue;
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
    /* NSDictionary *myJsonResponseIndividualElement = myProvidersArray[indexPath.row];
     NSString *providerID=myJsonResponseIndividualElement[@"providerID"];
     ProviderDetailsViewController *vc=[self.storyboard instantiateViewControllerWithIdentifier:@"ProviderDetails"];
     vc.providersID=providerID;
     
     [self.navigationController pushViewController:vc animated:YES];
     */
    
    NSLog(@"Button Clicked");
    
    NSDictionary *myJsonResponseIndividualElement = myProvidersArray[indexPath.row];
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"GeneralStoryboard" bundle:nil];
    ProviderDetailsViewController *viewcontrol=[storyboard instantiateViewControllerWithIdentifier:@"ProviderDetails"];
    viewcontrol.providersID=myJsonResponseIndividualElement[@"providerID"];
    
    [self presentViewController:viewcontrol animated:NO completion:nil];
}

//Added by: Nalina
//Added Date: 24/08/2016
//Discription: Redirect to make an appointment screen

-(IBAction)MakeAnAppointment:(id)sender{
    NSLog(@"Button Clicked");
    AppDelegate *appdelegate=(AppDelegate *)[[UIApplication sharedApplication]delegate];
    
    //Discription: Payment popup for the first user
    
    NSDictionary *userStatus=[[appdelegate usersDetails]valueForKey:@"userStatus"];
    
    if(![appdelegate accessToken] || [appdelegate.accessToken isKindOfClass:[NSNull class]])
    {
        _alert = [UIAlertController
                  alertControllerWithTitle:@""
                  message:[[GlobalFunction sharedInstance].arrayOfAlerts objectAtIndex:131]
                  preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* okButton = [UIAlertAction
                                   actionWithTitle:@"OK"
                                   style:UIAlertActionStyleDefault
                                   handler:^(UIAlertAction * action) {
                                       [self dismissViewControllerAnimated:YES completion:nil];
                                   }];
        [_alert addAction:okButton];
        [self presentViewController:_alert animated:YES completion: nil];
        
    }else{
        
        if([[userStatus valueForKey:@"isPaymentInfoUpdated"] isEqualToNumber:[NSNumber numberWithInt:0]] )
        {
            NSLog(@"Payment Information");
            UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"UserStoryboard" bundle:nil];
            paymentInfoViewController *vc=[storyboard instantiateViewControllerWithIdentifier:@"paymentInfo"];
            [self presentViewController:vc animated:YES completion:nil];
            
        }else{
            
            NSLog(@"Make An Appointment");
            UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"UserStoryboard" bundle:nil];
            UIButton *btn=(UIButton *)sender;
            NSDictionary *myJsonResponseIndividualElement = myProvidersArray[btn.tag];
            
            MakeAnAppointmentViewController *vc=[storyboard instantiateViewControllerWithIdentifier:@"makeanappointment"];
            [providerDetails setObject:myJsonResponseIndividualElement[@"providerID"] forKey:@"providerID"];
            [providerDetails setObject:myJsonResponseIndividualElement[@"firstName"] forKey:@"providerfirstName"];
            [providerDetails setObject:myJsonResponseIndividualElement[@"qualification"] forKey:@"qualification"];
            [providerDetails setObject:myJsonResponseIndividualElement[@"lastName"] forKey:@"providerlastName"];
            [providerDetails setObject:myJsonResponseIndividualElement[@"profilePicPath"] forKey:@"providerprofile"];
            [providerDetails setObject:myJsonResponseIndividualElement[@"rate"] forKey:@"rate"];
            vc.screenStatus=@"appointment";
            vc.postScheduleDetails=providerDetails;
            [self presentViewController:vc animated:YES completion:nil];
            
        }
        
    }
    
    
    /*UIButton *btn=(UIButton *)sender;
     NSDictionary *myJsonResponseIndividualElement = myProvidersArray[btn.tag];
     MakeAnAppointmentViewController *vc=[self.storyboard instantiateViewControllerWithIdentifier:@"makeanappointment"];
     [providerDetails setObject:myJsonResponseIndividualElement[@"providerID"] forKey:@"providerID"];
     [providerDetails setObject:myJsonResponseIndividualElement[@"firstName"] forKey:@"providerfirstName"];
     [providerDetails setObject:myJsonResponseIndividualElement[@"qualification"] forKey:@"qualification"];
     [providerDetails setObject:myJsonResponseIndividualElement[@"lastName"] forKey:@"providerlastName"];
     [providerDetails setObject:myJsonResponseIndividualElement[@"profilePicPath"] forKey:@"providerprofile"];
     [providerDetails setObject:myJsonResponseIndividualElement[@"rate"] forKey:@"rate"];
     vc.screenStatus=@"appointment";
     vc.postScheduleDetails=providerDetails;
     [self.navigationController pushViewController:vc animated:YES];*/
}

//Added by: Nalina
//Added Date: 16/08/2016
//Discription: Convert 24 hour format to 12 hour format

-(NSString *)Convert24FormatTo12Format:(NSString *)time{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"HH:mm:ss"];
    
    NSDate *amPmDate = [formatter dateFromString:time];
    [formatter setDateFormat:@"hh:mm a"];
    
    NSString *HourString = [formatter stringFromDate:amPmDate];
    return HourString;
}

//Loads each time when page appears
-(void)viewWillAppear:(BOOL)animated{
    
    if ([_screenStatus isEqualToString:@"fromDashboard"]) {
        _pageBackBtn.hidden=NO;
    }else{
        _pageBackBtn.hidden=YES;
    }
    _searchTxt.delegate = self;
    [[self navigationController] setNavigationBarHidden:YES animated:YES];
    
    id<GAITracker> tracker = [[GAI sharedInstance] defaultTracker];
    [tracker set:kGAIScreenName value:@"MyProviders"];
    [tracker send:[[GAIDictionaryBuilder createScreenView] build]];
    
    
}

//To return textpad
- (BOOL)textFieldShouldReturn:(UITextField *)theTextField {
    [_searchTxt resignFirstResponder];
    return YES;
}



/*-(void)sendmail{
 UIImage* image3 = [UIImage imageNamed:@"reject.png"];
 CGRect frameimg = CGRectMake(0, 0, image3.size.width, image3.size.height);
 UIButton *someButton = [[UIButton alloc] initWithFrame:frameimg];
 [someButton setBackgroundImage:image3 forState:UIControlStateNormal];
 [someButton addTarget:self action:@selector(sendmailTO)
 forControlEvents:UIControlEventTouchUpInside];
 [someButton setShowsTouchWhenHighlighted:YES];
 
 UIBarButtonItem *mailbutton =[[UIBarButtonItem alloc] initWithCustomView:someButton];
 self.navigationItem.rightBarButtonItem=mailbutton;
 
 self.navigationItem.hidesBackButton = YES;
 
 // UIBarButtonItem *searchBarItem = [[UIBarButtonItem alloc] initWithCustomView:searchBar];
 // self.navigationItem.rightBarButtonItem = searchBarItem;
 
 }
 
 -(void)sendmailTO{
 }
 */

//Close the page when click on back icon
- (IBAction)pageBackClick:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

//Search Icon click to show search bar
- (IBAction)searchIconClick:(id)sender {
    _searchView.hidden=NO;
}

//Close the search bar and hides
- (IBAction)closeSearchBarClick:(id)sender {
    _searchTxt.text=@"";
    _searchView.hidden=YES;
    myProvidersArray=myProvidersAllDataArray;
    [_providerTable reloadData];
}


//  Added by:Zeenath
//  Added Date:2016-20-08.
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
//  Added Date:2016-20-08.
//  Description:To stop the activity indicator.

-(void)stopLoadingIndicator
{
    _loadingView.hidden=YES;
}

- (IBAction)backArrowClick:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (IBAction)redirectToProviderDetails:(id)sender {
    NSLog(@"Button Clicked");
    
    UITapGestureRecognizer *tap = (UITapGestureRecognizer *)sender;
    NSDictionary *myJsonResponseIndividualElement = myProvidersArray[tap.view.tag];
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"GeneralStoryboard" bundle:nil];
    ProviderDetailsViewController *viewcontrol=[storyboard instantiateViewControllerWithIdentifier:@"ProviderDetails"];
    viewcontrol.providersID=myJsonResponseIndividualElement[@"providerID"];
    
    [self presentViewController:viewcontrol animated:NO completion:nil];
}

//Called on click of back button in header
- (IBAction)bookAppointmentClick:(id)sender {
    
    
    UITapGestureRecognizer *tap = (UITapGestureRecognizer *)sender; // Try casting it to an GR
    //This will give your tag
    //NSLog(@"%i",tap.view.tag);
    
    NSDictionary *myJsonResponseIndividualElement = myProvidersArray[tap.view.tag];
    
    AppDelegate *appdelegate=(AppDelegate *)[[UIApplication sharedApplication]delegate];
    NSNumber *availablity=myJsonResponseIndividualElement[@"isAvailable"];
    if([availablity isEqual:[NSNumber numberWithInt:1]]) {
        
        
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:
                                    @"GeneralStoryboard" bundle:nil];
        
        AppointmentRequestOptionsPopUpViewController *appointmentOptions=[storyboard instantiateViewControllerWithIdentifier:@"AppointmentRequestOptions"];
        
        [providerDetails setObject:myJsonResponseIndividualElement[@"providerID"] forKey:@"providerID"];
        [providerDetails setObject:myJsonResponseIndividualElement[@"firstName"] forKey:@"providerfirstName"];
        [providerDetails setObject:myJsonResponseIndividualElement[@"qualification"] forKey:@"qualification"];
        [providerDetails setObject:myJsonResponseIndividualElement[@"lastName"] forKey:@"providerlastName"];
        [providerDetails setObject:myJsonResponseIndividualElement[@"profilePicPath"] forKey:@"providerprofile"];
        [providerDetails setObject:myJsonResponseIndividualElement[@"rate"] forKey:@"rate"];
        
        self.modalPresentationStyle = UIModalPresentationFullScreen;
        
        appointmentOptions.modalPresentationStyle = UIModalPresentationOverCurrentContext;
        
        appointmentOptions.providerDictionary=providerDetails;
        
        [self presentViewController:appointmentOptions animated:NO completion:nil];
        
        
    }else{
    
    if(![appdelegate accessToken] || [appdelegate.accessToken isKindOfClass:[NSNull class]])
    {
        _alert = [UIAlertController
                  alertControllerWithTitle:@""
                  message:[[GlobalFunction sharedInstance].arrayOfAlerts objectAtIndex:131]
                  preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* okButton = [UIAlertAction
                                   actionWithTitle:@"OK"
                                   style:UIAlertActionStyleDefault
                                   handler:^(UIAlertAction * action) {
                                       [self dismissViewControllerAnimated:YES completion:nil];
                                   }];
        [_alert addAction:okButton];
        [self presentViewController:_alert animated:YES completion: nil];
        
    }else{
        
        NSDictionary *userStatus=[[appdelegate usersDetails]valueForKey:@"userStatus"];
        if([[userStatus valueForKey:@"isPaymentInfoUpdated"] isEqualToNumber:[NSNumber numberWithInt:0]] )
        {
            NSLog(@"Payment Information");
            UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"UserStoryboard" bundle:nil];
            paymentInfoViewController *vc=[storyboard instantiateViewControllerWithIdentifier:@"paymentInfo"];
            [self presentViewController:vc animated:YES completion:nil];
            
        }else{
            
            NSLog(@"Make An Appointment");
            UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"UserStoryboard" bundle:nil];
            
            MakeAnAppointmentViewController *vc=[storyboard instantiateViewControllerWithIdentifier:@"makeanappointment"];
            [providerDetails setObject:myJsonResponseIndividualElement[@"providerID"] forKey:@"providerID"];
            [providerDetails setObject:myJsonResponseIndividualElement[@"firstName"] forKey:@"providerfirstName"];
            [providerDetails setObject:myJsonResponseIndividualElement[@"qualification"] forKey:@"qualification"];
            [providerDetails setObject:myJsonResponseIndividualElement[@"lastName"] forKey:@"providerlastName"];
            [providerDetails setObject:myJsonResponseIndividualElement[@"profilePicPath"] forKey:@"providerprofile"];
            [providerDetails setObject:myJsonResponseIndividualElement[@"rate"] forKey:@"rate"];
            vc.screenStatus=@"appointment";
            vc.postScheduleDetails=providerDetails;
            [self presentViewController:vc animated:YES completion:nil];
            
        }
        
       
    }
    }
}

-(IBAction)addToFavorites:(id)sender{
    
    UIButton *btn=(UIButton *)sender;
    NSIndexPath *indexPath=[NSIndexPath indexPathForRow:btn.tag inSection:0];
    MyprovidersTableViewCell *cell=(MyprovidersTableViewCell *)[self.providerTable cellForRowAtIndexPath:indexPath];
    NSMutableDictionary *myJsonResponseIndividualElement =[[NSMutableDictionary alloc]init];
    myJsonResponseIndividualElement = [myProvidersArray[btn.tag] mutableCopy];
    NSString * providerId =  myJsonResponseIndividualElement[@"providerID"];
    
    
    cell.favoriteProviderIcon.selected=!cell.favoriteProviderIcon.selected;
    ToggleButton *obj=[_values objectAtIndex:indexPath.row];
    obj.selected=!obj.selected;
    
    NSMutableDictionary *dict=[[NSMutableDictionary alloc]init];
    AppDelegate *appdelegate=(AppDelegate *)[[UIApplication sharedApplication]delegate];
    
    
    if(!obj.selected)
    {
        [myJsonResponseIndividualElement setValue:[NSNumber numberWithInt:0] forKey:@"isFavorite"];
        
        [dict setObject:providerId forKey:@"providerID"];
        [dict setObject:@"false" forKey:@"isFavorite"];
        [cell.favoriteProviderIcon setImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"favoriteUnselected" ofType:@"png"]]
                                   forState:UIControlStateNormal];
        
        
    }
    else{
        [cell.favoriteProviderIcon setImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"favoriteSelected" ofType:@"png"]]
                                   forState:UIControlStateNormal];
        
        [myJsonResponseIndividualElement setValue:[NSNumber numberWithInt:1] forKey:@"isFavorite"];
        
        [dict setObject:providerId forKey:@"providerID"];
        [dict setObject:@"true" forKey:@"isFavorite"];
    }
    [myProvidersArray setObject:myJsonResponseIndividualElement atIndexedSubscript:btn.tag];
    
    NSString *Url=[appdelegate.serviceURL stringByAppendingString:@"api/ProviderSearch/Favorites"];
    [self startLoadingIndicator];
    [[GlobalFunction sharedInstance]getServerResponseAfterLogin:Url method:@"POST" param:dict withCallback:^(NSInteger statusCode, NSDictionary *response, NSError *error) {
        if(statusCode == 200)
        {
            NSLog(@"Respponse %@",response);
            // [_providerTableView reloadData];
            
        }
        [self stopLoadingIndicator];
        
    }];
}


@end
