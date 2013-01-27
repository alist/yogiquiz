//
//  SMFoodSelectViewController.m
//  suga mngr
//
//  Created by Alexander List on 1/26/13.
//  Copyright (c) 2013 pancreas crew. All rights reserved.
//

#import "SMFoodSelectViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface SMFoodSelectViewController ()

@end

@implementation SMFoodSelectViewController

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
	self.categoryPrefixes = @[@"b",@"l",@"s",@"d",@"ds"];
	self.selectedViewsByCategory = [NSMutableDictionary dictionary];
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



-(BOOL) isCompleted{
	BOOL completed = TRUE;
	for (NSString* category in self.categoryPrefixes){
		if ([self.selectedViewsByCategory valueForKey:category] == nil)
			completed = FALSE;
	}
	return completed;
}

-(void) handleCompletion{
	
	[UIView beginAnimations:@"a" context:nil];
	[UIView setAnimationDuration:.7];
	[UIView setAnimationBeginsFromCurrentState:TRUE];
	
	double borderWidth = 5;
	
	double virtuousity = 1;
	for (NSString* category in self.categoryPrefixes){
		UIView * selectedView = [self.selectedViewsByCategory valueForKey:category];
		
		if (selectedView == self.b1iv){
			virtuousity = virtuousity - .5;
			selectedView.layer.borderColor = [[UIColor redColor] CGColor];
			selectedView.layer.borderWidth = borderWidth;
		}

		if (selectedView == self.l0iv){
			virtuousity = virtuousity - .5;
			selectedView.layer.borderColor = [[UIColor redColor] CGColor];
			selectedView.layer.borderWidth = borderWidth;
		}

		if (selectedView == self.l1iv){
			virtuousity = virtuousity - .3;
			selectedView.layer.borderColor = [[UIColor yellowColor] CGColor];
			selectedView.layer.borderWidth = borderWidth;
		}
		if (selectedView == self.s1iv || selectedView == self.s2iv){
			virtuousity = virtuousity - .3;
			selectedView.layer.borderColor = [[UIColor yellowColor] CGColor];
			selectedView.layer.borderWidth = borderWidth;
		}
		if (selectedView == self.d1iv ){
			virtuousity = virtuousity - .3;
			selectedView.layer.borderColor = [[UIColor yellowColor] CGColor];
			selectedView.layer.borderWidth = borderWidth;
		}

		if (selectedView == self.d2iv){
			virtuousity = virtuousity - .5;
			selectedView.layer.borderColor = [[UIColor redColor] CGColor];
			selectedView.layer.borderWidth = borderWidth;
		}

		if (selectedView == self.ds1iv){
			virtuousity = virtuousity - .7;
			selectedView.layer.borderColor = [[UIColor redColor] CGColor];
			selectedView.layer.borderWidth = borderWidth;
		}
		if (selectedView == self.ds2iv ){
			virtuousity = virtuousity - .3;
			selectedView.layer.borderColor = [[UIColor yellowColor] CGColor];
			selectedView.layer.borderWidth = borderWidth;
		}

	}
	
	[UIView commitAnimations];
	
	if (virtuousity < 0){
		[self.completionOverlayImage setImage:[UIImage imageNamed:@"completion-overlay-fail768x1024.png"]];
	}else{
		[self.completionOverlayImage setImage:[UIImage imageNamed:@"completion-overlay-success768x1024.png"]];

	}
	[UIView animateWithDuration:.2 animations:^{
		[self.completionOverlayImage setAlpha:.8];
	}completion:^(BOOL finished) {
		[UIView animateWithDuration:.5 delay:2 options:UIViewAnimationOptionAllowAnimatedContent|UIViewAnimationOptionBeginFromCurrentState animations:^{
			[self.completionOverlayImage setAlpha:0];
			
		} completion:^(BOOL finished) {
			if (virtuousity >= 0){
				[self performSegueWithIdentifier:@"b" sender: self];
			}else{

			for (NSString* category in self.categoryPrefixes){
				[self resetHighlightsForCategory:category];
			}}}];
		
	}];

}

-(void) resetHighlightsForCategory:(NSString*)category{

	for (int i =0; i<= 2; i++){
		UIView * selectedView = [self valueForKey:[NSString stringWithFormat:@"%@%iiv",category,i]];
		[selectedView.layer setBorderWidth:0];
		[selectedView.layer setBorderColor:[[UIColor blackColor] CGColor]];
		
	}
	[self.selectedViewsByCategory removeObjectForKey:category];
}

-(NSString*) categoryForImageView:(UIView*)selectedView{
	for (NSString* category in self.categoryPrefixes){
		for (int i =0; i<= 2; i++){
			NSString* key = [NSString stringWithFormat:@"%@%iiv",category,i];
			UIView * retreivedView = [self valueForKey:key];
			if (retreivedView == selectedView)
				return category;
		}
		
	}
	
	return nil;
}

- (IBAction)tapHappenedWithRecognizer:(UITapGestureRecognizer *)sender {
	UIView * selectedView = [sender.view hitTest:[sender locationInView:sender.view] withEvent:nil];
	NSString * category = [self categoryForImageView:selectedView];
	if (category){
		UIImageView * iv = (UIImageView*)selectedView;
		[self resetHighlightsForCategory:category];
		
		[self.selectedViewsByCategory setValue:iv forKey:category];
		[iv.layer setBorderWidth:3];
		
		if ([self isCompleted]){
			[self handleCompletion];
		}
		
	}
}


@end
