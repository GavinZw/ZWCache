//
//  ZWCache.m
//  SkyCommon
//
//  Created by Gavin on 2017/7/28.
//  Copyright © 2017年 北京我的天科技有限公司. All rights reserved.
//
#import <CommonCrypto/CommonDigest.h>
#import "ZWCache.h"

#if __has_include(<YYKit/YYKit.h>)
#import <YYKit/YYKit.h>

#elif __has_include(<YYCache/YYCache.h>)
#import <YYCache/YYCache.h>

#else
#import "YYCache.h"
#endif

static YYCache *_YYCache = nil;
static NSString *const cachePathBase = @"com.imysky.ZWCache";

@implementation ZWCache

+ (YYCache *)cache{
  if (!_YYCache) {
    _YYCache = [[YYCache alloc] initWithName:[ZWCache _cachePathName:@"default_db"]];
  }
  return _YYCache;
}

#pragma makr -
#pragma makr - public

// TODO: contains

+ (BOOL)containsObjectForKey:(NSString *)key{
  return [[ZWCache cache] containsObjectForKey:[ZWCache _cachedFileNameForKey:key]];
}

+ (void)containsObjectForKey:(NSString *)key withBlock:(nullable void(^)(NSString *key, BOOL contains))block{
  [[ZWCache cache] containsObjectForKey:[ZWCache _cachedFileNameForKey:key] withBlock:block];
}


// TODO: get

+ (nullable id<NSCoding>)objectForKey:(NSString *)key{
    return [[ZWCache cache] objectForKey:[ZWCache _cachedFileNameForKey:key]];
}

+ (void)objectForKey:(NSString *)key withBlock:(nullable void(^)(NSString *key, id<NSCoding> object))block{
  [[ZWCache cache] objectForKey:[ZWCache _cachedFileNameForKey:key] withBlock:block];
}


// TODO: set

+ (void)setObject:(nullable id<NSCoding>)object forKey:(NSString *)key{
   [[ZWCache cache] setObject:object forKey:[ZWCache _cachedFileNameForKey:key]];
}

+ (void)setObject:(nullable id<NSCoding>)object forKey:(NSString *)key withBlock:(nullable void(^)(void))block{
   [[ZWCache cache] setObject:object forKey:[ZWCache _cachedFileNameForKey:key] withBlock:block];
}


// TODO: remove

+ (void)removeObjectForKey:(NSString *)key{
   [[ZWCache cache] removeObjectForKey:[ZWCache _cachedFileNameForKey:key]];
}

+ (void)removeObjectForKey:(NSString *)key withBlock:(nullable void(^)(NSString *key))block{
   [[ZWCache cache] removeObjectForKey:[ZWCache _cachedFileNameForKey:key] withBlock:block];
}

+ (void)removeAllObjects{
  [[ZWCache cache] removeAllObjects];
}

+ (void)removeAllObjectsWithBlock:(void(^)(void))block{
   [[ZWCache cache] removeAllObjectsWithBlock:block];
}

+ (void)removeAllObjectsWithProgressBlock:(nullable void(^)(int removedCount, int totalCount))progress
                                 endBlock:(nullable void(^)(BOOL error))end{
  [[ZWCache cache] removeAllObjectsWithProgressBlock:progress endBlock:end];
}

#pragma makr -
#pragma makr - private

/**
 *  设置缓存路径
 *
 *  @param name 路径文件夹的名称
 */
+ (NSString *)_cachePathName:(NSString *)name{
  NSString *cachePath = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).firstObject;
  cachePath = [cachePath stringByAppendingPathComponent:cachePathBase];
  cachePath = [cachePath stringByAppendingPathComponent:name];
  return [ZWCache _cachedFileNameForKey:cachePath];
}

+ (NSString *)_cachedFileNameForKey:(NSString *)key {
  const char *str = key.UTF8String;
  if (str == NULL) {
    str = "";
  }
  unsigned char r[CC_MD5_DIGEST_LENGTH];
  CC_MD5(str, (CC_LONG)strlen(str), r);
  NSString *filename = [NSString stringWithFormat:@"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%@",
                        r[0], r[1], r[2], r[3], r[4], r[5], r[6], r[7], r[8], r[9], r[10],
                        r[11], r[12], r[13], r[14], r[15], [key.pathExtension isEqualToString:@""] ? @"" : [NSString stringWithFormat:@".%@", key.pathExtension]];
  return filename;
}

@end
