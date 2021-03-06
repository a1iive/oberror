#ifndef __OBERROR_LIB_OS_ERROR_H__
#define __OBERROR_LIB_OS_ERROR_H__

#include <errno.h>
// error code

// error message
#define EPERM_ERROR_MSG        "OS Error 1: Operation not permitted"
#define ENOENT_ERROR_MSG       "OS Error 2: No such file or directory"
#define ESRCH_ERROR_MSG        "OS Error 3: No such process"
#define EINTR_ERROR_MSG        "OS Error 4: Interrupted system call"
#define EIO_ERROR_MSG          "OS Error 5: I/O error"
#define ENXIO_ERROR_MSG        "OS Error 6: No such device or address"
#define E2BIG_ERROR_MSG        "OS Error 7: Argument list too long"
#define ENOEXEC_ERROR_MSG      "OS Error 8: Exec format error"
#define EBADF_ERROR_MSG        "OS Error 9: Bad file number"
#define ECHILD_ERROR_MSG       "OS Error 10: No child processes"
#define EAGAIN_ERROR_MSG       "OS Error 11: Try again"
#define ENOMEM_ERROR_MSG       "OS Error 12: Out of memory"
#define EACCES_ERROR_MSG       "OS Error 13: Permission denied"
#define EFAULT_ERROR_MSG       "OS Error 14: Bad address"
#define ENOTBLK_ERROR_MSG      "OS Error 15: Block device required"
#define EBUSY_ERROR_MSG        "OS Error 16: Device or resource busy"
#define EEXIST_ERROR_MSG       "OS Error 17: File exists"
#define EXDEV_ERROR_MSG        "OS Error 18: Cross-device link"
#define ENODEV_ERROR_MSG       "OS Error 19: No such device"
#define ENOTDIR_ERROR_MSG      "OS Error 20: Not a directory"
#define EISDIR_ERROR_MSG       "OS Error 21: Is a directory"
#define EINVAL_ERROR_MSG       "OS Error 22: Invalid argument"
#define ENFILE_ERROR_MSG       "OS Error 23: File table overflow"
#define EMFILE_ERROR_MSG       "OS Error 24: Too many open files"
#define ENOTTY_ERROR_MSG       "OS Error 25: Not a typewriter"
#define ETXTBSY_ERROR_MSG      "OS Error 26: Text file busy"
#define EFBIG_ERROR_MSG        "OS Error 27: File too large"
#define ENOSPC_ERROR_MSG       "OS Error 28: No space left on device"
#define ESPIPE_ERROR_MSG       "OS Error 29: Illegal seek"
#define EROFS_ERROR_MSG        "OS Error 30: Read-only file system"
#define EMLINK_ERROR_MSG       "OS Error 31: Too many links"
#define EPIPE_ERROR_MSG        "OS Error 32: Broken pipe"
#define EDOM_ERROR_MSG         "OS Error 33: Math argument out of domain of func"
#define ERANGE_ERROR_MSG       "OS Error 34: Math result not representable"
#define EDEADLK_ERROR_MSG      "OS Error 35: Resource deadlock would occur"
#define ENAMETOOLONG_ERROR_MSG   "OS Error 36: File name too long"
#define ENOLCK_ERROR_MSG       "OS Error 37: No record locks available"
#define ENOSYS_ERROR_MSG       "OS Error 38: Function not implemented"
#define ENOTEMPTY_ERROR_MSG    "OS Error 39: Directory not empty"
#define ELOOP_ERROR_MSG        "OS Error 40: Too many symbolic links encountered"
#define EWOULDBLOCK_ERROR_MSG  "OS Error 11: Operation would block"
#define ENOMSG_ERROR_MSG       "OS Error 42: No message of desired type"
#define EIDRM_ERROR_MSG        "OS Error 43: Identifier removed"
#define ECHRNG_ERROR_MSG       "OS Error 44: Channel number out of range"
#define EL2NSYNC_ERROR_MSG     "OS Error 45: Level 2 not synchronized"
#define EL3HLT_ERROR_MSG       "OS Error 46: Level 3 halted"
#define EL3RST_ERROR_MSG       "OS Error 47: Level 3 reset"
#define ELNRNG_ERROR_MSG       "OS Error 48: Link number out of range"
#define EUNATCH_ERROR_MSG      "OS Error 49: Protocol driver not attached"
#define ENOCSI_ERROR_MSG       "OS Error 50: No CSI structure available"
#define EL2HLT_ERROR_MSG       "OS Error 51: Level 2 halted"
#define EBADE_ERROR_MSG        "OS Error 52: Invalid exchange"
#define EBADR_ERROR_MSG        "OS Error 53: Invalid request descriptor"
#define EXFULL_ERROR_MSG       "OS Error 54: Exchange full"
#define ENOANO_ERROR_MSG       "OS Error 55: No anode"
#define EBADRQC_ERROR_MSG      "OS Error 56: Invalid request code"
#define EBADSLT_ERROR_MSG      "OS Error 57: Invalid slot"

