#ifdef __OBJC__
#import <UIKit/UIKit.h>
#else
#ifndef FOUNDATION_EXPORT
#if defined(__cplusplus)
#define FOUNDATION_EXPORT extern "C"
#else
#define FOUNDATION_EXPORT extern
#endif
#endif
#endif

#import "FITNetClient.h"
#import "FITNetKit.h"
#import "FITNetRequest.h"
#import "FITNetTarget.h"

FOUNDATION_EXPORT double FITNetKitVersionNumber;
FOUNDATION_EXPORT const unsigned char FITNetKitVersionString[];

