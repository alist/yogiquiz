//
//  SMViewController.m
//  suga mngr
//
//  Created by Alexander List on 1/26/13.
//  Copyright (c) 2013 pancreas crew. All rights reserved.
//

#import "SMViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface SMViewController ()

@end

@implementation SMViewController
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.

	self.narrativeAudio = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"Narrative-Opening" ofType:@"wav" inDirectory:@"/"]] error:nil];
	self.narrativeAudio.volume = .3;
	self.narrativeAudio.numberOfLoops = -1;
	int64_t delayInSeconds = 2.0;
	dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
	dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
		[self.narrativeAudio play];
	});
	
	CFURLRef baseURL = (__bridge CFURLRef)[NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"Narrative-Jibberish-goodpoint" ofType:@"wav" inDirectory:@"/"]];
	AudioServicesCreateSystemSoundID (baseURL, &yawnSound);
	

	baseURL = (__bridge CFURLRef)[NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"Narrative-Jibberish" ofType:@"wav" inDirectory:@"/"]];
	AudioServicesCreateSystemSoundID (baseURL, &speakSound);
//
	
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
		
		
		
		AudioServicesPlaySystemSound (yawnSound);

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
		AudioServicesPlaySystemSound (speakSound);

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
		AudioServicesPlaySystemSound (speakSound);
		
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
		AudioServicesPlaySystemSound (speakSound);
		
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
		AudioServicesPlaySystemSound (yawnSound);
		
		self.mentorImageView.image = [UIImage imageNamed:@"mentor-talk270x317.png"];
		[UIView animateWithDuration:2 delay:.1 options:UIViewAnimationOptionAllowAnimatedContent|UIViewAnimationOptionAllowUserInteraction animations:^{
			
			self.mentorImageView.transform = CGAffineTransformMakeRotation(.1);
			
			
			[self.mentorSpeechLabel setText:@"=D"];
		} completion:^(BOOL finished) {
			
			[self performSegueWithIdentifier:@"a" sender: self];
		}];
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

-(void)viewWillDisappear:(BOOL)animated{
	[super viewWillDisappear:animated];
	[self doVolumeFade];
}

-(void)doVolumeFade{
    if (self.narrativeAudio.volume > 0.1) {
        self.narrativeAudio.volume = self.narrativeAudio.volume - 0.04;
        [self performSelector:@selector(doVolumeFade) withObject:nil afterDelay:0.1];
	} else {
        // Stop and get the sound ready for playing again
        [self.narrativeAudio stop];
        self.narrativeAudio.currentTime = 0;
        self.narrativeAudio.volume = .3;
    }
}

-(void)dealloc{
	AudioServicesDisposeSystemSoundID(yawnSound);
	yawnSound = 0;
	AudioServicesDisposeSystemSoundID(speakSound);
	speakSound = 0;
}

@end
