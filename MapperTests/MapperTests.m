//
//  MapperTests.m
//  MapperTests
//
//  Created by Jonathan.Guan on 4/13/13.
//  Copyright (c) 2013 SlingMedia. All rights reserved.
//

#import "MapperTests.h"
#import "Mapper.h"

@implementation MapperTests

- (void)setUp
{
    [super setUp];
    
    // Set-up code here.
    self.mapper = [[Mapper alloc] init];
}

- (void)tearDown
{
    // Tear-down code here.
    
    [super tearDown];
}

- (void)testNumbers
{
    NSArray *array = @[@1, @2, @3, @5, @8];
    NSObject *(^mapBlock)(NSNumber *) = ^(NSNumber *num){ return @(num.intValue * 2); };
    
    NSDictionary *result = [self.mapper resultFromInputArray:array block:mapBlock];
    
    NSLog(@"result is %@", result);
    STAssertNotNil(result, @"result should not be nil");
    STAssertEqualObjects([result objectForKey:@1], @2, @"result incongruent");
}

- (void)testStrings
{
    NSArray *strings = @[@"foo", @"bar", @"baz", @"jon", @"wow"];
    NSObject *(^mapBlock)(NSString *) = ^(NSString *str){ return [NSString stringWithFormat:@"%@ %@", str, str]; };
    
    NSDictionary *result = [self.mapper resultFromInputArray:strings block:mapBlock];
    
    NSLog(@"result is %@", result);
    STAssertNotNil(result, @"result should not be nil");
    STAssertEqualObjects([result objectForKey:@"jon"], @"jon jon", @"result incongruent");
}

@end
