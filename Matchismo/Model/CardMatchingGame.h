//
//  CardMatchingGame.h
//  Matchismo
//
//  Created by wangyipu on 13-11-29.
//  Copyright (c) 2013年 stone. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Deck.h"
#import "Card.h"

@interface CardMatchingGame : NSObject

- (instancetype)initWithCardCount:(NSUInteger)count
                        usingDeck:(Deck *)deck;

- (void)chooseCardAtIndex:(NSUInteger)index;
- (Card *)cardAtIndex:(NSUInteger)index;

@property (nonatomic, readonly) NSInteger score;

//reset cards
- (void)resetCards:(NSUInteger)index;

@end
