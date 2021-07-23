#ifndef __OBERROR_ERROR_H__
#define __OBERROR_ERROR_H__
#include <iostream>
#include <cstdio>
#include "ob_errno.h"

#define PRINT_INFO_LOOP(array, oracle_mode) \
    do { \
        for (int i = 0; i < OB_MAX_SAME_ERRORCODE; i++) { \
            if (-1 == g_##array[errorcode][i]) { \
                break; \
            } else { \
                ob_error = g_##array[errorcode][i]; \
                const char *str_user_error = ob_errpkt_str_user_error(-ob_error, oracle_mode); \
                if (nullptr != str_user_error) { \
                    if (oracle_mode) { \
                        printf("\n%s\n", str_user_error); \
                    } else { \
                        printf("\nERROR %d (%s): %s\n", errorcode, ob_sqlstate(-ob_error), str_user_error); \
                    } \
                    printf("Cause: %s\n", ob_error_cause(-ob_error)); \
                    printf("Solution: %s\n", ob_error_solution(-ob_error)); \
                    info_count++; \
                } \
            } \
        } \
    } while(0) \

int g_oracle_ora[OB_MAX_ERROR_CODE][OB_MAX_SAME_ERRORCODE];
int g_oracle_pls[OB_MAX_ERROR_CODE][OB_MAX_SAME_ERRORCODE];
int g_mysql_error[-OB_ERROR][OB_MAX_SAME_ERRORCODE];

void init_global_info();
bool parse_param(int args, const char *argv[]);

#endif



