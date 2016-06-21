//
//  ThiefMachine.m
//  Vidrios
//
//  Created by AdminMacLC01 on 6/21/16.
//  Copyright © 2016 Dero. All rights reserved.
//

#import "ThiefMachine.h"

@implementation ThiefMachine {
    CGPoint spawnLocations[6];
}

-(instancetype)init {
    if (self = [super init]) {
        //running thief
        NSMutableArray *runningFrames = [NSMutableArray array];
        SKTextureAtlas *runningAnimatedAtlas = [SKTextureAtlas atlasNamed:@"Sprite"];
        int numImages = 4;
        for(int i=1;i<=numImages ; i++){
            NSString *textureName = [NSString stringWithFormat:@"running%d",i];
            SKTexture * temp = [runningAnimatedAtlas textureNamed:textureName ];
            [runningFrames addObject:temp];
        }
        self.thiefRunningTextures = runningFrames;
        
        //Personaje adelante
        runningFrames = [NSMutableArray array];
        numImages = 7;
        for(int i=1; i<=numImages ; i++){
            NSString *textureName = [NSString stringWithFormat:@"ladronAdelante%d",i];
            SKTexture *temp = [runningAnimatedAtlas textureNamed:textureName];
            [runningFrames addObject:temp];
        }
        self.thiefWithFrontTextures = runningFrames;
        
        runningFrames = [NSMutableArray array ];
        numImages = 7;
        for(int i=1; i<=numImages ; i++){
            NSString *textureName = [NSString stringWithFormat:@"ladronAtras%d",i];
            SKTexture *temp = [runningAnimatedAtlas textureNamed:textureName];
            [runningFrames addObject:temp];
        }
        self.thiefWithBackTextures = runningFrames;
        
        //Thieves spawn locations
        spawnLocations[0] = CGPointMake(300, 250);
        spawnLocations[1] = CGPointMake(100, 250);
        spawnLocations[2] = CGPointMake(150, 500);
        spawnLocations[3] = CGPointMake(200, 500);
        spawnLocations[4] = CGPointMake(250, 500);
        spawnLocations[5] = CGPointMake(400, 750);
    }
    return self;
}

-(void)spawnThiefInScene:(SKScene*)scene AtLocation:(CGPoint)location {
    SKSpriteNode* frontThief = [SKSpriteNode spriteNodeWithTexture:self.thiefWithFrontTextures[0]];
    SKSpriteNode* backThief = [SKSpriteNode spriteNodeWithTexture:self.thiefWithBackTextures[0]];
    
    frontThief.position = CGPointMake(location.x - 20, location.y);
    backThief.position = CGPointMake(location.x + 20, location.y);
    
    frontThief.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:CGSizeMake(frontThief.size.width, frontThief.size.height)];
    backThief.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:CGSizeMake(backThief.size.width, backThief.size.height)];
    frontThief.physicsBody.dynamic = YES;
    backThief.physicsBody.dynamic = YES;
    frontThief.physicsBody.allowsRotation = NO;
    backThief.physicsBody.allowsRotation = NO;
    frontThief.physicsBody.categoryBitMask = thiefCategory;
    backThief.physicsBody.categoryBitMask = thiefCategory;
    frontThief.physicsBody.collisionBitMask = worldCategory;
    backThief.physicsBody.collisionBitMask = worldCategory;
    
    [scene addChild:frontThief];
    [scene addChild:backThief];
    
    [frontThief runAction:[SKAction repeatActionForever:[SKAction animateWithTextures:self.thiefWithFrontTextures timePerFrame:0.1f resize:NO restore:YES]] withKey:@"runningInPlace"];
    [backThief runAction:[SKAction repeatActionForever:[SKAction animateWithTextures:self.thiefWithBackTextures timePerFrame:0.1f resize:NO restore:YES]] withKey:@"runningInPlace"];
    
}

@end
