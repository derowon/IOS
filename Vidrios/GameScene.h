//
//  GameScene.h
//  Vidrios
//

//  Copyright (c) 2016년 Dero. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "ThiefMachine.h"

@interface GameScene : SKScene

@property (strong, nonatomic) ThiefMachine* thiefMachine;
@property (strong,nonatomic ) NSMutableArray *clouds;
@property float bgVel;
@property  NSTimeInterval lastUpdateTime;
@property  NSTimeInterval deltaTime;
@property BOOL gameOver;

@end
