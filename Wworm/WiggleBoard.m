//
//  WiggleBoard.m
//  Wworm
//COM6510 Assignment
//  Created by acp14pue on 28/10/2014.
//  Copyright (c) 2014 acp14pue. All rights reserved.
//

#import "WiggleBoard.h"
#import "WormHoleModel.h"

@interface WiggleBoard ()

@end

@implementation WiggleBoard
#define NUM_ROW 16
#define NUM_COL 14
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //Create an instance of the Model class and Application delegate
    wModel = [[WormHoleModel alloc]init];
    delegateGetData=(AppDelegate *)[[UIApplication sharedApplication]delegate];
    int numTags = NUM_COL*NUM_ROW;
    float xStart=15.0;
    float yStart =81.0;
    
    //define number tags for each cell
    int currentTag=1;
    //images needed in this set up
    //UIImage *wormHoleCell = [UIImage imageNamed:@"wormholecell.png"];
    //UIImage *snakeCell = [UIImage imageNamed:@"snakecell.png"];
     UIImage *shroomCell = [UIImage imageNamed:@"shroomcell.png"];
    UIImage *wormFace =[UIImage imageNamed:@"wormface.png"];
    UIImageView *newCell;
    int numWormHole = 5;
    float timerSpeed=1.0;
    
    //set User Chosen level from AppDelegate
    wModel.userChosenLevel=delegateGetData.difficultyLevel;
    
    //Put worm holes and set clock time according to level of difficulty
    if(wModel.userChosenLevel==wModel.EASY){
        wModel.numWormHole= wModel.easyLevelHoles;
        timerSpeed = wModel.easyLevelTime;
    }
    else if (wModel.userChosenLevel == wModel.MEDIUM){
        wModel.numWormHole= wModel.mediumLevelHoles;
        timerSpeed = wModel.mediumLevelTime;
    }
    else if (wModel.userChosenLevel == wModel.HARD){
        wModel.numWormHole= wModel.hardLevelHoles;
        timerSpeed = wModel.hardLevelTime;
    }
   // NSLog(@" Wmodel.numwormhole is %d", wModel.numWormHole);
    //Load Empty Cells
    for(int j=1;j<=NUM_ROW;j++){
        for(int i=1; i<=NUM_COL;i++)
        {
            UIImage *imgCell = [UIImage imageNamed:@"emptycell.png"];
                newCell = [[UIImageView alloc] initWithImage:imgCell];
                myUIViewGroups[currentTag-1]=wModel.EMPTYCELL;
            CGRect myFrame = CGRectMake(xStart, yStart  , 20.0f,20.0f);
            [newCell setFrame:myFrame];
            [newCell setContentMode:UIViewContentModeScaleAspectFit];
                
            newCell.tag=currentTag;
            [self.view addSubview:newCell];
            currentTag+=1;
            xStart += 20.0f;
        }
            yStart+=20.0;
            xStart = 15.0;
    }
    
       //set 20% of the cells to Mushroom
    int numOfMushroomRequired = 0.2 * numTags;
    int countSetMushrooms=0;
    int mushroom=0;
    for(int i=1; i<=numTags; i++){
         mushroom= arc4random() % numTags;
        myUIViewGroups[mushroom-1]=wModel.MUSHROOMCELL;
        ((UIImageView *)[self.view viewWithTag:mushroom]).image = shroomCell;
        countSetMushrooms+=1;
        if(countSetMushrooms > numOfMushroomRequired)
            break;
    }
    
    //Add Wormholes based on difficulty level
    [self AddWormHoles:wModel.numWormHole];
    
    //set the starting point of the snake cell
    wModel.currentSnakeHead=(numTags/2)-(NUM_COL/2);
    wModel.currentSnakeTail=wModel.currentSnakeHead;
    ((UIImageView *)[self.view viewWithTag:wModel.currentSnakeHead]).image = wormFace;
    myUIViewGroups[wModel.currentSnakeHead-1]=wModel.SNAKECELL;
    wModel.snakeLength=1;
    [wModel.myWorms addObject:[NSNumber numberWithInt:(int)wModel.currentSnakeHead]];
    
    
    
    //Schedule Timer to respond based on difficulty level selected
    wModel.t = [NSTimer scheduledTimerWithTimeInterval:timerSpeed
                                         target:self
                                       selector:@selector(onTick:)
                                       userInfo:nil repeats:YES];
    [wModel.t fire];
}

