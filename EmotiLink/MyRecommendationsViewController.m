/***************************************************************
 Page name:MyRecommendationsViewController.m
 Created By:Nalina
 Created Date:12/07/16
 Description:my recommendation implementation file
 ***************************************************************/


#import "MyRecommendationsViewController.h"
#import "MyRecommendationsTableViewCell.h"
#import "GlobalFunction.h"
#import "RecommendationSearchViewController.h"
#import "AppDelegate.h"
#import <Google/Analytics.h>
#import <HCSStarRatingView/HCSStarRatingView.h>

@interface MyRecommendationsViewController ()

@property (nonatomic) BOOL useCustomCells;
@property (nonatomic, weak) UIRefreshControl *refreshControl;
@end

@implementation MyRecommendationsViewController

//Loads first time when page appears
- (void)viewDidLoad {
    recommendationArray = [NSMutableArray array];
    UIImage *backgroundImage = [UIImage imageNamed:@"05. List-View.png"];
    UIImageView *backgroundImageView=[[UIImageView alloc]initWithFrame:self.view.frame];
    backgroundImageView.image=backgroundImage;
    [self.view insertSubview:backgroundImageView atIndex:0];

    [super viewDidLoad];
}

//Loads every time when page loads completely
-(void)viewDidAppear:(BOOL)animated{
   
    //Added by: Nalina
    //Added Date: 16/08/2016
    //Discription: service call to get the list of the providers and the details
    
   // GlobalFunction *globalValues=[[GlobalFunction alloc]init];
    AppDelegate *appdelegate= (AppDelegate *)[[UIApplication sharedApplication]delegate];
    
    NSString *url=[@"api/Recommendations/MyRecommendations?id=" stringByAppendingString:@""];
    NSString *getRecommendrUrl=[appdelegate.serviceURL stringByAppendingString:url];
    [self startLoadingIndicator];
    [[GlobalFunction sharedInstance] getServerResponseAfterLogin:getRecommendrUrl method:@"GET" param:nil withCallback:^(NSInteger statusCode, NSDictionary *response, NSError *error)
     {
         if (statusCode == 200)
         {
             recommendationArray=[response mutableCopy];
             [self stopLoadingIndicator];
             [_recommendationTable reloadData];

         }else if(statusCode==404){
             [self stopLoadingIndicator];
             _alert = [UIAlertController
                       alertControllerWithTitle:@""
                       message:[[GlobalFunction sharedInstance].arrayOfAlerts objectAtIndex:79]
                       preferredStyle:UIAlertControllerStyleAlert];
             
             UIAlertAction* okButton = [UIAlertAction
                                        actionWithTitle:@"OK"
                                        style:UIAlertActionStyleDefault
                                        handler:^(UIAlertAction * action) {
                                        
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

//Loads each time when page appears
-(void)viewWillAppear:(BOOL)animated
{
    id<GAITracker> tracker = [[GAI sharedInstance] defaultTracker];
    [tracker set:kGAIScreenName value:@"MyRecommendations"];
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
    return recommendationArray.count;
}

//Return the data to display and cell in table
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //Added by: Nalina
    //Added Date: 16/08/2016
    //Discription: bind and display table data
    
    MyRecommendationsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"recommendationCell" forIndexPath:indexPath];
     [cell setRightUtilityButtons:[self rightButtons] WithButtonWidth:58.0f];
    //cell.profileImageView.layer.cornerRadius = cell.profileImageView.frame.size.width / 2;
    cell.profileImageView.clipsToBounds = YES;
    
    cell.delegate = self;
    NSString *item = recommendationArray[indexPath.row];
    cell.itemText = item;
    if ([self.cellsCurrentlyEditing containsObject:indexPath]) {
    }
    
    cell.cancelBtn.tag = indexPath.row;
    [cell.cancelBtn addTarget:self action:@selector(AcceptClicked:) forControlEvents:UIControlEventTouchUpInside];
    
  /*  if (indexPath.row % 2) {
        
        cell.mainContentView.backgroundColor = [[UIColor alloc]initWithRed:51.0/255.0 green:51.0/255.0 blue:51.0/255.0 alpha:1];
    }else{
        cell.mainContentView.backgroundColor =[[UIColor alloc]initWithRed:62.0/255.0 green:62.0/255.0 blue:62.0/255.0 alpha:1];
    }*/
    
    NSDictionary *myJsonResponseIndividualElement = recommendationArray[indexPath.row];
    
    NSString *name=[myJsonResponseIndividualElement[@"firstName"] stringByAppendingString:@" "];
    cell.firstnameLabel.text= [name stringByAppendingString:myJsonResponseIndividualElement[@"lastName"]];
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
                    UIImage *image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"upload-profile" ofType:@"png"]];
                    cell.profileImageView.image  = image;
                }
                else{
                    cell.profileImageView.image  = image;
                }
            });
            
        });    }
    if(![myJsonResponseIndividualElement[@"qualification"] isEqual:[NSNull null]])
    {
     cell.expertiseLabel.text=myJsonResponseIndividualElement[@"qualification"];
    }
    else{
        cell.expertiseLabel.text=@" ";
    }
    
    cell.rateLabel.text=[myJsonResponseIndividualElement[@"rateCurrency"] stringByAppendingString:@"/hour"];
    
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

