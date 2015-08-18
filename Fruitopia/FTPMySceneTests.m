//
//  FTPMySceneTests.m
//  Fruitopia
//
//  Created by Philippe on 2013-11-02.
//  Copyright (c) 2013 Philippe Casgrain. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "FTPMyScene.h"

@interface FTPMySceneTests : XCTestCase

@end

@implementation FTPMySceneTests

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testCreation
{
    FTPMyScene *scene;
    XCTAssertNoThrow(scene = [[FTPMyScene alloc] initWithSize:CGSizeMake(1024, 768)], @"");
    XCTAssertNotNil(scene, @"");
}

@end
