//
//  Vidrio.h
//  Vidrios
//
//  Created by Dero on 2016. 6. 22..
//  Copyright © 2016년 Dero. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "ThiefMachine.h"

@interface Vidrio : SKSpriteNode
@property (strong,nonatomic) NSMutableArray *pines;
@property (strong,nonatomic) SKSpriteNode *front;
@property (strong,nonatomic) SKSpriteNode *back;
@property int direction;

-(instancetype)init;
-(void) addFront:(SKSpriteNode*) front andBack:(SKSpriteNode*)back;
-(void) addFirstJoints:(SKPhysicsJoint*)firstJoint andSecond:(SKPhysicsJoint*)secondJoint;

@end
