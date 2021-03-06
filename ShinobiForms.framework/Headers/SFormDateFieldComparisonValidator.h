//
//  SFormDateFieldComparisonValidator.h
//  ShinobiForms
//
//  Copyright (c) 2015 Scott Logic. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SFormDateFieldValidator.h"
#import "SFormComparisonRule.h"

@class SFormDateField;

/** A validator that compares the validating date field's input against a specified date field's input. */
@interface SFormDateFieldComparisonValidator : NSObject<SFormDateFieldValidator>

/** A string representing the invalid message to provide. */
@property (nonatomic, strong) NSString *invalidMessage;

/** The date field that we are comparing the validating date field's input against. */
@property (nonatomic, readonly, retain) SFormDateField *toCompare;

/** The result needed from the comparison to achieve positive validation. */
@property (nonatomic, readonly, assign) SFormComparisonRule validResult;

/** Returns an instance of this class that will compare the validating date field's input against the input a provided date field.
 
 This validator calls the `compare:` method on the field's `value` property, passing in the `toCompare` field's `value` as the parameter. This validator will validate positively if the comparison result is the same as the valid result provided.
 
 @param toCompare The date field whose input will be compare with the validating date field's input.
 @param validResult The comparison result that trigger provide positive validation.
 */
- (instancetype)initWithFieldToCompare:(SFormDateField *)toCompare validResult:(SFormComparisonRule)validResult;

@end

