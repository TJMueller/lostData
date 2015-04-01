//
//  Character.m
//  LostDataBase
//
//  Created by Timothy Mueller on 3/31/15.
//  Copyright (c) 2015 Timothy Mueller. All rights reserved.
//

#import "Character.h"


@implementation Character

@dynamic name;
@dynamic age;
@dynamic planeseat;
@dynamic gender;
@dynamic actor;
@dynamic image;


+ (Character *)itemWithName:(NSString *)characterName age:(NSString *)characterAge actor:(NSString *)characterActor gender:(NSString *)characterGender seat:(NSString *)planeSeat inManagedObjectContext:(NSManagedObjectContext *)context {

    Character * item = (Character *)[NSEntityDescription insertNewObjectForEntityForName:@"Character" inManagedObjectContext:context];
    item.name = characterName;
    item.age = characterAge;
    item.planeseat = planeSeat;
    item.gender = characterGender;
    item.actor = characterActor;
    item.image = nil;
    return item;
}

@end
