//
//  EmotiLinkTests.m
//  EmotiLinkTests
//
//  Created by Star on 6/29/16.
//  Copyright © 2016 Stark. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "ChangePasswordViewController.h"
#import "GlobalFunction.h"
#import "AppDelegate.h"
@interface EmotiLinkTests : XCTestCase

@end

@implementation EmotiLinkTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
    
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

-(void)testChangePassword{
    
    NSMutableDictionary *changePwdData = [[NSMutableDictionary alloc] init];
    [changePwdData setObject:@"String@123" forKey:@"currentPassword"];
    [changePwdData setObject:@"Star@123" forKey:@"newPassword"];
    
    AppDelegate *appdelegate= (AppDelegate *)[[UIApplication sharedApplication]delegate];
    NSString *changePasswordUrl=[appdelegate.serviceURL stringByAppendingString:@"api/Account/ChangePassword"];
    
    
    NSLog(@"serviceURL=%@",changePasswordUrl);
     NSLog(@"Acess token =%@",appdelegate.accessToken);
    [self PostMethodServiceCheck:changePasswordUrl parameters:changePwdData];
    
    
}


- (void)testSecurityQuestions {
    
    AppDelegate *appdelegate= (AppDelegate *)[[UIApplication sharedApplication]delegate];
    NSString *securityQuestionUrl=[appdelegate.serviceURL stringByAppendingString:@"api/SecurityQuestions"];
    [self GetMethodServiceCheck:securityQuestionUrl];
}


-(void)GetMethodServiceCheck:(NSString *)url{
    NSURL *URL = [NSURL URLWithString:url];
    NSString *description = [NSString stringWithFormat:@"GET %@", URL];
    XCTestExpectation *expectation = [self expectationWithDescription:description];
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *task = [session dataTaskWithURL:URL
                                        completionHandler:^(NSData *data, NSURLResponse *response, NSError *error)
                                  {
                                      
                                      NSDictionary *responseArray = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&error];
                                      NSLog(@"response array=%@",responseArray);
                                      NSLog(@"response array count=%lu",(unsigned long)responseArray.count);
                                      
                                      XCTAssertNotNil(data, "data should not be nil");
                                      XCTAssertNil(error, "error should be nil");
                                      NSLog(@"Data response=%@ %@",response,data);
                                      if ([response isKindOfClass:[NSHTTPURLResponse class]]) {
                                          NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
                                          XCTAssertEqual(httpResponse.statusCode, 200, @"HTTP response status code should be 200");
                                          XCTAssertGreaterThan(responseArray.count, 0, @"Result length is grater than zero");
                                      } else {
                                          XCTFail(@"Response was not NSHTTPURLResponse");
                                      }
                                      
                                      [expectation fulfill];
                                  }];
    
    [task resume];
    
    [self waitForExpectationsWithTimeout:task.originalRequest.timeoutInterval handler:^(NSError *error) {
        if (error != nil) {
            NSLog(@"Error: %@", error.localizedDescription);
        }
        [task cancel];
    }];
    
}


-(void)PostMethodServiceCheck:(NSString *)url parameters:(NSDictionary *)parameters{
    
    NSLog(@"string append =%@",parameters);
    
    AppDelegate *appdelegate= (AppDelegate *)[[UIApplication sharedApplication]delegate];
    
    NSMutableURLRequest * urlRequest = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]];
  //  NSString *description = [NSString stringWithFormat:@"POST %@", urlRequest];
   // XCTestExpectation *expectation = [self expectationWithDescription:description];
    
    NSData* jsonData = [NSJSONSerialization dataWithJSONObject:parameters options:kNilOptions error:nil];
    NSLog(@"json string append =%@",jsonData);

    [urlRequest setHTTPBody:jsonData];
   
    NSString *authValue = [NSString stringWithFormat:@"Bearer %@", @"d83dftOtbuvFKtGjGz2LfS4ZVVDgcAp-kAd2TNcWuzM5N7dgbemU6RsVFDcF9s32JNHPfiTyVKuH_AM8R3nyCa5nVKV_BV4RshR6f065jhzNOrFlREYbLO38VkRkS2LEfOGbSvWQwo-HjdeJUP-vCa6NrxlzG2AYdcHgzlHvHB133H3quvhBY2NXxgzapUj-DY-VYAT6w5QmCGF7c9BjEnRjPeHxpQFvLVgC9uD29mhEkWaLH3UV8-x_pS6hZO2_dI8CW5NOJwwMfONa6Cq636Q3MtqJIYSnmSIUHS-S9bk-RwYUnwSJbt-P_q_EBiMaRbR1SXPm-oBEvjnycNPiLupq20oJ6hQy6_vevSajtmJrWzXeZCPiZyhN67C8lTAils8A28MPNcI74U66piNxY1HzMlBbZQBlkXjyDiSqv8aPy_36mkrbHC5ZT2aaF01igj9NsGUxAfCvA-nbPpKxaFnDMwJitOPYvmMTgK6eX92lBlHNplgMthk_-qMTKM7t"];
    NSLog(@" appdelegate.accessToken=%@", appdelegate.accessToken);
    NSLog(@"authValue=%@", authValue);
  //  urlRequest.timeoutInterval = 1000.0;

    [urlRequest setValue:authValue forHTTPHeaderField:@"Authorization"];
    [urlRequest setHTTPMethod:@"POST"];
    
    XCTestExpectation *expectation =[self expectationWithDescription:@"document"];

    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:urlRequest
                                            completionHandler:^(NSData *data, NSURLResponse *response, NSError *error)
                                  {
                                      
                                      NSDictionary *responseArray = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&error];
                                      NSLog(@"response array=%@",responseArray);
                                      NSLog(@"response array count=%lu",(unsigned long)responseArray.count);
                                      
                                      XCTAssertNotNil(data, "data should not be nil");
                                      XCTAssertNil(error, "error should be nil");
                                      NSLog(@"Data response=%@ %@",response,data);
                                      if ([response isKindOfClass:[NSHTTPURLResponse class]]) {
                                          NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
                                          XCTAssertEqual(httpResponse.statusCode, 200, @"HTTP response status code should be 200");
                                         // XCTAssertGreaterThan(responseArray.count, 0, @"Result length is grater than zero");
                                      } else {
                                          XCTFail(@"Response was not NSHTTPURLResponse");
                                      }
                                      
                                    [expectation fulfill];
                                  }];
    
     NSLog(@"response task =%@",task);
    [task resume];
    
    [self waitForExpectationsWithTimeout:5.0 handler:^(NSError *error) {
        if (error != nil) {
            NSLog(@"Error: %@", error.localizedDescription);
        }
        [task cancel];
    }];
    
}


@end
