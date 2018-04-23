//
//  CategoriesViewController.m
//  climateConvos
//
//  Created by Sandra Le on 4/11/18.
//  Copyright © 2018 acn96. All rights reserved.
//

#import "CategoriesViewController.h"
#import "ArticlesViewController.h"


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
    self.categories = [NSArray arrayWithObjects:@"agriculture", @"energy", @"extreme weather", @"health", @"legislation", @"water", @"wildlife", nil];
}

#pragma mark - table view delegate and data source methods
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return self.categories.count;
    } else {
        return 0;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    UILabel *categoryLabel = [cell viewWithTag:1];
    categoryLabel.text = self.categories[indexPath.row];
    
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
