//
//  GameScene.m
//  Vidrios
//
//  Created by Dero on 2016. 5. 26..
//  Copyright (c) 2016년 Dero. All rights reserved.
//

#import "GameScene.h"
#import "FMMParallaxNode.h"

@implementation GameScene
{
    SKSpriteNode *_cloud;
    NSArray *_thiefRunningFrames;
    NSArray *_thiefRunningWithFoward;
    NSArray *_thiefRunningWithBack;
    NSTimeInterval _lastUpdateTime;
    NSTimeInterval _deltaTime;
    SKColor* _skyColor;
    float _bgVel ;
    NSMutableArray *_clouds;
    FMMParallaxNode *_parallaxNodeBackground;
    SKSpriteNode *_thief;
    SKSpriteNode *vidrio;
    SKSpriteNode *_adelante;
    SKSpriteNode *_atras;
    SKTexture *vidrioRoto;
    SKLabelNode *tiempo;
    NSTimer *timer;
    int timeSec ;
    int timeMin ;
}

-(void)didMoveToView:(SKView *)view {
    static const int ladronesCategory =1;
    static const int worldCategory = 2;
    static const int objectsCategory = 4;
    
    /* Setup your scene here */
   // SKLabelNode *myLabel = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
    
   // myLabel.text = @"Hello, World!";
    //myLabel.fontSize = 45;
    //myLabel.position = CGPointMake(CGRectGetMidX(self.frame),
                         //          CGRectGetMidY(self.frame));
    
    //[self addChild:myLabel];
    /*
    NSMutableArray *walkFrames = [NSMutableArray array];
    SKTextureAtlas *bearAnimatedAtlas = [SKTextureAtlas atlasNamed:@"BearImages"];
    int numImages = bearAnimatedAtlas.textureNames.count;
    for (int i=1; i <= numImages; i++) {
        NSString *textureName = [NSString stringWithFormat:@"bear%d", i];
        SKTexture *temp = [bearAnimatedAtlas textureNamed:textureName];
        [walkFrames addObject:temp];
    }
    _bearWalkingFrames = walkFrames;
    
    SKTexture *temp = _bearWalkingFrames[0];
    _bear = [SKSpriteNode spriteNodeWithTexture:temp];
    _bear.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame));
    [self addChild:_bear];
    [self walkingBear];
    */
    
    
    //PERSONAJE Corriendo
    NSMutableArray *runningFrames = [NSMutableArray array];
    SKTextureAtlas *runningAnimatedAtlas = [SKTextureAtlas atlasNamed:@"Sprite"];
    int numImages = 4;
    for(int i=1;i<=numImages ; i++){
        NSString *textureName = [NSString stringWithFormat:@"running%d",i];
        SKTexture * temp = [runningAnimatedAtlas textureNamed:textureName ];
        [runningFrames addObject:temp];
    }
    _thiefRunningFrames = runningFrames;
    
    //Personaje adelante
    NSMutableArray *runningWithFoward = [NSMutableArray array ];
    numImages = 7;
    for(int i=1; i<=numImages ; i++){
        NSString *textureName = [NSString stringWithFormat:@"ladronAdelante%d",i];
        SKTexture *temp = [runningAnimatedAtlas textureNamed:textureName];
        [runningWithFoward addObject:temp];
    }
    _thiefRunningWithFoward = runningWithFoward;
    
    NSMutableArray *runningWithBack = [NSMutableArray array ];
    numImages = 7;
    for(int i=1; i<=numImages ; i++){
        NSString *textureName = [NSString stringWithFormat:@"ladronAtras%d",i];
        SKTexture *temp = [runningAnimatedAtlas textureNamed:textureName];
        [runningWithBack addObject:temp];
    }
    _thiefRunningWithBack = runningWithBack;
    
    SKSpriteNode *atras;
    SKSpriteNode *adelante;
    
    SKTexture *temp = _thiefRunningWithBack[0];
    _thief = [SKSpriteNode spriteNodeWithTexture:temp];
    atras = _thief;
    _thief.position = CGPointMake(200, 250);
    _thief.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:CGSizeMake(_thief.size.width, _thief.size.height-10)];
    _thief.physicsBody.dynamic = YES;
    _thief.physicsBody.allowsRotation = NO;
    _thief.physicsBody.categoryBitMask = ladronesCategory;
    _thief.physicsBody.collisionBitMask = worldCategory;
    _thief.physicsBody.density =1;
    [self addChild:_thief ];
    [self runThief: _thiefRunningWithBack thief:_thief];


    //Vidrio
    SKTexture *v = [SKTexture textureWithImageNamed:@"vidrio"];
    SKSpriteNode *vidrios = [SKSpriteNode spriteNodeWithTexture:v];
    vidrios.position = CGPointMake(atras.position.x+atras.size.width-30,260);
    vidrios.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:CGSizeMake(vidrios.size.width, vidrios.size.height)];
    vidrios.physicsBody.dynamic = YES;
    //vidrios.physicsBody.allowsRotation = NO;
    vidrios.alpha = 0.85;
    vidrios.physicsBody.categoryBitMask = objectsCategory;
    vidrios.physicsBody.collisionBitMask = worldCategory;
    vidrios.name= @"Vidrio";
    vidrio = vidrios;
    [self addChild:vidrios];
    
    //VidrioRoto
    vidrioRoto = [SKTexture textureWithImageNamed:@"vidrioRoto"];
    
    SKTexture *temp2 = _thiefRunningWithFoward[0];
    _thief = [SKSpriteNode spriteNodeWithTexture:temp2];
    adelante = _thief;
    _thief.position = CGPointMake(vidrios.position.x+vidrios.size.width-30 , 250);
    _thief.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:CGSizeMake(_thief.size.width, _thief.size.height-10)];
    _thief.physicsBody.dynamic = YES;
    _thief.physicsBody.allowsRotation = NO;
    _thief.physicsBody.categoryBitMask = ladronesCategory;
    _thief.physicsBody.collisionBitMask = worldCategory;
    _thief.physicsBody.density =1;
    _adelante = _thief;
    [self addChild:_thief ];
    [self runThief:_thiefRunningWithFoward thief:_thief];
    
    SKTexture *temp3 = _thiefRunningFrames[0];
    _thief = [SKSpriteNode spriteNodeWithTexture:temp3];
    _thief.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame));
    _thief.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:CGSizeMake(_thief.size.width, _thief.size.height)];
    _thief.physicsBody.dynamic = YES;
    _thief.physicsBody.allowsRotation = NO;

    _thief.physicsBody.categoryBitMask = ladronesCategory;
    _thief.physicsBody.collisionBitMask = worldCategory;
    [self addChild:_thief ];
    [self runThief:_thiefRunningFrames thief:_thief];
   
        _atras = atras;
    
    
    
     CGPoint anchor = CGPointMake(atras.position.x + atras.size.width/2, atras.position.y);
    SKPhysicsJointFixed *pin = [SKPhysicsJointFixed jointWithBodyA:vidrios.physicsBody bodyB:atras.physicsBody anchor:anchor];
    [self.physicsWorld addJoint:pin];
    anchor = CGPointMake(vidrios.position.x + vidrios.size.width/2, vidrios.position.y);
    pin = [SKPhysicsJointFixed jointWithBodyA:vidrios.physicsBody bodyB:adelante.physicsBody anchor:anchor];
    [self.physicsWorld addJoint:pin];
    
    
    SKTexture *ground = [SKTexture textureWithImageNamed:@"brick"];
    for(int i=0;i<self.frame.size.width+50;){
        SKSpriteNode *piso = [SKSpriteNode spriteNodeWithTexture:ground];
        //SKSpriteNode *piso = [SKSpriteNode spriteNodeWithImageNamed:@"brick"];
        piso.size = CGSizeMake(30, 30);
        piso.position = CGPointMake(i, 110);
        i+=piso.size.width;
        piso.zPosition =-90;        [self addChild:piso];
    }
    
    for(int i=0;i<self.frame.size.width+50;){
        SKSpriteNode *piso = [SKSpriteNode spriteNodeWithTexture:ground];
        //SKSpriteNode *piso = [SKSpriteNode spriteNodeWithImageNamed:@"brick"];
        piso.size = CGSizeMake(30, 30);
        piso.position = CGPointMake(i, 300);
        i+=piso.size.width;
        piso.zPosition =-90;
        [self addChild:piso];
    }

    
    for(int i=0;i<self.frame.size.width+50;){
        SKSpriteNode *piso = [SKSpriteNode spriteNodeWithTexture:ground];
        //SKSpriteNode *piso = [SKSpriteNode spriteNodeWithImageNamed:@"brick"];
        piso.size = CGSizeMake(30, 30);
        piso.position = CGPointMake(i, 500 );
        i+=piso.size.width;
        piso.zPosition =-90;
        [self addChild:piso];
    }
    
    //Agrego fisica al piso
    SKNode *dummy = [SKNode node];
    dummy.position = CGPointMake(self.frame.size.width/2, 110);
    dummy.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:CGSizeMake(self.frame.size.width, 30)];
    dummy.physicsBody.dynamic = NO;
    dummy.physicsBody.categoryBitMask = worldCategory;
    [self addChild:dummy];
    
    //Cambiando de gravedad
    self.physicsWorld.gravity = CGVectorMake(0.0, -5.0);
    
    //tiempo
    /*
     CGRect frame = myLabel.frame;
     frame.origin.y=10;//pass the cordinate which you want
     frame.origin.x= 12;//pass the cordinate which you want
     myLabel.frame= frame;
     self.myLabel = [SKLabelNode labelNodeWithFontNamed:@"Arial"];
     self.myLabel.text = @"Drag this label";
     self.myLabel.fontSize = 20;
     self.myLabel.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame));
     */
    
    
    tiempo = [SKLabelNode labelNodeWithFontNamed:@"Arial"];
    tiempo.text =@"00:00";
    tiempo.fontSize = 20;
    tiempo.position = CGPointMake(CGRectGetMaxX(self.frame)-50 , CGRectGetMaxY(self.frame)-150);
    timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timerTick:) userInfo:nil repeats:YES];
    tiempo.zPosition = 1;
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSDefaultRunLoopMode];
    [self addChild:tiempo];
    timeSec =0;
    timeMin=0;
    
    
    //Color del fondo
    _skyColor = [SKColor colorWithRed:113.0/255.0 green:197.0/255.0 blue:207.0/255.0 alpha:1.0];
    [self setBackgroundColor:_skyColor];
    
    SKSpriteNode *buildings = [SKSpriteNode spriteNodeWithImageNamed:@"buildings"];
    buildings.size = CGSizeMake(self.frame.size.width, CGRectGetMidY(self.frame));
    buildings.position = CGPointMake(0, 0);
    buildings.anchorPoint = CGPointMake(0, 0);
    buildings.zPosition =-95;
    buildings.yScale +=1;
    [self addChild:buildings];
    
    //Agregando las nubes
    
    _clouds  = [NSMutableArray arrayWithCapacity:8];
    _bgVel = 35;
    int acum=0;
    for(int i=0;i< 9 ;i++){
        _cloud = [SKSpriteNode spriteNodeWithImageNamed:@"cloud"];
        _cloud.size = CGSizeMake(100, 50);
        int rand = arc4random() %100;
        _cloud.position = CGPointMake(acum +rand, [self getRandomNumberBetween:100 to:self.frame.size.height-150]);
        acum+= _cloud.size.width +rand;
        _cloud.zPosition = -100;
        [_clouds addObject:_cloud ];
        [self addChild:_cloud];
    }
    
    
   // NSArray *parallaxBackground = @[@"cloud@2x.png",@"cloud@2x.png",@"cloud@2x.png",@"cloud@2x.png",@"cloud@2x.png",@"cloud@2x.png",@"cloud@2x.png",@"cloud@2x.png",@"cloud@2x.png"];
   // CGSize cloudSize = CGSizeMake(100, 50);
   // _parallaxNodeBackground = [[FMMParallaxNode alloc] initWithBackgrounds:parallaxBackground size:cloudSize pointsPerSecondSpeed:25.0 frameSize:self.frame.size];
    //_parallaxNodeBackground.position = CGPointMake(0, 0);
    //[_parallaxNodeBackground randomizeNodesPositions];
    //[self addChild:_parallaxNodeBackground];
    
    
   
    
    
}
-(void)runThief:(NSArray*)arr thief:(SKSpriteNode*)thief {
    [thief runAction:[SKAction repeatActionForever:
                      [SKAction animateWithTextures:arr
                                       timePerFrame:0.1f
                                             resize:NO
                                            restore:YES]] withKey:@"runningInPlace"];
    return;
}


