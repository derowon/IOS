//
//  ThiefMachine.m
//  Vidrios
//
//  Created by AdminMacLC01 on 6/21/16.
//  Copyright © 2016 Dero. All rights reserved.
//

#import "ThiefMachine.h"

@implementation ThiefMachine {
    CGPoint spawnLocations[6];
}

-(instancetype)init {
    if (self = [super init]) {
        //running thief
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
        spawnLocations[0] = CGPointMake(300, 250);
        spawnLocations[1] = CGPointMake(100, 250);
        spawnLocations[2] = CGPointMake(150, 500);
        spawnLocations[3] = CGPointMake(200, 600);
        spawnLocations[4] = CGPointMake(250, 500);
        spawnLocations[5] = CGPointMake(400, 750);
     
        //Ground creation
        
        
    }
    return self;
}

-(void)spawnRandomThiefInScene:(SKScene*)scene WithSpeed:(CGFloat)speed {
    uint32_t location = arc4random_uniform(6);
    [self spawnThiefInScene:scene AtLocation:spawnLocations[location] WithSpeed:speed];
}

-(void)spawnThiefInScene:(SKScene*)scene AtLocation:(CGPoint)location WithSpeed:(CGFloat)speed {
    SKSpriteNode* frontThief = [SKSpriteNode spriteNodeWithTexture:self.thiefWithFrontTextures[0]];
    SKSpriteNode* backThief = [SKSpriteNode spriteNodeWithTexture:self.thiefWithBackTextures[0]];
    Vidrio *v = [[Vidrio alloc] init];
    
    backThief.position = CGPointMake(location.x , location.y);
    
    v.position = CGPointMake(backThief.position.x + backThief.size.width - 30, backThief.position.y+10);
    
    frontThief.position = CGPointMake(backThief.position.x + v.size.width+backThief.size.width/2 -15, location.y);

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
}

-(void) setBackGround:(SKScene *)scene{
    SKColor *skyColor = [SKColor colorWithRed:113.0/255.0 green:197.0/255.0 blue:207.0/255.0 alpha:1.0];
    [scene setBackgroundColor:skyColor];
    
    SKSpriteNode *buildings = [SKSpriteNode spriteNodeWithImageNamed:@"buildings"];
    buildings.size = CGSizeMake(scene.frame.size.width, CGRectGetMidY(scene.frame));
    buildings.position = CGPointMake(0, 0);
    buildings.anchorPoint = CGPointMake(0, 0);
    buildings.zPosition =-95;
    buildings.yScale +=1;
    [scene addChild:buildings];
    
    //Agregando las nubes
    
    self.clouds  = [NSMutableArray arrayWithCapacity:8];
    self.bgVel = 35;
    int acum=0;
    for(int i=0;i< 9 ;i++){
        SKSpriteNode *cloud = [SKSpriteNode spriteNodeWithImageNamed:@"cloud"];
        cloud.size = CGSizeMake(100, 50);
        int rand = arc4random() %100;
        cloud.position = CGPointMake(acum +rand, [self getRandomNumberBetween:100 to:scene.frame.size.height-150]);
        acum+= cloud.size.width +rand;
        cloud.zPosition = -100;
        [self.clouds addObject:cloud ];
        [scene addChild:cloud];
    }
    scene.physicsWorld.gravity = CGVectorMake(0.0, -5.0);
}

-(int)getRandomNumberBetween:(int)from to:(int)to {
    
    return (int)from + arc4random() % (to-from+1);
}

