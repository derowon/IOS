//
//  ThiefMachine.m
//  Vidrios
//
//  Created by AdminMacLC01 on 6/21/16.
//  Copyright © 2016 Dero. All rights reserved.
//

#import "ThiefMachine.h"
#import "GameScene.h"

@implementation ThiefMachine {
    CGPoint spawnLocations[6];
    int percentage ;
}

-(instancetype)init {
    if (self = [super init]) {
        //running thief
        percentage = 10;
        self.vidrios = [NSMutableArray array];
        NSMutableArray *runningFrames = [NSMutableArray array];
        SKTextureAtlas *runningAnimatedAtlas = [SKTextureAtlas atlasNamed:@"Sprite"];
        int numImages = 4;
        for(int i=1;i<=numImages ; i++){
            NSString *textureName = [NSString stringWithFormat:@"running%d",i];
            SKTexture * temp = [runningAnimatedAtlas textureNamed:textureName ];
            [runningFrames addObject:temp];
        }
        self.thiefRunningTextures = runningFrames;
        
        //Personaje adelante
        runningFrames = [NSMutableArray array];
        numImages = 7;
        for(int i=1; i<=numImages ; i++){
            NSString *textureName = [NSString stringWithFormat:@"ladronAdelante%d",i];
            SKTexture *temp = [runningAnimatedAtlas textureNamed:textureName];
            [runningFrames addObject:temp];
        }
        self.thiefWithFrontTextures = runningFrames;
        
        runningFrames = [NSMutableArray array ];
        numImages = 7;
        for(int i=1; i<=numImages ; i++){
            NSString *textureName = [NSString stringWithFormat:@"ladronAtras%d",i];
            SKTexture *temp = [runningAnimatedAtlas textureNamed:textureName];
            [runningFrames addObject:temp];
        }
        self.thiefWithBackTextures = runningFrames;
        
        //Thieves spawn locations
        
        spawnLocations[0] = CGPointMake(-200, 150);
        spawnLocations[1] = CGPointMake(-200, 350);
        spawnLocations[2] = CGPointMake(-200, 550);
        spawnLocations[3] = CGPointMake(1200, 550);
        spawnLocations[4] = CGPointMake(1200, 350);
        spawnLocations[5] = CGPointMake(1200, 150);
         /*
        spawnLocations[0] = CGPointMake(200, 150);
        spawnLocations[1] = CGPointMake(200, 350);
        spawnLocations[2] = CGPointMake(200, 550);
        spawnLocations[3] = CGPointMake(600, 550);
        spawnLocations[4] = CGPointMake(600, 350);
        spawnLocations[5] = CGPointMake(600, 150);
     */
        //Ground creation
        self.escapingThieves = [NSMutableArray array];
        
    }
    return self;
}

-(void)spawnRandomThiefInScene:(SKScene*)scene WithSpeed:(CGFloat)speed {
    uint32_t location = arc4random_uniform(6);
    [self spawnThiefInScene:scene AtLocation:spawnLocations[location] WithSpeed:speed];
}

-(void)spawnThiefInScene:(SKScene*)scene AtLocation:(CGPoint)location WithSpeed:(CGFloat)speed {
    SKSpriteNode* frontThief = [SKSpriteNode spriteNodeWithTexture:self.thiefWithFrontTextures[0]];
    SKSpriteNode*  backThief = [SKSpriteNode spriteNodeWithTexture:self.thiefWithBackTextures[0]];
    
    int type = arc4random_uniform(percentage);
    
    backThief.position = CGPointMake(location.x , location.y);
    Element *v ;
    if(type>=2){
        v = [[Window alloc] init];
    }else if (type ==1){
        v = [[Bomb alloc] init];
    }else if (type ==0){
        v = [[HardWindow alloc] init];
    }
    
    v.position = CGPointMake(backThief.position.x + backThief.size.width , backThief.position.y);
    
    if(type ==1){
        v.position = CGPointMake(backThief.position.x + backThief.size.width-25, backThief.position.y);
    }
    
    v.direction = 1;
    v.velocity = speed;
    
    frontThief.position = CGPointMake(backThief.position.x + v.size.width+backThief.size.width/2 -15, location.y);
    
    if(CGPointEqualToPoint(location , self->spawnLocations[3]) || CGPointEqualToPoint(location, self->spawnLocations[4]) || CGPointEqualToPoint(location, self->spawnLocations[5])){
        CGPoint temp = backThief.position;
        backThief.position = frontThief.position;
        frontThief.position = temp;
        
        frontThief.xScale = fabs(frontThief.xScale) * -1;
        backThief.xScale = fabs(backThief.xScale) *-1;
        frontThief.position= CGPointMake(frontThief.position.x +10, frontThief.position.y);
        backThief.position = CGPointMake(backThief.position.x+10, backThief.position.y);
        v.velocity = v.velocity *-1 ;
        v.direction=-1;
    }
   // NSLog(@"%f ",v.velocity);
    
    frontThief.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:CGSizeMake(frontThief.size.width, frontThief.size.height)];
    backThief.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:CGSizeMake(backThief.size.width, backThief.size.height)];
    frontThief.physicsBody.dynamic = YES;
    backThief.physicsBody.dynamic = YES;
    frontThief.physicsBody.allowsRotation = NO;
    backThief.physicsBody.allowsRotation = NO;
    frontThief.physicsBody.categoryBitMask = thiefCategory;
    backThief.physicsBody.categoryBitMask = thiefCategory;
    frontThief.physicsBody.collisionBitMask = worldCategory;
    backThief.physicsBody.collisionBitMask = worldCategory;
   
    [scene addChild:frontThief];
    [scene addChild:backThief];
    [scene addChild:v];
    
    [frontThief runAction:[SKAction repeatActionForever:[SKAction animateWithTextures:self.thiefWithFrontTextures timePerFrame:0.1f resize:NO restore:YES]] withKey:@"runningInPlace"];
    [backThief runAction:[SKAction repeatActionForever:[SKAction animateWithTextures:self.thiefWithBackTextures timePerFrame:0.1f resize:NO restore:YES]] withKey:@"runningInPlace"];
    [v addFront:frontThief andBack:backThief];
    
    CGPoint anchor = CGPointMake(backThief.position.x + backThief.size.width/2, backThief.position.y);
    SKPhysicsJointFixed *pin = [SKPhysicsJointFixed jointWithBodyA:v.physicsBody bodyB:backThief.physicsBody anchor:anchor];
    [scene.physicsWorld addJoint:pin];
    
    anchor = CGPointMake(v.position.x + v.size.width/2, v.position.y);
    SKPhysicsJointFixed *pin2 = [SKPhysicsJointFixed jointWithBodyA:v.physicsBody bodyB:frontThief.physicsBody anchor:anchor];
    [scene.physicsWorld addJoint:pin2];
    [v addFirstJoints:pin2 andSecond:pin];
    [self.vidrios addObject:v];
}

