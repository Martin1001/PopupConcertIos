//
//  CollectionViewController.m
//  test123
//
//  Created by Shay Finkelstein on 12/3/16.
//  Copyright © 2016 Shay Finkelstein. All rights reserved.
//

#import "CollectionViewController.h"
#import "ViewController.h"

@interface CollectionViewController (){
    int _itemsPerRow;
}

@property (nonatomic,strong) NSArray * shows;
@end

@implementation CollectionViewController

static NSString * const reuseIdentifier = @"Shay";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"data" ofType:@"json"];
    NSString *myJSON = [[NSString alloc] initWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:NULL];

    NSArray *result = [NSJSONSerialization JSONObjectWithData:[myJSON dataUsingEncoding:NSUTF8StringEncoding] options:0 error:nil];

    
    self.title = [NSString stringWithFormat:@"%@ Shows",_genre];
    
    
    NSMutableArray * res = [NSMutableArray new];
    
    for (NSDictionary * dic in result) {
        NSString * dicGenre = dic[@"genre"];
        if ([dicGenre caseInsensitiveCompare:_genre] == 0){
        
            [res addObject:dic];
        }
        
    }
    
    
    
    
    self.shows = res;

    
    _itemsPerRow = 3;
    
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"logo_small"]]];
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Do any additional setup after loading the view.
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    return CGSizeMake(180.0f,180.0f);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(15.0f,15.0f,15.0f,15.0f);
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation
//
// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    NSArray * paths = [self.collectionView indexPathsForSelectedItems];
    NSIndexPath * path = paths[0];
    
    
    NSDictionary * show = self.shows[path.row];
    ViewController * viewController = segue.destinationViewController;
    
    viewController.theShow = show;
}


#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _shows.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    
    
    NSDictionary * show = _shows[indexPath.row];
    
    UIImageView * imageView = [cell.contentView viewWithTag:100];
    NSString * picture = show[@"performer"][@"picture"];
    picture = [picture stringByReplacingOccurrencesOfString:@".jpg" withString:@""];
    imageView.image = [UIImage imageNamed:picture];
    
    UILabel * mainLabel = [cell.contentView viewWithTag:101];
    
    mainLabel.text = show[@"performer"][@"name"];
    
    UILabel * subLabel = [cell.contentView viewWithTag:102];
    
    subLabel.text = show[@"gigname"];
    
    UILabel * location = [cell.contentView viewWithTag:103];
    
    location.text = [NSString stringWithFormat:@"%@ %@",show[@"location"][@"name"],show[@"time"]];
    
    location.numberOfLines = 2;
    // Configure the cell
    
    return cell;
}

#pragma mark <UICollectionViewDelegate>

/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/

/*
// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
*/

/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}
*/

@end
