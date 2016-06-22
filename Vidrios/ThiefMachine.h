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

static const uint32_t thiefCategory = 1;
static const uint32_t objectCategory = 4;
static const uint32_t worldCategory = 2;

@interface ThiefMachine : NSObject

@property (strong, nonatomic) NSArray* thiefRunningTextures;
@property (strong, nonatomic) NSArray* thiefWithFrontTextures;
@property (strong, nonatomic) NSArray* thiefWithBackTextures;
@property (strong,nonatomic ) NSMutableArray *clouds;
@property  NSTimeInterval lastUpdateTime;
@property  NSTimeInterval deltaTime;
@property float bgVel;

-(instancetype)init;
-(void)spawnThiefInScene:(SKScene*)scene AtLocation:(CGPoint)location;
-(void)createGround:(SKScene*)scene;
-(void)setBackGround:(SKScene*)scene;
-(void)update:(CFTimeInterval)currentTime withScene:(SKScene*)scene;

@end
