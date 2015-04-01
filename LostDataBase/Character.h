//
//  Character.h
//  LostDataBase
//
//  Created by Timothy Mueller on 3/31/15.
//  Copyright (c) 2015 Timothy Mueller. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Character : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * gender;
@property (nonatomic, retain) NSString * age;
@property (nonatomic, retain) NSString * planeseat;
@property (nonatomic, retain) NSString * actor;
@property (nonatomic, retain) NSData * image;


+ (Character *)itemWithName:(NSString *)characterName age:(NSString *)characterAge actor:(NSString *)characterActor gender:(NSString *)characterGender seat:(NSString *)planeSeat inManagedObjectContext:(NSManagedObjectContext *)context;


@end
