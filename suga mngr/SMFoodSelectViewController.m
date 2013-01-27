//
//  SMFoodSelectViewController.m
//  suga mngr
//
//  Created by Alexander List on 1/26/13.
//  Copyright (c) 2013 pancreas crew. All rights reserved.
//

#import "SMFoodSelectViewController.h"

@interface SMFoodSelectViewController ()

@end

@implementation SMFoodSelectViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
		self.categoryPrefixes = @[@"b",@"l",@"s",@"d",@"ds"];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) highlightSelectionsByVirtueForCategory:(NSString*)category{
	
}

-(void) resetHighlightsForCategory:(NSString*)category{
	
}

-(NSString*) categoryForImageView:(UIView*)selectedView{
	for (NSString* category in self.categoryPrefixes){
		for (int i =0; i<= 2; i++){
			UIView * selectedView = [self valueForKey:[NSString stringWithFormat:@"%@%iiv",category,i]];
			if (selectedView)
				return category;
		}
		
	}
	
	return nil;
}

- (IBAction)tapHappenedWithRecognizer:(UITapGestureRecognizer *)sender {
	UIView * selectedView = [sender.view hitTest:[sender locationInView:sender.view] withEvent:nil];
	NSString * category = [self categoryForImageView:selectedView];
	if (category){
		[self resetHighlightsForCategory:category];
	}
}


@end
