//
//  SMFoodSelect2ViewController.m
//  suga mngr
//
//  Created by Alexander List on 1/27/13.
//  Copyright (c) 2013 pancreas crew. All rights reserved.
//

#import "SMFoodSelect2ViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface SMFoodSelect2ViewController ()

@end

@implementation SMFoodSelect2ViewController
@synthesize autoSelectedKeys;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
	self.autoSelectedKeys = @[@"l0iv",@"s2iv"];
	
	[self autoSelectRequired];
}

-(void)autoSelectRequired{
	for (NSString * key in self.autoSelectedKeys){
		UIView * retreivedView = [self valueForKey:key];

		assert(key.length == 4); //otherwise this will fail, it's a hack
		[self.selectedViewsByCategory setValue:retreivedView forKey:[key substringToIndex:1]];
		[retreivedView.layer setBorderWidth:8];

	}
}

-(void)resetHighlightsForCategory:(NSString *)category{
	[super resetHighlightsForCategory:category];
	[self autoSelectRequired];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
