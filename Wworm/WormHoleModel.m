//
//  WormHoleModel.m
//  Wworm
//
//  Created by acp14pue on 30/10/2014.
//  Copyright (c) 2014 acp14pue. All rights reserved.
//

#import "WormHoleModel.h"

@implementation WormHoleModel
- (id)init
{
    self = [super init];
    if (self) {
        
        _clickedButton=@"Down";
        _isBoundary=NO;
        _EMPTYCELL=1;
        _WORMHOLE=2;
        _MUSHROOMCELL=3;
        _SNAKECELL=4;
        _WORMFACE=5;
        _easyLevelHoles=5;
        _mediumLevelHoles=10;
        _hardLevelHoles=15;
        _EASY=1;_MEDIUM=2;_HARD=3;
        _easyLevelTime=0.8;_mediumLevelTime=0.5;_hardLevelTime=0.2;
        _userChosenLevel=_EASY;
        _myWorms = [[NSMutableArray alloc]init];
        
        
    }
    return self;
}


@end
