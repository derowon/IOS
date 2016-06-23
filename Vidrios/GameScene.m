//
//  GameScene.m
//  Vidrios
//
//  Created by Dero on 2016. 5. 26..
//  Copyright (c) 2016년 Dero. All rights reserved.
//

#import "GameScene.h"

@implementation GameScene
{
    SKLabelNode* tiempo;
    NSTimer* timer;
    NSUInteger timeSec;
    CGFloat spawnInterval;
}

-(void)didMoveToView:(SKView *)view {

    spawnInterval = 5;
    self.gameOver =false;
    SKColor *skyColor = [SKColor colorWithRed:113.0/255.0 green:197.0/255.0 blue:207.0/255.0 alpha:1.0];
    [self setBackgroundColor:skyColor];
    
    [self buttonShow];
    //self.thiefMachine = [[ThiefMachine alloc] init];
    //[self.thiefMachine spawnRandomThiefInScene:self WithSpeed:100];
   
    
    
}
-(void) setTimer{
    tiempo = [SKLabelNode labelNodeWithFontNamed:@"Arial"];
    tiempo.text = @"00:00";
    tiempo.fontSize = 20;
    tiempo.position = CGPointMake(CGRectGetMaxX(self.frame) - 50, CGRectGetMaxY(self.frame) - 150);
    timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timerTick:) userInfo:nil repeats:YES];
    tiempo.zPosition = 1;
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSDefaultRunLoopMode];
    [self addChild:tiempo];
    timeSec = 0;

}

- (void)timerTick:(NSTimer*) timer {
    timeSec++;
    [tiempo setText:[NSString stringWithFormat:@"%02lu:%02lu", timeSec / 60, timeSec % 60]];
    
    [self.thiefMachine spawnRandomThiefInScene:self WithSpeed:(arc4random_uniform((uint32_t)timeSec + 60) + 60)];
}

- (void)StopTimer {
    [timer invalidate];
    timeSec = 0;
    tiempo.text = [NSString stringWithFormat:@"%02lu:%02lu", timeSec, timeSec];
}

-(int)getRandomNumberBetween:(int)from to:(int)to {
    
    return (int)from + arc4random() % (to-from+1);
}


// Add these new methods
-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    
    }

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInNode:self];
    SKNode *node = [self nodeAtPoint:location];
    if([node.name isEqualToString:@"Vidrio"] || [node.name isEqualToString:@"Vidrio2"]){
        NSLog(@"Aprete!!! el vidrio");
        [self.thiefMachine vidrioTouched:node scene:self];
        
    }
    if([node.name isEqualToString:@"restartLabel"]){
        self.gameOver = false;
        [[self childNodeWithName:@"restartLabel"] removeFromParent];
        [self setTimer];
        [self setBackGround];
        [self createGround];
        [self startGame];
        
    }
    if([node.name isEqualToString:@"bomb"]){
        self.gameOver= true;
        
    }
    
    
}

-(void) setBackGround{
   
    
    SKSpriteNode *buildings = [SKSpriteNode spriteNodeWithImageNamed:@"buildings"];
    buildings.size = CGSizeMake(self.frame.size.width, CGRectGetMidY(self.frame));
    buildings.position = CGPointMake(0, 0);
    buildings.anchorPoint = CGPointMake(0, 0);
    buildings.zPosition =-95;
    buildings.yScale +=1;
    [self addChild:buildings];
    
    //Agregando las nubes
    
    self.clouds  = [NSMutableArray arrayWithCapacity:8];
    self.bgVel = 35;
    int acum=0;
    for(int i=0;i< 9 ;i++){
        SKSpriteNode *cloud = [SKSpriteNode spriteNodeWithImageNamed:@"cloud"];
        cloud.size = CGSizeMake(100, 50);
        int rand = arc4random() %100;
        cloud.position = CGPointMake(acum +rand, [self getRandomNumberBetween:100 to:self.frame.size.height-150]);
        acum+= cloud.size.width +rand;
        cloud.zPosition = -100;
        [self.clouds addObject:cloud ];
        [self addChild:cloud];
    }
    self.physicsWorld.gravity = CGVectorMake(0.0, -5.0);
}