//Load Empty Cells
-(void) loadEmptyCells{
   // int numTags = NUM_COL*NUM_ROW;
    float xStart=15.0;
    float yStart =81.0;
    UIImageView *newCell;
    int currentTag=1;
    for(int j=1;j<=NUM_ROW;j++){
        for(int i=1; i<=NUM_COL;i++)
        {
            UIImage *imgCell = [UIImage imageNamed:@"emptycell.png"];
            newCell = [[UIImageView alloc] initWithImage:imgCell];
            myUIViewGroups[currentTag-1]=wModel.EMPTYCELL;
            CGRect myFrame = CGRectMake(xStart, yStart  , 20.0f,20.0f);
            [newCell setFrame:myFrame];
            [newCell setContentMode:UIViewContentModeScaleAspectFit];
            
            newCell.tag=currentTag;
            [self.view addSubview:newCell];
            currentTag+=1;
            xStart += 20.0f;
            
        }
        yStart+=20.0;
        xStart = 15.0;
    }
}
//Add wormHoles based on difficulty level
-(void) loadWormHolesBasedOnDifficultyLevel{
     [self AddWormHoles:wModel.numWormHole];
}
-(void) addMushrooms{
    //set 20% of the cells to Mushroom
    int numTags = NUM_ROW*NUM_COL;
    int numOfMushroomRequired = 0.2 * numTags;
    int countSetMushrooms=0;
    //UIImage *shroomCell = [UIImage imageNamed:@"shroomcell.png"];
    //UIImage *wormFace =[UIImage imageNamed:@"wormface.png"];
    int mushroom=0;
    for(int i=1; i<=numTags; i++){
        mushroom= arc4random() % numTags;
        [self replaceACell:mushroom :wModel.MUSHROOMCELL];
         countSetMushrooms+=1;
        if(countSetMushrooms > numOfMushroomRequired)
            break;
    }
    
}
//Set starting cell
-(void) setStartingCell{
    //set the starting point of the snake cell
    int numTags = NUM_COL*NUM_ROW;
    wModel.currentSnakeHead=(numTags/2)-(NUM_COL/2);
    wModel.currentSnakeTail=wModel.currentSnakeHead;
    [self replaceACell:wModel.currentSnakeHead :wModel.WORMFACE];
     wModel.snakeLength=1;
    [wModel.myWorms addObject:[NSNumber numberWithInt:(int)wModel.currentSnakeHead]];
    

}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) onTick:(NSTimer *)timer{
    NSString *message;
    int nextCell =0;
    if([wModel.clickedButton isEqual:@"Up"]){
        nextCell = [self getMyUp];
        if(wModel.isBoundary){
            message = [NSString stringWithFormat:@" Oops, you just hit the top wall. Ending game with a score of %d",(int)wModel.currentScore];
            [self endGame:message];
        }
        //Get the type of Cell for nextCell if game did not end by hitting TOP Wall
        int cellType = [self getMyCellType:nextCell];
        [self handleCellTypes:cellType :nextCell :timer];
    }
    else if ([wModel.clickedButton isEqual:@"Down"]){
        nextCell = [self getMyDown];
        if(wModel.isBoundary){
            message = [NSString stringWithFormat:@" Oops!, you just hit the bottom wall. Ending game with a score of %d",(int)wModel.currentScore];
            //[timer invalidate];
            //timer = nil;
            [self endGame:message];
        }
        //Get the type of Cell for nextCell if game did not end hitting DOWN Wall
        int cellType = [self getMyCellType:nextCell];
        [self handleCellTypes:cellType :nextCell :timer];
        
    }
    else if ([wModel.clickedButton isEqual:@"Left"]){
        nextCell = [self getMyLeft];
        if(wModel.isBoundary){
            message = [NSString stringWithFormat:@" Oops!, you just hit the left wall. Ending game with a score of %d",(int)wModel.currentScore];
            //[timer invalidate];
            //timer = nil;
            [self endGame:message];
        }
        //Get the type of Cell for nextCell if game did not end by hitting LEFT Wall
        int cellType = [self getMyCellType:nextCell];
        [self handleCellTypes:cellType :nextCell :timer];
        
        
    }
    else if ([wModel.clickedButton isEqual:@"Right"]){
        nextCell = [self getMyRight];
        if(wModel.isBoundary){
            message = [NSString stringWithFormat:@" Oops!, you just hit the right wall. Ending game with a score of %d",(int)wModel.currentScore];
            //[timer invalidate];
            //timer = nil;
            [self endGame:message];
        }
        //Get the type of Cell for nextCell if game did not end by hitting Right Wall
        int cellType = [self getMyCellType:nextCell];
        [self handleCellTypes:cellType :nextCell :timer];
    }

}

