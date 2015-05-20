/*
 Copyright (C) 2012-2014 Soomla Inc.
 
 Licensed under the Apache License, Version 2.0 (the "License");
 you may not use this file except in compliance with the License.
 You may obtain a copy of the License at
 
 http://www.apache.org/licenses/LICENSE-2.0
 
 Unless required by applicable law or agreed to in writing, software
 distributed under the License is distributed on an "AS IS" BASIS,
 WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 See the License for the specific language governing permissions and
 limitations under the License.
 */

#import "SocialEntity.h"
#import "JSONConsts.h"
#import "SocialUtils.h"

@implementation SocialEntity

@synthesize name, description, ID;

static NSString* TAG = @"SOCIAL SocialEntity";

- (id)init{
    self = [super init];
    if ([self class] == [SocialEntity class]) {
        @throw [NSException exceptionWithName:NSInternalInconsistencyException
                                       reason:@"Error, attempting to instantiate AbstractClass directly." userInfo:nil];
    }
    
    return self;
}

- (id)initWithName:(NSString*)oName andDescription:(NSString*)oDescription andID:(NSString*)oID {
    self = [super init];
    if ([self class] == [SocialEntity class]) {
        @throw [NSException exceptionWithName:NSInternalInconsistencyException
                                       reason:@"Error, attempting to instantiate AbstractClass directly." userInfo:nil];
    }
    
    if (self) {
        self.name = oName;
        self.description = oDescription;
        ID = oID;
    }
    
    return self;
}


- (id)initWithDictionary:(NSDictionary*)dict{
    self = [super init];
    if ([self class] == [SocialEntity class]) {
        @throw [NSException exceptionWithName:NSInternalInconsistencyException
                                       reason:@"Error, attempting to instantiate AbstractClass directly." userInfo:nil];
    }
    
    if (self) {
        self.name = dict[SOCIAL_ENTITY_NAME];
        ID = dict[SOCIAL_ENTITY_ID];
        self.description = dict[SOCIAL_ENTITY_DESCRIPTION] ?: @"";
    }
    
    return self;
}

- (NSDictionary*)toDictionary{
    if (!self.name) {
        self.name = @"";
    }
    if (!self.description) {
        self.description = @"";
    }
    return @{
             SOCIAL_CLASSNAME: [SocialUtils getClassName:self],
             SOCIAL_ENTITY_NAME: self.name,
             SOCIAL_ENTITY_DESCRIPTION: self.description,
             SOCIAL_ENTITY_ID: self.ID
             };
}

- (BOOL)isEqualToSocialEntity:(SocialEntity*)soomlaEntity {
    if (!soomlaEntity) {
        return NO;
    }
    return [self.ID isEqualToString:soomlaEntity.ID];
}

- (id)clone:(NSString*)newId {
    NSMutableDictionary* dict = [NSMutableDictionary dictionaryWithDictionary:[self toDictionary]];
    [dict setObject:newId forKey:SOCIAL_ENTITY_ID];
    
    Class clazz = self.class;
    id obj = NULL;
    
    if (clazz) {
        obj = [[clazz alloc] initWithDictionary:dict];
    } else {
        LogDebug(TAG, ([NSString stringWithFormat:@"Error when trying to close class."]));
    }
    
    return obj;
}

#pragma mark - NSObject

- (BOOL)isEqual:(id)object {
    if (self == object) {
        return YES;
    }
    
    if (![object isKindOfClass:[SocialEntity class]]) {
        return NO;
    }
    
    return [self isEqualToSocialEntity:(SocialEntity *)object];
}

- (NSUInteger)hash {
    return [self.ID hash];
}

@end
