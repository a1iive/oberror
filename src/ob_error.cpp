#include <string.h>
#include "ob_error.h"
#include "./lib/os_errno.h"

static void print_help() {
    printf("This is the ob_error tool. Usage:\n\n");
    printf("    ob_error [option]\n");
    printf("    ob_error [facility] errorcode [-a=ARGUMENT]\n");
    printf("    ob_error [facility] errorcode [--argument=ARGUMENT]\n");
    printf("Get the error information, reasons and possible solutions.\n\n");
    printf("Query an error:\n\n");
    printf("    ob_error errorcode\n\n");
    printf("Query an error in MySQL mode:\n\n");
    printf("    ob_error MY errorcode\n\n");
    printf("Query an error in ORACLE mode:\n\n");
    printf("    ob_error facility errorcode\n");
    printf("    ob_error facility errorcode -a=ARGUMENT\n");
    printf("    ob_error facility errorcode --argument=ARGUMENT\n\n");
    printf("ARGUMENT:         \n\n");
    printf("  Positive number   OceanBase errorcode in ORA-00600 error output.\n\n");
    printf("facility:\n\n");
    printf("  MY                MySQL mode.\n");
    printf("  ORA               ORACLE mode. Error from database.\n");
    printf("  PLS               ORACLE mode. Error from the stored procedure.\n\n");
    printf("Normal options:\n\n");
    printf("  --help, -h        Print this message and then exit.\n");
    printf("  --version, -V     Print version information and then exit.\n\n");
}

static void print_version() {
    printf("OceanBase ob_error 0.1\n");
}

static bool print_os_info(int errorcode) {
    if (-1 == errorcode) {
        return false;
    }

    const char* err_name = str_os_error_name(errorcode);
    if (NULL == err_name) return false;
    printf("\n%s\n", str_os_error_msg(errorcode));
    return true;
}

static bool print_mysql_info(int errorcode) {
    if (-1 == errorcode) {
        return false;
    }

    int info_count = 0;
    int ob_error = errorcode;
    if (errorcode < -OB_ERROR) {
        PRINT_INFO_LOOP(mysql_error, false);
        return (info_count != 0);
    } 
    // 大于3999的MySQL错误码不存在多种错误含义
    const char *str_user_error = ob_errpkt_str_user_error(-ob_error, false);
    if (nullptr == str_user_error) {
        return false;
    }
    printf("\nERROR %d (%s): %s\n", errorcode, ob_sqlstate(-ob_error), str_user_error);
    printf("Cause: %s\n", ob_error_cause(-ob_error));
    printf("Solution: %s\n", ob_error_solution(-ob_error));
    return true;
}

static bool print_oracle_info(char *oracle_sqlstate, int errorcode, int argument) {
    if (-1 == errorcode) {
        return false;
    }

    int info_count = 0;
    int ob_error = -1;
    // 调用前保证nullptr条件下，argument不允许被设置
    if(nullptr == oracle_sqlstate) {
        // 处理errorcode是ORA-00600的argument的情况
        const char *str_user_error = ob_errpkt_str_user_error(-errorcode, true);
        if (nullptr != str_user_error) {
            // 根据ob内部错误码得到信息后，需要重新验证该错误是否是ORA-00600
            if (-OB_ERR_PROXY_REROUTE == ob_errpkt_errno(-errorcode, true) 
                || 600 == ob_errpkt_errno(-errorcode, true)) {
                printf("\n%s\n", str_user_error);
                printf("Cause: %s\n", ob_error_cause(-errorcode));
                printf("Solution: %s\n", ob_error_solution(-errorcode));
                info_count++;
            }
        }
        // 处理ORA-errorcode的情况
        // ORA-00600这里保证没有输入-a=ARG参数，因此输出ORA-00600原始的可能错误
        PRINT_INFO_LOOP(oracle_ora, true);
        // 处理PLS-errorcode的情况
        PRINT_INFO_LOOP(oracle_pls, true);
        // 如果任何00600不存在，那么提示可能是要找ORA-00600 -a
        if(600 == errorcode && info_count == 0) {
            printf("\nerror: this error does not exist\n");
            printf("Maybe you want to query error 'ORA-00600'? ");
            printf("Use 'ob_error ora 600 -a=ARG' to do it.\n");
            printf("Use 'ob_error --help' for help.\n");
            return true;
        }
        return (info_count != 0);
    } else {
        if (strcasecmp(oracle_sqlstate, "ORA") == 0) {
            if (600 == errorcode) {
                ob_error = argument;
                // 600是特殊错误值，如果没有-a参数那么输出ORA-00600原始的可能错误
                if(-1 == ob_error) {
                    PRINT_INFO_LOOP(oracle_ora, true);
                    return (info_count != 0);
                }
                const char *str_user_error = ob_errpkt_str_user_error(-ob_error, true);
                if (nullptr != str_user_error) {
                    // 根据ob内部错误码得到信息后，需要重新验证该错误是否是ORA-00600
                    if (-OB_ERR_PROXY_REROUTE == ob_errpkt_errno(-ob_error, true) 
                        || 600 == ob_errpkt_errno(-ob_error, true)) {
                        printf("\n%s\n", str_user_error);
                        printf("Cause: %s\n", ob_error_cause(-ob_error));
                        printf("Solution: %s\n", ob_error_solution(-ob_error));
                        return true;
                    }
                }
                // 直接返回
                return false;
            } else {
                if(-1 != argument) {
                    // -a参数仅支持ORA-00600错误码
                    printf("\nerror: '-a=ARG' is unsupport in this scene\n");
                    printf("Use 'ob_error ora 600 -a=ARG'.\n");
                    printf("Use 'ob_error --help' for help.\n");
                    return true;
                }
                PRINT_INFO_LOOP(oracle_ora, true);
                return (info_count != 0);
            }
        } else if(strcasecmp(oracle_sqlstate, "PLS") == 0) {
            if (-1 != argument) {
                // -a参数仅支持ORA-00600错误码
                printf("\nerror: '-a=ARG' is unsupport in this scene\n");
                printf("Use 'ob_error ora 600 -a=ARG'.\n");
                printf("Use 'ob_error --help' for help.\n");
                return true;
            }
            PRINT_INFO_LOOP(oracle_pls, true);
            return (info_count != 0);
        }
    }

    return false;
}

