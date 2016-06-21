//
//  ThiefSpriteNode.h
//  Vidrios
//
//  Created by AdminMacLC01 on 6/21/16.
//  Copyright © 2016 Dero. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <SpriteKit/SpriteKit.h>

static const uint32_t thiefCategory = 1;
static const uint32_t objectCategory = 2;
static const uint32_t worldCategory = 4;

@interface SKSpriteNode (ThiefSpriteNode)

-(void)runThief:(NSArray*)arr;

@end