#define EBFONT_ERROR_MSG       "OS Error 59: Bad font file format"
#define ENOSTR_ERROR_MSG       "OS Error 60: Device not a stream"
#define ENODATA_ERROR_MSG      "OS Error 61: No data available"
#define ETIME_ERROR_MSG        "OS Error 62: Timer expired"
#define ENOSR_ERROR_MSG        "OS Error 63: Out of streams resources"
#define ENONET_ERROR_MSG       "OS Error 64: Machine is not on the network"
#define ENOPKG_ERROR_MSG       "OS Error 65: Package not installed"
#define EREMOTE_ERROR_MSG      "OS Error 66: Object is remote"
#define ENOLINK_ERROR_MSG      "OS Error 67: Link has been severed"
#define EADV_ERROR_MSG         "OS Error 68: Advertise error"
#define ESRMNT_ERROR_MSG       "OS Error 69: Srmount error"
#define ECOMM_ERROR_MSG        "OS Error 70: Communication error on send"
#define EPROTO_ERROR_MSG       "OS Error 71: Protocol error"
#define EMULTIHOP_ERROR_MSG    "OS Error 72: Multihop attempted"
#define EDOTDOT_ERROR_MSG      "OS Error 73: RFS specific error"
#define EBADMSG_ERROR_MSG      "OS Error 74: Not a data message"
#define EOVERFLOW_ERROR_MSG    "OS Error 75: Value too large for defined data type"
#define ENOTUNIQ_ERROR_MSG     "OS Error 76: Name not unique on network"
#define EBADFD_ERROR_MSG       "OS Error 77: File descriptor in bad state"
#define EREMCHG_ERROR_MSG      "OS Error 78: Remote address changed"
#define ELIBACC_ERROR_MSG      "OS Error 79: Can not access a needed shared library"
#define ELIBBAD_ERROR_MSG      "OS Error 80: Accessing a corrupted shared library"
#define ELIBSCN_ERROR_MSG      "OS Error 81: .lib section in a.out corrupted"
#define ELIBMAX_ERROR_MSG      "OS Error 82: Attempting to link in too many shared libraries"
#define ELIBEXEC_ERROR_MSG     "OS Error 83: Cannot exec a shared library directly"
#define EILSEQ_ERROR_MSG       "OS Error 84: Illegal byte sequence"
#define ERESTART_ERROR_MSG     "OS Error 85: Interrupted system call should be restarted"
#define ESTRPIPE_ERROR_MSG     "OS Error 86: Streams pipe error"
#define EUSERS_ERROR_MSG       "OS Error 87: Too many users"
#define ENOTSOCK_ERROR_MSG     "OS Error 88: Socket operation on non-socket"
#define EDESTADDRREQ_ERROR_MSG   "OS Error 89: Destination address required"
#define EMSGSIZE_ERROR_MSG       "OS Error 90: Message too long"
#define EPROTOTYPE_ERROR_MSG     "OS Error 91: Protocol wrong type for socket"
#define ENOPROTOOPT_ERROR_MSG    "OS Error 92: Protocol not available"
#define EPROTONOSUPPORT_ERROR_MSG  "OS Error 93: Protocol not supported"
#define ESOCKTNOSUPPORT_ERROR_MSG  "OS Error 94: Socket type not supported"
#define EOPNOTSUPP_ERROR_MSG     "OS Error 95: Operation not supported on transport endpoint"
#define EPFNOSUPPORT_ERROR_MSG   "OS Error 96: Protocol family not supported"
#define EAFNOSUPPORT_ERROR_MSG   "OS Error 97: Address family not supported by protocol"
#define EADDRINUSE_ERROR_MSG     "OS Error 98: Address already in use"
#define EADDRNOTAVAIL_ERROR_MSG  "OS Error 99: Cannot assign requested address"
#define ENETDOWN_ERROR_MSG       "OS Error 100: Network is down"
#define ENETUNREACH_ERROR_MSG    "OS Error 101: Network is unreachable"
#define ENETRESET_ERROR_MSG      "OS Error 102: Network dropped connection because of reset"
#define ECONNABORTED_ERROR_MSG   "OS Error 103: Software caused connection abort"
#define ECONNRESET_ERROR_MSG     "OS Error 104: Connection reset by peer"
#define ENOBUFS_ERROR_MSG        "OS Error 105: No buffer space available"
#define EISCONN_ERROR_MSG        "OS Error 106: Transport endpoint is already connected"
#define ENOTCONN_ERROR_MSG       "OS Error 107: Transport endpoint is not connected"
#define ESHUTDOWN_ERROR_MSG      "OS Error 108: Cannot send after transport endpoint shutdown"
#define ETOOMANYREFS_ERROR_MSG   "OS Error 109: Too many references: cannot splice"
#define ETIMEDOUT_ERROR_MSG      "OS Error 110: Connection timed out"
#define ECONNREFUSED_ERROR_MSG   "OS Error 111: Connection refused"
#define EHOSTDOWN_ERROR_MSG      "OS Error 112: Host is down"
#define EHOSTUNREACH_ERROR_MSG   "OS Error 113: No route to host"
#define EALREADY_ERROR_MSG       "OS Error 114: Operation already in progress"
#define EINPROGRESS_ERROR_MSG    "OS Error 115: Operation now in progress"
#define ESTALE_ERROR_MSG         "OS Error 116: Stale file handle"
#define EUCLEAN_ERROR_MSG        "OS Error 117: Structure needs cleaning"
#define ENOTNAM_ERROR_MSG        "OS Error 118: Not a XENIX named type file"
#define ENAVAIL_ERROR_MSG        "OS Error 119: No XENIX semaphores available"
#define EISNAM_ERROR_MSG         "OS Error 120: Is a named type file"
#define EREMOTEIO_ERROR_MSG      "OS Error 121: Remote I/O error"
#define EDQUOT_ERROR_MSG         "OS Error 122: Quota exceeded"
#define ENOMEDIUM_ERROR_MSG      "OS Error 123: No medium found"
#define EMEDIUMTYPE_ERROR_MSG    "OS Error 124: Wrong medium type"
#define ECANCELED_ERROR_MSG      "OS Error 125: Operation Canceled"
#define ENOKEY_ERROR_MSG         "OS Error 126: Required key not available"
#define EKEYEXPIRED_ERROR_MSG    "OS Error 127: Key has expired"
#define EKEYREVOKED_ERROR_MSG    "OS Error 128: Key has been revoked"
#define EKEYREJECTED_ERROR_MSG   "OS Error 129: Key was rejected by service"