bool parse_param(int args, char *argv[]) {
    bool oracle_mode = false;
    bool mysql_mode = false;
    int errorcode = -1;
    char *oracle_sqlstate = nullptr;
    int argument = -1;

    if (2 != args && 3 != args && 4 != args) {
        // 强制保证输入参数个数
        return false;
    }

    for(int i = 1; i < args; i++) {
        if (0 == strcmp(argv[i], "-h")|| 0 == strcmp(argv[i], "--help")) {
            print_help();
            return true;
        } else if (0 == strcmp(argv[i], "-V") || 0 == strcmp(argv[i], "--version")) {
            print_version();
            return true;
        } else if (0 == strncmp(argv[i], "-a=", 3)) {
            // 仅支持 "-a="参数在末尾
            if(i != args-1) return false;
            argument = atoi(argv[i]+3);
        } else if (0 == strncmp(argv[i], "--argument=", 11)) {
            // 仅支持 "--argument="参数在末尾
            if(i != args-1) return false;
            argument = atoi(argv[i]+11);
        } else if (0 == strcasecmp(argv[i], "ORA") || 0 == strcasecmp(argv[i], "PLS")) {
            if(nullptr != oracle_sqlstate) return false;
            else {
                oracle_mode = true;
                oracle_sqlstate = argv[i];
            }
        } else if (0 == strcasecmp(argv[i], "MY")) {
            mysql_mode = true;
        } else if (argv[i][0] >= '0' && argv[i][0] <= '9') {
            // 如果输入多个数值，后面的值会覆盖原值
            errorcode = atoi(argv[i]);
        }
    }
    
    if (oracle_mode && mysql_mode) {
        return false;
    } else if (oracle_mode) {
        if (!print_oracle_info(oracle_sqlstate, errorcode, argument)) {
            printf("\nerror: this error does not exist\n");
            printf("Check your input.\n");
        }
        return true;
    } else if(mysql_mode) {
        if (!print_mysql_info(errorcode)) {
            printf("\nerror: this error does not exist\n");
            printf("Check your input.\n");
        }
        return true;
    } else {
        if (-1 != argument) {
            // -a参数仅支持ORA-00600错误码
            printf("\nerror: '-a=ARG' is unsupport in this scene\n");
            printf("Use 'ob_error ora 600 -a=ARG'.\n");
            printf("Use 'ob_error --help' for help.\n");
            return true;
        }
        bool res_os = print_os_info(errorcode);
        bool res_mysql = print_mysql_info(errorcode);
        bool res_oracle = print_oracle_info(nullptr, errorcode, argument);
        if(!(res_os || res_mysql || res_oracle)) {
            printf("\nerror: this error does not exist\n");
            printf("Check your input.\n");
        }
        return true;
    }

    // never go here
    return false;
}

void init_global_info() {
    memset(g_oracle_ora, -1, sizeof(g_oracle_ora));
    memset(g_oracle_pls, -1, sizeof(g_oracle_pls));
    memset(g_mysql_error, -1, sizeof(g_mysql_error));

    ob_init_error_to_oberror(g_oracle_ora, g_oracle_pls, g_mysql_error);
}

int main(int args, char *argv[]) {
    init_global_info();
    
    if (1 < args) {
        if (!parse_param(args, argv)) {
            printf("\nerror: parameter invalid\n");
            printf("Use 'ob_error --help' for help.\n");
            return 0;
        } 
        return 0;
    }
    
    printf("\nerror: missing parameter\n");
    printf("Use 'ob_error --help' for help.\n");
    return 0;
}