//
//  CardMatchingGame.m
//  Matchismo
//
//  Created by wangyipu on 13-11-29.
//  Copyright (c) 2013年 stone. All rights reserved.
//

#import "CardMatchingGame.h"

@interface CardMatchingGame()

@property (nonatomic, readwrite) NSInteger score;
@property (nonatomic, strong) NSMutableArray *cards;
//@property (nonatomic, readwrite) NSInteger matchCount;


@end

@implementation CardMatchingGame

static const int MISMATCH_PENALTY = 2;
static const int MATCH_BONUS = 4;
static const int COST_TO_CHOOSE = 1;


- (NSMutableArray *)cards
{
    if (!_cards) {
        _cards = [[NSMutableArray alloc] init];
    }
    return _cards;
}

- (instancetype)initWithCardCount:(NSUInteger)count usingDeck:(Deck *)deck
{
    self = [super init];
    if (self) {
        for (int i = 0; i<count; i++) {
            Card *card = [deck drawRandomCard];
            if (card) {
                [self.cards addObject:card];
            }else{
                self = nil;
                break;
            }
            
        }
    }
    return self;
}

- (Card *)cardAtIndex:(NSUInteger)index
{
    return (index < [self.cards count]) ? self.cards[index] : nil;
}


- (void)chooseCardAtIndex:(NSUInteger)index
{
    Card *card = [self cardAtIndex:index];
    if (!card.isMatched) {
        if (card.isChosen) {
            card.chosen = NO;
            self.lastContent = card.contents;
//            NSLog(@"%@",self.lastContent);
        }else{
            for (Card *otherCard in self.cards) {
                if (otherCard.isChosen && !otherCard.isMatched) {
                    int matchScore = [card match:@[otherCard]];
                    if (matchScore) {
                        self.score += matchScore * MATCH_BONUS;
                        otherCard.matched = YES;
                        card.matched = YES;
                        
                        self.lastContent = [NSString stringWithFormat:@"Matched %@ %@ for %d points.", card.contents, otherCard.contents, matchScore*MATCH_BONUS];
//                        NSLog(@"%@", self.lastContent);
                    }else{
                        
                        self.lastContent = [NSString stringWithFormat:@"%@%@ don't match! 2 points penalty!", otherCard.contents, card.contents];
//                        NSLog(@"%@",self.lastContent);
                        self.score -= MISMATCH_PENALTY;
                        otherCard.chosen = NO;
                    }
                    break;
                }
            }
            self.score -= COST_TO_CHOOSE;
            card.chosen = YES;
        }
    }
}

- (void)chooseCardsAtIndex:(NSUInteger)index
{
    Card *card = [self cardAtIndex:index];
    if (!card.isMatched) {
        if (card.isChosen) {
            card.chosen = NO;
            self.lastContent = card.contents;
        }else{
            for (Card *otherCard in self.cards) {
                if (otherCard.isChosen && !otherCard.isMatched) {
                    int matchScore = [card match:@[otherCard]];
                    if (matchScore) {
                        self.score += 2;
//                        int i = 1;
//                        self.matchCount += i;
//                        if (self.matchCount >= 2) {
                        
                        int cardsAmount = 1;
                        for (Card *cardsCount in self.cards) {
                            
                            if (!cardsCount.isMatched && cardsCount.isChosen) {
                                cardsAmount++;
//                                    NSLog(@"j = %d",cardsAmount);
                                if (cardsAmount == 3) {
                                    //self.matchCount = 0;
                                    self.score += matchScore * MATCH_BONUS * 2;
                                    for (Card *matchCards in self.cards) {
                                        if (matchCards.isChosen && !matchCards.isMatched) {
                                            matchCards.matched = YES;
                                            self.lastContent = [NSString stringWithFormat:@"%@ %@ Matched for %d points.",card.contents,matchCards.contents, MATCH_BONUS*2*matchScore];

                                        }
                                    }
                                    card.matched = YES;
                                }
                            }
                        }
                            
//                        }
//                        NSLog(@"i = %d",self.matchCount);

                    }else{
                        self.lastContent = [NSString stringWithFormat:@"%@ %@ don't match.2 points penalty.",otherCard.contents,card.contents];
                        self.score -= MISMATCH_PENALTY;
                        for (Card *otherCards in self.cards) {
                            if (otherCards.isChosen && !otherCards.isMatched) {
                                otherCards.chosen = NO;
                            }
                        }
                        otherCard.chosen = NO;
//                        NSLog(@"othercard");
                    }
                    break;
                }
            }
            self.score -= COST_TO_CHOOSE;
            card.chosen = YES;
        }
    }
}



//assignment 2



- (void)resetCards:(NSUInteger)index
{
    
    
    Card *card = [self cardAtIndex:index];
    if (!card.isMatched) {
        if (card.isChosen) {
            card.chosen = NO;
        }else{
            for (Card *otherCard in self.cards) {
                if (otherCard.isChosen && !otherCard.isMatched) {
                        otherCard.matched = NO;
                        card.matched = NO;
                        otherCard.chosen = NO;
                    break;
                }
            }
            card.chosen = NO;
        }
    }
    self.score = 0;
    
}
@end