-(void)createGround{
    SKTexture *ground = [SKTexture textureWithImageNamed:@"brick"];
    for(int i=0;i<self.frame.size.width+50;){
        SKSpriteNode *piso = [SKSpriteNode spriteNodeWithTexture:ground];
        //SKSpriteNode *piso = [SKSpriteNode spriteNodeWithImageNamed:@"brick"];
        piso.size = CGSizeMake(30, 30);
        piso.position = CGPointMake(i, 110);
        i+=piso.size.width;
        piso.zPosition =-90;
        [self addChild:piso];
    }
    SKNode *dummy = [SKNode node];
    dummy.position = CGPointMake(self.frame.size.width/2, 110);
    dummy.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:CGSizeMake(self.frame.size.width+(400), 30)];
    dummy.physicsBody.dynamic = NO;
    dummy.physicsBody.categoryBitMask = worldCategory;
    [self addChild:dummy];
    
    for(int i=0;i<self.frame.size.width+50;){
        SKSpriteNode *piso = [SKSpriteNode spriteNodeWithTexture:ground];
        //SKSpriteNode *piso = [SKSpriteNode spriteNodeWithImageNamed:@"brick"];
        piso.size = CGSizeMake(30, 30);
        piso.position = CGPointMake(i, 300);
        i+=piso.size.width;
        piso.zPosition =-90;
        [self addChild:piso];
    }
    dummy = [SKNode node];
    dummy.position = CGPointMake(self.frame.size.width/2, 300);
    dummy.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:CGSizeMake(self.frame.size.width+(400), 30)];
    dummy.physicsBody.dynamic = NO;
    dummy.physicsBody.categoryBitMask = worldCategory;
    [self addChild:dummy];
    
    for(int i=0;i<self.frame.size.width+50;){
        SKSpriteNode *piso = [SKSpriteNode spriteNodeWithTexture:ground];
        //SKSpriteNode *piso = [SKSpriteNode spriteNodeWithImageNamed:@"brick"];
        piso.size = CGSizeMake(30, 30);
        piso.position = CGPointMake(i, 500 );
        i+=piso.size.width;
        piso.zPosition =-90;
        [self addChild:piso];
    }
    dummy = [SKNode node];
    dummy.position = CGPointMake(self.frame.size.width/2, 500);
    dummy.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:CGSizeMake(self.frame.size.width+(400), 30)];
    dummy.physicsBody.dynamic = NO;
    dummy.physicsBody.categoryBitMask = worldCategory;
    [self addChild:dummy];
    
}

-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
    
    if(self.gameOver){
        [self gameEnded];
        return;
    }
    if (_lastUpdateTime) {
        _deltaTime = currentTime - _lastUpdateTime;
    } else {
        _deltaTime = 0;
    }
    _lastUpdateTime = currentTime;

    CGPoint bgVelocity = CGPointMake(-_bgVel, 0.0);
    

    for(SKSpriteNode *cloud in _clouds){
        
        if(cloud.position.x + cloud.size.width < 0){
            cloud.position = CGPointMake(self.frame.size.width + cloud.size.width, [self getRandomNumberBetween:100 to:self.frame.size.height-150]);
        }
        
        CGPoint amtToMove = CGPointMake(bgVelocity.x * _deltaTime, bgVelocity.y * _deltaTime);
        cloud.position = CGPointMake(cloud.position.x+amtToMove.x, cloud.position.y+amtToMove.y);
    }
    
    for(Vidrio* v in self.children) {
        if ([v isKindOfClass:[Vidrio class]]) {
            [v update:currentTime];
        }
    }
    [self.thiefMachine update:currentTime withScene:self];
}

-(void) buttonShow{
    SKLabelNode *restartLabel;
    restartLabel = [[SKLabelNode alloc] initWithFontNamed:@"Futura-CondensedMedium"];
    restartLabel.name = @"restartLabel";
    restartLabel.text = @"Play?";
    restartLabel.scale = 1;
    restartLabel.position = CGPointMake(self.frame.size.width/2, self.frame.size.height * 0.5);
    restartLabel.fontColor = [SKColor yellowColor];
    [self addChild:restartLabel];
    
   // SKAction *labelScaleAction = [SKAction scaleTo:3.0 duration:0.5];
    
    //[restartLabel runAction:labelScaleAction];
}
-(void) startGame{
    self.thiefMachine = [[ThiefMachine alloc] init];
    [self.thiefMachine spawnRandomThiefInScene:self WithSpeed:100];
}
-(void) gameEnded{
    
    [self removeAllActions];

    [self removeAllChildren];
    SKLabelNode *gameOverLabel;
    gameOverLabel= [[SKLabelNode alloc ]initWithFontNamed:@"Arial"];
    gameOverLabel.name = @"gameOverLabel";
    gameOverLabel.text = @ "Game Over";
    gameOverLabel.scale = 3;
    gameOverLabel.position = CGPointMake(self.frame.size.width/2, self.frame.size.height * 0.65);
    gameOverLabel.fontColor = [SKColor redColor];
    [self addChild:gameOverLabel];
    [self buttonShow];
}

@end