//This function handles the replacement of cells or ending the game for wrong moves
-(void) handleCellTypes:(int)cellType :(int)nextCell :(NSTimer *) timer{
    NSString *message;
    switch (cellType) {
        case 1:
            //EMPTYCELL:Replace the image in this cell with snakecell image and update myUIViewGroups array
            [self replaceACell:nextCell :wModel.WORMFACE];
            //[wModel.myWorms addObject:((UIImageView *)[self.view viewWithTag:nextCell])] ;
            [wModel.myWorms addObject:[NSNumber numberWithInt:nextCell]];
            [self updatePlayerScore];
            if(wModel.snakeLength==1){
                [self replaceACell:(int)wModel.currentSnakeHead :wModel.EMPTYCELL];
            }
            else if (wModel.snakeLength==2){
                [self replaceACell:(int)wModel.currentSnakeTail :wModel.EMPTYCELL];
                [self replaceACell:(int)wModel.currentSnakeHead :wModel.SNAKECELL];
                wModel.currentSnakeTail=wModel.currentSnakeHead;
                
            }
            else if (wModel.snakeLength==3){
                [self replaceACell:(int)wModel.currentSnakeTail :wModel.EMPTYCELL];
                [self replaceACell:(int)wModel.currentSnakeHead :wModel.SNAKECELL];
                wModel.currentSnakeTail=wModel.nextToTail;
                
            }
            else{
                [self replaceACell:(int)wModel.currentSnakeHead :wModel.SNAKECELL];
                [self replaceACell:(int)wModel.currentSnakeTail :wModel.EMPTYCELL];
                wModel.currentSnakeTail=wModel.nextToTail;

                
            }
            wModel.currentSnakeHead=nextCell;
            wModel.nextToHead=wModel.currentSnakeHead;
            [self reDrawMyWorm:wModel.myWorms];
            break;
        case 2:
            //WORMHOLE: Display Scores and exit game to home page
            message = [NSString stringWithFormat:@" Oops!, you jumped into a hole. Ending game with a score of %d",(int)wModel.currentScore];
            //[timer invalidate];
            //timer = nil;
            [self endGame:message];
            break;
        case 3:
            //MUSHROOMCELL: Add 10 to current score, add mushroom to another part of the board, replace the image in this cell with snake cell image and update myUIViewGroups
            [self replaceACell:nextCell :wModel.WORMFACE];
            [self replaceACell:(int)wModel.currentSnakeHead :wModel.SNAKECELL];
            //[wModel.myWorms addObject:((UIImageView *)[self.view viewWithTag:nextCell])] ;
            [wModel.myWorms addObject:[NSNumber numberWithInt:nextCell]];
            [self updatePlayerScore];
            if(wModel.snakeLength==1){
                wModel.currentSnakeTail = wModel.currentSnakeHead;
                wModel.nextToTail=nextCell;
                wModel.nextToHead=wModel.currentSnakeTail;
            }
            if(wModel.snakeLength==2){
                wModel.nextToTail=wModel.currentSnakeHead;
                wModel.nextToHead=wModel.currentSnakeHead;
            }
            [self AddRandomMushroom];
            wModel.currentSnakeHead=nextCell;
            wModel.snakeLength+=1;
            break;
        case 4:
            //SNAKECELL: it stepped on itself, same as Case 2
            message = [NSString stringWithFormat:@" Oops!, you just ran into yourself. Ending game with a score of %d",(int)wModel.currentScore];
            //[timer invalidate];
            //timer = nil;
            [self endGame:message];
            break;
            
        case 5:
            //WORMFACE: This may not likely ever occur
            message = [NSString stringWithFormat:@" Oops!, you just matched your head. Ending game with a score of %d",(int)wModel.currentScore];
            //[timer invalidate];
            //timer = nil;
            [self endGame:message];
            break;
        default:
            break;
    }
}