#define EOWNERDEAD_ERROR_MSG     "OS Error 130: Owner died"
#define ENOTRECOVERABLE_ERROR_MSG   "OS Error 131: State not recoverable"
#define ERFKILL_ERROR_MSG        "OS Error 132: Operation not possible due to RF-kill"
#define EHWPOISON_ERROR_MSG      "OS Error 133: Memory page has hardware error"

// error cause
#define EPERM_ERROR_CAUSE               "to be continue"
#define ENOENT_ERROR_CAUSE              "to be continue"
#define ESRCH_ERROR_CAUSE               "to be continue"
#define EINTR_ERROR_CAUSE               "to be continue"
#define EIO_ERROR_CAUSE                 "to be continue"
#define ENXIO_ERROR_CAUSE               "to be continue"
#define E2BIG_ERROR_CAUSE               "to be continue"
#define ENOEXEC_ERROR_CAUSE             "to be continue"
#define EBADF_ERROR_CAUSE               "to be continue"
#define ECHILD_ERROR_CAUSE              "to be continue"
#define EAGAIN_ERROR_CAUSE              "to be continue"
#define ENOMEM_ERROR_CAUSE              "to be continue"
#define EACCES_ERROR_CAUSE              "to be continue"
#define EFAULT_ERROR_CAUSE              "to be continue"
#define ENOTBLK_ERROR_CAUSE             "to be continue"
#define EBUSY_ERROR_CAUSE               "to be continue"
#define EEXIST_ERROR_CAUSE              "to be continue"
#define EXDEV_ERROR_CAUSE               "to be continue"
#define ENODEV_ERROR_CAUSE              "to be continue"
#define ENOTDIR_ERROR_CAUSE             "to be continue"
#define EISDIR_ERROR_CAUSE              "to be continue"
#define EINVAL_ERROR_CAUSE              "to be continue"
#define ENFILE_ERROR_CAUSE              "to be continue"
#define EMFILE_ERROR_CAUSE              "to be continue"
#define ENOTTY_ERROR_CAUSE              "to be continue"
#define ETXTBSY_ERROR_CAUSE             "to be continue"
#define EFBIG_ERROR_CAUSE               "to be continue"
#define ENOSPC_ERROR_CAUSE              "to be continue"
#define ESPIPE_ERROR_CAUSE              "to be continue"
#define EROFS_ERROR_CAUSE               "to be continue"
#define EMLINK_ERROR_CAUSE              "to be continue"
#define EPIPE_ERROR_CAUSE               "to be continue"
#define EDOM_ERROR_CAUSE                "to be continue"
#define ERANGE_ERROR_CAUSE              "to be continue"
#define EDEADLK_ERROR_CAUSE             "to be continue"
#define ENAMETOOLONG_ERROR_CAUSE        "to be continue"
#define ENOLCK_ERROR_CAUSE              "to be continue"
#define ENOSYS_ERROR_CAUSE              "to be continue"
#define ENOTEMPTY_ERROR_CAUSE           "to be continue"
#define ELOOP_ERROR_CAUSE               "to be continue"
#define EWOULDBLOCK_ERROR_CAUSE         "to be continue"
#define ENOMSG_ERROR_CAUSE              "to be continue"
#define EIDRM_ERROR_CAUSE               "to be continue"
#define ECHRNG_ERROR_CAUSE              "to be continue"
#define EL2NSYNC_ERROR_CAUSE            "to be continue"
#define EL3HLT_ERROR_CAUSE              "to be continue"
#define EL3RST_ERROR_CAUSE              "to be continue"
#define ELNRNG_ERROR_CAUSE              "to be continue"
#define EUNATCH_ERROR_CAUSE             "to be continue"
#define ENOCSI_ERROR_CAUSE              "to be continue"
#define EL2HLT_ERROR_CAUSE              "to be continue"
#define EBADE_ERROR_CAUSE               "to be continue"
#define EBADR_ERROR_CAUSE               "to be continue"
#define EXFULL_ERROR_CAUSE              "to be continue"
#define ENOANO_ERROR_CAUSE              "to be continue"
#define EBADRQC_ERROR_CAUSE             "to be continue"
#define EBADSLT_ERROR_CAUSE             "to be continue"