-(int)getRandomNumberBetween:(int)from to:(int)to {
    
    return (int)from + arc4random() % (to-from+1);
}


-(void)update:(CFTimeInterval)currentTime withScene:(GameScene*) scene {
    
    //elimina todos los vidrios que estan transparentes
    NSMutableArray *temp = [self.vidrios mutableCopy];
    for (Element *vidrio in temp) {
        //[vidrio removeFromParent];
        //[self.vidrios removeObject:vidrio];
        if(vidrio.direction == -1){
            if(vidrio.back.position.x + vidrio.size.width < 0){
                if (vidrio.pines.count > 0 && ![vidrio isKindOfClass:[Bomb class]]) {
                    scene.lives--;
                }
                [vidrio.front removeFromParent];
                [vidrio.back removeFromParent];
                [vidrio removeFromParent];
                [self.vidrios removeObject:vidrio];
            }
        } else {
            if(vidrio.back.position.x- vidrio.size.width >scene.frame.size.width){
                if (vidrio.pines.count > 0 && ![vidrio isKindOfClass:[Bomb class]]) {
                    scene.lives--;
                }
                [vidrio.front removeFromParent];
                [vidrio.back removeFromParent];
                [vidrio removeFromParent];
                [self.vidrios removeObject:vidrio];
            }
        }
    }
    
    for(SKSpriteNode *thief in self.escapingThieves){
        
        [thief.physicsBody applyImpulse:CGVectorMake(thief.physicsBody.velocity.dx *1.5,0)];
    }

}

-(void) vidrioTouched:(SKNode *)node scene:(GameScene*)scene{
    Element *v = (Element*)node;
    scene.score += 10;
    if([node.name isEqualToString:@"Vidrio"]){
        for (SKPhysicsJoint * joint in v.pines) {
            [scene.physicsWorld removeJoint:joint];
            
        }
        [v.pines removeAllObjects];
        SKAction *breakingSound = [SKAction playSoundFileNamed:@"breakingSound.wav" waitForCompletion:NO];
        v.texture = [SKTexture textureWithImageNamed:@"vidrioRoto"];
        v.zPosition = -10;
        v.name = @"vidrioRoto";
        SKAction *action = [SKAction fadeOutWithDuration:1.0];
        SKAction *withSound =[SKAction sequence:@[breakingSound,action]];
        [v runAction:withSound];
        [self.escapingThieves addObject:v.back];
        [self.escapingThieves addObject:v.front];
        
        [v.back runAction:[SKAction repeatActionForever:
                       [SKAction animateWithTextures:self.thiefRunningTextures
                                        timePerFrame:0.1f
                                              resize:NO
                                             restore:YES]] withKey:@"runningInPlace"];
        v.front.zPosition =-10;
        [v.front runAction:[SKAction repeatActionForever:
                       [SKAction animateWithTextures:self.thiefRunningTextures
                                        timePerFrame:0.1f
                                              resize:NO
                                             restore:YES]] withKey:@"runningInPlace"];
    v.back.zPosition=-10;
    }
    else if([node.name isEqualToString:@"Vidrio2"]) {
        SKAction *crackingSound = [SKAction playSoundFileNamed:@"crackingSound.wav" waitForCompletion:NO];
        SKAction *sound = [SKAction sequence:@[crackingSound]];
        [v runAction:sound];
        v.texture = [SKTexture textureWithImageNamed:@"vidrio2-2"];
        v.alpha = 1;
        v.name = @"Vidrio";
    }
}

@end
