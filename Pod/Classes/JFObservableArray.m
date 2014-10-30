//
//  JFObservableArray.m
//  JFObservableArray
//
//  Created by Jamie Forrest on 10/29/14.
//  Copyright (c) 2014 Jamie Forrest. All rights reserved.
//

#import "JFObservableArray.h"

static NSString *const JFSelfKey = @"self";

@interface JFObservableArray()

@property (nonatomic, strong) NSMutableArray *objects;

@end

@implementation JFObservableArray

- (instancetype)init
{
    return [self initWithArray:@[]];
}

- (instancetype)initWithArray:(NSArray *)array
{
    self = [super init];
    if (self) {
        self.objects = [array mutableCopy];
    }
    return self;
}

- (NSArray *)objectsCopy
{
    return [self.objects copy];
}

- (void)willChange:(NSKeyValueChange)change index:(NSUInteger)index
{
    NSIndexSet *indexSetForChange = [NSIndexSet indexSetWithIndex:index];
    [self willChange:change valuesAtIndexes:indexSetForChange forKey:JFSelfKey];
}

- (void)didChange
{
    [self didChangeValueForKey:JFSelfKey];
}

- (NSUInteger)count
{
    return self.objects.count;
}

- (NSArray *)objectsMatchingPredicate:(NSPredicate *)predicate
{
    return [self.objects filteredArrayUsingPredicate:predicate];
}

- (id)objectAtIndex:(NSUInteger)index
{
    return [self.objects objectAtIndex:index];
}

- (NSUInteger)indexOfObject:(id)anObject
{
    return [self.objects indexOfObject:anObject];
}

- (void)addObject:(id)anObject
{
    [self willChange:NSKeyValueChangeInsertion index:self.count];
    [self.objects addObject:anObject];
    [self didChange];
}

- (void)removeObject:(id)anObject
{
    [self willChange:NSKeyValueChangeRemoval index:[self.objects indexOfObject:anObject]];
    [self.objects removeObject:anObject];
    [self didChange];
}

- (void)insertObject:(id)anObject atIndex:(NSUInteger)index
{
    [self willChange:NSKeyValueChangeInsertion index:index];
    [self.objects insertObject:anObject atIndex:index];
    [self didChange];
}

- (void)replaceObjectAtIndex:(NSUInteger)index withObject:(id)anObject
{
    [self willChange:NSKeyValueChangeReplacement index:index];
    [self.objects replaceObjectAtIndex:index withObject:anObject];
    [self didChange];
}

@end
