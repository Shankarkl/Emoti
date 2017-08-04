

/***************************************************************
 Page name:AppDelegate.m
 Created By:ZEENATH
 Created Date:29-06-16
 Description:Called when the application is loaded 
 ***************************************************************/

#import "AppDelegate.h"
#import <AZSClient/AZSClient.h>
#import "UploadProfilePicture.h"
#import "GlobalFunction.h"
#import "Reachability.h"
#import <Google/Analytics.h>
#import "LoginViewController.h"

#import <WindowsAzureMessaging/WindowsAzureMessaging.h>
#import "HubInfo.h"

@interface AppDelegate ()

@end

@implementation AppDelegate
@synthesize serviceURL,imageURL;
@synthesize accessToken,prepopulateData,prepopulateImage,screenStatus,todaysSchedules,checkIdelTimer;
@synthesize alert,usersDetails,questionArray,questionIdArray,availabilityArray,availabilityId,availableData,cropProfileImage,userOnlineSessionDetails;

void(^getUrlCallback)(NSString *response, NSError *error);

//Called when the application finishes launch
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
     serviceURL=@"https://emotilinkservices.azurewebsites.net/";
    //serviceURL=@"https://staremotilinkservice.azurewebsites.net/";
    imageURL=@"https://starkblob.blob.core.windows.net/profilepics/";
    internetStatus=YES;
    // Configure tracker from GoogleService-Info.plist.
    NSError *configureError;
    [[GGLContext sharedInstance] configureWithError:&configureError];
    NSAssert(!configureError, @"Error configuring Google services: %@", configureError);
    
    // Optional: configure GAI options.
    GAI *gai = [GAI sharedInstance];
    gai.trackUncaughtExceptions = YES;  // report uncaught exceptions
    gai.logger.logLevel = kGAILogLevelVerbose;  // remove before app release
    
    // [BTAppSwitch setReturnURLScheme:@"com.stark.EmotiLink.payments"];
    
    ///Commented by Zeenath push Notification implementation without Azure
    /*
     if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)
     {
     [[UIApplication sharedApplication] registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:(UIUserNotificationTypeSound | UIUserNotificationTypeAlert | UIUserNotificationTypeBadge) categories:nil]];
     [[UIApplication sharedApplication] registerForRemoteNotifications];
     }
     else
     {
     [[UIApplication sharedApplication] registerForRemoteNotificationTypes:
     (UIUserNotificationTypeBadge | UIUserNotificationTypeSound | UIUserNotificationTypeAlert)];
     }
     
     
     
     UILocalNotification *locationNotification = [launchOptions objectForKey:UIApplicationLaunchOptionsLocalNotificationKey];
     if (locationNotification) {
     // Set icon badge number to zero
     application.applicationIconBadgeNumber = 1;
     }
     
     */
    
    //  Added by:Zeenath
    //  Added Date:2016-02-09.
    //  Description:To register for push Notification .
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)
    {
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeSound |
                                                UIUserNotificationTypeAlert | UIUserNotificationTypeBadge categories:nil];
        
        [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
        [[UIApplication sharedApplication] registerForRemoteNotifications];
    }
    else{
        
        [[UIApplication sharedApplication] registerForRemoteNotificationTypes: UIRemoteNotificationTypeAlert | UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeSound];
    }
    
    
    NSDictionary *notification = [launchOptions objectForKey:UIApplicationLaunchOptionsRemoteNotificationKey];
    
    if (notification) {
        NSString *message = notification[@"aps"][@"alert"];
        
        UILocalNotification *localNotification = [[UILocalNotification alloc] init];
        localNotification.userInfo = notification;
        localNotification.applicationIconBadgeNumber=0;
        localNotification.soundName = UILocalNotificationDefaultSoundName;
        localNotification.alertBody = message;
        localNotification.fireDate = [NSDate date];
        [[UIApplication sharedApplication] scheduleLocalNotification:localNotification];
    }
    
    return YES;
    
}