-(void) createGround:(SKScene*)scene{
    SKTexture *ground = [SKTexture textureWithImageNamed:@"brick"];
    for(int i=0;i<scene.frame.size.width+50;){
        SKSpriteNode *piso = [SKSpriteNode spriteNodeWithTexture:ground];
        //SKSpriteNode *piso = [SKSpriteNode spriteNodeWithImageNamed:@"brick"];
        piso.size = CGSizeMake(30, 30);
        piso.position = CGPointMake(i, 110);
        i+=piso.size.width;
        piso.zPosition =-90;
        [scene addChild:piso];
    }
    SKNode *dummy = [SKNode node];
    dummy.position = CGPointMake(scene.frame.size.width/2, 110);
    dummy.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:CGSizeMake(scene.frame.size.width+(400), 30)];
    dummy.physicsBody.dynamic = NO;
    dummy.physicsBody.categoryBitMask = worldCategory;
    [scene addChild:dummy];
    
    for(int i=0;i<scene.frame.size.width+50;){
        SKSpriteNode *piso = [SKSpriteNode spriteNodeWithTexture:ground];
        //SKSpriteNode *piso = [SKSpriteNode spriteNodeWithImageNamed:@"brick"];
        piso.size = CGSizeMake(30, 30);
        piso.position = CGPointMake(i, 300);
        i+=piso.size.width;
        piso.zPosition =-90;
        [scene addChild:piso];
    }
    dummy = [SKNode node];
    dummy.position = CGPointMake(scene.frame.size.width/2, 300);
    dummy.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:CGSizeMake(scene.frame.size.width+(400), 30)];
    dummy.physicsBody.dynamic = NO;
    dummy.physicsBody.categoryBitMask = worldCategory;
    [scene addChild:dummy];
    
    for(int i=0;i<scene.frame.size.width+50;){
        SKSpriteNode *piso = [SKSpriteNode spriteNodeWithTexture:ground];
        //SKSpriteNode *piso = [SKSpriteNode spriteNodeWithImageNamed:@"brick"];
        piso.size = CGSizeMake(30, 30);
        piso.position = CGPointMake(i, 500 );
        i+=piso.size.width;
        piso.zPosition =-90;
        [scene addChild:piso];
    }
    dummy = [SKNode node];
    dummy.position = CGPointMake(scene.frame.size.width/2, 500);
    dummy.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:CGSizeMake(scene.frame.size.width+(400), 30)];
    dummy.physicsBody.dynamic = NO;
    dummy.physicsBody.categoryBitMask = worldCategory;
    [scene addChild:dummy];

}

-(void)update:(CFTimeInterval)currentTime withScene:(SKScene*) scene{
    
    if (self.lastUpdateTime) {
        self.deltaTime = currentTime - self.lastUpdateTime;
    } else {
        self.deltaTime = 0;
    }
    self.lastUpdateTime = currentTime;
    
    //_thief.physicsBody.velocity = CGVectorMake(0, 0.5);
    //[_thief.physicsBody applyImpulse:CGVectorMake(5, 0)];
    //[_prueba.physicsBody applyImpulse:CGVectorMake(20, 0)];
    CGPoint bgVelocity = CGPointMake(-_bgVel, 0.0);
    
    
    for(SKSpriteNode *cloud in _clouds){
        
        if(cloud.position.x + cloud.size.width < 0){
            cloud.position = CGPointMake(scene.frame.size.width + cloud.size.width, [self getRandomNumberBetween:100 to:scene.frame.size.height-150]);
        }
        
        CGPoint amtToMove = CGPointMake(bgVelocity.x * _deltaTime, bgVelocity.y * _deltaTime);
        cloud.position = CGPointMake(cloud.position.x+amtToMove.x, cloud.position.y+amtToMove.y);
    }

}
-(void) vidrioTouched:(SKNode *)node scene:(SKScene*)scene{
    Vidrio *v = (Vidrio*)node;
    for (SKPhysicsJoint * joint in v.pines) {
        [scene.physicsWorld removeJoint:joint];
    }
    [scene.physicsWorld removeAllJoints];
    v.texture = [SKTexture textureWithImageNamed:@"vidrioRoto"];
    //[v.back removeAllActions];
    //v.back = [SKSpriteNode spriteNodeWithTexture:self.thiefRunningTextures[0]];
    [v.back runAction:[SKAction repeatActionForever:
                       [SKAction animateWithTextures:self.thiefRunningTextures
                                        timePerFrame:0.1f
                                              resize:NO
                                             restore:YES]] withKey:@"runningInPlace"];
    //[v.front removeAllActions];
    //v.front = [SKSpriteNode spriteNodeWithTexture:self.thiefRunningTextures[0]];

    [v.front runAction:[SKAction repeatActionForever:
                       [SKAction animateWithTextures:self.thiefRunningTextures
                                        timePerFrame:0.1f
                                              resize:NO
                                             restore:YES]] withKey:@"runningInPlace"];

}

@end
