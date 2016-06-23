//
//  Element.h
//  Vidrios
//
//  Created by Dero on 2016. 6. 23..
//  Copyright © 2016년 Dero. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface Element : SKSpriteNode

@property (strong,nonatomic) NSMutableArray *pines;
@property (strong,nonatomic) SKSpriteNode *front;
@property (strong,nonatomic) SKSpriteNode *back;
@property NSUInteger direction;
@property CGFloat velocity;


-(instancetype)init:(NSString *)name;
-(void) addFront:(SKSpriteNode*) front andBack:(SKSpriteNode*)back;
-(void) addFirstJoints:(SKPhysicsJoint*)firstJoint andSecond:(SKPhysicsJoint*)secondJoint;
-(void)update:(CFTimeInterval)currentTime;

@end
