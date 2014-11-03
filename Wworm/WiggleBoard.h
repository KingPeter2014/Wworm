//
//  WiggleBoard.h
//  Wworm
//
//  Created by acp14pue on 28/10/2014.
//  Copyright (c) 2014 acp14pue. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WormHoleModel.h"
#import "AppDelegate.h"


@interface WiggleBoard : UIViewController


{

    
    IBOutlet UIButton *upBtn;
    IBOutlet UIButton *downBtn;
    IBOutlet UIButton *leftBtn;
    IBOutlet UIButton *rightBtn;
    IBOutlet UILabel *scoreLabel;
    NSMutableArray *myCellsArray;
    
    WormHoleModel *wModel;
    AppDelegate *delegateGetData;
    int myUIViewGroups[280];
    

}
-(void) loadEmptyCells;
-(void) loadWormHolesBasedOnDifficultyLevel;
-(void) addMushrooms;
-(void) setStartingCell;
-(IBAction) moveWorm:(id)sender;
-(int) getMyRight;
-(int) getMyLeft;
-(int) getMyUp;
-(int) getMyDown;
-(void) onTick : (NSTimer *) timer;
-(void) endGame: (NSString *) message ;
-(int) getMyCellType:(int) imagviewTag;
-(void) AddRandomMushroom;
-(void) AddWormHoles: (int)numWormHoles;
-(void) replaceACell:(int)cellTag :(int)cellType;
-(void) handleCellTypes: (int) cellType : (int) nextCell :(NSTimer *) timer;
-(void) reDrawMyWorm: (NSMutableArray *)mynewWorm;
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex;
-(void) createTimer;
-(void) resetGame;
-(void) getGoodDirectionToMove;


@end