//  Added by:Zeenath
//  Added Date:2016-02-09.
//  Description:called when the application is registered.
- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *) deviceToken {
    
    
    _deviceToken=deviceToken;
    
    //Commented by nalina
    //To register device with azure
    
    /*   SBNotificationHub* hub = [[SBNotificationHub alloc] initWithConnectionString:HUBLISTENACCESS
     notificationHubPath:HUBNAME];
     NSSet *set = [NSSet setWithObjects:@"EmotiLink", @"Notification",
     @"StarKnowledge", nil];
     [hub registerNativeWithDeviceToken:deviceToken tags:set completion:^(NSError* error) {
     if (error != nil) {
     NSLog(@"Error registering for notifications: %@", error);
     [self MessageBox:@"Registration Status" message:error.description];
     }
     else {
     [self MessageBox:@"Registration Status" message:@"Registered"];
     }
     }];
     
     NSString *deviceTokenString = [NSString stringWithFormat:@"%@",deviceToken];*/
    /* UIAlertController * alertt=   [UIAlertController
     alertControllerWithTitle:@"DeviceToken"
     message:deviceTokenString
     preferredStyle:UIAlertControllerStyleAlert];
     
     UIAlertAction* ok = [UIAlertAction
     actionWithTitle:@"OK"
     style:UIAlertActionStyleDefault
     handler:^(UIAlertAction * action)
     {
     [alertt dismissViewControllerAnimated:YES completion:nil];
     
     }];
     
     [alertt addAction:ok];
     [self.window.rootViewController presentViewController:alertt animated:YES completion:nil];*/
}


//  Added by:Zeenath
//  Added Date:2016-02-09.
//  Description:connects to the notification hub using the connection information and gives the device token.
-(void)MessageBox:(NSString *)title message:(NSString *)messageText{
    UIAlertController *alertt=   [UIAlertController
                                  alertControllerWithTitle:title
                                  message:messageText
                                  preferredStyle:UIAlertControllerStyleAlert];
    //message:@"Recieved Notification"
    // preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* ok = [UIAlertAction
                         actionWithTitle:@"OK"
                         style:UIAlertActionStyleDefault
                         handler:^(UIAlertAction * action)
                         {
                             [self.window.rootViewController presentViewController:alertt animated:YES completion:nil];                             // [self presentViewController:alert animated:YES completion:nil];
                         }];
    [alertt addAction:ok];
    [self.window.rootViewController presentViewController:alertt animated:YES completion:nil];
}


//  Added by:Zeenath
//  Added Date:2016-02-09.
//  Description:called when the application recieves push notification.

- (void)application:(UIApplication *)application didReceiveRemoteNotification: (NSDictionary *)userInfo {
    NSLog(@"userInfo= %@", userInfo);
    /* [self MessageBox:@"Notification" message:[[userInfo objectForKey:@"aps"] valueForKey:@"alert"]];
     // UIApplicationState state = [application applicationState];
     // if (state == UIApplicationStateActive) {
     UIAlertController *alertView = [UIAlertController
     alertControllerWithTitle:@"Notification"
     message:[[userInfo objectForKey:@"aps"] valueForKey:@"alert"]
     preferredStyle:UIAlertControllerStyleAlert];
     
     UIAlertAction* okButton = [UIAlertAction
     actionWithTitle:@"OK"
     style:UIAlertActionStyleDefault
     handler:^(UIAlertAction * action) {
     }];
     [alertView addAction:okButton];
     [self.window.rootViewController presentViewController:alertView animated:YES completion:nil];*/
    
    NSString *message = [[userInfo objectForKey:@"aps"]objectForKey:@"alert"];
    
    /*   UIAlertView *alert = [[UIAlertView alloc]
     initWithTitle:@""
     message:message
     delegate:nil
     cancelButtonTitle:@"OK"
     otherButtonTitles:nil];
     [alert show];*/
    
    UILocalNotification *localNotification = [[UILocalNotification alloc] init];
    localNotification.userInfo = userInfo;
    localNotification.soundName = UILocalNotificationDefaultSoundName;
    localNotification.alertBody = message;
    localNotification.applicationIconBadgeNumber=0;
    localNotification.fireDate = [NSDate date];
    
    [[UIApplication sharedApplication] scheduleLocalNotification:localNotification];
    
    //  }
}

//Registering for local notifications
- (void)application:(UIApplication *)application didRegisterUserNotificationSettings:(UIUserNotificationSettings *)notificationSettings {
    if (notificationSettings.types != UIUserNotificationTypeNone) {
        NSLog(@"didRegisterUser");
        [application registerForRemoteNotifications];
    }
}

//For interactive notification only
- (void)application:(UIApplication *)application handleActionWithIdentifier:(NSString *)identifier forRemoteNotification:(NSDictionary *)userInfo completionHandler:(void(^)())completionHandler
{
    //handle the actions
    if ([identifier isEqualToString:@"declineAction"]){
    }
    else if ([identifier isEqualToString:@"answerAction"])
    {
        
    }
}