//Redraw worm after each move to an emptycell
-(void) reDrawMyWorm:(NSMutableArray *)mynewWorm{
    int wormLength = (int)[mynewWorm count];
    int newCell;
    newCell= (int)[[mynewWorm objectAtIndex:wormLength-1] integerValue];
    int oldestCell=(int)[[mynewWorm objectAtIndex:0] integerValue];
    //Now replace oldest Cell before removing it
    [self replaceACell:oldestCell :wModel.EMPTYCELL];
    [mynewWorm removeObjectAtIndex:0];
    
    
}
//Add one mushroom randomly
-(void) AddRandomMushroom{
    int numTags = NUM_ROW *NUM_COL;
    int CellType;
    int mushroom=0;
    while(1){
        mushroom= arc4random() % numTags;
        CellType = [self getMyCellType:mushroom];
        if(CellType == wModel.EMPTYCELL){
            [self replaceACell:mushroom :wModel.MUSHROOMCELL];
            break;
        }
        
            }
}
-(void) AddWormHoles: (int) numWormHoles{
    int numTags = NUM_ROW *NUM_COL;
    int countWormHoles=0;
    int wormHoles=0;
    while(1){
        wormHoles = arc4random() % numTags;
        [self replaceACell:wormHoles :wModel.WORMHOLE];
        countWormHoles+=1;
        if(countWormHoles == numWormHoles)
            break;
    }
}

//Replace a speciffied cell with SnakeCell or new Mushroom
-(void) replaceACell:(int)cellTag :(int)cellType{
    //NSLog(@" The parameters sent are %d,%d",cellTag,cellType);
    if(cellType == wModel.SNAKECELL){
        UIImage *snakeCell = [UIImage imageNamed:@"snakecell.png"];
        ((UIImageView *)[self.view viewWithTag:cellTag]).image = snakeCell;
        myUIViewGroups[cellTag-1]=wModel.SNAKECELL;
    }
    else if (cellType== wModel.MUSHROOMCELL){
        UIImage *shroomCell = [UIImage imageNamed:@"shroomcell.png"];
        ((UIImageView *)[self.view viewWithTag:cellTag]).image = shroomCell;
        myUIViewGroups[cellTag-1]=wModel.MUSHROOMCELL;
        //Now add new mushroom into a randomly selected empty cell
        
    }
    else if (cellType==wModel.WORMFACE){
        UIImage *wormFace = [UIImage imageNamed:@"wormface.png"];
        ((UIImageView *)[self.view viewWithTag:cellTag]).image = wormFace;
        myUIViewGroups[cellTag-1]=wModel.WORMFACE;
        
    }
    else if (cellType==wModel.EMPTYCELL){
        UIImage *emptyCell = [UIImage imageNamed:@"emptycell.png"];
        ((UIImageView *)[self.view viewWithTag:cellTag]).image = emptyCell;
        myUIViewGroups[cellTag-1]=wModel.EMPTYCELL;
    }
    else if (cellType==wModel.WORMHOLE){
        UIImage *wormholeCell = [UIImage imageNamed:@"wormholecell.png"];
        ((UIImageView *)[self.view viewWithTag:cellTag]).image = wormholeCell;
        myUIViewGroups[cellTag-1]=wModel.WORMHOLE;
    }
    
}

//Get the cell type where the snake head just entered
-(int) getMyCellType:(int)imagviewTag{
    int cellType = myUIViewGroups[imagviewTag-1];
    return cellType;
}

-(IBAction)moveWorm:(UIButton*)sender{
    //Get button id, state of the worm, position of its head, the direction it wants to move and the direction it is allowed to move
    //Get Clicked button and store in the model class
    
    NSString *clickedButton = sender.titleLabel.text;
    if([clickedButton  isEqual: @"Up"]){
        wModel.clickedButton =@"Up";
    }
    else if ([clickedButton  isEqual: @"Down"]){
        wModel.clickedButton =@"Down";
    }
    else if ([clickedButton  isEqual: @"Left"]){
        wModel.clickedButton =@"Left";
        
    }
    else if ([clickedButton  isEqual: @"Right"]){
        
        
        wModel.clickedButton =@"Right";
    }
    //NSLog(@"Worm should move @%@",wModel.clickedButton);
    
    //[self updatePlayerScore];
}
//Functions to determine the next snake head position and boundary conditions
-(int) getMyRight{
    int myRight=(int)wModel.currentSnakeHead +1;
    if(wModel.currentSnakeHead % NUM_COL ==0)
        wModel.isBoundary=YES;
    return myRight;
}
-(int) getMyLeft{
    int myLeft=(int)wModel.currentSnakeHead -1;
    if(myLeft % NUM_COL ==0)
        wModel.isBoundary=YES;
    return myLeft;
}
-(int) getMyUp{
    //int currentColumn;
    //currentColumn= wModel.currentSnakeHead % ;
    //NSLog(@"Current Snake Head is %d",wModel.currentSnakeHead);
    long myUp=wModel.currentSnakeHead - NUM_COL;
    if(myUp < 0)
        wModel.isBoundary=YES;
    return (int)myUp;
}
-(int) getMyDown{
    //int currentColumn = currentSnakeHead % ;
    int myDown=(int)wModel.currentSnakeHead + NUM_COL;
    if(myDown > (NUM_COL * NUM_ROW))
        wModel.isBoundary=YES;
    return myDown;
}

