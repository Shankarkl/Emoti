//
//  PhotopopupViewController.h
//  EmotiLink
//
//  Created by Star on 4/11/17.
//  Copyright © 2017 Stark. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol PhotopopupViewControllerDelegate <NSObject>
@required
- (void)dataFromController:(UIImage *)data;
@end

@interface PhotopopupViewController : UIViewController
@property (nonatomic, retain) UIImage *data;
@property (nonatomic, weak) id<PhotopopupViewControllerDelegate> delegate;
- (IBAction)CancelBtn:(id)sender;
- (IBAction)GalleryBtn:(id)sender;

- (IBAction)CameraBtn:(id)sender;

@property (nonatomic, retain) NSString *uploadType;

@end
