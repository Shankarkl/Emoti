

/***************************************************************
 Page name:GlobalFunction.h
 Created By:Nalina
 Created Date:01-07-16
 Description:Added global Methods and variables declaration file
 ***************************************************************/

#import <Foundation/Foundation.h>
#import "Reachability.h"

@interface GlobalFunction : NSObject
{
    NSMutableArray *ArrayOfAlerts;
}




@property(nonatomic,strong) NSMutableDictionary *userDetails;

- (NSMutableArray *)arrayOfAlerts;
+ (instancetype)sharedInstance;

/**************Added by Zeenath**********/
typedef void (^ASCompletionBlock)(NSInteger statusCode, NSDictionary *response, NSError *error);

- (void)getServerResponseForUrl:(NSString *)url method:(NSString *)method param:(NSDictionary *)param withCallback:(ASCompletionBlock)callback;
-(NSString *)Convert24FormatTo12Format:(NSString *)time;
-(NSString *)Convert12FormatTo24Format:(NSString *)time;



/**************Added by Nalina**********/

- (void)getServerResponseAfterLogin:(NSString *)url method:(NSString *)method param:(NSDictionary *)param withCallback:(ASCompletionBlock)callback;
@end
