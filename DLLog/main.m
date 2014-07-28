//
//  main.m
//  DLLog
//
//  Created by Vincent Esche on 7/28/14.
//  Copyright (c) 2014 Vincent Esche. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "DLLog.h"

const NSString *evenContext = @"even";
const NSString *oddContext = @"odd";

void DLSomeFunctionLoggingANotice() {
	DLLogNotice(@"Some note.");
}

void DLSomeFunctionLoggingGarbageAndACriticalMessage() {
	DLLogNotice(@"yadda yadda...");
	
	DLLogCritical(@"Oh noes!");
	DLLogEmergency(@"Someone was wrong on the internet!");
	
	DLLogNotice(@"...yadda yadda.");
}

void DLSomeFunctionLoggingInAContext() {
	for (NSUInteger i = 1; i <= 4; i++) {
		id context = (i % 2 == 0) ? evenContext : oddContext;
		DLLogNoticeInContext(context, @"%d is %@", (int)i, context);
	}
}

int main(int argc, const char * argv[]) {
	@autoreleasepool {
		
		const char *levels[] = {"Emergency", "Alert", "Critical", "Error", "Warning", "Notice", "Info", "Debug"};
		for (DLLogLevel level = DLLogLevelEmergency; level <= DLLogLevelDebug; level++) {
			printf("\n");
			printf("%s level or higher:\n", levels[level]);
			printf("\n");
			DLLogPerformWithLevelFilter(level, ^{
				DLLogEmergency(@"Lorem");
				DLLogAlert(@"ipsum");
				DLLogCritical(@"dolor");
				DLLogError(@"sir");
				DLLogWarning(@"amet");
				DLLogNotice(@"consectetur");
				DLLogInfo(@"adipiscing");
				DLLogDebug(@"elit.");
			});
		}
		
		printf("\n");
		printf("Nested level filters:\n");
		printf("\n");
		
		// Level filters can be nested:
		
		DLLogPushLevelFilter(DLLogLevelNotice);
		DLSomeFunctionLoggingANotice();
		DLLogPushLevelFilter(DLLogLevelCritical);
		DLSomeFunctionLoggingGarbageAndACriticalMessage();
		DLLogPopLevelFilter();
		DLLogPopLevelFilter();
		
		printf("\n");
		printf("Nested level filters using blocks:\n");
		printf("\n");
		
		// The same nested level filters can be achieved with the blocks API:
		
		DLLogPerformWithLevelFilter(DLLogLevelNotice, ^{
			DLSomeFunctionLoggingANotice();
			DLLogPerformWithLevelFilter(DLLogLevelCritical, ^{
				DLSomeFunctionLoggingGarbageAndACriticalMessage();
			});
		});
		
		printf("\n");
		printf("Any context observations:\n");
		printf("\n");
		DLLogBeginContextObservation(@[DLLogAnyContext()]);
		DLSomeFunctionLoggingInAContext();
		DLLogEndContextObservation(@[DLLogAnyContext()]);
		
		printf("\n");
		printf("Nested context observations:\n");
		printf("\n");
		
		// Context observations can be nested:
		
		DLLogBeginContextObservation(@[evenContext]);
		DLSomeFunctionLoggingInAContext();
		DLLogBeginContextObservation(@[oddContext]);
		DLSomeFunctionLoggingInAContext();
		DLLogEndContextObservation(@[oddContext]);
		DLSomeFunctionLoggingInAContext();
		DLLogEndContextObservation(@[evenContext]);
		
		printf("\n");
		printf("Nested context observations using blocks:\n");
		printf("\n");
		
		// The same nested context observations can be achieved with the blocks API:
		
		DLLogPerformWithContextObservation(@[evenContext], ^{
			DLSomeFunctionLoggingInAContext();
			DLLogPerformWithContextObservation(@[oddContext], ^{
				DLSomeFunctionLoggingInAContext();
			});
			DLSomeFunctionLoggingInAContext();
		});
		
		printf("\n");
		printf("Overlapping context observations:\n");
		printf("\n");
		
		// Context filters can be nested:
		
		DLLogBeginContextObservation(@[evenContext]);
		DLSomeFunctionLoggingInAContext();
		DLLogBeginContextObservation(@[oddContext]);
		DLSomeFunctionLoggingInAContext();
		DLLogEndContextObservation(@[evenContext]);
		DLSomeFunctionLoggingInAContext();
		DLLogEndContextObservation(@[oddContext]);
	}
	return 0;
}

