//
//  PureC.c
//  AppleDarthVader
//
//  Created by 杨俊艺 on 2025/9/7.
//

#include <stdio.h>
#include <stdlib.h>

int add(int a, int b) {
	return a + b;
}

void parse_buffer(int8_t *buffer, size_t len) {
	if (buffer == NULL || len == 0) {
		return;
	}
	
	for (size_t i = 0; i < len; i++) {
		buffer[i] = (int8_t)(buffer[i] + 1);
	}
}
