
/***************************************************************
 Page name:UploadProfilePicture.h
 Created By:ZEENATH
 Created Date:11-07-16
 Description:To upload a profile Picture implemetation file
 ***************************************************************/

#import "UploadProfilePicture.h"
#import "ProviderSignUpProfFitness.h"
#import "GlobalFunction.h"
#import "ForgotPasswordViewController.h"
#import "AppDelegate.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import <Google/Analytics.h>
@interface UploadProfilePicture ()

@end

@implementation UploadProfilePicture
@synthesize userDetails,prepopulateData;

//Called when the view controller is first time loaded to memory
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    prepopulateData=[[NSMutableDictionary alloc]init];
    self.profileImage.layer.cornerRadius = self.profileImage.frame.size.width / 2;
    self.profileImage.clipsToBounds = YES;
  
    ///profilePic
}

// Dispose of any resources that can be recreated.
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

//called each time when the view appears
-(void)viewWillAppear:(BOOL)animated{
    if([_screenStatus isEqualToString:@"userSignup"]){
        _headingLabel.text=@"USER SIGN UP";
    }else{
        _headingLabel.text=@"PROVIDER SIGN UP";
    }
    
      AppDelegate *appdelegate= (AppDelegate *)[[UIApplication sharedApplication]delegate];
     imagePath=appdelegate.prepopulateImage;
    if ([appdelegate.prepopulateData objectForKey:@"profilePic"]==nil) {
        if (appdelegate.prepopulateImage==nil || [appdelegate.prepopulateImage isEqualToString:@""]) {
            
            
        }else{
            
            NSString *name=appdelegate.prepopulateImage;
            NSString *imagename=[@"https://starkblob.blob.core.windows.net/profilepics/" stringByAppendingString:name];
            NSData *imageData = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:imagename]];
            UIImage *image = [[UIImage alloc] initWithData:imageData];
            _profileImage.image=image;

        }
    }else{
        imagePath=[appdelegate.prepopulateData objectForKey:@"profilePic"];
        NSString *name=[appdelegate.prepopulateData objectForKey:@"profilePic"];
        NSString *imagename=[appdelegate.imageURL stringByAppendingString:name];
        NSData *imageData = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:imagename]];
        UIImage *image = [[UIImage alloc] initWithData:imageData];
        _profileImage.image=image;
    }
    id<GAITracker> tracker = [[GAI sharedInstance] defaultTracker];
    [tracker set:kGAIScreenName value:@"UploadProfilePicture"];
    [tracker send:[[GAIDictionaryBuilder createScreenView] build]];
}


//Added bY:ZEENATH
//Added on:28-07-16
//Description:Show the popup to pick the image from gallery or camera
- (IBAction)uploadProfilePicture:(id)sender {
    [_profilePictureMainView setHidden:NO];
    
}



//Added bY:ZEENATH
//Added on:28-07-16
//Description:To pick the image from gallery
- (IBAction)galleryClick:(id)sender {
    
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc]init];
    imagePickerController.delegate = self;
    imagePickerController.sourceType =  UIImagePickerControllerSourceTypePhotoLibrary;
    
    [self presentViewController:imagePickerController animated:YES completion:nil];
}

//Added bY:ZEENATH
//Added on:28-07-16
//Description:To pick the image from camera
- (IBAction)cameraClick:(id)sender {
  
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc]init];
    imagePickerController.delegate = self;
    //imagePickerController = [[UIImagePickerController alloc] init];
    imagePickerController.sourceType =  UIImagePickerControllerSourceTypeCamera;
    // [self presentModalViewController:imagePickerController animated:YES];
    [self presentViewController:imagePickerController animated:YES completion:nil];
}


//Added bY:ZEENATH
//Added on:28-07-16
//Description:Hide the popup to pick the image
- (IBAction)cancelClick:(id)sender {
    
    [_profilePictureMainView setHidden:YES];
}

