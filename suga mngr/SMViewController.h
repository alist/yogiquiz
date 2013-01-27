//
//  SMViewController.h
//  suga mngr
//
//  Created by Alexander List on 1/26/13.
//  Copyright (c) 2013 pancreas crew. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
	introStateSleeping = 0,
	introStateWaking,
	introStateAwake,
	introStateSayingHello,
	introStateWaitingAfterHello,
	introStateSayingGamePurpose,
	introStateWaitingAfterGamePurpose,
	introStateSayingGameInstructions,
	introStateWaitingAfterGameInstructions,
	introStateReadyAsk,
	introStateReady
}introState;

@interface SMViewController : UIViewController
@property (nonatomic, assign) introState gameState;

@property (strong, nonatomic) IBOutlet UIImageView *mentorImageView;
@property (strong, nonatomic) IBOutlet UIImageView *taptapImageView;
@property (strong, nonatomic) IBOutlet UILabel *mentorSpeechLabel;
- (IBAction)touchGestureRecognizerRecognized:(id)sender;
-(void)performStateAnimate;

-(void) advanceGameState;
-(void) setupForUserInputWait;
@end
