//
//  ViewController.m
//  LostDataBase
//
//  Created by Timothy Mueller on 3/31/15.
//  Copyright (c) 2015 Timothy Mueller. All rights reserved.
//

#import "ViewController.h"
#import "AppDelegate.h"
#import "Character.h"
#import "DetailViewController.h"

@interface ViewController () <UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>
@property (strong, nonatomic) IBOutlet UITableView *characterTableView;

@property NSManagedObjectContext *moc;
@property (strong, nonatomic) IBOutlet UITextField *addTextField;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *addButton;
@property NSArray *characters;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.addTextField.delegate = self;
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    self.moc = appDelegate.managedObjectContext;
    [self load];
    if (self.characters.count == 0) {
        [self loadpList];
    }
}

-(IBAction)addWarrior:(id)sender{

    if ([self.addTextField.text isEqualToString:@""]) {
        [self.addTextField endEditing:YES];
    } else {
        [Character itemWithName:self.addTextField.text age:nil actor:nil gender:nil seat:nil inManagedObjectContext:self.moc];
        self.addTextField.text = @"";
        [self.addTextField endEditing:YES];
        [self.moc save:nil];
        [self load];
    }
}

-(void)viewWillAppear:(BOOL)animated {
    [self load];
}

-(void)load{
    NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:@"Character"];
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc]initWithKey:@"name" ascending:YES selector:@selector(caseInsensitiveCompare:)];
//    NSSortDescriptor *sortDescriptorTwo = [[NSSortDescriptor alloc]initWithKey:@"prowess" ascending:YES];
    //if (self.toggled) {
//        request.predicate = [NSPredicate predicateWithFormat:@"prowess >=5"];
   // } else {
      //  request.predicate = [NSPredicate predicateWithFormat:@"prowess <=5"];

    //}
    request.sortDescriptors = @[sortDescriptor];
    self.characters = [self.moc executeFetchRequest:request error:nil];
    [self.characterTableView reloadData];
}

#pragma mark - Tableview Delegates

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.characters.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    Character *character = self.characters[indexPath.row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CellID"];
    cell.textLabel.text = character.name;
    if (character.actor == nil) {
        cell.detailTextLabel.text = @"";
    }else {
        cell.detailTextLabel.text = character.actor;
        //[[character valueForKey:@"actor"]stringValue];
    }
    return cell;
}

-(NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath{
    return @"Smoke Monster";
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        NSMutableArray *editingArray = [[NSMutableArray alloc]initWithArray:self.characters];
        [editingArray removeObjectAtIndex:indexPath.row];
        [self.moc deleteObject:self.characters[indexPath.row]];
        self.characters = editingArray;
        [self.characterTableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationLeft];
        [self.characterTableView reloadData];
        [self.moc save:nil];
    }
}

#pragma mark - Segue

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    DetailViewController *dvc = segue.destinationViewController;
    dvc.character = [self.characters objectAtIndex:[self.characterTableView indexPathForCell:(UITableViewCell *)sender].row];
    dvc.moc = self.moc;
}


#pragma mark - Default plist Load


-(void)loadpList{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"lost" ofType:@"plist"];
    NSArray *defaultArray = [[NSArray alloc]initWithContentsOfFile:path];
    for (NSDictionary *dictionary in defaultArray) {
        [Character itemWithName:[dictionary objectForKey:@"passenger"] age:nil actor:[dictionary objectForKey:@"actor"] gender:nil seat:nil inManagedObjectContext:self.moc];
        [self.moc save:nil];
        [self.characterTableView reloadData];
    }
}


@end