//  Added by:Zeenath
//  Added Date:2016-02-09.
//  Description:called when the application fails to register for notification.
-(void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error
{
    
    NSString *str = [NSString stringWithFormat:@"Error : %@",error];
    NSLog(@"Failed to register %@",str);
    
}

///Commented by Zeenath push Notification implementation without Azure
/*
 -(void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
 {
 
 NSString *deviceTokenString = [NSString stringWithFormat:@"%@",deviceToken];
 NSLog(@"Device token %@",deviceTokenString);
 UIAlertController * alertt=   [UIAlertController
 alertControllerWithTitle:@"DeviceToken"
 message:deviceTokenString
 preferredStyle:UIAlertControllerStyleAlert];
 
 UIAlertAction* ok = [UIAlertAction
 actionWithTitle:@"OK"
 style:UIAlertActionStyleDefault
 handler:^(UIAlertAction * action)
 {
 [alertt dismissViewControllerAnimated:YES completion:nil];
 
 }];
 
 [alertt addAction:ok];
 [self.window.rootViewController presentViewController:alertt animated:YES completion:nil];
 
 }
 
 
 -(void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
 {
 
 NSLog(@"userInfo %@",userInfo);
 UIApplicationState state = [application applicationState];
 NSLog(@"state %ld",(long)state);
 UIAlertController * alertt=   [UIAlertController
 alertControllerWithTitle:@"userInfo"
 message:@"Recieved Notification"
 preferredStyle:UIAlertControllerStyleAlert];
 
 UIAlertAction* ok = [UIAlertAction
 actionWithTitle:@"OK"
 style:UIAlertActionStyleDefault
 handler:^(UIAlertAction * action)
 {
 [alertt dismissViewControllerAnimated:YES completion:nil];
 
 }];
 
 [alertt addAction:ok];
 [self.window.rootViewController presentViewController:alertt animated:YES completion:nil];
 // [self presentViewController:alert animated:YES completion:nil];
 
 }*/




/*- (BOOL)application:(UIApplication *)application
 openURL:(NSURL *)url
 sourceApplication:(NSString *)sourceApplication
 annotation:(id)annotation {
 if ([url.scheme localizedCaseInsensitiveCompare:@"com.stark.EmotiLink.payments"] == NSOrderedSame) {
 return [BTAppSwitch handleOpenURL:url sourceApplication:sourceApplication];
 }
 return NO;
 }
 */

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

//  Added by:Nalina
//  Added Date:2016-28-08.
//  Description: Logout the application when user clicks on home button or when it goes to background

- (void)applicationDidEnterBackground:(UIApplication *)application {
  
    //  Commented by:Nalina
    //  Added Date:2016-15-09.
    //  Description: Commented logout functionality basis on client feedback
    
    /* accessToken=nil;
    usersDetails=nil;
    availabilityArray=nil;
    availabilityId=nil;
    availableData=nil;
    screenStatus=@"";
    exit(0);*/
    
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

//  Added by:Nalina
//  Added Date:2016-20-08.
//  Description:called to the alert if internet is down.
-(void)displayNetworkAlert{
    GlobalFunction *globalValues=[[GlobalFunction alloc]init];
    
    alert = [UIAlertController
             alertControllerWithTitle:@""
             message:[globalValues.arrayOfAlerts objectAtIndex:67]
             preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* okButton = [UIAlertAction
                               actionWithTitle:@"OK"
                               style:UIAlertActionStyleDefault
                               handler:^(UIAlertAction * action) {
                                   //Handle your yes please button action here
                               }];
    
    [alert addAction:okButton];
    
}


//  Added by:Nalina
//  Added Date:2016-20-08.
//  Description:called to check the internet connectivity.
- (BOOL)testInternetConnection
{
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(reachabilityChanged:)
                                                 name:kReachabilityChangedNotification
                                               object:nil];
    
    
    // __weak __block typeof(self) weakself = self;
    
    //////////////////////////////////////////////////////////////////////
    /////////////////////////////////////////////////////////////////////
    //
    // create a Reachability object for www.google.com
    
    self.googleReach = [Reachability reachabilityWithHostname:@"www.google.com"];
    
    self.googleReach.reachableBlock = ^(Reachability * reachability)
    {
        // NSString * temp = [NSString stringWithFormat:@"GOOGLE Block Says Reachable(%@)", reachability.currentReachabilityString];
        // NSLog(@"%@", temp);
        internetStatus=YES;
        // to update UI components from a block callback
        // you need to dipatch this to the main thread
        // this uses NSOperationQueue mainQueue
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            
        }];
    };
    
    self.googleReach.unreachableBlock = ^(Reachability * reachability)
    {
        NSString * temp = [NSString stringWithFormat:@"GOOGLE Block Says Unreachable(%@)", reachability.currentReachabilityString];
        NSLog(@"%@", temp);
        internetStatus=NO;
        // to update UI components from a block callback
        // you need to dipatch this to the main thread
        // this one uses dispatch_async they do the same thing (as above)
        dispatch_async(dispatch_get_main_queue(), ^{
            
        });
    };
    
    [self.googleReach startNotifier];
    
    
    
    //////////////////////////////////////////////////////////////////////
    //////////////////////////////////////////////////////////////////////
    //
    // create a reachability for the local WiFi
    
    self.localWiFiReach = [Reachability reachabilityForLocalWiFi];
    
    // we ONLY want to be reachable on WIFI - cellular is NOT an acceptable connectivity
    self.localWiFiReach.reachableOnWWAN = NO;
    
    self.localWiFiReach.reachableBlock = ^(Reachability * reachability)
    {
        // NSString * temp = [NSString stringWithFormat:@"LocalWIFI Block Says Reachable(%@)", reachability.currentReachabilityString];
        //  NSLog(@"%@", temp);
        internetStatus=YES;
        dispatch_async(dispatch_get_main_queue(), ^{
            
        });
    };
    
    self.localWiFiReach.unreachableBlock = ^(Reachability * reachability)
    {
        NSString * temp = [NSString stringWithFormat:@"LocalWIFI Block Says Unreachable(%@)", reachability.currentReachabilityString];
        
        NSLog(@"%@", temp);
        internetStatus=NO;
        dispatch_async(dispatch_get_main_queue(), ^{
        });
    };
    
    [self.localWiFiReach startNotifier];
    
    
    
    //////////////////////////////////////////////////////////////////////
    //////////////////////////////////////////////////////////////////////
    //
    // create a Reachability object for the internet
    
    self.internetConnectionReach = [Reachability reachabilityForInternetConnection];
    
    self.internetConnectionReach.reachableBlock = ^(Reachability * reachability)
    {
        // NSString * temp = [NSString stringWithFormat:@" InternetConnection Says Reachable(%@)", reachability.currentReachabilityString];
        // NSLog(@"%@", temp);
        internetStatus=YES;
        dispatch_async(dispatch_get_main_queue(), ^{
        });
    };
    
    self.internetConnectionReach.unreachableBlock = ^(Reachability * reachability)
    {
        NSString * temp = [NSString stringWithFormat:@"InternetConnection Block Says Unreachable(%@)", reachability.currentReachabilityString];
        
        NSLog(@"%@", temp);
        internetStatus=NO;
        dispatch_async(dispatch_get_main_queue(), ^{
            
        });
    };
    
    [self.internetConnectionReach startNotifier];
    
    
    // if ( [ApplicationInternet isEqualToString:@"not"]) {
    //  NSLog(@"errrrrrrrrrrrrr");
    // }
    return internetStatus;
}

