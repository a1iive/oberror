#!/usr/bin/env perl
# Copyright 2016 Alibaba Inc. All Rights Reserved.
# This program is free software; you can redistribute it and/or
# modify it under the terms of the GNU General Public License
# version 2 as published by the Free Software Foundation.
# author: <zhuweng.yzf@taobao.com> Zhifeng YANG
# nomalizer: xueya.jxy <xueya.jxy@alibaba-inc.com>
# create date: 06 Nov 2013
# description: script to generate ob_errno.h from ob_errno.def

use strict;
use warnings;
open my $fh, '<', "ob_errno.def";
my %map_share;
my %other_map_share;
my %map_deps;
my %other_map_deps;
my %map;
my %other_map;
my $last_errno = 0;
my $error_count=0;
my $def_ora_errno=600;
my $def_ora_errmsg="\"internal error code, arguments: %d, %s\"";
my $print_def_ora_errmsg="\"%s-%05d: internal error code, arguments: %d, %s\"";
my $print_ora_errmsg="\"%s-%05d: %s\"";
my $print_error_cause="\"to be continue\"";
my $print_error_solution="\"to be continue\"";

while(<$fh>) {
  my $error_msg;
  my $sqlstate;
  my $error_code;

  if (/^DEFINE_ERROR\(([^,]+),\s*([^,]*),\s*([^,]*),\s*([^,]*),\s*([^,]*),\s*([^,]*),\s*("[^"]*")/) {
    ++$error_count;
    #print "\"$1\", $1, $2, $3, $4, $5, $6, $7\n";
    my $tmp_ora_errmsg=sprintf($print_def_ora_errmsg, "ORA", $def_ora_errno, $2, substr($5, 1, length($5) - 2));
    $map_share{$1} = [$2, $3, $4, $5, $5, "$1", $def_ora_errno, $tmp_ora_errmsg, $tmp_ora_errmsg, $6, $7];
    $map{$1} = [$2, $3, $4, $5, $5, "$1", $def_ora_errno, $tmp_ora_errmsg, $tmp_ora_errmsg, $6, $7];
    $last_errno = $2 if ($2 < $last_errno);
    $error_code = $2;
    $sqlstate = $4;
    $error_msg = $5;
  } elsif (/^DEFINE_ERROR_EXT\(([^,]+),\s*([^,]*),\s*([^,]*),\s*([^,]*),\s*([^,]*),\s*([^,]*),\s*([^,]*),\s*("[^"]*")/) {
    ++$error_count;
    #print "\"$1\", $1, $2, $3, $4, $5, $6, $7, $8\n";
    my $tmp_ora_errmsg=sprintf($print_def_ora_errmsg, "ORA", $def_ora_errno, $2, substr($5, 1, length($5) - 2));
    my $tmp_ora_user_errmsg=sprintf($print_def_ora_errmsg, "ORA", $def_ora_errno, $2, substr($6, 1, length($6) - 2));
    $map_share{$1} = [$2, $3, $4, $5, $6, "$1", $def_ora_errno, $tmp_ora_errmsg, $tmp_ora_user_errmsg, $7, $8];
    $map{$1} = [$2, $3, $4, $5, $6, "$1", $def_ora_errno, $tmp_ora_errmsg, $tmp_ora_user_errmsg, $7, $8];
    $last_errno = $2 if ($2 < $last_errno);
    $error_code = $2;
    $sqlstate = $4;
    $error_msg = $5;
  } elsif (/^DEFINE_ORACLE_ERROR\(([^,]+),\s*([^,]*),\s*([^,]*),\s*([^,]*),\s*([^,]*),\s*([^,]*),\s*("[^"]*")\s*,\s*([^,]*),\s*("[^"]*")/) {
    ++$error_count;
    #print "\"$1\", $1, $2, $3, $4, $5, $6, $7, $8, $9\n";
    my $tmp_ora_errmsg=sprintf($print_ora_errmsg, "ORA", $6, substr($7, 1, length($7) - 2));
    $map_share{$1} = [$2, $3, $4, $5, $5, "$1", $6, $tmp_ora_errmsg, $tmp_ora_errmsg, $8, $9];
    $map{$1} = [$2, $3, $4, $5, $5, "$1", $6, $tmp_ora_errmsg, $tmp_ora_errmsg, $8, $9];
    $last_errno = $2 if ($2 < $last_errno);
    $error_code = $2;
    $sqlstate = $4;
    $error_msg = $5;
  } elsif (/^DEFINE_ORACLE_ERROR_EXT\(([^,]+),\s*([^,]*),\s*([^,]*),\s*([^,]*),\s*([^,]*),\s*([^,]*),\s*("[^"]*")\s*,\s*("[^"]*")\s*,\s*([^,]*),\s*("[^"]*")\s*,\s*("[^"]*")/) {
    ++$error_count;
    #print "\"$1\", $1, $2, $3, $4, $5, $6, $7, $8, $9, $10, $11\n";
    my $tmp_ora_errmsg=sprintf($print_ora_errmsg, "ORA", $7, substr($8, 1, length($8) - 2));
    my $tmp_ora_user_errmsg=sprintf($print_ora_errmsg, "ORA", $7, substr($9, 1, length($9) - 2));
    $map_share{$1} = [$2, $3, $4, $5, $6, "$1", $7, $tmp_ora_errmsg, $tmp_ora_user_errmsg, $10, $11];
    $map{$1} = [$2, $3, $4, $5, $6, "$1", $7, $tmp_ora_errmsg, $tmp_ora_user_errmsg, $10, $11];
    $last_errno = $2 if ($2 < $last_errno);
    $error_code = $2;
    $sqlstate = $4;
    $error_msg = $5;
  } elsif (/^DEFINE_PLS_ERROR\(([^,]+),\s*([^,]*),\s*([^,]*),\s*([^,]*),\s*([^,]*),\s*([^,]*),\s*("[^"]*")\s*,\s*([^,]*),\s*("[^"]*")/) {
    ++$error_count;
    #print "\"$1\", $1, $2, $3, $4, $5, $6, $7, $8, $9\n";
    my $tmp_ora_errmsg=sprintf($print_ora_errmsg, "PLS", $6, substr($7, 1, length($7) - 2));
    $map_share{$1} = [$2, $3, $4, $5, $5, "$1", $6, $tmp_ora_errmsg, $tmp_ora_errmsg, $8, $9];
    $map{$1} = [$2, $3, $4, $5, $5, "$1", $6, $tmp_ora_errmsg, $tmp_ora_errmsg, $8, $9];
    $last_errno = $2 if ($2 < $last_errno);
    $error_code = $2;
    $sqlstate = $4;
    $error_msg = $5;
  } elsif (/^DEFINE_PLS_ERROR_EXT\(([^,]+),\s*([^,]*),\s*([^,]*),\s*([^,]*),\s*([^,]*),\s*([^,]*),\s*("[^"]*")\s*,\s*("[^"]*")\s*,\s*([^,]*),\s*("[^"]*")\s*,\s*("[^"]*")/) {
    ++$error_count;
    #print "\"$1\", $1, $2, $3, $4, $5, $6, $7, $8, $9, $10, $11\n";
    my $tmp_ora_errmsg=sprintf($print_ora_errmsg, "PLS", $7, substr($8, 1, length($8) - 2));
    my $tmp_ora_user_errmsg=sprintf($print_ora_errmsg, "PLS", $7, substr($9, 1, length($9) - 2));
    $map_share{$1} = [$2, $3, $4, $5, $6, "$1", $7, $tmp_ora_errmsg, $tmp_ora_user_errmsg, $10, $11];
    $map{$1} = [$2, $3, $4, $5, $6, "$1", $7, $tmp_ora_errmsg, $tmp_ora_user_errmsg, $10, $11];
    $last_errno = $2 if ($2 < $last_errno);
    $error_code = $2;
    $sqlstate = $4;
    $error_msg = $5;
  } elsif (/^DEFINE_ERROR\(([^,]+),\s*([^,]*),\s*([^,]*),\s*([^,]*),\s*("[^"]*")/) {
    ++$error_count;
    #print "\"$1\", $1, $2, $3, $4, $5\n";
    my $tmp_ora_errmsg=sprintf($print_def_ora_errmsg, "ORA", $def_ora_errno, $2, substr($5, 1, length($5) - 2));
    $map_share{$1} = [$2, $3, $4, $5, $5, "$1", $def_ora_errno, $tmp_ora_errmsg, $tmp_ora_errmsg, $print_error_cause, $print_error_solution];
    $map{$1} = [$2, $3, $4, $5, $5, "$1", $def_ora_errno, $tmp_ora_errmsg, $tmp_ora_errmsg, $print_error_cause, $print_error_solution];
    $last_errno = $2 if ($2 < $last_errno);
    $error_code = $2;
    $sqlstate = $4;
    $error_msg = $5;
  } elsif (/^DEFINE_ERROR_EXT\(([^,]+),\s*([^,]*),\s*([^,]*),\s*([^,]*),\s*([^,]*),\s*("[^"]*")/) {
    ++$error_count;
    #print "\"$1\", $1, $2, $3, $4, $5, $6\n";
    my $tmp_ora_errmsg=sprintf($print_def_ora_errmsg, "ORA", $def_ora_errno, $2, substr($5, 1, length($5) - 2));
    my $tmp_ora_user_errmsg=sprintf($print_def_ora_errmsg, "ORA", $def_ora_errno, $2, substr($6, 1, length($6) - 2));
    $map_share{$1} = [$2, $3, $4, $5, $6, "$1", $def_ora_errno, $tmp_ora_errmsg, $tmp_ora_user_errmsg, $print_error_cause, $print_error_solution];
    $map{$1} = [$2, $3, $4, $5, $6, "$1", $def_ora_errno, $tmp_ora_errmsg, $tmp_ora_user_errmsg, $print_error_cause, $print_error_solution];
    $last_errno = $2 if ($2 < $last_errno);
    $error_code = $2;
    $sqlstate = $4;
    $error_msg = $5;
  } elsif (/^DEFINE_ORACLE_ERROR\(([^,]+),\s*([^,]*),\s*([^,]*),\s*([^,]*),\s*("[^"]*")\s*,\s*([^,]*),\s*("[^"]*")/) {
    ++$error_count;
    #print "\"$1\", $1, $2, $3, $4, $5, $6, $7\n";
    #print "\"$1\", $6, $7\n";
    my $tmp_ora_errmsg=sprintf($print_ora_errmsg, "ORA", $6, substr($7, 1, length($7) - 2));
    $map_share{$1} = [$2, $3, $4, $5, $5, "$1", $6, $tmp_ora_errmsg, $tmp_ora_errmsg, $print_error_cause, $print_error_solution];
    $map{$1} = [$2, $3, $4, $5, $5, "$1", $6, $tmp_ora_errmsg, $tmp_ora_errmsg, $print_error_cause, $print_error_solution];
    $last_errno = $2 if ($2 < $last_errno);
    $error_code = $2;
    $sqlstate = $4;
    $error_msg = $5;
  } elsif (/^DEFINE_ORACLE_ERROR_EXT\(([^,]+),\s*([^,]*),\s*([^,]*),\s*([^,]*),\s*("[^"]*")\s*,\s*("[^"]*")\s*,\s*([^,]*),\s*("[^"]*")\s*,\s*("[^"]*")/) {
    ++$error_count;
    #print "\"$1\", $1, $2, $3, $4, $5, $6, $7, $8, $9\n";
    #print "\"$1\", $7, $8, $9\n";
    my $tmp_ora_errmsg=sprintf($print_ora_errmsg, "ORA", $7, substr($8, 1, length($8) - 2));
    my $tmp_ora_user_errmsg=sprintf($print_ora_errmsg, "ORA", $7, substr($9, 1, length($9) - 2));
    $map_share{$1} = [$2, $3, $4, $5, $6, "$1", $7, $tmp_ora_errmsg, $tmp_ora_user_errmsg, $print_error_cause, $print_error_solution];
    $map{$1} = [$2, $3, $4, $5, $6, "$1", $7, $tmp_ora_errmsg, $tmp_ora_user_errmsg, $print_error_cause, $print_error_solution];
    $last_errno = $2 if ($2 < $last_errno);
    $error_code = $2;
    $sqlstate = $4;
    $error_msg = $5;
  } elsif (/^DEFINE_OTHER_MSG_FMT\(([^,]+),\s*([^,]*),\s*("[^"]*")\s*,\s*("[^"]*")/) {
    #print "\"$1\", $1, $2, $3, $4\n";
    $other_map_share{$1} = [$2, $3, $4];
    $other_map{$1} = [$2, $3, $4];
  } elsif (/^DEFINE_PLS_ERROR\(([^,]+),\s*([^,]*),\s*([^,]*),\s*([^,]*),\s*("[^"]*")\s*,\s*([^,]*),\s*("[^"]*")/) {
    ++$error_count;
    #print "\"$1\", $1, $2, $3, $4, $5, $6, $7\n";
    #print "\"$1\", $6, $7\n";
    my $tmp_ora_errmsg=sprintf($print_ora_errmsg, "PLS", $6, substr($7, 1, length($7) - 2));
    $map_share{$1} = [$2, $3, $4, $5, $5, "$1", $6, $tmp_ora_errmsg, $tmp_ora_errmsg, $print_error_cause, $print_error_solution];
    $map{$1} = [$2, $3, $4, $5, $5, "$1", $6, $tmp_ora_errmsg, $tmp_ora_errmsg, $print_error_cause, $print_error_solution];
    $last_errno = $2 if ($2 < $last_errno);
    $error_code = $2;
    $sqlstate = $4;
    $error_msg = $5;
  } elsif (/^DEFINE_PLS_ERROR_EXT\(([^,]+),\s*([^,]*),\s*([^,]*),\s*([^,]*),\s*("[^"]*")\s*,\s*("[^"]*")\s*,\s*([^,]*),\s*("[^"]*")\s*,\s*("[^"]*")/) {
    ++$error_count;
    #print "\"$1\", $1, $2, $3, $4, $5, $6, $7, $8, $9\n";
    #print "\"$1\", $7, $8, $9\n";
    my $tmp_ora_errmsg=sprintf($print_ora_errmsg, "PLS", $7, substr($8, 1, length($8) - 2));
    my $tmp_ora_user_errmsg=sprintf($print_ora_errmsg, "PLS", $7, substr($9, 1, length($9) - 2));
    $map_share{$1} = [$2, $3, $4, $5, $6, "$1", $7, $tmp_ora_errmsg, $tmp_ora_user_errmsg, $print_error_cause, $print_error_solution];
    $map{$1} = [$2, $3, $4, $5, $6, "$1", $7, $tmp_ora_errmsg, $tmp_ora_user_errmsg, $print_error_cause, $print_error_solution];
    $last_errno = $2 if ($2 < $last_errno);
    $error_code = $2;
    $sqlstate = $4;
    $error_msg = $5;
  } elsif (/^DEFINE_ORACLE_ERROR_V2_EXT\(([^,]+),\s*([^,]*),\s*([^,]*),\s*([^,]*),\s*("[^"]*")\s*,\s*("[^"]*")\s*,\s*([^,]*),\s*("[^"]*")\s*,\s*("[^"]*")/) {
    ++$error_count;
    #print "\"$1\", $1, $2, $3, $4, $5, $6, $7, $8, $9\n";
    #print "\"$1\", $7, $8, $9\n";
    my $tmp_ora_errmsg=sprintf("\"%s\"", substr($8, 1, length($8) - 2));
    my $tmp_ora_user_errmsg=sprintf("\"%s\"", substr($9, 1, length($9) - 2));
    $map_share{$1} = [$2, $3, $4, $5, $6, "$1", $7, $tmp_ora_errmsg, $tmp_ora_user_errmsg, $print_error_cause, $print_error_solution];
    $map{$1} = [$2, $3, $4, $5, $6, "$1", $7, $tmp_ora_errmsg, $tmp_ora_user_errmsg, $print_error_cause, $print_error_solution];
    $last_errno = $2 if ($2 < $last_errno);
    $error_code = $2;
    $sqlstate = $4;
    $error_msg = $5;
  } elsif (/^DEFINE_ERROR_DEP\(([^,]+),\s*([^,]*),\s*([^,]*),\s*([^,]*),\s*("[^"]*")/) {
    ++$error_count;
    #print "\"$1\", $1, $2, $3, $4, $5\n";
    my $tmp_ora_errmsg=sprintf($print_def_ora_errmsg, "ORA", $def_ora_errno, $2, substr($5, 1, length($5) - 2));
    $map_deps{$1} = [$2, $3, $4, $5, $5, "$1", $def_ora_errno, $tmp_ora_errmsg, $tmp_ora_errmsg];
    $map{$1} = [$2, $3, $4, $5, $5, "$1", $def_ora_errno, $tmp_ora_errmsg, $tmp_ora_errmsg];
    $last_errno = $2 if ($2 < $last_errno);
    $error_code = $2;
    $sqlstate = $4;
    $error_msg = $5;
  } elsif (/^DEFINE_ERROR_EXT_DEP\(([^,]+),\s*([^,]*),\s*([^,]*),\s*([^,]*),\s*([^,]*),\s*("[^"]*")/) {
    ++$error_count;
    #print "\"$1\", $1, $2, $3, $4, $5, $6\n";
    my $tmp_ora_errmsg=sprintf($print_def_ora_errmsg, "ORA", $def_ora_errno, $2, substr($5, 1, length($5) - 2));
    my $tmp_ora_user_errmsg=sprintf($print_def_ora_errmsg, "ORA", $def_ora_errno, $2, substr($6, 1, length($6) - 2));
    $map_deps{$1} = [$2, $3, $4, $5, $6, "$1", $def_ora_errno, $tmp_ora_errmsg, $tmp_ora_user_errmsg];
    $map{$1} = [$2, $3, $4, $5, $6, "$1", $def_ora_errno, $tmp_ora_errmsg, $tmp_ora_user_errmsg];
    $last_errno = $2 if ($2 < $last_errno);
    $error_code = $2;
    $sqlstate = $4;
    $error_msg = $5;
  } elsif (/^DEFINE_ORACLE_ERROR_DEP\(([^,]+),\s*([^,]*),\s*([^,]*),\s*([^,]*),\s*("[^"]*")\s*,\s*([^,]*),\s*("[^"]*")/) {
    ++$error_count;
    #print "\"$1\", $1, $2, $3, $4, $5, $6, $7\n";
    #print "\"$1\", $6, $7\n";
    my $tmp_ora_errmsg=sprintf($print_ora_errmsg, "ORA", $6, substr($7, 1, length($7) - 2));
    $map_deps{$1} = [$2, $3, $4, $5, $5, "$1", $6, $tmp_ora_errmsg, $tmp_ora_errmsg];
    $map{$1} = [$2, $3, $4, $5, $5, "$1", $6, $tmp_ora_errmsg, $tmp_ora_errmsg];
    $last_errno = $2 if ($2 < $last_errno);
    $error_code = $2;
    $sqlstate = $4;
    $error_msg = $5;
  } elsif (/^DEFINE_ORACLE_ERROR_EXT_DEP\(([^,]+),\s*([^,]*),\s*([^,]*),\s*([^,]*),\s*("[^"]*")\s*,\s*("[^"]*")\s*,\s*([^,]*),\s*("[^"]*")\s*,\s*("[^"]*")/) {
    ++$error_count;
    #print "\"$1\", $1, $2, $3, $4, $5, $6, $7, $8, $9\n";
    #print "\"$1\", $7, $8, $9\n";
    my $tmp_ora_errmsg=sprintf($print_ora_errmsg, "ORA", $7, substr($8, 1, length($8) - 2));
    my $tmp_ora_user_errmsg=sprintf($print_ora_errmsg, "ORA", $7, substr($9, 1, length($9) - 2));
    $map_deps{$1} = [$2, $3, $4, $5, $6, "$1", $7, $tmp_ora_errmsg, $tmp_ora_user_errmsg];
    $map{$1} = [$2, $3, $4, $5, $6, "$1", $7, $tmp_ora_errmsg, $tmp_ora_user_errmsg];
    $last_errno = $2 if ($2 < $last_errno);
    $error_code = $2;
    $sqlstate = $4;
    $error_msg = $5;
  } elsif (/^DEFINE_OTHER_MSG_FMT_DEP\(([^,]+),\s*([^,]*),\s*("[^"]*")\s*,\s*("[^"]*")/) {
    #print "\"$1\", $1, $2, $3, $4\n";
    $other_map_deps{$1} = [$2, $3, $4];
    $other_map{$1} = [$2, $3, $4];
    } elsif (/^DEFINE_PLS_ERROR_DEP\(([^,]+),\s*([^,]*),\s*([^,]*),\s*([^,]*),\s*("[^"]*")\s*,\s*([^,]*),\s*("[^"]*")/) {
    ++$error_count;
    #print "\"$1\", $1, $2, $3, $4, $5, $6, $7\n";
    #print "\"$1\", $6, $7\n";
    my $tmp_ora_errmsg=sprintf($print_ora_errmsg, "PLS", $6, substr($7, 1, length($7) - 2));
    $map_deps{$1} = [$2, $3, $4, $5, $5, "$1", $6, $tmp_ora_errmsg, $tmp_ora_errmsg];
    $map{$1} = [$2, $3, $4, $5, $5, "$1", $6, $tmp_ora_errmsg, $tmp_ora_errmsg];
    $last_errno = $2 if ($2 < $last_errno);
    $error_code = $2;
    $sqlstate = $4;
    $error_msg = $5;
  } elsif (/^DEFINE_PLS_ERROR_EXT_DEP\(([^,]+),\s*([^,]*),\s*([^,]*),\s*([^,]*),\s*("[^"]*")\s*,\s*("[^"]*")\s*,\s*([^,]*),\s*("[^"]*")\s*,\s*("[^"]*")/) {
    ++$error_count;
    #print "\"$1\", $1, $2, $3, $4, $5, $6, $7, $8, $9\n";
    #print "\"$1\", $7, $8, $9\n";
    my $tmp_ora_errmsg=sprintf($print_ora_errmsg, "PLS", $7, substr($8, 1, length($8) - 2));
    my $tmp_ora_user_errmsg=sprintf($print_ora_errmsg, "PLS", $7, substr($9, 1, length($9) - 2));
    $map_deps{$1} = [$2, $3, $4, $5, $6, "$1", $7, $tmp_ora_errmsg, $tmp_ora_user_errmsg];
    $map{$1} = [$2, $3, $4, $5, $6, "$1", $7, $tmp_ora_errmsg, $tmp_ora_user_errmsg];
    $last_errno = $2 if ($2 < $last_errno);
    $error_code = $2;
    $sqlstate = $4;
    $error_msg = $5;
  } elsif (/^DEFINE_ORACLE_ERROR_V2_EXT_DEP\(([^,]+),\s*([^,]*),\s*([^,]*),\s*([^,]*),\s*("[^"]*")\s*,\s*("[^"]*")\s*,\s*([^,]*),\s*("[^"]*")\s*,\s*("[^"]*")/) {
    ++$error_count;
    #print "\"$1\", $1, $2, $3, $4, $5, $6, $7, $8, $9\n";
    #print "\"$1\", $7, $8, $9\n";
    my $tmp_ora_errmsg=sprintf("\"%s\"", substr($8, 1, length($8) - 2));
    my $tmp_ora_user_errmsg=sprintf("\"%s\"", substr($9, 1, length($9) - 2));
    $map_deps{$1} = [$2, $3, $4, $5, $6, "$1", $7, $tmp_ora_errmsg, $tmp_ora_user_errmsg];
    $map{$1} = [$2, $3, $4, $5, $6, "$1", $7, $tmp_ora_errmsg, $tmp_ora_user_errmsg];
    $last_errno = $2 if ($2 < $last_errno);
    $error_code = $2;
    $sqlstate = $4;
    $error_msg = $5;
  }
  if (defined $error_code) {
    print "WARN: undefined SQLSTATE for $1\n" if ($sqlstate eq "\"\"");
    print "WARN: undefined error message for $1\n" if ($error_msg eq "\"\"");
    print "WARN: error code out of range: $1\n" if ($error_code <= -1 && $error_code > -3000);
  }
}

print "total error code: $error_count\n";
print "please wait for writing files ...\n";
# check duplicate error number
my %dedup;
for my $oberr (keys % map) {
  my $errno = $map{$oberr}->[0];
  if (defined $dedup{$errno})
  {
    print "Error: error code($errno) is duplicated for $oberr and $dedup{$errno}\n";
    exit 1;
  } else {
    $dedup{$errno} = $oberr;
  }
}

# sort for share
my @pairs_share = map {[$_, $map_share{$_}->[0] ]} keys %map_share;
my @sorted_share = sort {$b->[1] <=> $a->[1]} @pairs_share;
my @errors_share = map {$_->[0]} @sorted_share;

# sort for deps
my @pairs_deps = map {[$_, $map_deps{$_}->[0] ]} keys %map_deps;
my @sorted_deps = sort {$b->[1] <=> $a->[1]} @pairs_deps;
my @errors_deps = map {$_->[0]} @sorted_deps;

# sort for all
my @pairs = map {[$_, $map{$_}->[0] ]} keys %map;
my @sorted = sort {$b->[1] <=> $a->[1]} @pairs;
my @errors = map {$_->[0]} @sorted;

# generate share/ob_errno.h
open my $fh_header, '>', "ob_errno.h";
print $fh_header '
// DO NOT EDIT. This file is automatically generated from `ob_errno.def\'.

// Copyright 2016 Alibaba Inc. All Rights Reserved.
// This program is free software; you can redistribute it and/or
// modify it under the terms of the GNU General Public License
// version 2 as published by the Free Software Foundation.
// ob_errno.h
//   Author:
//      zhuweng <zhuweng.yzf@taobao.com>
//   Normalizer:
//      xueya.jxy <xueya.jxy@alibaba-inc.com>

#ifndef __OBERROR_ERRNO_H__
#define __OBERROR_ERRNO_H__
#include <stdint.h>
#include <string.h>
#include "mysql_errno.h"
#include "./lib/ob_errno.h"

';
  print $fh_header "
constexpr int OB_LAST_ERROR_CODE = $last_errno;
constexpr int OB_ERR_SQL_START = -5000;
constexpr int OB_ERR_SQL_END = -5999;
";
  for my $oberr (@errors_share) {
    if (system "grep $oberr ./lib/ob_errno.h >/dev/null") {
      print $fh_header "constexpr int $oberr = $map_share{$oberr}->[0];\n";
    }
  }
  foreach my $oberr (keys %other_map){
    if (system "grep $oberr ./lib/ob_errno.h >/dev/null") {
      my $errno;
      if (exists($map{$other_map{$oberr}->[0]})){
        $errno = $map{$other_map{$oberr}->[0]}->[0];
      } else {
        print "Error: error code($other_map{$oberr}->[0]) is not exists\n";
        exit 1;
      }
      print $fh_header "constexpr int $oberr = $errno;\n";
    }
  }
  print $fh_header "\n\n";
  print $fh_header '

const char *ob_error_name(const int oberr);
const char* ob_error_cause(const int oberr);
const char* ob_error_solution(const int oberr);

int ob_mysql_errno(const int oberr);
int ob_mysql_errno_with_check(const int oberr);
const char *ob_sqlstate(const int oberr);
const char *ob_strerror(const int oberr);
const char *ob_str_user_error(const int oberr);

int ob_oracle_errno(const int oberr);
int ob_oracle_errno_with_check(const int oberr);
const char *ob_oracle_strerror(const int oberr);
const char *ob_oracle_str_user_error(const int oberr);

int ob_errpkt_errno(const int oberr, const bool is_oracle_mode);
const char *ob_errpkt_strerror(const int oberr, const bool is_oracle_mode);
const char *ob_errpkt_str_user_error(const int oberr, const bool is_oracle_mode);

int argument_exist(const char* error_msg);
void ob_init_error_to_oberror(int ora_err[][OB_MAX_SAME_ERRORCODE], 
    int pls_err[][OB_MAX_SAME_ERRORCODE], int mysql_err[][OB_MAX_SAME_ERRORCODE]);

#endif  // __OBERROR_ERRNO_H__
';

#generate dep/ob_errno.h
open my $fh_header_dep, '>', "./lib/ob_errno.h";
print $fh_header_dep '
// Copyright (c) 2018 Alibaba Inc. All Rights Reserved.
//
/// \file errno.h
/// \author Shi Yudi <fufeng.syd@alipay.com>
/// \date 2018-04-28
///

// DO NOT EDIT. This file is automatically generated from ob_errno.def.
// DO NOT EDIT. This file is automatically generated from ob_errno.def.
// DO NOT EDIT. This file is automatically generated from ob_errno.def.
// To add errno in this header file, you should use DEFINE_***_DEP to define errno in ob_errno.def
// For any question, call fyy280124
#ifndef __OBERROR_LIB_OB_ERRNO_H__
#define __OBERROR_LIB_OB_ERRNO_H__


constexpr int OB_MAX_SAME_ERRORCODE                  = 5; // maybe larger in the future
constexpr int OB_MAX_ERROR_CODE                      = 65535;
';

for my $oberr (@errors_deps) {
  print $fh_header_dep "\nconstexpr int $oberr = $map_deps{$oberr}->[0];";
}

print $fh_header_dep '
constexpr int OB_MAX_RAISE_APPLICATION_ERROR         = -20000;
constexpr int OB_MIN_RAISE_APPLICATION_ERROR         = -20999;


#endif /* __OBERROR_LIB_OB_ERRNO_H__ */
';


# generate ob_errno.cpp
open my $fh_cpp, '>', "ob_errno.cpp";
print $fh_cpp '
// DO NOT EDIT. This file is automatically generated from `ob_errno.def\'.

// Copyright 2016 Alibaba Inc. All Rights Reserved.
// This program is free software; you can redistribute it and/or
// modify it under the terms of the GNU General Public License
// version 2 as published by the Free Software Foundation.
// ob_errno.h
//   Author:
//      zhuweng <zhuweng.yzf@taobao.com>
//   Normalizer:
//      xueya.jxy <xueya.jxy@alibaba-inc.com>

#include "ob_errno.h"
#include "./lib/ob_macro_utils.h"

static const char *ERROR_NAME[OB_MAX_ERROR_CODE];
static const char *ERROR_CAUSE[OB_MAX_ERROR_CODE];
static const char *ERROR_SOLUTION[OB_MAX_ERROR_CODE];

static int MYSQL_ERRNO[OB_MAX_ERROR_CODE];
static const char *SQLSTATE[OB_MAX_ERROR_CODE];
static const char *STR_ERROR[OB_MAX_ERROR_CODE];
static const char *STR_USER_ERROR[OB_MAX_ERROR_CODE];

static int ORACLE_ERRNO[OB_MAX_ERROR_CODE];
static const char *ORACLE_STR_ERROR[OB_MAX_ERROR_CODE];
static const char *ORACLE_STR_USER_ERROR[OB_MAX_ERROR_CODE];

static struct ObStrErrorInit
{
  ObStrErrorInit()
  {
    memset(ERROR_NAME, 0, sizeof(ERROR_NAME));
    memset(ERROR_CAUSE, 0, sizeof(ERROR_CAUSE));
    memset(ERROR_SOLUTION, 0, sizeof(ERROR_SOLUTION));

    memset(MYSQL_ERRNO, 0, sizeof(MYSQL_ERRNO));
    memset(SQLSTATE, 0, sizeof(SQLSTATE));
    memset(STR_ERROR, 0, sizeof(STR_ERROR));
    memset(STR_USER_ERROR, 0, sizeof(STR_USER_ERROR));

    memset(ORACLE_ERRNO, 0, sizeof(ORACLE_ERRNO));
    memset(ORACLE_STR_ERROR, 0, sizeof(ORACLE_STR_ERROR));
    memset(ORACLE_STR_USER_ERROR, 0, sizeof(ORACLE_STR_USER_ERROR));

';
    for my $oberr (@errors) {
      if (0 > $map{$oberr}->[0]) {
        print $fh_cpp "    ERROR_NAME[-$oberr] = \"$map{$oberr}->[5]\";\n";
        print $fh_cpp "    ERROR_CAUSE[-$oberr] = $map{$oberr}->[9];\n";
        print $fh_cpp "    ERROR_SOLUTION[-$oberr] = $map{$oberr}->[10];\n";
        print $fh_cpp "    MYSQL_ERRNO[-$oberr] = $map{$oberr}->[1];\n";
        print $fh_cpp "    SQLSTATE[-$oberr] = $map{$oberr}->[2];\n";
        print $fh_cpp "    STR_ERROR[-$oberr] = $map{$oberr}->[3];\n";
        print $fh_cpp "    STR_USER_ERROR[-$oberr] = $map{$oberr}->[4];\n";
        print $fh_cpp "    ORACLE_ERRNO[-$oberr] = $map{$oberr}->[6];\n";
        print $fh_cpp "    ORACLE_STR_ERROR[-$oberr] = $map{$oberr}->[7];\n";
        print $fh_cpp "    ORACLE_STR_USER_ERROR[-$oberr] = $map{$oberr}->[8];\n";
      }
    }

  print $fh_cpp '
  }
} local_init;

const char *ob_error_name(const int err)
{
  const char *ret = "Unknown error";
  if (OB_UNLIKELY(0 == err)) {
    ret = "OB_SUCCESS";
  } else if (OB_LIKELY(0 > err && err > -OB_MAX_ERROR_CODE)) {
    ret = ERROR_NAME[-err];
    if (OB_UNLIKELY(NULL == ret || \'\0\' == ret[0]))
    {
      ret = "Unknown Error";
    }
  }
  return ret;
}
const char* ob_error_cause(const int err)
{
  const char* ret = "Unknown error";
  if (OB_UNLIKELY(0 == err)) {
    ret = "OB_SUCCESS";
  } else if (OB_LIKELY(0 > err && err > -OB_MAX_ERROR_CODE)) {
    ret = ERROR_CAUSE[-err];
    if (OB_UNLIKELY(NULL == ret || \'\0\' == ret[0])) {
      ret = "Unknown Error";
    }
  }
  return ret;
}
const char* ob_error_solution(const int err)
{
  const char* ret = "Unknown error";
  if (OB_UNLIKELY(0 == err)) {
    ret = "OB_SUCCESS";
  } else if (OB_LIKELY(0 > err && err > -OB_MAX_ERROR_CODE)) {
    ret = ERROR_SOLUTION[-err];
    if (OB_UNLIKELY(NULL == ret || \'\0\' == ret[0])) {
      ret = "Unknown Error";
    }
  }
  return ret;
}

const char *ob_strerror(const int err)
{
  const char *ret = "Unknown error";
  if (OB_LIKELY(0 >= err && err > -OB_MAX_ERROR_CODE)) {
    ret = STR_ERROR[-err];
    if (OB_UNLIKELY(NULL == ret || \'\0\' == ret[0]))
    {
      ret = "Unknown Error";
    }
  }
  return ret;
}
const char *ob_str_user_error(const int err)
{
  const char *ret = NULL;
  if (OB_LIKELY(0 >= err && err > -OB_MAX_ERROR_CODE)) {
    ret = STR_USER_ERROR[-err];
    if (OB_UNLIKELY(NULL == ret || \'\0\' == ret[0])) {
      ret = NULL;
    }
  }
  return ret;
}
const char *ob_sqlstate(const int err)
{
  const char *ret = "HY000";
  if (OB_LIKELY(0 >= err && err > -OB_MAX_ERROR_CODE)) {
    ret = SQLSTATE[-err];
    if (OB_UNLIKELY(NULL == ret || \'\0\' == ret[0])) {
      ret = "HY000";
    }
  }
  return ret;
}
int ob_mysql_errno(const int err)
{
  int ret = -1;
  if (OB_LIKELY(0 >= err && err > -OB_MAX_ERROR_CODE)) {
    ret = MYSQL_ERRNO[-err];
  }
  return ret;
}
int ob_mysql_errno_with_check(const int err)
{
  int ret = ob_mysql_errno(err);
  if (ret < 0) {
    ret = -err;
  }
  return ret;
}
const char *ob_oracle_strerror(const int err)
{
  const char *ret = "Unknown error";
  if (OB_LIKELY(0 >= err && err > -OB_MAX_ERROR_CODE)) {
    ret = ORACLE_STR_ERROR[-err];
    if (OB_UNLIKELY(NULL == ret || \'\0\' == ret[0]))
    {
      ret = "Unknown Error";
    }
  }
  return ret;
}
const char *ob_oracle_str_user_error(const int err)
{
  const char *ret = NULL;
  if (OB_LIKELY(0 >= err && err > -OB_MAX_ERROR_CODE)) {
    ret = ORACLE_STR_USER_ERROR[-err];
    if (OB_UNLIKELY(NULL == ret || \'\0\' == ret[0])) {
      ret = NULL;
    }
  }
  return ret;
}
int ob_oracle_errno(const int err)
{
  int ret = -1;
  if (OB_ERR_PROXY_REROUTE == err) {
    // Oracle Mode and MySQL mode should return same errcode for reroute sql
    // thus we make the specialization here
    ret = -1;
  } else if (err >= OB_MIN_RAISE_APPLICATION_ERROR && err <= OB_MAX_RAISE_APPLICATION_ERROR) {
    ret = err; // PL/SQL Raise Application Error
  } else if (OB_LIKELY(0 >= err && err > -OB_MAX_ERROR_CODE)) {
    ret = ORACLE_ERRNO[-err];
  }
  return ret;
}
int ob_oracle_errno_with_check(const int err)
{
  int ret = ob_oracle_errno(err);
  if (ret < 0) {
    ret = -err;
  }
  return ret;
}
int ob_errpkt_errno(const int err, const bool is_oracle_mode)
{
  return (is_oracle_mode ? ob_oracle_errno_with_check(err) : ob_mysql_errno_with_check(err));
}
const char *ob_errpkt_strerror(const int err, const bool is_oracle_mode)
{
  return (is_oracle_mode ? ob_oracle_strerror(err) : ob_strerror(err));
}
const char *ob_errpkt_str_user_error(const int err, const bool is_oracle_mode)
{
  return (is_oracle_mode ? ob_oracle_str_user_error(err) : ob_str_user_error(err));
}

int argument_exist(const char* error_msg) {
  if (NULL == error_msg) {
    return 0;
  }
  int len = strlen(error_msg);
  for (int i = 0; i < len; i++) {
    if (0 == strncmp(error_msg+i, "arguments", 9)) {
      return 1;
    }
  }
  return 0;
}
void ob_init_error_to_oberror(int ora_err[][OB_MAX_SAME_ERRORCODE], 
    int pls_err[][OB_MAX_SAME_ERRORCODE], int mysql_err[][OB_MAX_SAME_ERRORCODE]) {
  for (int i = 0; i < OB_MAX_ERROR_CODE; i++) {
    if (-1 != MYSQL_ERRNO[i] && MYSQL_ERRNO[i] < 4000) {
      for(int k = 0; k < OB_MAX_SAME_ERRORCODE; k++) {
        if(-1 == mysql_err[MYSQL_ERRNO[i]][k]) {
            mysql_err[MYSQL_ERRNO[i]][k] = i;
            break;
        }
      }
    }
    if (NULL != ORACLE_STR_ERROR[i]) {
      if (0 == strncmp(ORACLE_STR_ERROR[i], "ORA", 3)) {
        for (int k = 0; k < OB_MAX_SAME_ERRORCODE; k++) {
          if (-1 == ora_err[ORACLE_ERRNO[i]][k]) {
            if (600 == ORACLE_ERRNO[i]) {
              if (!argument_exist(ORACLE_STR_USER_ERROR[i])) {
                ora_err[ORACLE_ERRNO[i]][k] = i;
              }
            } else {
              ora_err[ORACLE_ERRNO[i]][k] = i;
            }
            break;
          }
        }
      } else if (0 == strncmp(ORACLE_STR_ERROR[i], "PLS", 3)) {
        for (int k = 0; k < OB_MAX_SAME_ERRORCODE; k++) {
          if (-1 == pls_err[ORACLE_ERRNO[i]][k]) {
            pls_err[ORACLE_ERRNO[i]][k] = i;
            break;
          }
        }
      }
    }
  }
}
  ';
    