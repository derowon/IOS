//
//  Bomb.m
//  Vidrios
//
//  Created by Dero on 2016. 6. 23..
//  Copyright © 2016년 Dero. All rights reserved.
//

#import "Bomb.h"
#import "ThiefMachine.h"

@implementation Bomb

-(instancetype)init{
    NSString *v = [NSString stringWithFormat:@"bomb"];

    

    if (self = [super initWithTexture:[SKTexture textureWithImageNamed:v]]) {
        self.pines = [NSMutableArray array];
        //self.position = CGPointMake(backThief.position.x+backThief.size.width-30, 250);
        //self.position = CGPointMake(300,300);
        self.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:CGSizeMake(self.size.width, self.size.height)];
        self.physicsBody.dynamic = YES;
        self.alpha=1;
        self.xScale *=2;
        self.physicsBody.categoryBitMask = objectCategory;
        self.physicsBody.collisionBitMask = worldCategory;
        }
    
    return self;
}

@end
