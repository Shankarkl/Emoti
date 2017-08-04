/***************************************************************
 Page name: ProviderDetailsViewController.m
 Created By:Nalina
 Created Date:2016-07-13
 Description:Provider details view controller implementation Screen.
 ***************************************************************/

#import "ProviderDetailsViewController.h"
#import "ProviderDetailsTableViewCell.h"
#import "MakeAnAppointmentViewController.h"
#import <Google/Analytics.h>
#import "AppDelegate.h"
#import "GlobalFunction.h"
#import "FZAccordionTableView.h"
#import "AccordionHeaderView.h"
#import "ProviderDetailsPageViewController.h"
#import "paymentInfoViewController.h"
#import "AppointmentRequestOptionsPopUpViewController.h"

static NSString *const kTableViewCellReuseIdentifier = @"TableViewCellReuseIdentifier";

@interface ProviderDetailsViewController ()  <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet FZAccordionTableView *tableView;

@end


@implementation ProviderDetailsViewController
@synthesize providersID;
- (void)viewDidLoad {
    
    [self setBorderColor:5];
    _makeAnAppointmentBtn.hidden = YES;
    _appointmentDetailsBtn.hidden = YES;
    _readMoreBtn.hidden = YES;
    
    _aboutProvider.editable = NO;
    
    AppDelegate *appdelegate=(AppDelegate *)[[UIApplication sharedApplication]delegate];
    if(![appdelegate accessToken] || [appdelegate.accessToken isKindOfClass:[NSNull class]])
    {
        _providerFavoriteButton.hidden = YES;
        
    }else{
        _providerFavoriteButton.hidden = NO;
    }
    
    UIImage *backgroundImage = [UIImage imageNamed:@"LoginBackground.png"];
    UIImageView *backgroundImageView=[[UIImageView alloc]initWithFrame:self.view.frame];
    backgroundImageView.image=backgroundImage;
    [self.view insertSubview:backgroundImageView atIndex:0];
    
    
    
    //Added by: Zeenath
    //Added Date: 18/08/2016
    //Discription: get the detail of the provider by his id
    
    providerDetails= [[NSMutableDictionary alloc]init];
    
    NSLog(@"First time %@", [[appdelegate usersDetails] valueForKey:@"isFirstTime"]);
    
    // GlobalFunction *globalValues=[[GlobalFunction alloc]init];
    NSLog(@"PROVIDER-ID  %@",providersID);
    
    NSString *Url=[appdelegate.serviceURL stringByAppendingFormat:@"/api/ProviderSearch/ProviderDetails?id=%@",providersID];
    
    [self startLoadingIndicator];
    [[GlobalFunction sharedInstance] getServerResponseAfterLogin:Url method:@"GET" param:nil withCallback:^(NSInteger statusCode, NSDictionary *response, NSError *error) {
        
        if(statusCode==200){
            providerInformationArray =[response mutableCopy];
            
            if([[response objectForKey:@"appointmentID"] isEqual:[NSNull null]]||[[response objectForKey:@"appointmentID"] isEqual:@""]){
                _makeAnAppointmentBtn.hidden = YES;
                _appointmentDetailsBtn.hidden = NO;
            }else{
                _makeAnAppointmentBtn.hidden = NO;
                _appointmentDetailsBtn.hidden = YES;
            }
            
            [providerDetails setObject:[response objectForKey:@"providerID"] forKey:@"providerID"];
            [providerDetails setObject:[response objectForKey:@"firstName"] forKey:@"providerfirstName"];
            if(![[response objectForKey:@"qualification"] isEqual:[NSNull null]])
            {
                [providerDetails setObject:[response objectForKey:@"qualification"] forKey:@"qualification"];
            }
            else{
                [providerDetails setObject:@"" forKey:@"qualification"];
            }
            [providerDetails setObject:[response objectForKey:@"lastName"] forKey:@"providerlastName"];
            [providerDetails setObject:[response objectForKey:@"profilePicPath"] forKey:@"providerprofile"];
            [providerDetails setObject:[response objectForKey:@"rate"] forKey:@"rate"];
            
            
            NSString *name=[[response objectForKey:@"firstName"] stringByAppendingString:@" "];
            _providerNameLabel.text=[name stringByAppendingString:[response objectForKey:@"lastName"]];
            NSString *imagePath= [response objectForKey:@"profilePicPath"];
            
            if ([[response objectForKey:@"profilePicPath"] isEqual:[NSNull null]]||[[response objectForKey:@"profilePicPath"] isEqual:@""]) {
                
                UIImage *image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"upload-profile" ofType:@"png"]];
                _providerProfileView.image=image;
                
            }else{
                
                NSString *imagename=[appdelegate.imageURL stringByAppendingString:imagePath];
                NSData *imageData = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:imagename]];
                UIImage *image = [[UIImage alloc] initWithData:imageData];
                _providerProfileView.image=image;
                
            }
            
            NSString *amount=[response valueForKey:@"rate"];
            NSNumber *value=[NSNumber numberWithInteger:[amount integerValue]];
            
            NSString *rate=[@"$" stringByAppendingString:[value stringValue]];
            _rateOfProviderLabel.text=[rate stringByAppendingString:@" / hour"];
            
            
            
            if(![[response objectForKey:@"aboutSelf"] isEqual:[NSNull null]])
            {
                _aboutProvider.text=[response objectForKey:@"aboutSelf"];
            }
            else
            {
                _aboutProvidersLabel.text=@"";
            }
            
            if(![[response objectForKey:@"nextScheduledAppointment"] isEqual:[NSNull null]])
            {
                _appointmentLabel.text=[[response objectForKey:@"nextScheduledAppointment"] objectForKey:@"appointment"];
                
            }
            else{
                _appointmentLabel.text=@"You have no appointments with this provider";
            }
            
            
            if([[response objectForKey:@"isFavorite"] isEqualToNumber:[NSNumber numberWithInt:0]])
            {
                UIImage *favoriteImage=[UIImage imageNamed:@"favoriteSelected.png"];
                [self.providerFavoriteButton setImage:favoriteImage forState:UIControlStateNormal];
            }
            else
            {
                UIImage *favoriteImage=[UIImage imageNamed:@""];
                [self.providerFavoriteButton setImage:favoriteImage forState:UIControlStateNormal];
            }
            
            NSMutableArray *array=[response objectForKey:@"experise"];
            if(array.count>0)
            {
                NSString *expertise=@"";
                for (int i=0; i<array.count; i++) {
                    NSDictionary *dictionary=[array objectAtIndex:i];
                    //expertise = [expertise stringByAppendingString:@","];
                    expertise= [NSString stringWithFormat: @"%@, %@", expertise, [dictionary objectForKey:@"expertiseText"]];
                    
                }
                NSRange range = NSMakeRange(0,1);
                NSString *exp = [expertise stringByReplacingCharactersInRange:range withString:@""];
                _providerExpertiseLabel.text=exp;
            }
            else
            {
                _providerExpertiseLabel.text=@"";
            }
            
            [providerDetails setObject:_providerExpertiseLabel.text forKey:@"expertiseText"];
            
            
            if(![[response objectForKey:@"languageSpoken"] isEqual:[NSNull null]]){
                [providerDetails setObject:[response objectForKey:@"languageSpoken"] forKey:@"languageSpoken"];
            }else{
                
                [providerDetails setObject:@"lanuages not specified" forKey:@"languageSpoken"];
            }
            
            [self.tableView reloadData];
            
            NSString *Url=[appdelegate.serviceURL stringByAppendingFormat:@"api/Recommendations/MyRecommendations?id=%@",providersID];
            
            [[GlobalFunction sharedInstance] getServerResponseAfterLogin:Url method:@"GET" param:nil withCallback:^(NSInteger statusCode, NSDictionary *response, NSError *error)
             {
                 if (statusCode == 200)
                 {
                     [self stopLoadingIndicator];
                     recommendationArray=[response mutableCopy];
                     _myRecommendationsLAbel.text=[[providerDetails valueForKey:@"providerfirstName"] stringByAppendingString:@"'s Recommendations"];
                     
                     [_recommendarionTable reloadData];
                     
                 }else if(statusCode==404){
                     [self stopLoadingIndicator];
                     _recommendarionTable.hidden=YES;
                     _myRecommendationsLAbel.text=@"No recommendations found";
                     
                 }else{
                     [self stopLoadingIndicator];
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
        else{
            [self stopLoadingIndicator];
            NSString *message;
            
            if(statusCode==403||statusCode==503||statusCode==404){
                
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
    
    //self.tableView.allowMultipleSectionsOpen = YES;
    self.tableView.keepOneSectionOpen = YES;
    self.tableView.initialOpenSections=[NSSet setWithObjects:@(0), nil];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:kTableViewCellReuseIdentifier];
    [self.tableView registerNib:[UINib nibWithNibName:@"AccordionHeaderView" bundle:nil] forHeaderFooterViewReuseIdentifier:kAccordionHeaderViewReuseIdentifier];
    
    [super viewDidLoad];
    UIImageView *bgImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"06. Appointment Confirmation.png"]];
    bgImageView.frame = self.view.bounds;
    bgImageView.contentMode = UIViewContentModeScaleAspectFill;
    bgImageView.clipsToBounds = YES;
    [_providerDetailsBackgroundView addSubview:bgImageView];
    [_providerDetailsBackgroundView sendSubviewToBack:bgImageView];
    
}

-(void)viewDidAppear:(BOOL)animated{
    
    self.pageViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"ProviderDetailsPageView"];
    self.pageViewController.dataSource = self;
    ProviderDetailsPageViewController  *startingViewController = [self viewControllerAtIndex:0];
    viewControllers = @[startingViewController];
    
    [self addChildViewController:_pageViewController];
    //[self.view addSubview:_pageViewController.view];
    [_recommendationListView addSubview:_pageViewController.view];
    
    [self.pageViewController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
    [self.pageViewController didMoveToParentViewController:self];
    
    self.pageViewController.view.frame = CGRectMake(0,0,self.view.frame.size.width-0, self.view.frame.size.height);
    
    //self.pageViewController.view.frame = CGRectMake(0, self.view.frame.size.height-210, self.view.frame.size.width-0, self.view.frame.size.height);
    
}

- (ProviderDetailsPageViewController *)viewControllerAtIndex:(NSUInteger)index
{
    NSLog(@"index%lu",index);
    
    // Create a new view controller and pass suitable data.
    ProviderDetailsPageViewController *pageContentView = [self.storyboard instantiateViewControllerWithIdentifier:@"ProviderDetailsReccomendation"];
    
    if(recommendationArray.count>0)
    {
        pageContentView.contentLabel= recommendationArray;
        pageContentView.pageIndex = index;
    }
    
    return pageContentView;
    
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController

{
    NSUInteger index = ((ProviderDetailsPageViewController*) viewController).pageIndex;
    NSUInteger lastrecord  = [recommendationArray count]-1;
    if ((index == 0) || (index == NSNotFound)|| (recommendationArray.count == 0)) {
        return nil;
    }
    
    index--;
    
    return [self viewControllerAtIndex:index];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
    NSUInteger index = ((ProviderDetailsPageViewController*) viewController).pageIndex;
    
    if (index == NSNotFound)
        {
            return nil;
        }
        
        index++;
        
        if (index == [recommendationArray count]||  (recommendationArray.count == 0))
        {
            return nil;
        }
    
    return [self viewControllerAtIndex:index];
}


- (NSInteger)presentationCountForPageViewController:(UIPageViewController *)pageViewController
{
    return [recommendationArray count];
}

- (NSInteger)presentationIndexForPageViewController:(UIPageViewController *)pageViewController
{
    
    return 0;
}

#pragma mark - <UITableViewDataSource> / <UITableViewDelegate> -

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    NSLog(@"Count to %@",faqArray);
    return 4;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return kDefaultAccordionHeaderViewHeight;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [self tableView:tableView heightForRowAtIndexPath:indexPath];
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForHeaderInSection:(NSInteger)section {
    return [self tableView:tableView heightForHeaderInSection:section];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kTableViewCellReuseIdentifier forIndexPath:indexPath];
    NSDictionary *myJsonResponseIndividualElement = providerDetails;
    // NSLog(@"myarrayyyy cell row to %lu",selectSectionValue);
    
    // NSLog(@"myarrayyyy cell to %@",myJsonResponseIndividualElement);
    AccordionHeaderView *headerVw= [tableView dequeueReusableHeaderFooterViewWithIdentifier:kAccordionHeaderViewReuseIdentifier];
    UITapGestureRecognizer *singleFingerTap =
    [[UITapGestureRecognizer alloc] initWithTarget:self
                                            action:@selector(handleSingleTapped:)];
    [headerVw.HeaderView addGestureRecognizer:singleFingerTap];
    if(selectSectionValue==0){
        cell.textLabel.text=[myJsonResponseIndividualElement objectForKey:@"qualification"];
        
    }else if(selectSectionValue==1){
        
        cell.textLabel.text=[myJsonResponseIndividualElement objectForKey:@"expertiseText"];
        
    }else if(selectSectionValue==2){
        
        cell.textLabel.text=@"Professional Statements";
        
    }else if(selectSectionValue==3){
        
        cell.textLabel.text=[myJsonResponseIndividualElement objectForKey:@"languageSpoken"];
        
    }
    
    //cell.textLabel.text=myJsonResponseIndividualElement[@"faqAnswer"];
    cell.layer.backgroundColor=[UIColor colorWithRed:207.0/255.0 green:230.0/255.0 blue:229.0/255.0 alpha:1].CGColor;
    cell.textLabel.layer.backgroundColor=[UIColor colorWithRed:207.0/255.0 green:230.0/255.0 blue:229.0/255.0 alpha:1].CGColor;
    [cell.textLabel setFont:[UIFont fontWithName:@"CenturyGothic.ttf" size:12]];
    //[cell.textLabel setFont:[UIFont fontWithName:@"System" size:12]];
    //cell.textLabel.text = @"Cell";
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    AccordionHeaderView *headerVw= [tableView dequeueReusableHeaderFooterViewWithIdentifier:kAccordionHeaderViewReuseIdentifier];
    if(section==0){
        headerVw.headerLabel.text= @"Education";
        
    }else if(section==01){
        
        headerVw.headerLabel.text =@"Specialities";
    }else if(section==02){
        
        headerVw.headerLabel.text =@"Professional Statement";
    }else if(section==03){
        
        headerVw.headerLabel.text =@"Languages Spoken";
    }
    return headerVw;
}

//The event handling method
- (void)handleSingleTapped:(UITapGestureRecognizer *)recognizer
{
    
    
    //Do stuff here...
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return nil;
}

/*- (void)handleSingleTapped:(UITapGestureRecognizer *)recognizer {
 AccordionHeaderView *headerVw= [tableView dequeueReusableHeaderFooterViewWithIdentifier:kAccordionHeaderViewReuseIdentifier];
 headerVw.DownBtn.hidden=NO;
 headerVw.ImageBtn.hidden=YES;
 }*/
#pragma mark - <FZAccordionTableViewDelegate> -

- (void)tableView:(FZAccordionTableView *)tableView willOpenSection:(NSInteger)section withHeader:(UITableViewHeaderFooterView *)header {
    NSLog(@"willOpenSection %lu",section);
    selectSectionValue=section;
    
}

- (void)tableView:(FZAccordionTableView *)tableView didOpenSection:(NSInteger)section withHeader:(UITableViewHeaderFooterView *)header {
    AccordionHeaderView *headerVw= [_tableView dequeueReusableHeaderFooterViewWithIdentifier:kAccordionHeaderViewReuseIdentifier];
    headerVw.DownBtn.hidden=NO;
    headerVw.ImageBtn.hidden=YES;
    
    
}

- (void)tableView:(FZAccordionTableView *)tableView willCloseSection:(NSInteger)section withHeader:(UITableViewHeaderFooterView *)header {
    
}

- (void)tableView:(FZAccordionTableView *)tableView didCloseSection:(NSInteger)section withHeader:(UITableViewHeaderFooterView *)header {
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

//Loads each time when page appears
-(void)viewWillAppear:(BOOL)animated{
    // self.providerProfileView.layer.cornerRadius = //self.providerProfileView.frame.size.width / 2;
    // self.providerProfileView.clipsToBounds = YES;
    
    id<GAITracker> tracker = [[GAI sharedInstance] defaultTracker];
    [tracker set:kGAIScreenName value:@"ProviderDetails"];
    [tracker send:[[GAIDictionaryBuilder createScreenView] build]];
}
/*
 //To return number of section in table
 - (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
 {
 return 1;
 }
 
 //Return number of rows in a table
 - (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
 {
 return recommendationArray.count;
 }
 
 //Display the details of the table data
 - (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
 {
 //Added by: Zeenath
 //Added Date: 18/08/2016
 //Discription: Bind the recommended providers
 
 ProviderDetailsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"providersCell" forIndexPath:indexPath];
 cell.providerProfileImage.layer.cornerRadius = cell.providerProfileImage.frame.size.width / 2;
 cell.providerProfileImage.clipsToBounds = YES;
 
 
 NSDictionary *myJsonResponseIndividualElement = recommendationArray[indexPath.row];
 
 NSString *name=[myJsonResponseIndividualElement[@"firstName"] stringByAppendingString:@" "];
 cell.lastnameLabel.text= [name stringByAppendingString:myJsonResponseIndividualElement[@"lastName"]];
 
 if ([myJsonResponseIndividualElement[@"profilePicPath"] isEqual:[NSNull null]]) {
 
 }else{
 
 NSString *imagePath= myJsonResponseIndividualElement[@"profilePicPath"];
 NSString *imagename=[@"https://starkblob.blob.core.windows.net/profilepics/" stringByAppendingString:imagePath];
 dispatch_queue_t imagequeue =dispatch_queue_create("imageDownloader", nil);
 dispatch_async(imagequeue, ^{
 
 //download iamge
 NSData *imageData = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:imagename]];
 UIImage *image = [[UIImage alloc] initWithData:imageData];
 dispatch_async(dispatch_get_main_queue(), ^{
 
 if (image==NULL) {
 UIImage *image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"upload-profile" ofType:@"png"]];
 cell.providerProfileImage.image  = image;
 }
 else{
 cell.providerProfileImage.image  = image;
 }
 });
 
 });
 
 }
 if(![myJsonResponseIndividualElement[@"qualification"] isEqual:[NSNull null]])
 {
 cell.expertiseInLabel.text=myJsonResponseIndividualElement[@"qualification"];
 }
 else{
 cell.expertiseInLabel.text=@"";
 }
 
 
 
 return cell;
 }
 
 */

//Returns selected row
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *myJsonResponseIndividualElement = recommendationArray[indexPath.row];
    NSString *providerID=myJsonResponseIndividualElement[@"providerID"];
    ProviderDetailsViewController *vc=[self.storyboard instantiateViewControllerWithIdentifier:@"ProviderDetails"];
    vc.providersID=providerID;
    [self.navigationController pushViewController:vc animated:YES];
}



//Close the screen on click of back icon
- (IBAction)seeAppointmentDetailsClick:(id)sender {
    
    
}

- (IBAction)pageBackClick:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}



