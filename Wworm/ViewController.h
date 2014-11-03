//
//  ViewController.h
//  Wworm
//
//  Created by acp14pue on 28/10/2014.
//  Copyright (c) 2014 ___FULLUSERNAME___. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WormHoleModel.h"
#import "AppDelegate.h"

@interface ViewController : UIViewController{
    
    IBOutlet UIButton* exitButton;
    IBOutlet UIButton* easyButton;
    IBOutlet UIButton* mediumButton;
    IBOutlet UIButton* hardButton;
    WormHoleModel *wModel;
    AppDelegate *delegateShareData;
}
-(IBAction)exitApp;
-(IBAction)setDifficulty:(UIButton*)sender;
@end
