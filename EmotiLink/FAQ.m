/***************************************************************
 Page name: FAQ.m
 Created By:Nalina
 Created Date:21/07/16
 Description:FAQ implementation file
 ***************************************************************/


#import "FAQ.h"
#import "GlobalFunction.h"
#import "AppDelegate.h"
#import "FZAccordionTableView.h"
#import "AccordionHeaderView.h"

static NSString *const kTableViewCellReuseIdentifier = @"TableViewCellReuseIdentifier";
@interface FAQ () <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet FZAccordionTableView *tableView;



@end

@implementation FAQ

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - View lifecycle

//Called for the first time when the view is loaded
- (void)viewDidLoad
{
    UIImage *backgroundImage = [UIImage imageNamed:@"06. Appointment Confirmation.png"];
    UIImageView *backgroundImageView=[[UIImageView alloc]initWithFrame:self.view.frame];
    backgroundImageView.image=backgroundImage;
    [self.view insertSubview:backgroundImageView atIndex:0];
    
    //[self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"background-dashboard.png"]]];
    
    // Added By: Nalina
    // Added Date: 21/07/16
    // Description:Setting the design part customly to implement expand collapse functionality
    
    accordion = [[AccordionView alloc] initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height)];
    
    [self.faqBackView addSubview:accordion];
    self.faqBackView.backgroundColor = [UIColor  colorWithRed:(239/255.0) green:(239/255.0) blue:(239/255.0) alpha:1];
    
    selectSectionValue=0;
    
    AppDelegate *appdelegate= (AppDelegate *)[[UIApplication sharedApplication]delegate];
    //  GlobalFunction *globalValues=[[GlobalFunction alloc]init];
    
    BOOL internetCheck= [appdelegate testInternetConnection];
    
    if (internetCheck==NO) {
        
        _alert = [UIAlertController
                  alertControllerWithTitle:@""
                  message:[[GlobalFunction sharedInstance].arrayOfAlerts objectAtIndex:67]
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
        
        // Added By:Nalina
        // Added Date:01/08/16
        // Description: FAQ list service call
        
        NSString *faqUrl=[appdelegate.serviceURL stringByAppendingString:@"api/FAQs"];
        [self startLoadingIndicator];
        [[GlobalFunction sharedInstance] getServerResponseAfterLogin:faqUrl method:@"GET" param:nil withCallback:^(NSInteger statusCode, NSDictionary *response, NSError *error)
         {
             NSString *message;
             if (statusCode==200) {
                 
                 NSMutableArray *responseArray = [[NSMutableArray alloc] initWithObjects:response, nil];
                 NSMutableArray *sortedArray =[responseArray objectAtIndex:0];
                 faqArray=[response mutableCopy];
                 [_tableView reloadData];
                 NSLog(@"Countedvalue to %lu",faqArray.count);
                 
                 /*for(int i=0;i<sortedArray.count;i++) {
                  NSDictionary *actualData=[sortedArray objectAtIndex:i];
                  [self ScreenDesign:[actualData objectForKey:@"faqQuestion"] answerArray:[actualData objectForKey:@"faqAnswer"] i:i];
                  }*/
                 [self stopLoadingIndicator];
                 
             }else{
                 
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
                 
                 UIAlertAction* okbutton = [UIAlertAction
                                            actionWithTitle:@"OK"
                                            style:UIAlertActionStyleDefault
                                            handler:^(UIAlertAction * action) {
                                                [self stopLoadingIndicator];
                                            }];
                 
                 [_alert addAction:okbutton];
                 [self presentViewController:_alert animated:YES completion: nil];
             }
         }];
    }
    
    self.tableView.allowMultipleSectionsOpen = NO;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:kTableViewCellReuseIdentifier];
    [self.tableView registerNib:[UINib nibWithNibName:@"AccordionHeaderView" bundle:nil] forHeaderFooterViewReuseIdentifier:kAccordionHeaderViewReuseIdentifier];
    [super viewDidLoad];
    
    
}


- (BOOL)prefersStatusBarHidden {
    return YES;
}

