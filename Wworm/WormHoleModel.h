//
//  WormHoleModel.h
//  Wworm
//
//  Created by acp14pue on 30/10/2014.
//  Copyright (c) 2014 acp14pue. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WormHoleModel : NSObject
{
    
    int highScores[5];
    int level;

}
@property NSInteger currentSnakeHead;
@property NSInteger currentSnakeTail;
@property NSInteger nextToHead;
@property NSInteger nextToTail;
@property int snakeLength;
@property NSInteger currentScore;
@property NSTimer *t;
@property int numWormHole;
@property NSString *clickedButton;
@property BOOL isBoundary;

@property int EMPTYCELL;
@property int WORMHOLE,  MUSHROOMCELL,  SNAKECELL,WORMFACE;
@property int easyLevelHoles,mediumLevelHoles,hardLevelHoles;
@property float easyLevelTime, mediumLevelTime,hardLevelTime;
@property int EASY,MEDIUM,HARD;
@property int userChosenLevel;
@property NSMutableArray *myWorms;



@end
