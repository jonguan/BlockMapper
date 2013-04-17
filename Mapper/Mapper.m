//
//  Mapper.m
//  Mapper
//
//  Created by Jonathan.Guan on 4/13/13.
//  Copyright (c) 2013 SlingMedia. All rights reserved.
//

#import "Mapper.h"
@interface Mapper ()

@property (nonatomic, strong) NSMutableDictionary *resultDict;
@property (nonatomic, strong) NSOperationQueue *blockQueue;

@end

@implementation Mapper

- (id)init
{
    self = [super init];
    if (self)
    {
        self.resultDict = [NSMutableDictionary dictionary];
        self.blockQueue = [[NSOperationQueue alloc] init];
    }
    return self;
}

/**
 Main worker
 @param array - input array
 @returns NSDictionary @{ arrayVal : block(arrayVal)}
 */
- (NSDictionary *)resultFromInputArray:(NSArray *)array block:(NSObject *(^)(id<NSCopying>))block
{
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    
    
    NSBlockOperation *mainOp = [[NSBlockOperation alloc] init];
    [mainOp addExecutionBlock:^{
        NSLog(@"finished dict %@", dict);
    }];
   
    
    
    if (array != nil)
    {
        for (id<NSCopying> object in array)
        {

            NSLog(@"new blockop");
            NSBlockOperation *blockOp = [[NSBlockOperation alloc] init];
            [blockOp addExecutionBlock:^{
                NSObject *result = block(object);
                @synchronized(dict)
                {
                    [dict setObject:result forKey:object];
                }
             

            
            }];
            [mainOp addDependency:blockOp];
            
            [self.blockQueue addOperation:blockOp];
        }
    }
    [self.blockQueue addOperation:mainOp];

    [mainOp waitUntilFinished];
    
    
    return dict;
}


@end