//To give the player appropriate score for each correct move
-(void) updatePlayerScore{
    int currentscore=0;
    currentscore = (int)wModel.currentScore;
    currentscore +=10;
    scoreLabel.text = [NSString stringWithFormat:@"%i",currentscore];
    wModel.currentScore = currentscore;
    //NSLog(@"Current Score is %d",currentscore);
    
}

-(void) endGame:(NSString *)message{
    [wModel.t invalidate];
    wModel.t  = nil;
    UIAlertView *endAlert = [[UIAlertView alloc]initWithTitle:@"End of Game" message:message delegate:self cancelButtonTitle:@"Replay" otherButtonTitles:@"HighScores", nil];
    [endAlert show];
        //Display Score and move back to home page
    
}
-(void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if(buttonIndex==0){
       // NSLog(@" First Button Clicked. Restart game");
        wModel.currentScore=0;
        
        //Randomly set the start direction on replay
        int startDirection = arc4random()%4;
        if (startDirection==1) {
            wModel.clickedButton=@"Up";
        }
        else if (startDirection==2)
            wModel.clickedButton=@"Down";
        else if (startDirection==3)
            wModel.clickedButton=@"Right";
        else
            wModel.clickedButton=@"Left";
        
        [self resetGame];
        [self createTimer];
    }
    else{
      
        //Write code to exit appication or Go home to show highScores and exit
        
        
    }
}

//Reset game in preparation to restart it
-(void) resetGame{
    [myCellsArray removeAllObjects];
    int numCells = NUM_COL*NUM_ROW;
    for(int i=1; i<= numCells;i++){
        [self replaceACell:i :wModel.EMPTYCELL];
    }
    [self addMushrooms];
    [self AddWormHoles:wModel.numWormHole];
    [self setStartingCell];
    wModel.isBoundary = NO;
    
}
-(void) createTimer{
    //Schedule Timer to respond based on difficulty level selected
    wModel.t = [NSTimer scheduledTimerWithTimeInterval:1.0
                                         target:self
                                       selector:@selector(onTick:)
                                       userInfo:nil repeats:YES];
    // = t;
    [wModel.t fire];

}

//Functions to implement COMPUTER PLAYER IN DEMO MODE
-(void) getGoodDirectionToMove{
    int myRight = [self getMyRight];
    int myLeft = [self getMyLeft];
    int myUp = [self getMyUp];
    int myDowm = [self getMyDown];
    
    int cellType = [self getMyCellType:myRight];
    if(wModel.isBoundary ==NO && (cellType == wModel.EMPTYCELL || cellType==wModel.MUSHROOMCELL)){
        wModel.clickedButton = @"Right";
        return;
    }
    cellType = [self getMyCellType:myLeft];
    if(wModel.isBoundary ==NO && (cellType == wModel.EMPTYCELL || cellType==wModel.MUSHROOMCELL)){
        wModel.clickedButton = @"Left";
        return;
    }
    cellType = [self getMyCellType:myUp];
    if(wModel.isBoundary ==NO && (cellType == wModel.EMPTYCELL || cellType==wModel.MUSHROOMCELL)){
        wModel.clickedButton = @"Up";
        return;
    }
    cellType=[self getMyCellType:myDowm];
    if(wModel.isBoundary ==NO && (cellType == wModel.EMPTYCELL || cellType==wModel.MUSHROOMCELL)){
        wModel.clickedButton = @"Down";
        return;
    }
    NSLog(@" The Computer is screwed and has lost the game");
    
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
