/***************************************************************
 Page name: IdleTimeCheck.h
 Created By: Nalina
 Created Date: 2016-08-27
 Description:To check the application inactivity declaration screen
 ***************************************************************/

#import <UIKit/UIKit.h>

@interface IdleTimeCheck : UIApplication
{
    NSTimer *idleTimer;
    float maxIdleTime;
}
@end
