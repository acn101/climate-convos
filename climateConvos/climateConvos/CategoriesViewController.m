//
//  CategoriesViewController.m
//  climateConvos
//
//  Created by Sandra Le on 4/11/18.
//  Copyright © 2018 acn96. All rights reserved.
//

#import "CategoriesViewController.h"
#import "ArticlesViewController.h"
#import "CustomTableViewCell.h"


@interface CategoriesViewController ()

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSArray *categories;
@property (strong, nonatomic) NSString *categoryForArticleVC;


@end

@implementation CategoriesViewController

- (void)setup
{
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.layer.cornerRadius = 11;
    self.tableView.layer.masksToBounds = YES;
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.categories = [NSArray arrayWithObjects:@"Agriculture", @"Energy", @"Extreme weather", @"Health", @"Legislation", @"Water", @"Wildlife", nil];
}

#pragma mark - table view delegate and data source methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return self.categories.count;
    } else {
        return 0;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    CustomTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    /*UIImageView *myImageView = (UIImageView *)[cell viewWithTag:2];
    myImageView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"category_body"]];*/
    cell.category.text = [self.categories objectAtIndex:indexPath.row];
    cell.background.layer.cornerRadius = 11;
    cell.background.layer.masksToBounds = YES;
    cell.backgroundColor = [UIColor clearColor];
    cell.contentView.backgroundColor = [UIColor clearColor];
    
    
   // cell.layer.cornerRadius = 11;
    //cell.layer.masksToBounds = YES;
    return cell;
    
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.categoryForArticleVC = self.categories[indexPath.row];
    [self performSegueWithIdentifier:@"articleSegue" sender:self];
    
}

#pragma mark - inherited methods
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setup];
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSLog(@"prep for segue");
    ArticlesViewController *articleVC = segue.destinationViewController;
    articleVC.selectedCategory = self.categoryForArticleVC;
}


@end
