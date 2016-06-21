//
//  ThiefSpriteNode.m
//  Vidrios
//
//  Created by AdminMacLC01 on 6/21/16.
//  Copyright © 2016 Dero. All rights reserved.
//

#import "ThiefSpriteNode.h"

@implementation SKSpriteNode (ThiefSpriteNode)

-(instancetype)initThief {
    if (self = [super init]) {
        self = [SKSpriteNode spriteNodeWithTexture:[SKTexture textureWithImageNamed:@"running1"]];
        self.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:CGSizeMake(self.size.width, self.size.height)];
        self.physicsBody.dynamic = YES;
        self.physicsBody.allowsRotation = NO;
        self.physicsBody.categoryBitMask = thiefCategory;
        self.physicsBody.collisionBitMask = worldCategory;
    }
    return self;
}

-(void)runThief:(NSArray*)arr {
    [self runAction:[SKAction repeatActionForever:
                       [SKAction animateWithTextures:arr
                                        timePerFrame:0.1f
                                              resize:NO
                                             restore:YES]] withKey:@"runningInPlace"];
}

@end