-(void)reachabilityChanged:(NSNotification*)note

{
    Reachability * reach = [note object];
    
    if(reach == self.googleReach)
    {
        if([reach isReachable])
        {
            internetStatus=YES;
            
            NSString * temp = [NSString stringWithFormat:@"GOOGLE Notification Says Reachable(%@)", reach.currentReachabilityString];
            NSLog(@"%@", temp);
            
        }
        else
        {
            
            ApplicationInternet = [NSString stringWithFormat:@"GOOGLE Notification Says Unreachable(%@)", reach.currentReachabilityString];
            NSLog(@"ApplicationInternet %@", ApplicationInternet);
            internetStatus=NO;
            
        }
    }
    else if (reach == self.localWiFiReach)
    {
        if([reach isReachable])
        {
            NSString * temp = [NSString stringWithFormat:@"LocalWIFI Notification Says Reachable(%@)", reach.currentReachabilityString];
            NSLog(@"%@", temp);
            internetStatus=YES;
            
        }
        else
        {
            NSString * temp = [NSString stringWithFormat:@"LocalWIFI Notification Says Unreachable(%@)", reach.currentReachabilityString];
            NSLog(@"%@", temp);
            internetStatus=NO;
            
        }
    }
    else if (reach == self.internetConnectionReach)
    {
        if([reach isReachable])
        {
            NSString * temp = [NSString stringWithFormat:@"InternetConnection Notification Says Reachable(%@)", reach.currentReachabilityString];
            NSLog(@"%@", temp);
            internetStatus=YES;
            
        }
        else
        {
            NSString * temp = [NSString stringWithFormat:@"InternetConnection Notification Says Unreachable(%@)", reach.currentReachabilityString];
            NSLog(@"%@", temp);
            
            internetStatus=NO;
            
        }
    }
    
}



