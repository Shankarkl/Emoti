
/***************************************************************
 Page name: MyClientsViewController.m
 Created By:Nalina
 Created Date:11/07/16
 Description:my clients implementation file
 ***************************************************************/

#import "MyClientsViewController.h"
#import "MyClientsTableViewCell.h"
#import "GlobalFunction.h"
#import "ClientDetailsViewController.h"
#import "AppDelegate.h"
#import <Google/Analytics.h>

@interface MyClientsViewController ()

@end

@implementation MyClientsViewController

//Loads first time when page appears
- (void)viewDidLoad {
    
    
    
    if([_providerclients isEqualToString:@"myclients"]){
        
        _backArrowBtn.hidden = NO;
    }
    
    myclientsArray= [NSMutableArray array];
    
    [super viewDidLoad];
    
    UIImageView *bgImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"05. List-View.png"]];
    bgImageView.frame = self.view.bounds;
    bgImageView.contentMode = UIViewContentModeScaleAspectFit;
    bgImageView.clipsToBounds = YES;
    [self.view addSubview:bgImageView];
    [self.view sendSubviewToBack:bgImageView];
}

-(void)viewDidAppear:(BOOL)animated{
    //Added by: Nalina
    //Added Date: 19/08/2016
    //Discription: service call to get the list of the clients
    
    // GlobalFunction *globalValues=[[GlobalFunction alloc]init];
    AppDelegate *appdelegate= (AppDelegate *)[[UIApplication sharedApplication]delegate];
    
    NSString *getRecommendrUrl=[appdelegate.serviceURL stringByAppendingString:@"api/MyClients"];
    [self startLoadingIndicator];
    [[GlobalFunction sharedInstance] getServerResponseAfterLogin:getRecommendrUrl method:@"GET" param:nil withCallback:^(NSInteger statusCode, NSDictionary *response, NSError *error)
     {
         
         if (statusCode == 200)
         {
             
             myclientsArray=[response mutableCopy];
             [self stopLoadingIndicator];
             [_scheduledTable reloadData];
             
         }else if(statusCode==404){
             [self stopLoadingIndicator];
             _alert = [UIAlertController
                       alertControllerWithTitle:@""
                       message:[[GlobalFunction sharedInstance].arrayOfAlerts objectAtIndex:81]
                       preferredStyle:UIAlertControllerStyleAlert];
             
             UIAlertAction* okButton = [UIAlertAction
                                        actionWithTitle:@"OK"
                                        style:UIAlertActionStyleDefault
                                        handler:^(UIAlertAction * action) {
                                            [self.navigationController popViewControllerAnimated:YES];
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
    [tracker set:kGAIScreenName value:@"MyClients"];
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
    return myclientsArray.count;
}

//Return the data to display and cell in table
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    MyClientsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"myClientsCell" forIndexPath:indexPath];
    //cell.profileImageView.layer.cornerRadius = cell.profileImageView.frame.size.width / 2;
    cell.profileImageView.clipsToBounds = YES;
    
    cell.delegate = self;
    NSString *item = myclientsArray[indexPath.row];
    cell.itemText = item;
    if ([self.cellsCurrentlyEditing containsObject:indexPath]) {
    }
    
    cell.cancelBtn.tag = indexPath.row;
    [cell.cancelBtn addTarget:self action:@selector(AcceptClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    /*if (indexPath.row % 2) {
        cell.mainContentView.backgroundColor = [[UIColor alloc]initWithRed:51.0/255.0 green:51.0/255.0 blue:51.0/255.0 alpha:1];
    }else{
        cell.mainContentView.backgroundColor =[[UIColor alloc]initWithRed:62.0/255.0 green:62.0/255.0 blue:62.0/255.0 alpha:1];
    }*/
    
    NSDictionary *myJsonResponseIndividualElement = myclientsArray[indexPath.row];
    
    //NSString *name=[myJsonResponseIndividualElement[@"firstName"] stringByAppendingString:@" "];
    
    cell.firstnameLabel.text= [myJsonResponseIndividualElement[@"firstName"] stringByAppendingString:@" "]; //[name stringByAppendingString:myJsonResponseIndividualElement[@"lastName"]];
    
    NSString *amount=myJsonResponseIndividualElement[@"totalSessions"];
    NSNumber *value=[NSNumber numberWithInteger:[amount integerValue]];
    
    cell.numberOfSession.text=[value stringValue];
    
    if(![myJsonResponseIndividualElement[@"lastScheduledSession"] isEqual:[NSNull null]])
    {
        cell.dateTimeLabel.text=myJsonResponseIndividualElement[@"lastScheduledSession"];
    }
    else{
        cell.dateTimeLabel.text=@"No Session.";
    }
    
    //cell.appointmentLabel.text=  myJsonResponseIndividualElement[@"totalBilledAmount"];
    
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
    
    return cell;
}


//Added by: Nalina
//Added Date: 24/08/2016
//Discription: Redirect to client details screen to check the details of session requested client

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ClientDetailsViewController *vc=[self.storyboard instantiateViewControllerWithIdentifier:@"clientDetails"];
    vc.detailsDict=myclientsArray[indexPath.row];
    vc.screenStatus=@"myclients";
    [self.navigationController pushViewController:vc animated:YES];
}

//Added by: Nalina
//Added Date: 20/08/2016
//Discription: Service call to delete the recommendiee when we swipe and click on delete button

- (void)AcceptClicked:(UIButton*)sender{
    
    //  GlobalFunction *globalValues=[[GlobalFunction alloc]init];
    AppDelegate *appdelegate= (AppDelegate *)[[UIApplication sharedApplication]delegate];
    
    UIButton *btn=(UIButton *)sender;
    
    NSDictionary *myJsonResponseIndividualElement = myclientsArray[btn.tag];
    NSDictionary * clientID =  myJsonResponseIndividualElement[@"clientID"];
    
    _alert = [UIAlertController
              alertControllerWithTitle:@""
              message:[[GlobalFunction sharedInstance].arrayOfAlerts objectAtIndex:62]
              preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* yesButton = [UIAlertAction
                                actionWithTitle:@"Yes"
                                style:UIAlertActionStyleDefault
                                handler:^(UIAlertAction * action) {
                                    NSString *removeClientUrl=[appdelegate.serviceURL stringByAppendingString:@"api/MyClients"];
                                    NSMutableDictionary *myClientData = [[NSMutableDictionary alloc] init];
                                    [myClientData setObject:clientID forKey:@"clientID"];
                                    [myClientData setObject:@"false" forKey:@"isMyClient"];
                                    [self startLoadingIndicator];
                                    [[GlobalFunction sharedInstance] getServerResponseAfterLogin:removeClientUrl method:@"POST" param:myClientData withCallback:^(NSInteger statusCode, NSDictionary *response, NSError *error)
                                     {
                                         if(statusCode==200){
                                             [self stopLoadingIndicator];
                                             CGPoint touchPoint = [sender convertPoint:CGPointZero toView:self.scheduledTable];
                                             NSIndexPath *indexPath = [self.scheduledTable indexPathForRowAtPoint:touchPoint];
                                             [myclientsArray removeObjectAtIndex:indexPath.row];
                                             [self.scheduledTable reloadData];
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
        [myclientsArray removeObjectAtIndex:indexPath.row];
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
    //  NSLog(@"In the delegate, Clicked button one for %@", itemText);
}

- (void)buttonTwoActionForItemText:(NSString *)itemText {
    // NSLog(@"In the delegate, Clicked button two for %@", itemText);
}

//Close the screen on click of back icon
- (IBAction)backClick:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}


//Added by: Nalina
//Added Date: 20/08/2016
//Discription:To start the activity indicator.

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
//Added Date: 20/08/2016
//Discription:To stop the activity indicator.

-(void)stopLoadingIndicator
{
    
    _loadingView.hidden=YES;
}

- (IBAction)backbtn:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
