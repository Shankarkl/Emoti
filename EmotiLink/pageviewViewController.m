//
//  pageviewViewController.m
//  swibeViewSample
//
//  Created by Starsoft on 2016-11-15.
//  Copyright © 2016 StarKnowledge. All rights reserved.
//

#import "pageviewViewController.h"

@interface pageviewViewController ()

@end

@implementation pageviewViewController
 //contentLabel=[[NSMutableDictionary alloc]init];
- (void)viewDidLoad {
    _noappointmentlabel.hidden=YES;
     _noappointmentlabel.text=@"";
    NSLog(@"array content%lu",_contentLabel.count);//contentLabel;
    
    if(_contentLabel.count==0){
        _UserName.hidden=YES;
        _noappointmentlabel.hidden=NO;
        _offeredamount.hidden=YES;
        _timelbl.hidden=YES;
        _profilepic.hidden=YES;
        
       _noappointmentlabel.text=@"There are no appointments for the day!";
    }else{
        _UserName.hidden=NO;
         _profilepic.hidden=NO;
        _offeredamount.hidden=NO;
        _timelbl.hidden=NO;

         _noappointmentlabel.hidden=YES;
        _contentsbind= _contentLabel[_pageIndex];
        
        _UserName.text=[_contentsbind objectForKey:@"clientFirstName"];
        
        // _offeredamount.text=[_contentsbind objectForKey:@"offeredAmountCurrency"];
        _timelbl.text=[_contentsbind objectForKey:@"scheduledStartTime"];
        // _profilepic.image=[_contentsbind objectForKey:@"clientProfilePicPath"];
        _offeredamount.text= [@"Offered Amount :" stringByAppendingString:[_contentsbind objectForKey:@"offeredAmountCurrency"]];
    }
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