//  Added by:Zeenath
//  Added Date:2016-2-08.
//  Description:Function to upload the picture and document to Azure.
- (void)uploadBlobToContainer:(UIImage *)image name:(NSString *)name path:(NSInteger)path  withCallback:(ASCompletionBlockAppdelegate)callback{
    
    getUrlCallback=callback;
    NSError *accountCreationError;
    
    // Create a storage account object from a connection string.
    AZSCloudStorageAccount *account = [AZSCloudStorageAccount accountFromConnectionString:@"DefaultEndpointsProtocol=https;AccountName=starkblob;AccountKey=SPJIbXvnblgEEBIEcKbPgmpBer+Us1c222kFHyxKYCHp7L49HdtErhIX5nqXRrjY+y5t+hQiPZYbcfRDwkbKYQ==" error:&accountCreationError];
    
    if(accountCreationError){
        NSLog(@"Error in creating account.");
    }
    
    // Create a blob service client object.
    AZSCloudBlobClient *blobClient = [account getBlobClient];
    
    // Create a local container object.
    NSString *container;
    if(path==1)
    {
        container=@"profilepics";
    }
    else{
        container=@"providerdocuments";
    }
    AZSCloudBlobContainer *blobContainer = [blobClient containerReferenceFromName:container];
    
    [blobContainer createContainerIfNotExistsWithAccessType:AZSContainerPublicAccessTypeContainer requestOptions:nil operationContext:nil completionHandler:^(NSError *error, BOOL exists)
     {
         if (error){
             NSLog(@"Error in creating container.");
         }
         else{
             // Create a local blob object
             NSTimeInterval timeInSeconds = [[NSDate date] timeIntervalSince1970];
             NSString *someText = [NSString stringWithFormat: @"%f", timeInSeconds];
             NSRange range = NSMakeRange(10,1);
             NSString *newTime = [someText stringByReplacingCharactersInRange:range withString:@""];
             // NSString *string=@"upload-profile.png";
             // NSString *theFileName = [[string lastPathComponent] stringByDeletingPathExtension];
             // NSString *thepath=[theFileName stringByAppendingString:newTime];
             NSString *retunString=[name stringByAppendingString:newTime];
             urlPath=[retunString stringByAppendingString:@".png"];
             NSLog(@"urlpath %@",urlPath);
             
             AZSCloudBlockBlob *blockBlob = [blobContainer blockBlobReferenceFromName:urlPath];
             // UIImage *image=[UIImage imageNamed:@"upload-profile.png"];
             // NSData *imagedata=UIImagePNGRepresentation(image);
             NSData *imagedata = UIImageJPEGRepresentation(image,1);
             
             // Upload blob to Storage
             [blockBlob uploadFromData:imagedata completionHandler:^(NSError *error) {
                 dispatch_async(dispatch_get_main_queue(), ^{
                     // code here
                     if(error == nil)
                     {
                         [self onResponse:urlPath error:error];
                     }
                 });
                 
                 /* completionHandler(error == nil
                  ? blockBlob.storageUri.primaryUri
                  : nil);*/
                 
             }];
         }
     }];
    
}

// Callback
- (void)onResponse:(NSString *)response error:(NSError *)error
{
    getUrlCallback(response, error);
}


//Called when the application recieves the local notification
- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification
{
    UIApplicationState state = [application applicationState];
    if (state == UIApplicationStateActive) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Reminder"
                                                        message:notification.alertBody
                                                       delegate:self cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
    }
    
    // Request to reload table view data
    [[NSNotificationCenter defaultCenter] postNotificationName:@"reloadData" object:self];
    
    // Set icon badge number to zero
    // application.applicationIconBadgeNumber = 1;
}


@end
