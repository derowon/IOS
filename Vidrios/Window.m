//
//  Window.m
//  Vidrios
//
//  Created by Dero on 2016. 6. 23..
//  Copyright © 2016년 Dero. All rights reserved.
//

#import "Window.h"
#import "ThiefMachine.h"

@implementation Window

-(instancetype)init{
    NSString *v = [NSString stringWithFormat:@"vidrio"];

        if (self = [super initWithTexture:[SKTexture textureWithImageNamed:v]]) {
        self.pines = [NSMutableArray array];
        //self.position = CGPointMake(backThief.position.x+backThief.size.width-30, 250);
        //self.position = CGPointMake(300,300);
        self.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:CGSizeMake(self.size.width, self.size.height)];
        self.physicsBody.dynamic = YES;
        self.alpha=0.85;
        
        self.physicsBody.categoryBitMask = objectCategory;
        self.physicsBody.collisionBitMask = worldCategory;
      
        self.name=@"Vidrio";
        
    }
    
    return self;
}


@end