//Added bY:ZEENATH
//Added on:28-07-16
//Description:dismiss the view to pick the image
- (void)imagePickerControllerDidCancel:(UIImagePickerController *) Picker {
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

//Added bY:ZEENATH
//Added on:28-07-16
//Description:Bind the image and store it to Azure blob after picking the image from camera or gallery
- (void) imagePickerController:(UIImagePickerController *)picker
         didFinishPickingImage:(UIImage *)image
                   editingInfo:(NSDictionary *)editingInfo
{
    [self startLoadingIndicator];
    [_profilePictureMainView setHidden:YES];
   
    
    NSString *name=[userDetails valueForKey:@"firstName"];
    
    AppDelegate *appDelegat=(AppDelegate *)[[UIApplication sharedApplication]delegate];
    [appDelegat uploadBlobToContainer:image name:name path:1 withCallback:^(NSString *response, NSError *error) {
        if (error == nil)
        {
            [self stopLoadingIndicator];
            imagePath=response;
            [userDetails setObject:response forKey:@"profilePicPath"];
           
             self.profileImage.image = image;
           
        }
        else
        {
            //imagePath=@"";
            [self stopLoadingIndicator];
            [userDetails setObject:@"" forKey:@"profilePicPath"];
           
        }
        
        
    }];
    
    
    [self dismissModalViewControllerAnimated:YES];
    
    
    
}

//Added bY:ZEENATH
//Added on:28-07-16
//Description:Called when the back button is clicked
- (IBAction)backClick:(id)sender {
    AppDelegate *appDelegat=(AppDelegate *)[[UIApplication sharedApplication]delegate];
    
   // imagePath=[userDetails objectForKey:@"profilePicPath"];
    appDelegat.prepopulateImage=imagePath;
    [self dismissViewControllerAnimated:YES completion:nil];
}


//Added bY:ZEENATH
//Added on:28-07-16
//Description:Called when the next button is clicked
- (IBAction)nextClick:(id)sender {
    if(imagePath == nil || [imagePath
       isEqualToString:@""])
    {
          [userDetails setObject:@"" forKey:@"profilePicPath"];
    }
    else{
          [userDetails setObject:imagePath forKey:@"profilePicPath"];
    }
    
    AppDelegate *appdelegate= (AppDelegate *)[[UIApplication sharedApplication]delegate];
    
    BOOL internetCheck= [appdelegate testInternetConnection];
    
    if (internetCheck==NO) {
        [appdelegate displayNetworkAlert];
        [self presentViewController:appdelegate.alert animated:YES completion:nil];
    }
    
    
       /* if([_screenStatus isEqualToString:@"userSignup"]){
            AppDelegate *appdelegate= (AppDelegate *)[[UIApplication sharedApplication]delegate];
            
           ForgotPasswordViewController *forgotPasswordviewController=[self.storyboard instantiateViewControllerWithIdentifier:@"forgotPassword"];
            forgotPasswordviewController.screenStatus=@"userSignup";
            forgotPasswordviewController.providerDetails=userDetails;
            forgotPasswordviewController.pickerArray=appdelegate.questionArray;
            forgotPasswordviewController.questionID=appdelegate.questionIdArray;
            forgotPasswordviewController.imagePath=imagePath;

            [self presentViewController:forgotPasswordviewController animated:YES completion:nil];
        }else{
            ProviderSignUpProfFitness *vc=[self.storyboard instantiateViewControllerWithIdentifier:@"ProfFitness"];
            vc.imagePath=imagePath;
            vc.providerDetails=userDetails;
            [self presentViewController:vc animated:YES completion:nil];
        }*/
    

}

//  Added by:Zeenath
//  Added Date:2016-24-08.
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
//  Added Date:2016-24-08.
//  Description:To stop the activity indicator.
-(void)stopLoadingIndicator
{
    
    _loadingView.hidden=YES;
}

@end
