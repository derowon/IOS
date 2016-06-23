//
//  Element.m
//  Vidrios
//
//  Created by Dero on 2016. 6. 23..
//  Copyright © 2016년 Dero. All rights reserved.
//

#import "Element.h"

@implementation Element



-(void)addFront:(SKSpriteNode *)front andBack:(SKSpriteNode *)back{
    self.back = back;
    self.front = front;
}

-(void) addFirstJoints:(SKPhysicsJoint*)firstJoint andSecond:(SKPhysicsJoint*)secondJoint{
    [self.pines addObject:firstJoint];
    [self.pines addObject:secondJoint];
}

-(void)update:(CFTimeInterval)currentTime {
    self.front.physicsBody.velocity = CGVectorMake(self.velocity , 0);
    self.back.physicsBody.velocity = CGVectorMake(self.velocity , 0);
}


@end
