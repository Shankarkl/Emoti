/***************************************************************
 Page name: ProviderMarketPlaceViewCell.m
 Created By: nalina
 Created Date:17/08/16
 Description: provider market place implementation file
 ***************************************************************/

#import "ProviderMarketPlaceViewController.h"
#import "ProviderMarketPlaceTableViewCell.h"
#import <Google/Analytics.h>
#import "AppDelegate.h"
#import "GlobalFunction.h"
#import "ProviderDetailsViewController.h"
#import <HCSStarRatingView/HCSStarRatingView.h>
#import "MakeAnAppointmentViewController.h"
#import "paymentInfoViewController.h"
#import "AppointmentRequestOptionsPopUpViewController.h"

@interface ProviderMarketPlaceViewController ()

@end

@implementation ProviderMarketPlaceViewController


//Loads first time when page appears
- (void)viewDidLoad {
    _values=[[NSMutableArray alloc] init];
    providerDetails= [[NSMutableDictionary alloc]init];
    
    [super viewDidLoad];
    UIImage *backgroundImage = [UIImage imageNamed:@"LoginBackground.png"];
    UIImageView *backgroundImageView=[[UIImageView alloc]initWithFrame:self.view.frame];
    backgroundImageView.image=backgroundImage;
    [self.view insertSubview:backgroundImageView atIndex:0];
    
    
    UITapGestureRecognizer *singleFingerTap =
    [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(redirectToProviderDetails:)];
    //[self.providerInfoCellView addGestureRecognizer:singleFingerTap];
    
    _providerDataArray= [_providerDataArray mutableCopy];
    
    if(_providerDataArray.count==0)
    {
        _providerTableView.hidden=YES;
        // GlobalFunction *globalValues=[[GlobalFunction alloc]init];
        _alert = [UIAlertController
                  alertControllerWithTitle:@""
                  message:[[GlobalFunction sharedInstance].arrayOfAlerts objectAtIndex:79]
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
    else
    {
        _providerTableView.hidden=NO;
    }
    
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
        
        for(int i=0;i<_providerDataArray.count;i++){
            ToggleButton *obj=[[ToggleButton alloc] init];
            [_values addObject:obj];
        }
    }
    return _providerDataArray.count;
}


//Return the data to display and cell in table
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    //Added by: Zeenath
    //Added Date: 18/08/2016
    //Discription: Bind the searched providers
    
    ProviderMarketPlaceTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ProviderCell" forIndexPath:indexPath];
    //cell.providerProfileImage.layer.cornerRadius = cell.providerProfileImage.frame.size.width / 2;
    cell.providerProfileImage.clipsToBounds = YES;
    
    ToggleButton *obj=[_values objectAtIndex:indexPath.row];
    cell.favoriteProviderIcon.tag=indexPath.row;
    
    cell.favoriteProviderIcon.selected=obj.selected;
    [cell.favoriteProviderIcon setImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"favoriteUnselected" ofType:@"png"]]
                               forState:UIControlStateNormal];
    [cell.favoriteProviderIcon setImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"favoriteSelected" ofType:@"png"]]
                               forState:UIControlStateSelected];
    [cell.favoriteProviderIcon addTarget:self action:@selector(addToFavorites:) forControlEvents:UIControlEventTouchUpInside];
    
    
    if (indexPath.row % 2) {
        cell.mainview.backgroundColor = [[UIColor alloc]initWithRed:51.0/255.0 green:51.0/255.0 blue:51.0/255.0 alpha:1];
    }else{
        cell.mainview.backgroundColor =[[UIColor alloc]initWithRed:62.0/255.0 green:62.0/255.0 blue:62.0/255.0 alpha:1];
    }
    
    AppDelegate *appdelegate=(AppDelegate *)[[UIApplication sharedApplication]delegate];
    
    if(![appdelegate accessToken] || [appdelegate.accessToken isKindOfClass:[NSNull class]])
    {
        cell.favoriteProviderIcon.hidden = YES;
        cell.availableView.hidden = YES;
        cell.availableBtn.hidden = YES;
        
    }else{
        cell.favoriteProviderIcon.hidden = NO;
        cell.availableView.hidden = NO;
         cell.availableBtn.hidden = NO;
    }
    
    NSDictionary *myJsonResponseIndividualElement = _providerDataArray[indexPath.row];
    
    NSString *name=[myJsonResponseIndividualElement[@"firstName"] stringByAppendingString:@" "];
    cell.firstNameLabel.text= [name stringByAppendingString:myJsonResponseIndividualElement[@"lastName"]];
    
    if(![myJsonResponseIndividualElement[@"qualification"] isEqual:[NSNull null]])
    {
        
        cell.ExpertiseLabel.text=myJsonResponseIndividualElement[@"qualification"];
    }
    else
    {
        cell.ExpertiseLabel.text=@"";
    }
    
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
                cell.providerProfileImage.image  = image;
            }
            else{
                cell.providerProfileImage.image  = image;
            }
        });
        
    });
    
    
    NSNumber *favorite=myJsonResponseIndividualElement[@"isFavorite"];
    
    if([favorite isEqualToNumber:[NSNumber numberWithInt:0]])
    {
        cell.favoriteProviderIcon.selected=NO;
        ToggleButton *obj=[_values objectAtIndex:indexPath.row];
        obj.selected=NO;
    }
    else
    {
        cell.favoriteProviderIcon.selected=YES;
        ToggleButton *obj=[_values objectAtIndex:indexPath.row];
        obj.selected=YES;
    }
    
    NSNumber *availablity=myJsonResponseIndividualElement[@"isAvailable"];
    if([availablity isEqual:[NSNumber numberWithInt:0]]) {
        UIImage *image=[UIImage imageNamed:@"not-available.png"];
        [cell.availableBtn setImage:image forState:UIControlStateNormal];
    }else{
        UIImage *image=[UIImage imageNamed:@"available.png"];
        [cell.availableBtn setImage:image forState:UIControlStateNormal];
    }
    
    cell.availableView.tag=indexPath.row;
    cell.providerInfoCellView.tag=indexPath.row;
    
    UITapGestureRecognizer *cellViewTap =
    [[UITapGestureRecognizer alloc] initWithTarget:self
                                            action:@selector(redirectToProviderDetails:)];
    [cell.providerInfoCellView addGestureRecognizer:cellViewTap];
    
    cell.rateLabel.text=[myJsonResponseIndividualElement[@"rateCurrency"] stringByAppendingString:@"/hour"];
    
    UITapGestureRecognizer *availBtnViewTap =
    [[UITapGestureRecognizer alloc] initWithTarget:self
                                            action:@selector(bookAppointmentClick:)];
    [cell.availableView addGestureRecognizer:availBtnViewTap];
    
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