#define EBFONT_ERROR_CAUSE              "to be continue"
#define ENOSTR_ERROR_CAUSE              "to be continue"
#define ENODATA_ERROR_CAUSE             "to be continue"
#define ETIME_ERROR_CAUSE               "to be continue"
#define ENOSR_ERROR_CAUSE               "to be continue"
#define ENONET_ERROR_CAUSE              "to be continue"
#define ENOPKG_ERROR_CAUSE              "to be continue"
#define EREMOTE_ERROR_CAUSE             "to be continue"
#define ENOLINK_ERROR_CAUSE             "to be continue"
#define EADV_ERROR_CAUSE                "to be continue"
#define ESRMNT_ERROR_CAUSE              "to be continue"
#define ECOMM_ERROR_CAUSE               "to be continue"
#define EPROTO_ERROR_CAUSE              "to be continue"
#define EMULTIHOP_ERROR_CAUSE           "to be continue"
#define EDOTDOT_ERROR_CAUSE             "to be continue"
#define EBADMSG_ERROR_CAUSE             "to be continue"
#define EOVERFLOW_ERROR_CAUSE           "to be continue"
#define ENOTUNIQ_ERROR_CAUSE            "to be continue"
#define EBADFD_ERROR_CAUSE              "to be continue"
#define EREMCHG_ERROR_CAUSE             "to be continue"
#define ELIBACC_ERROR_CAUSE             "to be continue"
#define ELIBBAD_ERROR_CAUSE             "to be continue"
#define ELIBSCN_ERROR_CAUSE             "to be continue"
#define ELIBMAX_ERROR_CAUSE             "to be continue"
#define ELIBEXEC_ERROR_CAUSE            "to be continue"
#define EILSEQ_ERROR_CAUSE              "to be continue"
#define ERESTART_ERROR_CAUSE            "to be continue"
#define ESTRPIPE_ERROR_CAUSE            "to be continue"
#define EUSERS_ERROR_CAUSE              "to be continue"
#define ENOTSOCK_ERROR_CAUSE            "to be continue"
#define EDESTADDRREQ_ERROR_CAUSE        "to be continue"
#define EMSGSIZE_ERROR_CAUSE            "to be continue"
#define EPROTOTYPE_ERROR_CAUSE          "to be continue"
#define ENOPROTOOPT_ERROR_CAUSE         "to be continue"
#define EPROTONOSUPPORT_ERROR_CAUSE     "to be continue" 
#define ESOCKTNOSUPPORT_ERROR_CAUSE     "to be continue"
#define EOPNOTSUPP_ERROR_CAUSE          "to be continue"  
#define EPFNOSUPPORT_ERROR_CAUSE        "to be continue"
#define EAFNOSUPPORT_ERROR_CAUSE        "to be continue"
#define EADDRINUSE_ERROR_CAUSE          "to be continue"
#define EADDRNOTAVAIL_ERROR_CAUSE       "to be continue"
#define ENETDOWN_ERROR_CAUSE            "to be continue"
#define ENETUNREACH_ERROR_CAUSE         "to be continue"
#define ENETRESET_ERROR_CAUSE           "to be continue"
#define ECONNABORTED_ERROR_CAUSE        "to be continue"
#define ECONNRESET_ERROR_CAUSE          "to be continue"
#define ENOBUFS_ERROR_CAUSE             "to be continue"
#define EISCONN_ERROR_CAUSE             "to be continue"
#define ENOTCONN_ERROR_CAUSE            "to be continue"
#define ESHUTDOWN_ERROR_CAUSE           "to be continue"
#define ETOOMANYREFS_ERROR_CAUSE        "to be continue"
#define ETIMEDOUT_ERROR_CAUSE           "to be continue"
#define ECONNREFUSED_ERROR_CAUSE        "to be continue"
#define EHOSTDOWN_ERROR_CAUSE           "to be continue"
#define EHOSTUNREACH_ERROR_CAUSE        "to be continue"
#define EALREADY_ERROR_CAUSE            "to be continue"
#define EINPROGRESS_ERROR_CAUSE         "to be continue"
#define ESTALE_ERROR_CAUSE              "to be continue"
#define EUCLEAN_ERROR_CAUSE             "to be continue"
#define ENOTNAM_ERROR_CAUSE             "to be continue"
#define ENAVAIL_ERROR_CAUSE             "to be continue"
#define EISNAM_ERROR_CAUSE              "to be continue"
#define EREMOTEIO_ERROR_CAUSE           "to be continue"
#define EDQUOT_ERROR_CAUSE              "to be continue"
#define ENOMEDIUM_ERROR_CAUSE           "to be continue"
#define EMEDIUMTYPE_ERROR_CAUSE         "to be continue"
#define ECANCELED_ERROR_CAUSE           "to be continue"
#define ENOKEY_ERROR_CAUSE              "to be continue"
#define EKEYEXPIRED_ERROR_CAUSE         "to be continue"
#define EKEYREVOKED_ERROR_CAUSE         "to be continue"
#define EKEYREJECTED_ERROR_CAUSE        "to be continue"

