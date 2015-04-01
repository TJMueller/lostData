//
//  DetailViewController.h
//  LostDataBase
//
//  Created by Timothy Mueller on 3/31/15.
//  Copyright (c) 2015 Timothy Mueller. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Character.h"
@interface DetailViewController : UIViewController
@property Character *character;
@property NSManagedObjectContext *moc;
@end
