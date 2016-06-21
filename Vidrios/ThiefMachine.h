//
//  ThiefMachine.h
//  Vidrios
//
//  Created by AdminMacLC01 on 6/21/16.
//  Copyright © 2016 Dero. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <SpriteKit/SpriteKit.h>

static const uint32_t thiefCategory = 1;
static const uint32_t objectCategory = 2;
static const uint32_t worldCategory = 4;

@interface ThiefMachine : NSObject

@property (strong, nonatomic) NSArray* thiefRunningTextures;
@property (strong, nonatomic) NSArray* thiefWithFrontTextures;
@property (strong, nonatomic) NSArray* thiefWithBackTextures;

-(instancetype)init;
-(void)spawnThiefInScene:(SKScene*)scene AtLocation:(CGPoint)location;


@end
