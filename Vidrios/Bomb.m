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
    if(self = [super init:v]){
        self.alpha =1;
        self.name = @"bomb";
        self.xScale *=0.8;
        self.yScale*=0.8;
    }
    return self;
}



@end
