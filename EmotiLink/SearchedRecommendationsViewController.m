/***************************************************************
 Page name: SearchedRecommendationsViewController.m
 Created By:Nalina
 Created Date:2016-07-12
 Description: Searched recommendation implementation Screen.
 ***************************************************************/

#import "SearchedRecommendationsViewController.h"
#import "SearchedRecommendationsTableViewCell.h"
#import "GlobalFunction.h"
#import "AppDelegate.h"
#import <Google/Analytics.h>
#import <HCSStarRatingView/HCSStarRatingView.h>
#import "MyRecommendationsViewController.h"

@interface SearchedRecommendationsViewController ()

@end

@implementation SearchedRecommendationsViewController

//Loads for the first time when page loads
- (void)viewDidLoad {
    
    UIImage *backgroundImage = [UIImage imageNamed:@"05. List-View.png"];
    UIImageView *backgroundImageView=[[UIImageView alloc]initWithFrame:self.view.frame];
    backgroundImageView.image=backgroundImage;
    [self.view insertSubview:backgroundImageView atIndex:0];
    [super viewDidLoad];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

//Loads each time when page appears
-(void)viewWillAppear:(BOOL)animated
{
    id<GAITracker> tracker = [[GAI sharedInstance] defaultTracker];
    [tracker set:kGAIScreenName value:@"SearchedRecommendations"];
    [tracker send:[[GAIDictionaryBuilder createScreenView] build]];
}

//Return number of section in table
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

//Return the number of rows count to display in table
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _searchedRecommendationArray.count;
}

//Return the data to display and cell in table
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //  Added by: Nalina
    //  Added Date:2016-20-07.
    //  Description: Display details of the searched recommendation in the table cell
    
    SearchedRecommendationsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"searchedRecommendCell" forIndexPath:indexPath];
    //cell.profileImageView.layer.cornerRadius = cell.profileImageView.frame.size.width / 2;
    cell.profileImageView.clipsToBounds = YES;
    
    cell.addRecommendationBtn.tag = indexPath.row;
    [cell.addRecommendationBtn addTarget:self action:@selector(AcceptClicked:) forControlEvents:UIControlEventTouchUpInside];
    
   /* if (indexPath.row % 2) {
        
        cell.mainview.backgroundColor = [[UIColor alloc]initWithRed:51.0/255.0 green:51.0/255.0 blue:51.0/255.0 alpha:1];
    }else{
        cell.mainview.backgroundColor =[[UIColor alloc]initWithRed:62.0/255.0 green:62.0/255.0 blue:62.0/255.0 alpha:1];
    }*/
    
    NSDictionary *myJsonResponseIndividualElement = _searchedRecommendationArray[indexPath.row];
    
    NSString *name=[myJsonResponseIndividualElement[@"firstName"] stringByAppendingString:@" "];
    cell.firstNameLabel.text= [name stringByAppendingString:myJsonResponseIndividualElement[@"lastName"]];
    AppDelegate *appdelegate=(AppDelegate *)[[UIApplication sharedApplication]delegate];
    
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
        
    });
    
    cell.rateLabel.text=[myJsonResponseIndividualElement[@"rateCurrency"] stringByAppendingString:@"/hour"];
    
    if(![myJsonResponseIndividualElement[@"qualification"] isEqual:[NSNull null]])
    {
        cell.expertiseLabel.text=myJsonResponseIndividualElement[@"qualification"];
    }
    else{
      cell.expertiseLabel.text=@"";
    }
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


//  Added by: Nalina
//  Added Date:2016-20-07.
//  Description: make user as a recommendiee

