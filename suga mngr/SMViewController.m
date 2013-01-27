//
//  SMViewController.m
//  suga mngr
//
//  Created by Alexander List on 1/26/13.
//  Copyright (c) 2013 pancreas crew. All rights reserved.
//

#import "SMViewController.h"
#import <QuartzCore/QuartzCore.h>
#import <AudioToolbox/AudioToolbox.h>

@interface SMViewController ()

@end

@implementation SMViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.

//	SystemSoundID criticalErrorSound = 0;
//	NSString* sndpath = [[NSBundle mainBundle] pathForResource:@"glass_shatter" ofType:@"wav" inDirectory:@"/"];
//	CFURLRef baseURL = (__bridge CFURLRef)[[NSURL alloc] initFileURLWithPath:sndpath];
//	AudioServicesCreateSystemSoundID (baseURL, &criticalErrorSound);
//
//	AudioServicesPlaySystemSound (criticalErrorSound);


	[UIView animateWithDuration:.5 delay:.1 options:UIViewAnimationOptionAutoreverse|UIViewAnimationOptionAllowUserInteraction|UIViewAnimationOptionRepeat|UIViewAnimationOptionAllowAnimatedContent animations:^{
		
		self.taptapImageView.transform = CGAffineTransformMakeRotation(.2);
	}completion:^(BOOL finished) {
		
	}];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)touchGestureRecognizerRecognized:(UITapGestureRecognizer*)sender {
	if ([sender state]==UIGestureRecognizerStateRecognized){
		switch (self.gameState){
			case introStateSleeping:
			case introStateAwake:
			case introStateWaitingAfterHello:
			case introStateWaitingAfterGamePurpose:
			case introStateWaitingAfterGameInstructions:
			case introStateReadyAsk:
				[self advanceGameState];
				break;
				
			
			default:
				//nothin
				break;
		}
	}
}