#define EOWNERDEAD_ERROR_CAUSE          "to be continue"
#define ENOTRECOVERABLE_ERROR_CAUSE     "to be continue"
#define ERFKILL_ERROR_CAUSE             "to be continue"
#define EHWPOISON_ERROR_CAUSE           "to be continue"

// error solution
#define EPERM_ERROR_SOLUTION               "to be continue"
#define ENOENT_ERROR_SOLUTION              "to be continue"
#define ESRCH_ERROR_SOLUTION               "to be continue"
#define EINTR_ERROR_SOLUTION               "to be continue"
#define EIO_ERROR_SOLUTION                 "to be continue"
#define ENXIO_ERROR_SOLUTION               "to be continue"
#define E2BIG_ERROR_SOLUTION               "to be continue"
#define ENOEXEC_ERROR_SOLUTION             "to be continue"
#define EBADF_ERROR_SOLUTION               "to be continue"
#define ECHILD_ERROR_SOLUTION              "to be continue"
#define EAGAIN_ERROR_SOLUTION              "to be continue"
#define ENOMEM_ERROR_SOLUTION              "to be continue"
#define EACCES_ERROR_SOLUTION              "to be continue"
#define EFAULT_ERROR_SOLUTION              "to be continue"
#define ENOTBLK_ERROR_SOLUTION             "to be continue"
#define EBUSY_ERROR_SOLUTION               "to be continue"
#define EEXIST_ERROR_SOLUTION              "to be continue"
#define EXDEV_ERROR_SOLUTION               "to be continue"
#define ENODEV_ERROR_SOLUTION              "to be continue"
#define ENOTDIR_ERROR_SOLUTION             "to be continue"
#define EISDIR_ERROR_SOLUTION              "to be continue"
#define EINVAL_ERROR_SOLUTION              "to be continue"
#define ENFILE_ERROR_SOLUTION              "to be continue"
#define EMFILE_ERROR_SOLUTION              "to be continue"
#define ENOTTY_ERROR_SOLUTION              "to be continue"
#define ETXTBSY_ERROR_SOLUTION             "to be continue"
#define EFBIG_ERROR_SOLUTION               "to be continue"
#define ENOSPC_ERROR_SOLUTION              "to be continue"
#define ESPIPE_ERROR_SOLUTION              "to be continue"
#define EROFS_ERROR_SOLUTION               "to be continue"
#define EMLINK_ERROR_SOLUTION              "to be continue"
#define EPIPE_ERROR_SOLUTION               "to be continue"
#define EDOM_ERROR_SOLUTION                "to be continue"
#define ERANGE_ERROR_SOLUTION              "to be continue"
#define EDEADLK_ERROR_SOLUTION             "to be continue"
#define ENAMETOOLONG_ERROR_SOLUTION        "to be continue"
#define ENOLCK_ERROR_SOLUTION              "to be continue"
#define ENOSYS_ERROR_SOLUTION              "to be continue"
#define ENOTEMPTY_ERROR_SOLUTION           "to be continue"
#define ELOOP_ERROR_SOLUTION               "to be continue"
#define EWOULDBLOCK_ERROR_SOLUTION         "to be continue"
#define ENOMSG_ERROR_SOLUTION              "to be continue"
#define EIDRM_ERROR_SOLUTION               "to be continue"
#define ECHRNG_ERROR_SOLUTION              "to be continue"
#define EL2NSYNC_ERROR_SOLUTION            "to be continue"
#define EL3HLT_ERROR_SOLUTION              "to be continue"
#define EL3RST_ERROR_SOLUTION              "to be continue"
#define ELNRNG_ERROR_SOLUTION              "to be continue"
#define EUNATCH_ERROR_SOLUTION             "to be continue"
#define ENOCSI_ERROR_SOLUTION              "to be continue"
#define EL2HLT_ERROR_SOLUTION              "to be continue"
#define EBADE_ERROR_SOLUTION               "to be continue"
#define EBADR_ERROR_SOLUTION               "to be continue"
#define EXFULL_ERROR_SOLUTION              "to be continue"
#define ENOANO_ERROR_SOLUTION              "to be continue"
#define EBADRQC_ERROR_SOLUTION             "to be continue"
#define EBADSLT_ERROR_SOLUTION             "to be continue"

