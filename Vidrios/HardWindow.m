//
//  HardWindow.m
//  Vidrios
//
//  Created by Dero on 2016. 6. 23..
//  Copyright © 2016년 Dero. All rights reserved.
//

#import "HardWindow.h"
#import "ThiefMachine.h"

@implementation HardWindow

-(instancetype)init{
    NSString *v = [NSString stringWithFormat:@"vidrio2-1"];
    
    
    
    if (self = [super initWithTexture:[SKTexture textureWithImageNamed:v]]) {
        self.pines = [NSMutableArray array];
        self.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:CGSizeMake(self.size.width, self.size.height)];
        self.physicsBody.dynamic = YES;
        self.alpha=1;
        self.physicsBody.categoryBitMask = objectCategory;
        self.physicsBody.collisionBitMask = worldCategory;
        self.name = @"Vidrio2";
    }
    
    return self;
}
@end