//Added by: Zeenath
//Added Date: 18/08/2016
//Discription: Make as favorite button click and functionality

-(IBAction)addToFavorites:(id)sender{
    
    UIButton *btn=(UIButton *)sender;
    NSIndexPath *indexPath=[NSIndexPath indexPathForRow:btn.tag inSection:0];
    ProviderMarketPlaceTableViewCell *cell=(ProviderMarketPlaceTableViewCell *)[self.providerTableView cellForRowAtIndexPath:indexPath];
    NSMutableDictionary *myJsonResponseIndividualElement =[[NSMutableDictionary alloc]init];
    myJsonResponseIndividualElement = [_providerDataArray[btn.tag] mutableCopy];
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
        
    }
    else{
        [myJsonResponseIndividualElement setValue:[NSNumber numberWithInt:1] forKey:@"isFavorite"];
        
        [dict setObject:providerId forKey:@"providerID"];
        [dict setObject:@"true" forKey:@"isFavorite"];
    }
    [_providerDataArray setObject:myJsonResponseIndividualElement atIndexedSubscript:btn.tag];
    
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

//Loads each time when page appears
-(void)viewWillAppear:(BOOL)animated{
    self.navigationItem.title = @"PROVIDERS MARKETPLACE";
    id<GAITracker> tracker = [[GAI sharedInstance] defaultTracker];
    [tracker set:kGAIScreenName value:@"ProviderMarketPlaceList"];
    [tracker send:[[GAIDictionaryBuilder createScreenView] build]];
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *myJsonResponseIndividualElement = _providerDataArray[indexPath.row];
    NSString *providerID=myJsonResponseIndividualElement[@"providerID"];
    ProviderDetailsViewController *vc=[self.storyboard instantiateViewControllerWithIdentifier:@"ProviderDetails"];
    vc.providersID=providerID;
    
    [self.navigationController pushViewController:vc animated:YES];
}

//Called on click of back button in header
- (IBAction)bookAppointmentClick:(id)sender {
    
    
    UITapGestureRecognizer *tap = (UITapGestureRecognizer *)sender; // Try casting it to an GR
    //This will give your tag
    //NSLog(@"%i",tap.view.tag);
    
    NSDictionary *myJsonResponseIndividualElement = _providerDataArray[tap.view.tag];
    
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
        
        AppDelegate *appdelegate=(AppDelegate *)[[UIApplication sharedApplication]delegate];
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
            //vc.providersID=providerId;
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


//Called on click of back button in header
- (IBAction)backClick:(id)sender {
    /*  [self.navigationController popViewControllerAnimated:YES];*/
    NSLog(@"Button Clicked");
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"GeneralStoryBoard" bundle:nil];
    ProviderDetailsViewController *viewcontrol=[storyboard instantiateViewControllerWithIdentifier:@"ProviderDetails"];
    [self presentViewController:[storyboard instantiateViewControllerWithIdentifier:@"ProviderDetails"] animated:NO completion:nil];
    
}

//Called on click of filter icon in header
- (IBAction)filterProvidersClick:(id)sender {
    
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


- (UIViewController*) topMostController {
    UIViewController *topController = [UIApplication sharedApplication].keyWindow.rootViewController;
    
    while (topController.presentedViewController) {
        topController = topController.presentedViewController;
    }
    
    return topController;
}

- (IBAction)backArrowClick:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)redirectToProviderDetails:(id)sender {
    NSLog(@"Button Clicked");
    
    UITapGestureRecognizer *tap = (UITapGestureRecognizer *)sender;
    NSDictionary *myJsonResponseIndividualElement = _providerDataArray[tap.view.tag];
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"GeneralStoryboard" bundle:nil];
    ProviderDetailsViewController *viewcontrol=[storyboard instantiateViewControllerWithIdentifier:@"ProviderDetails"];
    viewcontrol.providersID=myJsonResponseIndividualElement[@"providerID"];
    
    [self presentViewController:viewcontrol animated:NO completion:nil];
}

@end