//Added by: Nalina
//Added Date: 16/08/2016
//Discription: Service call to delete the recommendiee when we swipe and click on delete button

- (void)AcceptClicked:(UIButton*)sender{
    
   // GlobalFunction *globalValues=[[GlobalFunction alloc]init];
    AppDelegate *appdelegate= (AppDelegate *)[[UIApplication sharedApplication]delegate];
    UIButton *btn=(UIButton *)sender;
    
    NSDictionary *myJsonResponseIndividualElement = recommendationArray[btn.tag];
    NSDictionary * providerId =  myJsonResponseIndividualElement[@"providerID"];
    _alert = [UIAlertController
              alertControllerWithTitle:@""
              message:[[GlobalFunction sharedInstance].arrayOfAlerts objectAtIndex:57]
              preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* yesButton = [UIAlertAction
                                actionWithTitle:@"Yes"
                                style:UIAlertActionStyleDefault
                                handler:^(UIAlertAction * action) {
                                    
                                    
                                    NSString *searchRecommendUrl=[appdelegate.serviceURL stringByAppendingString:@"api/Recommendations/MyRecommendations"];
                                    NSMutableDictionary *searchRecommendData = [[NSMutableDictionary alloc] init];
                                    [searchRecommendData setObject:providerId forKey:@"providerID"];
                                    [searchRecommendData setObject:@"false" forKey:@"isRecommendations"];
                                    [self startLoadingIndicator];
                                    [[GlobalFunction sharedInstance] getServerResponseAfterLogin:searchRecommendUrl method:@"POST" param:searchRecommendData withCallback:^(NSInteger statusCode, NSDictionary *response, NSError *error)
                                     {
                                         if(statusCode==200){
                                             [self stopLoadingIndicator];
                                             CGPoint touchPoint = [sender convertPoint:CGPointZero toView:self.recommendationTable];
                                             NSIndexPath *indexPath = [self.recommendationTable indexPathForRowAtPoint:touchPoint];
                                             [recommendationArray removeObjectAtIndex:indexPath.row];
                                             [self.recommendationTable reloadData];
                                         }else{
                                             NSString *message;
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
                                             [self presentViewController:_alert animated:YES completion: nil];
                                         }
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
        [recommendationArray removeObjectAtIndex:indexPath.row];
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
    [self dismissViewControllerAnimated:YES completion:nil];
}


//Added by: Nalina
//Added Date: 16/08/2016
//Discription: Add recommendiees on click of add button redirect to the search screen

- (IBAction)addMoreRecommendationClick:(id)sender {
    NSLog(@"Filter Click Event");
    /*RecommendationSearchViewController *vc=[self.storyboard instantiateViewControllerWithIdentifier:@"RecommendationSearch"];
    [self.navigationController pushViewController:vc animated:YES];*/
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"ProviderStoryboard" bundle:nil];
    RecommendationSearchViewController *viewcontrol=[storyboard instantiateViewControllerWithIdentifier:@"RecommendationSearch"];
    [self presentViewController:[storyboard instantiateViewControllerWithIdentifier:@"RecommendationSearch"] animated:NO completion:nil];
    
}


//Added by: Nalina
//Added Date: 16/08/2016
//Discription: Start loading indicator

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
//Added Date: 16/08/2016
//Discription: Stop loading indicator

-(void)stopLoadingIndicator
{
    
    _loadingView.hidden=YES;
}

- (IBAction)backbutton:(id)sender {
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
    [_recommendationTable reloadData];
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
            NSDictionary *myJsonResponseIndividualElement = recommendationArray[index];
            NSDictionary *providerID =  myJsonResponseIndividualElement[@"providerID"];
            NSLog(@"ProviderID %@",providerID);
            NSMutableDictionary *dict=[[NSMutableDictionary alloc]init];
            [dict setObject:providerID forKey:@"providerID"];
            [dict setObject:@"false" forKey:@"isRecommendations"];
           // [dict setObject:@"2" forKey:@"rating"];
            
            // GlobalFunction *globalValues=[[GlobalFunction alloc]init];
            
            _alert = [UIAlertController
                      alertControllerWithTitle:@""
                      message:[[GlobalFunction sharedInstance].arrayOfAlerts objectAtIndex:137]
                      preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction* yesButton = [UIAlertAction
                                        actionWithTitle:@"Yes"
                                        style:UIAlertActionStyleDefault
                                        handler:^(UIAlertAction * action) {
                                            
                                            NSString *Url=[appdelegate.serviceURL stringByAppendingString:@"api/Recommendations/MyRecommendations"];
                                            [self startLoadingIndicator];
                                            [[GlobalFunction sharedInstance]getServerResponseAfterLogin:Url method:@"POST" param:dict withCallback:^(NSInteger statusCode, NSDictionary *response, NSError *error) {
                                                if(statusCode == 200)
                                                {
                                                    NSIndexPath *indexPath =[_recommendationTable indexPathForCell:cell];
                                                    [recommendationArray removeObjectAtIndex:indexPath.row];
                                                    [self.recommendationTable reloadData];
                                                    
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
