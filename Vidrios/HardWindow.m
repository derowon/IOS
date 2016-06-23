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
    
    
    
    if (self = [super init:v]) {
        
        self.name = @"Vidrio2";
        self.xScale *=1.8;
        self.yScale *=1.8;
    }
    
    return self;
}

@end

