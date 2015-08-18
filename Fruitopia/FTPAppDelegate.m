//
//  FTPAppDelegate.m
//  Fruitopia
//
//  Created by Philippe on 2013-11-02.
//  Copyright (c) 2013 Philippe Casgrain. All rights reserved.
//

#import "FTPAppDelegate.h"
#import "FTPMyScene.h"

@implementation FTPAppDelegate

@synthesize window = _window;

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    /* Pick a size for the scene */
    SKScene *scene = [FTPMyScene sceneWithSize:CGSizeMake(1024, 768)];

    /* Set the scale mode to scale to fit the window */
    scene.scaleMode = SKSceneScaleModeAspectFit;

    [self.skView presentScene:scene];

    self.skView.showsFPS = YES;
    self.skView.showsNodeCount = YES;
}

- (BOOL)applicationShouldTerminateAfterLastWindowClosed:(NSApplication *)sender {
    return YES;
}

@end