//  Added by: Nalina
//  Added Date:2016-24-08.
//  Description: Redirect to the make an appointment screen

- (IBAction)makeAnAppointmentClick:(id)sender {
    NSLog(@"Button Clicked");
    AppDelegate *appdelegate=(AppDelegate *)[[UIApplication sharedApplication]delegate];
    
    //Discription: Payment popup for the first user
    NSDictionary *myJsonResponseIndividualElement = _providerDataArray;
    NSDictionary *userStatus=[[appdelegate usersDetails]valueForKey:@"userStatus"];
    
    NSNumber *availablity=myJsonResponseIndividualElement[@"isAvailable"];
    if([availablity isEqual:[NSNumber numberWithInt:0]]) {
        
        
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:
                                    @"GeneralStoryboard" bundle:nil];
        
        AppointmentRequestOptionsPopUpViewController *appointmentOptions=[storyboard instantiateViewControllerWithIdentifier:@"AppointmentRequestOptions"];
        
    
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
                                       
                                       /*[self dismissViewControllerAnimated:YES completion:nil];*/
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
            
          /*  NSLog(@"Make An Appointment");
            UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"UserStoryboard" bundle:nil];
            
            MakeAnAppointmentViewController *vc=[storyboard instantiateViewControllerWithIdentifier:@"makeanappointment"];
            vc.screenStatus=@"appointment";
            vc.postScheduleDetails=providerDetails;
            [self presentViewController:vc animated:YES completion:nil];*/
            
        }
        
    }
    }
    
}

- (IBAction)providermakeFavoriteClick:(id)sender {
    
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


-(void) setBorderColor:(int)tagName{
    UIButton *cancelBtn = (UIButton *) [self.view viewWithTag:tagName];
    cancelBtn.layer.borderColor = [UIColor colorWithRed:246.0/255.0 green:108.0/255.0 blue:118.0/255.0 alpha:1].CGColor;
}
@end
