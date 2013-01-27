//
//  SMYogi2Controller.h
//  suga mngr
//
//  Created by Alexander List on 1/26/13.
//  Copyright (c) 2013 pancreas crew. All rights reserved.
//

#import "SMViewController.h"
typedef enum {
	yogi2StateSleeping = introStateSleeping,
	yogi2StateWaking = introStateWaking,
	yogi2StateAwake = introStateAwake,
	yogi2StateSayingNextRoundRules,
	yogi2StateWaitingAfterNextRoundRules,
	yogi2StateReadyAsk,
	yogi2StateReady
}yogi2State;

@interface SMYogi2Controller : SMViewController

@end
