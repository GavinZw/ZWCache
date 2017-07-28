//
//  ZWCache.h
//  SkyCommon
//
//  Created by Gavin on 2017/7/28.
//  Copyright © 2017年 北京我的天科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

__attribute__((objc_subclassing_restricted))
@interface ZWCache : NSObject

#pragma makr - contains

/**
 Returns a boolean value that indicates whether a given key is in cache.
 This method may blocks the calling thread until file read finished.
 
 @param key A string identifying the value. If nil, just return NO.
 @return Whether the key is in cache.
 */
+ (BOOL)containsObjectForKey:(NSString *)key;

/**
 Returns a boolean value with the block that indicates whether a given key is in cache.
 This method returns immediately and invoke the passed block in background queue
 when the operation finished.
 
 @param key   A string identifying the value. If nil, just return NO.
 @param block A block which will be invoked in background queue when finished.
 */
+ (void)containsObjectForKey:(NSString *)key withBlock:(nullable void(^)(NSString *key, BOOL contains))block;

#pragma makr - get

/**
 Returns the value associated with a given key.
 This method may blocks the calling thread until file read finished.
 
 @param key A string identifying the value. If nil, just return nil.
 @return The value associated with key, or nil if no value is associated with key.
 */
+ (nullable id<NSCoding>)objectForKey:(NSString *)key;

/**
 Returns the value associated with a given key.
 This method returns immediately and invoke the passed block in background queue
 when the operation finished.
 
 @param key A string identifying the value. If nil, just return nil.
 @param block A block which will be invoked in background queue when finished.
 */
+ (void)objectForKey:(NSString *)key withBlock:(nullable void(^)(NSString *key, id<NSCoding> object))block;

#pragma makr - set

/**
 Sets the value of the specified key in the cache.
 This method may blocks the calling thread until file write finished.
 
 @param object The object to be stored in the cache. If nil, it calls `removeObjectForKey:`.
 @param key    The key with which to associate the value. If nil, this method has no effect.
 */
+ (void)setObject:(nullable id<NSCoding>)object forKey:(NSString *)key;

/**
 Sets the value of the specified key in the cache.
 This method returns immediately and invoke the passed block in background queue
 when the operation finished.
 
 @param object The object to be stored in the cache. If nil, it calls `removeObjectForKey:`.
 @param block  A block which will be invoked in background queue when finished.
 */
+ (void)setObject:(nullable id<NSCoding>)object forKey:(NSString *)key withBlock:(nullable void(^)(void))block;

#pragma makr - remove

/**
 Removes the value of the specified key in the cache.
 This method may blocks the calling thread until file delete finished.
 
 @param key The key identifying the value to be removed. If nil, this method has no effect.
 */
+ (void)removeObjectForKey:(NSString *)key;

/**
 Removes the value of the specified key in the cache.
 This method returns immediately and invoke the passed block in background queue
 when the operation finished.
 
 @param key The key identifying the value to be removed. If nil, this method has no effect.
 @param block  A block which will be invoked in background queue when finished.
 */
+ (void)removeObjectForKey:(NSString *)key withBlock:(nullable void(^)(NSString *key))block;

/**
 Empties the cache.
 This method may blocks the calling thread until file delete finished.
 */
+ (void)removeAllObjects;

/**
 Empties the cache.
 This method returns immediately and invoke the passed block in background queue
 when the operation finished.
 
 @param block  A block which will be invoked in background queue when finished.
 */
+ (void)removeAllObjectsWithBlock:(void(^)(void))block;

/**
 Empties the cache with block.
 This method returns immediately and executes the clear operation with block in background.
 
 @warning You should not send message to this instance in these blocks.
 @param progress This block will be invoked during removing, pass nil to ignore.
 @param end      This block will be invoked at the end, pass nil to ignore.
 */
+ (void)removeAllObjectsWithProgressBlock:(nullable void(^)(int removedCount, int totalCount))progress
                                 endBlock:(nullable void(^)(BOOL error))end;


@end

@interface ZWCache (Unavailable)

- (instancetype)init NS_UNAVAILABLE;
+ (instancetype)new NS_UNAVAILABLE;

@end

NS_ASSUME_NONNULL_END

