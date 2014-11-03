//
//  ViewController.m
//  Wworm
//
//  Created by acp14pue on 28/10/2014.
//  Copyright (c) 2014 ___FULLUSERNAME___. All rights reserved.
//

#import "ViewController.h"
#import "WormHoleModel.h"
#import "AppDelegate.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    wModel = [[WormHoleModel alloc]init];
    delegateShareData=(AppDelegate *)[[UIApplication sharedApplication]delegate];
    
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(IBAction)exitApp{
    exit(0);
}
-(IBAction) setDifficulty:(UIButton*)sender{

    NSString *clickedButton = sender.titleLabel.text;
    if([clickedButton  isEqual: @"EASY"]){
        wModel.userChosenLevel =1;
        delegateShareData.difficultyLevel=wModel.EASY;
        
        
    }
    else if ([clickedButton  isEqual: @"MEDIUM"]){
       wModel.userChosenLevel =2;
        delegateShareData.difficultyLevel=wModel.MEDIUM;
    }
    else if ([clickedButton  isEqual: @"HARD"]){
       wModel.userChosenLevel =3;
        delegateShareData.difficultyLevel=wModel.HARD;
        
    }
    NSLog(@"The sent button is %@",clickedButton);
}

@end
