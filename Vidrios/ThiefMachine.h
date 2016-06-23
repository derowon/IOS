//
//  ThiefMachine.h
//  Vidrios
//
//  Created by AdminMacLC01 on 6/21/16.
//  Copyright © 2016 Dero. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <SpriteKit/SpriteKit.h>
#import "Vidrio.h"
#import "Window.h"
#import "Bomb.h"
#import "HardWindow.h"

@class GameScene;

static const uint32_t thiefCategory = 1;
static const uint32_t objectCategory = 4;
static const uint32_t worldCategory = 2;

@interface ThiefMachine : NSObject

@property (strong, nonatomic) NSArray* thiefRunningTextures;
@property (strong, nonatomic) NSArray* thiefWithFrontTextures;
@property (strong, nonatomic) NSArray* thiefWithBackTextures;
@property (strong,nonatomic) NSMutableArray *escapingThieves;

@property (strong,nonatomic) NSMutableArray *vidrios;


-(instancetype)init;
-(void)spawnRandomThiefInScene:(SKScene*)scene WithSpeed:(CGFloat)speed;
-(void)spawnThiefInScene:(SKScene*)scene AtLocation:(CGPoint)location WithSpeed:(CGFloat)speed;
-(void)update:(CFTimeInterval)currentTime withScene:(GameScene*)scene;
-(void)vidrioTouched:(SKNode*)node scene:(SKScene*) scene;
@end
