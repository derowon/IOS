//
//  Vidrio.m
//  Vidrios
//
//  Created by Dero on 2016. 6. 22..
//  Copyright © 2016년 Dero. All rights reserved.
//

#import "Vidrio.h"

@implementation Vidrio

-(instancetype)init:(int)type{
    NSString *v = [NSString stringWithFormat:@"vidrio"];
    if(type ==1){
        v =[v stringByAppendingString:@"2-1"];
    }else if(type ==0){
        v = [NSString stringWithFormat:@"bomb"];
    }

    if (self = [super initWithTexture:[SKTexture textureWithImageNamed:v]]) {
        self.pines = [NSMutableArray array];
        //self.position = CGPointMake(backThief.position.x+backThief.size.width-30, 250);
        //self.position = CGPointMake(300,300);
        self.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:CGSizeMake(self.size.width, self.size.height)];
        self.physicsBody.dynamic = YES;
        self.alpha=0.85;
        
        self.physicsBody.categoryBitMask = objectCategory;
        self.physicsBody.collisionBitMask = worldCategory;
        if(type ==1 ){
            self.name = @"Vidrio2";
            self.alpha=1;
        }else if(type ==0) {
            self.name=@"bomb";
            self.alpha =1;
        }else{
            self.name = @"Vidrio";
        }
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
    self.front.physicsBody.velocity = CGVectorMake(self.velocity , 0);
    self.back.physicsBody.velocity = CGVectorMake(self.velocity , 0);
}

@end
