//
//  SMYogi2Controller.m
//  suga mngr
//
//  Created by Alexander List on 1/26/13.
//  Copyright (c) 2013 pancreas crew. All rights reserved.
//

#import "SMYogi2Controller.h"

@interface SMYogi2Controller ()

@end

@implementation SMYogi2Controller

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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)touchGestureRecognizerRecognized:(UITapGestureRecognizer*)sender {
	if (self.gameState < yogi2StateSayingNextRoundRules){
		[super touchGestureRecognizerRecognized:sender];
		return;
	}

	if ([sender state]==UIGestureRecognizerStateRecognized){
		switch (self.gameState){
			case yogi2StateWaitingAfterNextRoundRules:
			case yogi2StateReadyAsk:
				[self advanceGameState];
				break;
			default:
				//nothin
				break;

		}
	}
}

-(void) performStateAnimate{
	if (self.gameState < introStateWaking){
		[super performStateAnimate];
		return;
	}
	
	[UIView animateWithDuration:.3 delay:0 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
		[self.taptapImageView setAlpha:0];
	} completion:nil];
	
	
	if (self.gameState == introStateWaking){
		[UIView animateWithDuration:.3 delay:.1 options:UIViewAnimationOptionAllowAnimatedContent|UIViewAnimationOptionAllowUserInteraction animations:^{
			self.mentorImageView.transform = CGAffineTransformMakeRotation(.32);
		} completion:^(BOOL finished) {
			
			[UIView animateWithDuration:.3 delay:.1 options:UIViewAnimationOptionAllowAnimatedContent|UIViewAnimationOptionAllowUserInteraction animations:^{
				self.mentorImageView.transform = CGAffineTransformMakeRotation(0);
				self.mentorImageView.image = [UIImage imageNamed:@"mentor-idle270x317.png"];
			} completion:^(BOOL finished) {
				[self.mentorSpeechLabel setText:@"*Yawn!* Oh hi, NICE JOB!"];
				[self advanceGameState];
			}];
			
		}];
	}

	if (self.gameState == yogi2StateSayingNextRoundRules){
		self.mentorImageView.image = [UIImage imageNamed:@"mentor-talk270x317.png"];
		[UIView animateWithDuration:3 delay:.1 options:UIViewAnimationOptionAllowAnimatedContent|UIViewAnimationOptionAllowUserInteraction animations:^{
			
			self.mentorImageView.transform = CGAffineTransformMakeRotation(.3);
			
			
			[self.mentorSpeechLabel setText:@"Tonight you're going to pizza with a friend for lunch, and the movies later in the night!\n Ready?"];
		} completion:^(BOOL finished) {
			
			[UIView animateWithDuration:.3 delay:.1 options:UIViewAnimationOptionAllowAnimatedContent|UIViewAnimationOptionAllowUserInteraction|UIViewAnimationOptionBeginFromCurrentState animations:^{
				self.mentorImageView.image = [UIImage imageNamed:@"mentor-idle270x317.png"];
				
				self.mentorImageView.transform = CGAffineTransformMakeRotation(0);
			} completion:^(BOOL finished) {
				[self advanceGameState];
			}];
			
		}];
	}
	

	if (self.gameState == yogi2StateReady){
		self.mentorImageView.image = [UIImage imageNamed:@"mentor-talk270x317.png"];
		[UIView animateWithDuration:3 delay:.1 options:UIViewAnimationOptionAllowAnimatedContent|UIViewAnimationOptionAllowUserInteraction animations:^{
			
			self.mentorImageView.transform = CGAffineTransformMakeRotation(.3);
			
			
			[self.mentorSpeechLabel setText:@"Good luck! =]"];
		} completion:^(BOOL finished) {
			
			[UIView animateWithDuration:.3 delay:.1 options:UIViewAnimationOptionAllowAnimatedContent|UIViewAnimationOptionAllowUserInteraction|UIViewAnimationOptionBeginFromCurrentState animations:^{
				self.mentorImageView.image = [UIImage imageNamed:@"mentor-idle270x317.png"];
				
				self.mentorImageView.transform = CGAffineTransformMakeRotation(0);
			} completion:^(BOOL finished) {
				[self advanceGameState];
			}];
			
		}];
	}

}

-(void) advanceGameState{
	if (self.gameState < yogi2StateSayingNextRoundRules){
		[super advanceGameState];
		return;
	}

	self.gameState = self.gameState + 1;
	switch (self.gameState){
		case yogi2StateSayingNextRoundRules:
		case yogi2StateReady:
			[self performStateAnimate];
			break;
		case yogi2StateWaitingAfterNextRoundRules:
		case yogi2StateReadyAsk:
			[self setupForUserInputWait];
		default:
			//nothin
			break;
	}
}


@end