#pragma mark - <UITableViewDataSource> / <UITableViewDelegate> -

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    NSLog(@"Count to %@",faqArray);
    return (faqArray.count);
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
    NSDictionary *myJsonResponseIndividualElement = faqArray[selectSectionValue];
    NSLog(@"myarrayyyy cell row to %lu",selectSectionValue);
    
    NSLog(@"myarrayyyy cell to %@",myJsonResponseIndividualElement);
    AccordionHeaderView *headerVw= [tableView dequeueReusableHeaderFooterViewWithIdentifier:kAccordionHeaderViewReuseIdentifier];
    UITapGestureRecognizer *singleFingerTap =
    [[UITapGestureRecognizer alloc] initWithTarget:self
                                            action:@selector(handleSingleTapped:)];
    [headerVw.HeaderView addGestureRecognizer:singleFingerTap];
    
    cell.textLabel.numberOfLines=0;
    cell.textLabel.lineBreakMode = NSLineBreakByWordWrapping;
    cell.textLabel.text=myJsonResponseIndividualElement[@"faqAnswer"];
    
    cell.backgroundColor=[UIColor clearColor];
    
    //cell.layer.backgroundColor=[UIColor colorWithRed:207.0/255.0 green:230.0/255.0 blue:229.0/255.0 alpha:1].CGColor;
    //cell.textLabel.layer.backgroundColor=[UIColor colorWithRed:207.0/255.0 green:230.0/255.0 blue:229.0/255.0 alpha:1].CGColor;
    //cell.textLabel.backgroundColor=CFBridgingRelease([UIColor colorWithRed:207.0/255.0 green:230.0/255.0 blue:229.0/255.0 alpha:1].CGColor);
    
    [cell.textLabel setFont:[UIFont fontWithName:@"System" size:12]];
    //cell.textLabel.text = @"Cell";
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    AccordionHeaderView *headerVw= [tableView dequeueReusableHeaderFooterViewWithIdentifier:kAccordionHeaderViewReuseIdentifier];
    if(faqArray.count>0){
        NSDictionary *myJsonResponseIndividualElement = faqArray[section];
        NSLog(@"myarrayyyy to %@",myJsonResponseIndividualElement);
        NSLog(@"myarrayyyy to section %lu",section);
        
        headerVw.headerLabel.numberOfLines=0;
        headerVw.headerLabel.lineBreakMode = NSLineBreakByWordWrapping;
        headerVw.headerLabel.text=myJsonResponseIndividualElement[@"faqQuestion"];
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
// Added By: Nalina
// Added Date: 21/07/16
// Description: To design complete screen function

-(void)ScreenDesign:(NSString *)questionIs answerArray:(NSString *)answerIs i:(int)i{
    
    NSString* questionCount = [NSString stringWithFormat:@"%i", i+1];
    NSString *questionLabel =     [questionCount stringByAppendingString:@". "];
    questionLabel = [questionLabel stringByAppendingString:questionIs];
    
    questionBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 0, 55)];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 10,[[UIScreen mainScreen] bounds].size.width-30 , 35)];
    titleLabel.numberOfLines = 2;
    titleLabel.minimumFontSize = 10;
    titleLabel.adjustsFontSizeToFitWidth = YES;
    titleLabel.text = questionLabel;
    [titleLabel setFont:[UIFont fontWithName:@"CenturyGothic.ttf" size:12]];
    titleLabel.textColor =[UIColor  colorWithRed:(51/255.0) green:(51/255.0) blue:(51/255.0) alpha:1];
    [questionBtn addSubview:titleLabel];
    
    
    arrowImg=[[UIImageView alloc]initWithFrame:CGRectMake([[UIScreen mainScreen] bounds].size.width-25, 18, 15, 15)];
    arrowImg.image =  [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"ndrop_arrow" ofType:@"png"]];
    
    
    lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 55, [[UIScreen mainScreen] bounds].size.width, 1)];
    lineView.backgroundColor = [UIColor blackColor];
    
    expandableView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, 100)];
    expandableView.backgroundColor = [UIColor whiteColor];
    
    answerText= [[UITextView alloc] initWithFrame:CGRectMake(10, 0,expandableView.bounds.size.width-10, expandableView.bounds.size.height)];
    answerText.editable = NO;
    answerText.dataDetectorTypes = UIDataDetectorTypeLink;
    answerText.text=answerIs;
    answerText.textColor=[UIColor  colorWithRed:(51/255.0) green:(51/255.0) blue:(51/255.0) alpha:1];
    [answerText setTextAlignment:NSTextAlignmentLeft];
    [answerText setFont:[UIFont fontWithName:@"CenturyGothic.ttf" size:14]];
    
    [expandableView addSubview:answerText];
    [questionBtn addSubview:arrowImg];
    [questionBtn addSubview:lineView];
    [accordion addHeader:questionBtn withView:expandableView imgView:arrowImg];
    
    [accordion setNeedsLayout];
    
    // Set this if you want to allow multiple selection
    [accordion setAllowsMultipleSelection:YES];
    
    // Set this to NO if you want to have at least one open section at all times
    [accordion setAllowsEmptySelection:YES];
    
}

- (void)removeSecondRow {
    [accordion removeHeaderAtIndex:1];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
}


// View will load each time when user focus the screen
- (void)viewWillAppear:(BOOL)animated
{
    
    UIImage *image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"back-28x28" ofType:@"png"]];
    
    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithImage:image style:UIBarButtonItemStylePlain target:self action:@selector(goBack)];
    [self.navigationItem setLeftBarButtonItem:barButtonItem];
    self.navigationItem.title = @"FAQs";
    
    [self.navigationController.navigationBar
     setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor colorWithRed:239.0/255.0 green:239.0/255.0 blue:239.0/255.0 alpha:1.0]}];
    
    self.navigationController.navigationBar.tintColor = [UIColor colorWithRed:239.0/255.0 green:239.0/255.0 blue:239.0/255.0 alpha:1.0];
    [super viewWillAppear:animated];
}

//To close the FAQ screen
-(void)goBack{
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

//To close the FAQ screen
- (IBAction)backClick:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

//  Added by: Nalina
//  Added Date: 01/08/16
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

//  Description:To stop the activity indicator.
-(void)stopLoadingIndicator
{
    
    _loadingView.hidden=YES;
}


- (IBAction)backArrowClick:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
