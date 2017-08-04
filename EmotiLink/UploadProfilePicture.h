//
//  UploadProfilePicture.h
//  EmotiLink
//
//  Created by Star on 7/11/16.
//  Copyright © 2016 Stark. All rights reserved.
//

/***************************************************************
 Page name:UploadProfilePicture.m
 Created By:ZEENATH
 Created Date:11-07-16
 Description:To upload a profile Picture declaration file
 ***************************************************************/

#import <UIKit/UIKit.h>

@interface UploadProfilePicture : UIViewController<UIImagePickerControllerDelegate ,UINavigationControllerDelegate>
{
    NSString *imagePath;
}

//Declare the global methods and variables
@property (strong, nonatomic) UIView *loadingView;
@property (retain, nonatomic) NSString *profileUrl;
@property (strong, nonatomic) NSMutableDictionary * userDetails;
@property (weak, nonatomic) IBOutlet UIImageView *profileImage;
@property (weak, nonatomic) IBOutlet UIView *profilePictureMainView;
@property (strong, nonatomic) UIAlertController *alert;
@property (strong, nonatomic) NSString *screenStatus;
@property (strong, nonatomic) IBOutlet UILabel *headingLabel;
@property (strong, nonatomic) NSMutableDictionary * prepopulateData;

@end