-(int)getRandomNumberBetween:(int)from to:(int)to {
    
    return (int)from + arc4random() % (to-from+1);
}

- (void)timerTick:(NSTimer *)timer
{
    timeSec++;
    if (timeSec == 60)
    {
        timeSec = 0;
        timeMin++;
    }
    NSLog(@"A");
    //Format the string 00:00
    NSString* timeNow = [NSString stringWithFormat:@"%02d:%02d", timeMin, timeSec];
    //Display on your label
    //[timeLabel setStringValue:timeNow];
    [tiempo setText:timeNow];
}

- (void) StopTimer
{
    [timer invalidate];
    timeSec = 0;
    timeMin = 0;
    //Since we reset here, and timerTick won't update your label again, we need to refresh it again.
    //Format the string in 00:00
    NSString* timeNow = [NSString stringWithFormat:@"%02d:%02d", timeMin, timeSec];
    //Display on your label
    // [timeLabel setStringValue:timeNow];
    tiempo.text= timeNow;
}

// Add these new methods
-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    
    }

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch * touch = [touches anyObject];
    CGPoint location = [touch locationInNode:self];
    SKNode *node = [self nodeAtPoint:location];
    if([node.name isEqualToString:@"Vidrio"]){
        NSLog(@"Toque el vidrio");
        //SKAction* changeFace = [SKAction setTexture:[SKTexture textureWithImageNamed:@"vidrioRoto"]];
        //[vidrio runAction:changeFace];
        vidrio.texture = [SKTexture textureWithImageNamed:@"vidrioRoto"];
        [self runThief:_thiefRunningFrames thief:_atras];
        [self runThief:_thiefRunningFrames thief:_adelante ];
        [self.physicsWorld removeAllJoints];
        
    }
}

-(void)bearMoveEnded
{

}

-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
    if (_lastUpdateTime) {
        _deltaTime = currentTime - _lastUpdateTime;
    } else {
        _deltaTime = 0;
    }
    _lastUpdateTime = currentTime;
    
    //_thief.physicsBody.velocity = CGVectorMake(0, 0.5);
   //[_thief.physicsBody applyImpulse:CGVectorMake(5, 0)];
    [_atras.physicsBody applyImpulse:CGVectorMake(7, 0)];
    [_adelante.physicsBody applyImpulse:CGVectorMake(7, 0)];
    
    CGPoint bgVelocity = CGPointMake(-_bgVel, 0.0);
    

    for(SKSpriteNode *cloud in _clouds){
        
        if(cloud.position.x + cloud.size.width < 0){
            cloud.position = CGPointMake(self.frame.size.width + cloud.size.width, [self getRandomNumberBetween:100 to:self.frame.size.height-150]);
        }
        
        CGPoint amtToMove = CGPointMake(bgVelocity.x * _deltaTime, bgVelocity.y * _deltaTime);
        cloud.position = CGPointMake(cloud.position.x+amtToMove.x, cloud.position.y+amtToMove.y);
    }
    
    
}

@end
