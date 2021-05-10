#! /usr/bin/env perl
#
# Short description for a4shirt-process.pl
#
# Version 0.0.1
# Copyright (C) 2021 Shlomi Fish < https://www.shlomifish.org/ >
#
# Licensed under the terms of the MIT license.

use strict;
use warnings;
use 5.014;
use autodie;

use Path::Tiny qw/ path tempdir tempfile cwd /;

s%'(Source Code Pro)((?:, Heavy Italic)?)'%
    "'Courier New" . ((length $2)?"Black":"") . "'"
%egms;
s%font-style:italic;%%g;
