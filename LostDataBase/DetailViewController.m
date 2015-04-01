//
//  DetailViewController.m
//  LostDataBase
//
//  Created by Timothy Mueller on 3/31/15.
//  Copyright (c) 2015 Timothy Mueller. All rights reserved.
//

#import "DetailViewController.h"
#import "AppDelegate.h"

@interface DetailViewController ()
@property (strong, nonatomic) IBOutlet UILabel *nameLabel;
@property (strong, nonatomic) IBOutlet UILabel *actorLabel;
@property (strong, nonatomic) IBOutlet UILabel *ageLabel;
@property (strong, nonatomic) IBOutlet UILabel *planeSeatLabel;
@property (strong, nonatomic) IBOutlet UILabel *genderLabel;
@property (strong, nonatomic) IBOutlet UIImageView *imageView;
@property (strong, nonatomic) IBOutlet UITextField *nameTF;
@property (strong, nonatomic) IBOutlet UITextField *actorTF;
@property (strong, nonatomic) IBOutlet UITextField *ageTF;
@property (strong, nonatomic) IBOutlet UITextField *planeSeatTF;
@property (strong, nonatomic) IBOutlet UITextField *genderTF;


@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.nameLabel.text = self.character.name;
    self.actorLabel.text = [self.character.actor isEqualToString:@""] ? @"" : self.character.actor;
    self.planeSeatLabel.text = self.character.planeseat == nil ? @"" : self.character.planeseat;
    self.genderLabel.text = self.character.gender == nil ? @"" : self.character.gender;
    self.ageLabel.text = self.character.age == nil ? @"" : self.character.age;
    self.ageTF.enabled = NO;
    self.nameTF.enabled = NO;
    self.actorTF.enabled = NO;
    self.genderTF.enabled = NO;
    self.planeSeatTF.enabled = NO;
    self.ageTF.text = self.character.age;
    self.nameTF.text = self.character.name;
    self.actorTF.text = self.character.actor;
    self.genderTF.text = self.character.gender;
    self.planeSeatTF.text = self.character.planeseat;
    self.title = self.character.name;
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    self.moc = appDelegate.managedObjectContext;

}

- (IBAction)onEditButtonTapped:(id)sender {
    if (self.nameLabel.alpha == 1) {
        self.nameLabel.alpha = 0;
        self.actorLabel.alpha = 0;
        self.ageLabel.alpha = 0;
        self.planeSeatLabel.alpha = 0;
        self.genderLabel.alpha = 0;
    } else {
        self.nameLabel.alpha = 1;
        self.actorLabel.alpha = 1;
        self.ageLabel.alpha = 1;
        self.planeSeatLabel.alpha = 1;
        self.genderLabel.alpha = 1;
    }
    self.ageTF.enabled = !self.ageTF.enabled;
    self.nameTF.enabled = !self.nameTF.enabled;
    self.actorTF.enabled = !self.actorTF.enabled;
    self.genderTF.enabled = !self.genderTF.enabled;
    self.planeSeatTF.enabled = !self.planeSeatTF.enabled;

    self.character.name = self.nameTF.text;
    self.character.age = self.ageTF.text;
    self.character.actor = self.actorTF.text;
    self.character.planeseat = self.planeSeatTF.text;
    self.character.gender = self.genderTF.text;

    self.title = self.character.name;
    self.nameLabel.text = self.character.name;
    self.actorLabel.text = [self.character.actor isEqualToString:@""] ? @"" : self.character.actor;
    self.planeSeatLabel.text = self.character.planeseat == nil ? @"" : self.character.planeseat;
    self.genderLabel.text = self.character.gender == nil ? @"" : self.character.gender;
    self.ageLabel.text = self.character.age == nil ? @"" : self.character.age;
    [self.moc save:nil];

}



@end