- (void)AcceptClicked:(UIButton*)sender{
    
    AppDelegate *appdelegate= (AppDelegate *)[[UIApplication sharedApplication]delegate];
    UIButton *btn=(UIButton *)sender;
    NSDictionary *myJsonResponseIndividualElement = _searchedRecommendationArray[btn.tag];
    NSDictionary * providerId =  myJsonResponseIndividualElement[@"providerID"];
    
   // GlobalFunction *globalValues=[[GlobalFunction alloc]init];
    
    _alert = [UIAlertController
              alertControllerWithTitle:@""
              message:[[GlobalFunction sharedInstance].arrayOfAlerts objectAtIndex:58]
              preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* yesButton = [UIAlertAction
                                actionWithTitle:@"Yes"
                                style:UIAlertActionStyleDefault
                                handler:^(UIAlertAction * action) {
                                    
                                    NSString *searchRecommendUrl=[appdelegate.serviceURL stringByAppendingString:@"api/Recommendations/MyRecommendations"];
                                    NSMutableDictionary *searchRecommendData = [[NSMutableDictionary alloc] init];
                                    [searchRecommendData setObject:providerId forKey:@"providerID"];
                                    [searchRecommendData setObject:@"true" forKey:@"isRecommendations"];
                                    [self startLoadingIndicator];
                                    [[GlobalFunction sharedInstance] getServerResponseAfterLogin:searchRecommendUrl method:@"POST" param:searchRecommendData withCallback:^(NSInteger statusCode, NSDictionary *response, NSError *error)
                                     {
                                         if(statusCode==200){
                                             [self stopLoadingIndicator];

                                             /*CGPoint touchPoint = [sender convertPoint:CGPointZero toView:self.searchedRecommendationTable];
                                             NSIndexPath *indexPath = [self.searchedRecommendationTable indexPathForRowAtPoint:touchPoint];
                                             [_searchedRecommendationArray removeObjectAtIndex:indexPath.row];
                                             [self.searchedRecommendationTable reloadData]; */
                                             
                                             
                                             [self dismissViewControllerAnimated:YES completion:nil];
                                             
                                             
                                             
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

//Close the screen on click of back icon
- (IBAction)PageBackClick:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];

}


//  Added by: Nalina
//  Added Date:2016-20-07.
//  Description: To start the activity indicator.

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

//  Added by: Nalina
//  Added Date:2016-20-07.
//  Description: To stop the activity indicator.

-(void)stopLoadingIndicator
{
    
    _loadingView.hidden=YES;
}


- (IBAction)filterClick:(id)sender {
    AppDelegate *appdelegate= (AppDelegate *)[[UIApplication sharedApplication]delegate];
    UIButton *btn=(UIButton *)sender;
    NSDictionary *myJsonResponseIndividualElement = _searchedRecommendationArray[btn.tag];
    NSDictionary * providerId =  myJsonResponseIndividualElement[@"providerID"];
    
    // GlobalFunction *globalValues=[[GlobalFunction alloc]init];
    
    _alert = [UIAlertController
              alertControllerWithTitle:@""
              message:[[GlobalFunction sharedInstance].arrayOfAlerts objectAtIndex:58]
              preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* yesButton = [UIAlertAction
                                actionWithTitle:@"Yes"
                                style:UIAlertActionStyleDefault
                                handler:^(UIAlertAction * action) {
                                    
                                    NSString *searchRecommendUrl=[appdelegate.serviceURL stringByAppendingString:@"api/Recommendations/MyRecommendations"];
                                    NSMutableDictionary *searchRecommendData = [[NSMutableDictionary alloc] init];
                                    [searchRecommendData setObject:providerId forKey:@"providerID"];
                                    [searchRecommendData setObject:@"true" forKey:@"isRecommendations"];
                                    [self startLoadingIndicator];
                                    [[GlobalFunction sharedInstance] getServerResponseAfterLogin:searchRecommendUrl method:@"POST" param:searchRecommendData withCallback:^(NSInteger statusCode, NSDictionary *response, NSError *error)
                                     {
                                         if(statusCode==200){
                                             [self stopLoadingIndicator];
                                             
                                             CGPoint touchPoint = [sender convertPoint:CGPointZero toView:self.searchedRecommendationTable];
                                             NSIndexPath *indexPath = [self.searchedRecommendationTable indexPathForRowAtPoint:touchPoint];
                                             [_searchedRecommendationArray removeObjectAtIndex:indexPath.row];
                                             [self.searchedRecommendationTable reloadData];
                                             
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
@end
