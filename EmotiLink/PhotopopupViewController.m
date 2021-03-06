//
//  PhotopopupViewController.m
//  EmotiLink
//
//  Created by Star on 4/11/17.
//  Copyright © 2017 Stark. All rights reserved.
//

#import "PhotopopupViewController.h"
#import "TOCropViewController.h"
#import "AppDelegate.h"
#import "UserSignUpFirstViewController.h"
#import <QBImagePickerController/QBImagePickerController.h>

@interface PhotopopupViewController () <UINavigationControllerDelegate,UIImagePickerControllerDelegate, UIPageViewControllerDelegate>

@property (nonatomic, strong) UIImage *image;           // The image we'll be cropping
@property (nonatomic, strong) UIImageView *imageView;   // The image view to present the cropped image

@property (nonatomic, assign) TOCropViewCroppingStyle croppingStyle; //The cropping style
@property (nonatomic, assign) CGRect croppedFrame;
@property (nonatomic, assign) NSInteger angle;

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
@property (nonatomic, strong) UIPopoverController *activityPopoverController;
#pragma clang diagnostic pop

- (void)showCropViewController;
- (void)sharePhoto;

- (void)layoutImageView;
- (void)didTapImageView;

- (void)updateImageViewWithImage:(UIImage *)image fromCropViewController:(TOCropViewController *)cropViewController;


@end

