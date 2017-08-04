/***************************************************************
 Page name: IdleTimeCheck.m
 Created By: Nalina
 Created Date: 2016-08-27
 Description:To check the application inactivity implementation screen
 ***************************************************************/


#import "IdleTimeCheck.h"
#import "AppDelegate.h"
#import "LoginViewController.h"
#define app (AppDelegate *)[[UIApplication sharedApplication]delegate]
@implementation IdleTimeCheck


- (void)sendEvent:(UIEvent *)event {
    
    [super sendEvent:event];
    // Only want to reset the timer on a Began touch or an Ended touch, to reduce the number of timer resets.
    NSSet *allTouches = [event allTouches];
    if ([allTouches count] > 0) {
        // allTouches count only ever seems to be 1, so anyObject works here.
        UITouchPhase phase = ((UITouch *)[allTouches anyObject]).phase;
        if (phase == UITouchPhaseBegan || phase == UITouchPhaseEnded){
            [self resetIdleTimer];
        }
    }
}

- (void)resetIdleTimer {
    if (idleTimer) {
        [idleTimer invalidate];
    }
    idleTimer = [NSTimer scheduledTimerWithTimeInterval:300 target:self selector:@selector(idleTimerExceeded) userInfo:nil repeats:NO];
}

// Added By: Nalina
// Added Date: 2016-08-27
// Description:After 20 min if application is inactive exit the app and redirect to the login

- (void)idleTimerExceeded {
    AppDelegate *appdelegate=(AppDelegate *)[[UIApplication sharedApplication]delegate];

    if ([appdelegate.checkIdelTimer isEqualToString:@"stopTimer"]) {
        NSLog(@"join session");
    }else{
        appdelegate.accessToken=nil;
        appdelegate.usersDetails=nil;
        appdelegate.availabilityArray=nil;
        appdelegate.availabilityId=nil;
        appdelegate.availableData=nil;
        appdelegate.screenStatus=@"";
        exit(0);
    }
}

@end
