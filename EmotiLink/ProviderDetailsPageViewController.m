//
//  ProviderDetailsPageViewController.m
//  EmotiLink
//
//  Created by Star on 4/25/17.
//  Copyright © 2017 Stark. All rights reserved.
//

#import "ProviderDetailsPageViewController.h"
#import "AppDelegate.h"

@interface ProviderDetailsPageViewController ()

@end

@implementation ProviderDetailsPageViewController
 NSMutableArray *array;

- (void)viewDidLoad {
    _ExpertiseArray=[[NSMutableArray alloc]init];
    [super viewDidLoad];
    
    _noRecommendationLabel.hidden = NO;
    _providerName.hidden=YES;
    _providerExpertise.hidden =YES;
    
    if(_contentLabel.count == 0){
        _noRecommendationLabel.hidden=NO;
        _providerName.hidden=YES;
        _providerExpertise.hidden =YES;
        _profilePictures.hidden = YES;
        _noRecommendationLabel.text=@"No recommendations found!";
        // Do any additional setup after loading the view.
    }else{
        
        AppDelegate *appdelegate=(AppDelegate *)[[UIApplication sharedApplication]delegate];
        
        _providerName.hidden=NO;
        _providerExpertise.hidden =NO;
        _profilePictures.hidden = NO;
        _noRecommendationLabel.hidden =YES;
         _profilePictures.hidden = NO;
        _providerBasicInfo = _contentLabel[_pageIndex];
        
       /* array =[[NSMutableArray alloc]init];
        _ExpertiseArray =[[_providerBasicInfo objectForKey:@"experise"] mutableCopy];
        array=[_providerBasicInfo objectForKey:@"experise"];*/
        
        NSArray *array=[_providerBasicInfo objectForKey:@"experise"];
        if(array.count>0)
        {
            NSString *expertise=@"";
            for (int i=0; i<array.count; i++) {
                NSDictionary *dictionary=[array objectAtIndex:i];
                expertise = [expertise stringByAppendingString:@","];
                expertise= [NSString stringWithFormat: @"%@, %@", expertise, [dictionary objectForKey:@"expertiseText"]];
                
            }
            NSRange range = NSMakeRange(0,1);
            NSString *exp = [expertise stringByReplacingCharactersInRange:range withString:@""];
            _providerExpertise.text=exp;
        }
        else
        {
            _providerExpertise.text=@"";
        }
        
        [_providerBasicInfo setObject:_providerExpertise.text forKey:@"expertiseText"];
        
        NSString *imagePath= [_providerBasicInfo objectForKey:@"profilePicPath"];
        
        if ([[_providerBasicInfo objectForKey:@"profilePicPath"] isEqual:[NSNull null]]||[[_providerBasicInfo objectForKey:@"profilePicPath"] isEqual:@""]) {
            
            UIImage *image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"upload-profile" ofType:@"png"]];
            _profilePictures.image=image;
            
        }else{
            
            // _profilePictures.image=@"";
            
            /*NSString *imagename=[appdelegate.imageURL stringByAppendingString:imagePath];
             NSData *imageData = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:imagename]];
             UIImage *image = [[UIImage alloc] initWithData:imageData];
             _profilePictures.image=image;*/
            
        }
    
      //  NSDictionary *myJsonResponseIndividualElement = _providerBasicInfo;
        
        _providerName.text = [_providerBasicInfo objectForKey:@"firstName"];
        _providerExpertise.text =[_providerBasicInfo objectForKey:@"expertiseText"];
      
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