@implementation PhotopopupViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.modalPresentationStyle = UIModalPresentationCurrentContext;
    [self setBorderColor:1];
    [self setBorderColor:2];
    // Do any additional setup after loading the view.
    
    //self.title = @"TOCropViewController";
    
    /*self.navigationController.navigationBar.translucent = NO;
     
     self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(showCropViewController)];
     self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(sharePhoto)];
     
     self.navigationItem.rightBarButtonItem.enabled = NO;*/
    
    self.imageView = [[UIImageView alloc] init];
    self.imageView.userInteractionEnabled = YES;
    self.imageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.view addSubview:self.imageView];
    
    UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTapImageView)];
    [self.imageView addGestureRecognizer:tapRecognizer];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void) setBorderColor:(int)tagName{
    UIButton *cancelBtn = (UIButton *) [self.view viewWithTag:tagName];
    cancelBtn.layer.borderColor = [UIColor colorWithRed:246.0/255.0 green:108.0/255.0 blue:118.0/255.0 alpha:1].CGColor;
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

- (IBAction)CancelBtn:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

#pragma mark - Image Picker Delegate -
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo
{
    TOCropViewController *cropController = [[TOCropViewController alloc] initWithCroppingStyle:self.croppingStyle image:image];
    cropController.delegate = self;
    
    // -- Uncomment these if you want to test out restoring to a previous crop setting --
    //cropController.angle = 90; // The initial angle in which the image will be rotated
    //cropController.imageCropFrame = CGRectMake(0,0,2848,4288); //The
    
    // -- Uncomment the following lines of code to test out the aspect ratio features --
    //cropController.aspectRatioPreset = TOCropViewControllerAspectRatioPresetSquare; //Set the initial aspect ratio as a square
    //cropController.aspectRatioLockEnabled = YES; // The crop box is locked to the aspect ratio and can't be resized away from it
    //cropController.resetAspectRatioEnabled = NO; // When tapping 'reset', the aspect ratio will NOT be reset back to default
    
    // -- Uncomment this line of code to place the toolbar at the top of the view controller --
    // cropController.toolbarPosition = TOCropViewControllerToolbarPositionTop;
    
    self.image = image;
    
    //If profile picture, push onto the same navigation stack
    if (self.croppingStyle == TOCropViewCroppingStyleCircular) {
        [picker pushViewController:cropController animated:YES];
    }
    else { //otherwise dismiss, and then present from the main controller
        [picker dismissViewControllerAnimated:YES completion:^{
            [self presentViewController:cropController animated:YES completion:nil];
        }];
    }
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Gesture Recognizer -
- (void)didTapImageView
{
    //When tapping the image view, restore the image to the previous cropping state
    
    TOCropViewController *cropController = [[TOCropViewController alloc] initWithCroppingStyle:self.croppingStyle image:self.image];
    cropController.delegate = self;
    CGRect viewFrame = [self.view convertRect:self.imageView.frame toView:self.navigationController.view];
    [cropController presentAnimatedFromParentViewController:self
                                                  fromImage:self.imageView.image
                                                   fromView:nil
                                                  fromFrame:viewFrame
                                                      angle:self.angle
                                               toImageFrame:self.croppedFrame
                                                      setup:^{ self.imageView.hidden = YES; }
                                                 completion:nil];
}

#pragma mark - Cropper Delegate -
- (void)cropViewController:(TOCropViewController *)cropViewController didCropToImage:(UIImage *)image withRect:(CGRect)cropRect angle:(NSInteger)angle
{
    self.croppedFrame = cropRect;
    self.angle = angle;
    [self updateImageViewWithImage:image fromCropViewController:cropViewController];
}

- (void)cropViewController:(TOCropViewController *)cropViewController didCropToCircularImage:(UIImage *)image withRect:(CGRect)cropRect angle:(NSInteger)angle
{
    self.croppedFrame = cropRect;
    self.angle = angle;
    [self updateImageViewWithImage:image fromCropViewController:cropViewController];
}

- (void)updateImageViewWithImage:(UIImage *)image fromCropViewController:(TOCropViewController *)cropViewController
{
    //AppDelegate *appdelegate=(AppDelegate *)[[UIApplication sharedApplication]delegate];
    
    //appdelegate.cropProfileImage=image;
    //_data=image;
    
    //(UserSignUpFirstViewController*)self.delegate.profilePicImage setImage[image];
    
    /*[[UserSignUpFirstViewController sharedInstance] bindImage:image viewcontrol:nil];*/
    if ([_delegate respondsToSelector:@selector(dataFromController:)])
    {
        [_delegate dataFromController:image];
    }
    
    //[self dismissViewControllerAnimated:YES completion:nil];
    [[self presentingViewController]dismissViewControllerAnimated:YES completion:NULL];
    
    /*UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
     
     UserSignUpFirstViewController *vc=[storyboard instantiateViewControllerWithIdentifier:@"userSignupController"];
     vc.profilePicImage.image=image;*/
    
    /*self.imageView.image = image;
     [self layoutImageView];
     self.navigationItem.rightBarButtonItem.enabled = YES;
     
     if (cropViewController.croppingStyle != TOCropViewCroppingStyleCircular) {
     self.imageView.hidden = YES;
     [cropViewController.presentingViewController dismissViewControllerAnimated:YES completion:nil];
     [cropViewController dismissAnimatedFromParentViewController:self
     withCroppedImage:image
     toView:self.imageView
     toFrame:CGRectZero
     setup:^{ [self layoutImageView]; }
     completion:
     ^{
     self.imageView.hidden = NO;
     }];
     }
     else {
     self.imageView.hidden = NO;
     [cropViewController.presentingViewController dismissViewControllerAnimated:YES completion:nil];
     }*/
}

#pragma mark - Image Layout -
- (void)layoutImageView
{
    if (self.imageView.image == nil)
        return;
    
    CGFloat padding = 20.0f;
    
    CGRect viewFrame = self.view.bounds;
    viewFrame.size.width -= (padding * 2.0f);
    viewFrame.size.height -= ((padding * 2.0f));
    
    CGRect imageFrame = CGRectZero;
    imageFrame.size = self.imageView.image.size;
    
    if (self.imageView.image.size.width > viewFrame.size.width ||
        self.imageView.image.size.height > viewFrame.size.height)
    {
        CGFloat scale = MIN(viewFrame.size.width / imageFrame.size.width, viewFrame.size.height / imageFrame.size.height);
        imageFrame.size.width *= scale;
        imageFrame.size.height *= scale;
        imageFrame.origin.x = (CGRectGetWidth(self.view.bounds) - imageFrame.size.width) * 0.5f;
        imageFrame.origin.y = (CGRectGetHeight(self.view.bounds) - imageFrame.size.height) * 0.5f;
        self.imageView.frame = imageFrame;
    }
    else {
        self.imageView.frame = imageFrame;
        self.imageView.center = (CGPoint){CGRectGetMidX(self.view.bounds), CGRectGetMidY(self.view.bounds)};
    }
}

#pragma mark - Bar Button Items -
- (void)showCropViewController
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *defaultAction = [UIAlertAction actionWithTitle:@"Crop Image"
                                                            style:UIAlertActionStyleDefault
                                                          handler:^(UIAlertAction *action) {
                                                              self.croppingStyle = TOCropViewCroppingStyleDefault;
                                                              
                                                              UIImagePickerController *standardPicker = [[UIImagePickerController alloc] init];
                                                              standardPicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                                                              standardPicker.allowsEditing = NO;
                                                              standardPicker.delegate = self;
                                                              [self presentViewController:standardPicker animated:YES completion:nil];
                                                          }];
    
    UIAlertAction *profileAction = [UIAlertAction actionWithTitle:@"Make Profile Picture"
                                                            style:UIAlertActionStyleDefault
                                                          handler:^(UIAlertAction *action) {
                                                              self.croppingStyle = TOCropViewCroppingStyleCircular;
                                                              
                                                              UIImagePickerController *profilePicker = [[UIImagePickerController alloc] init];
                                                              profilePicker.modalPresentationStyle = UIModalPresentationPopover;
                                                              profilePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                                                              profilePicker.allowsEditing = NO;
                                                              profilePicker.delegate = self;
                                                              profilePicker.preferredContentSize = CGSizeMake(512,512);
                                                              profilePicker.popoverPresentationController.barButtonItem = self.navigationItem.leftBarButtonItem;
                                                              [self presentViewController:profilePicker animated:YES completion:nil];
                                                          }];
    
    [alertController addAction:defaultAction];
    [alertController addAction:profileAction];
    [alertController setModalPresentationStyle:UIModalPresentationPopover];
    
    UIPopoverPresentationController *popPresenter = [alertController popoverPresentationController];
    popPresenter.barButtonItem = self.navigationItem.leftBarButtonItem;
    [self presentViewController:alertController animated:YES completion:nil];
}

- (void)sharePhoto
{
    if (self.imageView.image == nil)
        return;
    
    UIActivityViewController *activityController = [[UIActivityViewController alloc] initWithActivityItems:@[self.imageView.image] applicationActivities:nil];
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
        [self presentViewController:activityController animated:YES completion:nil];
    }
    else {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
        [self.activityPopoverController dismissPopoverAnimated:NO];
        self.activityPopoverController = [[UIPopoverController alloc] initWithContentViewController:activityController];
        [self.activityPopoverController presentPopoverFromBarButtonItem:self.navigationItem.rightBarButtonItem permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
#pragma clang diagnostic pop
    }
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    [self layoutImageView];
}

- (IBAction)GalleryBtn:(id)sender {
    
    /*UIImagePickerController *imagePickerController = [[UIImagePickerController alloc]init];
     imagePickerController.delegate = self;
     imagePickerController.sourceType =  UIImagePickerControllerSourceTypePhotoLibrary;
     
     [self presentViewController:imagePickerController animated:YES completion:nil];*/
    
    if([_uploadType isEqual:@"Documents"])
    {
        
        QBImagePickerController *imagePickerController = [QBImagePickerController new];
        imagePickerController.delegate = self;
        imagePickerController.allowsMultipleSelection = YES;
        imagePickerController.maximumNumberOfSelection = 6;
        imagePickerController.showsNumberOfSelectedAssets = YES;
        imagePickerController.mediaType=QBImagePickerMediaTypeImage;
        [self presentViewController:imagePickerController animated:YES completion:NULL];
        
    } else {
        
        self.croppingStyle = TOCropViewCroppingStyleDefault;
        UIImagePickerController *standardPicker = [[UIImagePickerController alloc] init];
        standardPicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        standardPicker.allowsEditing = NO;
        standardPicker.delegate = self;
        //standardPicker.
        [self presentViewController:standardPicker animated:YES completion:nil];
        
    }
    
    
    
    
}

- (IBAction)CameraBtn:(id)sender {
    
    
    /*UIImagePickerController *imagePickerController = [[UIImagePickerController alloc]init];
     imagePickerController.delegate = self;
     imagePickerController.sourceType =  UIImagePickerControllerSourceTypeCamera;
     
     [self presentViewController:imagePickerController animated:YES completion:nil];*/
    
    self.croppingStyle = TOCropViewCroppingStyleCircular;
    
    UIImagePickerController *profilePicker = [[UIImagePickerController alloc] init];
    profilePicker.modalPresentationStyle = UIModalPresentationPopover;
    profilePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
    profilePicker.allowsEditing = NO;
    profilePicker.delegate = self;
    profilePicker.preferredContentSize = CGSizeMake(512,512);
    profilePicker.popoverPresentationController.barButtonItem = self.navigationItem.leftBarButtonItem;
    [self presentViewController:profilePicker animated:YES completion:nil];
}


- (void)qb_imagePickerController:(QBImagePickerController *)imagePickerController didFinishPickingAssets:(NSArray *)assets {
    
    NSMutableArray * imageViewsArray = [[NSMutableArray alloc] init];
    
    for (PHAsset *asset in assets) {
        // Do something with the asset
        PHImageRequestOptions *options = [[PHImageRequestOptions alloc] init];
        options.deliveryMode = PHImageRequestOptionsDeliveryModeHighQualityFormat;
        options.resizeMode=PHImageRequestOptionsResizeModeExact;
        
        options.synchronous = true;
        
        [[PHImageManager defaultManager] requestImageForAsset:asset targetSize:[UIScreen mainScreen].bounds.size contentMode:PHImageContentModeAspectFit options:options resultHandler:^(UIImage *result, NSDictionary *info) {
            //self.imageView.image=result;
            [imageViewsArray addObject:result];
        }];
    }
    
    if ([_delegate respondsToSelector:@selector(dataFromController:)])
    {
        [_delegate dataFromController:imageViewsArray];
    }
     [[self presentingViewController]dismissViewControllerAnimated:YES completion:NULL];
    //[self dismissViewControllerAnimated:YES completion:NULL];
    
}

- (void)qb_imagePickerControllerDidCancel:(QBImagePickerController *)imagePickerController {
    [self dismissViewControllerAnimated:YES completion:NULL];
}


@end