#define EBFONT_ERROR_SOLUTION              "to be continue"
#define ENOSTR_ERROR_SOLUTION              "to be continue"
#define ENODATA_ERROR_SOLUTION             "to be continue"
#define ETIME_ERROR_SOLUTION               "to be continue"
#define ENOSR_ERROR_SOLUTION               "to be continue"
#define ENONET_ERROR_SOLUTION              "to be continue"
#define ENOPKG_ERROR_SOLUTION              "to be continue"
#define EREMOTE_ERROR_SOLUTION             "to be continue"
#define ENOLINK_ERROR_SOLUTION             "to be continue"
#define EADV_ERROR_SOLUTION                "to be continue"
#define ESRMNT_ERROR_SOLUTION              "to be continue"
#define ECOMM_ERROR_SOLUTION               "to be continue"
#define EPROTO_ERROR_SOLUTION              "to be continue"
#define EMULTIHOP_ERROR_SOLUTION           "to be continue"
#define EDOTDOT_ERROR_SOLUTION             "to be continue"
#define EBADMSG_ERROR_SOLUTION             "to be continue"
#define EOVERFLOW_ERROR_SOLUTION           "to be continue"
#define ENOTUNIQ_ERROR_SOLUTION            "to be continue"
#define EBADFD_ERROR_SOLUTION              "to be continue"
#define EREMCHG_ERROR_SOLUTION             "to be continue"
#define ELIBACC_ERROR_SOLUTION             "to be continue"
#define ELIBBAD_ERROR_SOLUTION             "to be continue"
#define ELIBSCN_ERROR_SOLUTION             "to be continue"
#define ELIBMAX_ERROR_SOLUTION             "to be continue"
#define ELIBEXEC_ERROR_SOLUTION            "to be continue"
#define EILSEQ_ERROR_SOLUTION              "to be continue"
#define ERESTART_ERROR_SOLUTION            "to be continue"
#define ESTRPIPE_ERROR_SOLUTION            "to be continue"
#define EUSERS_ERROR_SOLUTION              "to be continue"
#define ENOTSOCK_ERROR_SOLUTION            "to be continue"
#define EDESTADDRREQ_ERROR_SOLUTION        "to be continue"
#define EMSGSIZE_ERROR_SOLUTION            "to be continue"
#define EPROTOTYPE_ERROR_SOLUTION          "to be continue"
#define ENOPROTOOPT_ERROR_SOLUTION         "to be continue"
#define EPROTONOSUPPORT_ERROR_SOLUTION     "to be continue" 
#define ESOCKTNOSUPPORT_ERROR_SOLUTION     "to be continue"
#define EOPNOTSUPP_ERROR_SOLUTION          "to be continue"  
#define EPFNOSUPPORT_ERROR_SOLUTION        "to be continue"
#define EAFNOSUPPORT_ERROR_SOLUTION        "to be continue"
#define EADDRINUSE_ERROR_SOLUTION          "to be continue"
#define EADDRNOTAVAIL_ERROR_SOLUTION       "to be continue"
#define ENETDOWN_ERROR_SOLUTION            "to be continue"
#define ENETUNREACH_ERROR_SOLUTION         "to be continue"
#define ENETRESET_ERROR_SOLUTION           "to be continue"
#define ECONNABORTED_ERROR_SOLUTION        "to be continue"
#define ECONNRESET_ERROR_SOLUTION          "to be continue"
#define ENOBUFS_ERROR_SOLUTION             "to be continue"
#define EISCONN_ERROR_SOLUTION             "to be continue"
#define ENOTCONN_ERROR_SOLUTION            "to be continue"
#define ESHUTDOWN_ERROR_SOLUTION           "to be continue"
#define ETOOMANYREFS_ERROR_SOLUTION        "to be continue"
#define ETIMEDOUT_ERROR_SOLUTION           "to be continue"
#define ECONNREFUSED_ERROR_SOLUTION        "to be continue"
#define EHOSTDOWN_ERROR_SOLUTION           "to be continue"
#define EHOSTUNREACH_ERROR_SOLUTION        "to be continue"
#define EALREADY_ERROR_SOLUTION            "to be continue"
#define EINPROGRESS_ERROR_SOLUTION         "to be continue"
#define ESTALE_ERROR_SOLUTION              "to be continue"
#define EUCLEAN_ERROR_SOLUTION             "to be continue"
#define ENOTNAM_ERROR_SOLUTION             "to be continue"
#define ENAVAIL_ERROR_SOLUTION             "to be continue"
#define EISNAM_ERROR_SOLUTION              "to be continue"
#define EREMOTEIO_ERROR_SOLUTION           "to be continue"
#define EDQUOT_ERROR_SOLUTION              "to be continue"
#define ENOMEDIUM_ERROR_SOLUTION           "to be continue"
#define EMEDIUMTYPE_ERROR_SOLUTION         "to be continue"
#define ECANCELED_ERROR_SOLUTION           "to be continue"
#define ENOKEY_ERROR_SOLUTION              "to be continue"
#define EKEYEXPIRED_ERROR_SOLUTION         "to be continue"
#define EKEYREVOKED_ERROR_SOLUTION         "to be continue"
#define EKEYREJECTED_ERROR_SOLUTION        "to be continue"

#define EOWNERDEAD_ERROR_SOLUTION          "to be continue"
#define ENOTRECOVERABLE_ERROR_SOLUTION     "to be continue"
#define ERFKILL_ERROR_SOLUTION             "to be continue"
#define EHWPOISON_ERROR_SOLUTION           "to be continue"

// functions
const char* str_os_error_name(int errorcode);
const char* str_os_error_msg(int errorcode);
const char* str_os_error_cause(int errorcode);
const char* str_os_error_solution(int errorcode);

#endif /* __OBERROR_LIB_OS_ERROR_H__ */