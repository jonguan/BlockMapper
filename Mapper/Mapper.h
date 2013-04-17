//
//  Mapper.h
//  Mapper
//
//  Created by Jonathan.Guan on 4/13/13.
//  Copyright (c) 2013 SlingMedia. All rights reserved.
//
/*
 Challenge
 The challenge is to write an API and an implementation for concurrently mapping a block to every object in an NSArray. 
 The block is passed a value from the array (at a minimum) and returns an object (the map function in functional programming).   
 Your implementation must generate and return an NSDictionary of the results where every (key, value) pair is such that the key is the original value, and the value is what the block returns given that parameter.
 
 The blocks should be executed in parallel.
 
 Example:
 
 Block: x -> 2*x
 Input Array: [1,5,2]
 Output Dictionary: {1:2, 5:10, 2:4}
 
 Please note that the example is not an indication that the implementation should work only with integers. The API should be generic and work with any NSObject.

 */

#import <Foundation/Foundation.h>

//typedef  NSObject *(^ObjectBlock)(NSObject *object);

@interface Mapper : NSObject

/**
	Main worker
	@param array - input array
	@returns NSDictionary @{ arrayVal : block(arrayVal)}
 */
- (NSDictionary *)resultFromInputArray:(NSArray *)array block:(NSObject *(^)(id <NSCopying>))block;


@end
