//
//  Vidrio.m
//  Vidrios
//
//  Created by Dero on 2016. 6. 22..
//  Copyright © 2016년 Dero. All rights reserved.
//

#import "Vidrio.h"

@implementation Vidrio

-(instancetype)init{
    if (self = [super initWithTexture:[SKTexture textureWithImageNamed:@"vidrio"]]) {
        self.pines = [NSMutableArray array];
        //self.position = CGPointMake(backThief.position.x+backThief.size.width-30, 250);
        //self.position = CGPointMake(300,300);
        self.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:CGSizeMake(self.size.width, self.size.height)];
        self.physicsBody.dynamic = YES;
        self.alpha=0.85;
        self.physicsBody.categoryBitMask = objectCategory;
        self.physicsBody.collisionBitMask = worldCategory;
    }
 
    return self;
}

-(void)addFront:(SKSpriteNode *)front andBack:(SKSpriteNode *)back{
    self.back = back;
    self.front = front;
}

-(void) addFirstJoints:(SKPhysicsJoint*)firstJoint andSecond:(SKPhysicsJoint*)secondJoint{
    [self.pines addObject:firstJoint];
    [self.pines addObject:secondJoint];
}

-(void)update:(CFTimeInterval)currentTime {
    self.front.physicsBody.velocity = CGVectorMake(self.velocity * self.direction, 0);
    self.back.physicsBody.velocity = CGVectorMake(self.velocity * self.direction, 0);
}

@end
