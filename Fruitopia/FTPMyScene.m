//
//  FTPMyScene.m
//  Fruitopia
//
//  Created by Philippe on 2013-11-02.
//  Copyright (c) 2013 Philippe Casgrain. All rights reserved.
//

#import "FTPMyScene.h"

@interface FTPMyScene()

@property (strong) SKSpriteNode *hero;
@property (copy) NSArray *heroWalkingFrames;

@end

@implementation FTPMyScene

- (instancetype)initWithSize:(CGSize)size
{
    if (self = [super initWithSize:size])
    {
        /* Setup your scene here */
        
        self.backgroundColor = [SKColor colorWithRed:0.15 green:0.15 blue:0.3 alpha:1.0];
        
        NSMutableArray *walkFrames = [NSMutableArray array];
        SKTextureAtlas *heroAnimatedAtlas = [SKTextureAtlas atlasNamed:@"HeroImages"];

        NSUInteger numImages = heroAnimatedAtlas.textureNames.count;
        for (NSUInteger i = 1; i <= numImages / 2; i++)
        {
            NSString *textureName = [NSString stringWithFormat:@"hero%zd", i];
            SKTexture *temp = [heroAnimatedAtlas textureNamed:textureName];
            [walkFrames addObject:temp];
        }
        self.heroWalkingFrames = walkFrames;

        SKTexture *temp = self.heroWalkingFrames[0];
        self.hero = [SKSpriteNode spriteNodeWithTexture:temp];
        self.hero.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame));
        [self addChild:self.hero];
    }
    return self;
}

-(void)walkingHero
{
    [self.hero runAction:[SKAction repeatActionForever:[SKAction animateWithTextures:self.heroWalkingFrames
                                                                        timePerFrame:0.1f
                                                                              resize:NO
                                                                             restore:YES]] withKey:@"walkingInPlaceHero"];
}


- (void)mouseUp:(NSEvent *)theEvent
{
    CGPoint location = [theEvent locationInNode:self];
    CGFloat multiplierForDirection;

    CGSize screenSize = self.frame.size;
    float heroVelocity = screenSize.width / 3.0;

    CGPoint moveDifference = CGPointMake(location.x - self.hero.position.x, location.y - self.hero.position.y);
    float distanceToMove = sqrtf(moveDifference.x * moveDifference.x + moveDifference.y * moveDifference.y);
    float moveDuration = distanceToMove / heroVelocity;

    if (moveDifference.x < 0)
    {
        // Walk left
        multiplierForDirection = 1;
    }
    else
    {
        // Walk right
        multiplierForDirection = -1;
    }

    self.hero.xScale = fabs(self.hero.xScale) * multiplierForDirection;


    if ([self.hero actionForKey:@"heroMoving"])
    {
        // Stop just the moving to a new location, but leave the walking legs movement running
        [self.hero removeActionForKey:@"heroMoving"];
    }

    if (![self.hero actionForKey:@"walkingInPlaceHero"])
    {
        // If legs are not moving go ahead and start them
        [self walkingHero];
    }

    SKAction *moveAction = [SKAction moveTo:location duration:moveDuration];
    SKAction *doneAction = [SKAction runBlock:(dispatch_block_t)^() {
        NSLog(@"Animation Completed");
        [self heroMoveEnded];
    }];

    SKAction *moveActionWithDone = [SKAction sequence:@[moveAction,doneAction]];

    [self.hero runAction:moveActionWithDone withKey:@"heroMoving"];
}

-(void)heroMoveEnded
{
    [self.hero removeAllActions];
}

- (void)update:(CFTimeInterval)currentTime
{
    /* Called before each frame is rendered */
}

@end
