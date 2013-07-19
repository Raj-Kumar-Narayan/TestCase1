//
//  ViewController.m
//  TableViewSearch
//
//  Created by admin on 19/07/13.
//  Copyright (c) 2013 admin. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController
@synthesize tableView;
@synthesize searchText1;




- (void)viewDidLoad
{
    [super viewDidLoad];
    data=[[NSMutableArray alloc]initWithObjects:@"Deepak",@"Farukh",@"Gomcy",@"Nonu",@"Inderpreet",@"Vandna",@"Eva",@"Urmi",@"Tina",@"Yoni",@"Navu",@"Mohan",@"Komal",@"Heena",@"Avneet",@"Arsh",@"Rupesh", nil];
    NSSortDescriptor *sortOrder1 = [NSSortDescriptor sortDescriptorWithKey: @"self" ascending: YES];
    [data sortUsingDescriptors:[NSArray arrayWithObject: sortOrder1]];
    
    [self.view addSubview:tableView];
    copydata=[[NSMutableArray alloc]init];
    self.tableView.tableHeaderView = searchbar;
    searchbar.autocorrectionType = UITextAutocorrectionTypeNo;
    self.navigationItem.title = @"Contacts";
    searching = NO;
    letUserSelectRow = YES;
	// Do any additional setup after loading the view, typically from a nib.
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (searching){
        return [copydata count];
    }
    return [data count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString*CellIdentifier=@"cell";
    UITableViewCell *cell = [tableView  dequeueReusableCellWithIdentifier:CellIdentifier];
    if(searching)
    {
        cell.textLabel.text = [copydata objectAtIndex:indexPath.row];
        // [searchbar resignFirstResponder];
    }
    else if(!searching){
        
        
        if (cell == nil){
            
            cell = [[[UITableViewCell alloc]  initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
            
            cell.selectionStyle = UITableViewCellSelectionStyleGray;
            
            
            cell.accessoryType=UITableViewCellAccessoryDetailDisclosureButton;
        }
        
        
        cell.textLabel.text =[data objectAtIndex: indexPath.row];
    }
    return cell;
    
}
- (void) searchBarTextDidBeginEditing:(UISearchBar *)theSearchBar {
    
    self.navigationItem.title = @"Searching....";
    searching = YES;
    letUserSelectRow = NO;
    self.tableView.scrollEnabled = NO;
    
    //Add the done button.
    self.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc]
                                               initWithBarButtonSystemItem:UIBarButtonSystemItemDone
                                               target:self action:@selector(doneSearching_Clicked:)] autorelease];
}
- (NSIndexPath *)tableView :(UITableView *)theTableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if(letUserSelectRow)
        return indexPath;
    else
        return nil;
}
- (void) searchTableView
{
    
    // searchText1=searchbar.text;
    for (NSString *sTemp in data)
    {
        //NSRange titleResultsRange = [sTemp rangeOfString:searchText options:NSCaseInsensitiveSearch];
        
        /* if([[searchText1 substringToIndex:1] isEqualToString:[sTemp substringToIndex:1]])
         {
         [copydata addObject:sTemp];
         }*/
        NSComparisonResult result = [sTemp compare:searchText1 options:(NSCaseInsensitiveSearch|NSDiacriticInsensitiveSearch) range:NSMakeRange(0, [searchText1 length])];
        if (result == NSOrderedSame)
        {
            [copydata addObject:sTemp];
        }
    }
    
    
}
- (void) doneSearching_Clicked:(id)sender
{
    searchbar.text = @"";
    [searchbar resignFirstResponder];
    letUserSelectRow = YES;
    searching = NO;
    self.navigationItem.title=@"Contacts";
    self.navigationItem.rightBarButtonItem = nil;
    self.tableView.scrollEnabled = YES;
    [searchbar resignFirstResponder];
    [self.tableView reloadData];
}
- (void)searchBar:(UISearchBar *)theSearchBar textDidChange:(NSString *)searchText {
    
    //Remove all objects first.
    [copydata removeAllObjects];
    
    if([searchText length] > 0) {
        
        searching = YES;
        letUserSelectRow = YES;
        self.tableView.scrollEnabled = YES;
        searchText1 =searchText;
        [self searchTableView];
    }
    else {
        
        searching = NO;
        letUserSelectRow = NO;
        self.tableView.scrollEnabled = NO;
    }
    
    [self.tableView reloadData];
}

//- (BOOL)searchBarShouldEndEditing:(UISearchBar *)searchBar
//{
//    [searchbar resignFirstResponder];
//    [searchBar resignFirstResponder];
//    return YES;
//}
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [searchbar resignFirstResponder];
    [searchBar resignFirstResponder];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [tableView release];
    [searchbar release];
    [super dealloc];
}
@end