-(void) performStateAnimate{
	[UIView animateWithDuration:.3 delay:0 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
		[self.taptapImageView setAlpha:0];
	} completion:nil];
	
	
	NSLog(@"%i",self.gameState);
	if (self.gameState == introStateWaking){
		[UIView animateWithDuration:.3 delay:.1 options:UIViewAnimationOptionAllowAnimatedContent|UIViewAnimationOptionAllowUserInteraction animations:^{
			self.mentorImageView.transform = CGAffineTransformMakeRotation(.32);
		} completion:^(BOOL finished) {
			
			[UIView animateWithDuration:.3 delay:.1 options:UIViewAnimationOptionAllowAnimatedContent|UIViewAnimationOptionAllowUserInteraction animations:^{
				self.mentorImageView.transform = CGAffineTransformMakeRotation(0);
				self.mentorImageView.image = [UIImage imageNamed:@"mentor-idle270x317.png"];
			} completion:^(BOOL finished) {
				[self.mentorSpeechLabel setText:@"*Yawn!*"];
				[self advanceGameState];
			}];
			
		}];
	}
	
	
	if (self.gameState == introStateSayingHello){
		self.mentorImageView.image = [UIImage imageNamed:@"mentor-talk270x317.png"];
		[UIView animateWithDuration:2 delay:.1 options:UIViewAnimationOptionAllowAnimatedContent|UIViewAnimationOptionAllowUserInteraction animations:^{

			self.mentorImageView.transform = CGAffineTransformMakeRotation(.3);
			
			
			[self.mentorSpeechLabel setText:@"I'm yogi!\nI'm here to teach family and friends about diabeties!"];
		} completion:^(BOOL finished) {
			
			[UIView animateWithDuration:.3 delay:.1 options:UIViewAnimationOptionAllowAnimatedContent|UIViewAnimationOptionAllowUserInteraction|UIViewAnimationOptionBeginFromCurrentState animations:^{
				self.mentorImageView.image = [UIImage imageNamed:@"mentor-idle270x317.png"];
				
				self.mentorImageView.transform = CGAffineTransformMakeRotation(0);
			} completion:^(BOOL finished) {
				[self advanceGameState];
			}];
			
		}];
	}

	
	if (self.gameState == introStateSayingGamePurpose){
		self.mentorImageView.image = [UIImage imageNamed:@"mentor-talk270x317.png"];
		[UIView animateWithDuration:3 delay:.1 options:UIViewAnimationOptionAllowAnimatedContent|UIViewAnimationOptionAllowUserInteraction animations:^{
			
			self.mentorImageView.transform = CGAffineTransformMakeRotation(.3);
			
			
			[self.mentorSpeechLabel setText:@"I'll show you how to be a good supporter through a game!\nYou'll see the difficulty of eating as a diabetic."];
		} completion:^(BOOL finished) {
			
			[UIView animateWithDuration:.3 delay:.1 options:UIViewAnimationOptionAllowAnimatedContent|UIViewAnimationOptionAllowUserInteraction|UIViewAnimationOptionBeginFromCurrentState animations:^{
				self.mentorImageView.image = [UIImage imageNamed:@"mentor-idle270x317.png"];
				
				self.mentorImageView.transform = CGAffineTransformMakeRotation(0);
			} completion:^(BOOL finished) {
				[self advanceGameState];
			}];
			
		}];
	}

	
	if (self.gameState == introStateSayingGameInstructions){
		self.mentorImageView.image = [UIImage imageNamed:@"mentor-talk270x317.png"];
		[UIView animateWithDuration:3 delay:.1 options:UIViewAnimationOptionAllowAnimatedContent|UIViewAnimationOptionAllowUserInteraction animations:^{
			
			self.mentorImageView.transform = CGAffineTransformMakeRotation(3);
			
			
			[self.mentorSpeechLabel setText:@"Eat as tasty food as possible without going into diabetic shock. \nReady?"];
		} completion:^(BOOL finished) {
			
			[UIView animateWithDuration:.3 delay:.1 options:UIViewAnimationOptionAllowAnimatedContent|UIViewAnimationOptionAllowUserInteraction|UIViewAnimationOptionBeginFromCurrentState animations:^{
				self.mentorImageView.image = [UIImage imageNamed:@"mentor-idle270x317.png"];
				
				self.mentorImageView.transform = CGAffineTransformMakeRotation(0);
			} completion:^(BOOL finished) {
				[self advanceGameState];
			}];
			
		}];
	}
	
	if (self.gameState == introStateReady){
		self.mentorImageView.image = [UIImage imageNamed:@"mentor-talk270x317.png"];
		[UIView animateWithDuration:3 delay:.1 options:UIViewAnimationOptionAllowAnimatedContent|UIViewAnimationOptionAllowUserInteraction animations:^{
			
			self.mentorImageView.transform = CGAffineTransformMakeRotation(.1);
			
			
			[self.mentorSpeechLabel setText:@"=D"];
		} completion:^(BOOL finished) {
			
			[self performSegueWithIdentifier:@"a" sender: self];
		}];
	}


	if (self.gameState == introStateReadyAsk){
		[self performSegueWithIdentifier:@"a" sender: self];
	}
	
}
-(void) setupForUserInputWait{
	[UIView animateWithDuration:.3 delay:4 options:UIViewAnimationOptionAllowAnimatedContent|UIViewAnimationOptionAllowUserInteraction  animations:^{
		[self.taptapImageView setAlpha:1];
	} completion:nil];

}

-(void) advanceGameState{
	self.gameState = self.gameState + 1;
	switch (self.gameState){
		case introStateWaking:
		case introStateSayingHello:
		case introStateSayingGamePurpose:
		case introStateSayingGameInstructions:
		case introStateReady:
			[self performStateAnimate];
			break;
		case introStateAwake:
		case introStateWaitingAfterHello:
		case introStateWaitingAfterGamePurpose:
		case introStateWaitingAfterGameInstructions:
		case introStateReadyAsk:
			[self setupForUserInputWait];
		default:
			//nothin
			break;
	}
}

@end
