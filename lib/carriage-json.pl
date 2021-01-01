#!/usr/bin/env perl
# Copyright (C) 2020 Daniel Friesel
#
# SPDX-License-Identifier: BSD-2-Clause

use strict;
use warnings;
use 5.020;

use File::Slurp qw(read_file write_file);
use IPC::Run3;
use JSON;
use utf8;

my ($json_file, $pdf_file, $key, @extra_keys) = @ARGV;

my $command = [ "pdftotext", "-layout", "-nopgbrk", $pdf_file, "/dev/stdout" ];
my $wagon_txt;

run3($command, \undef, \$wagon_txt, undef, { binmode_stdout => ':encoding(utf-8)' } );

my @lines = split(qr{\n}, $wagon_txt);


my $name = $lines[0];

$name =~ s{^\s+}{};
$name =~ s{\s+$}{};

my $json = JSON->new->utf8->decode(read_file($json_file));

my $data = {};

if ($name =~ m{ \d{3} \. \S \) }x) {
	$data->{name} = $name;
}
else {
	for my $line (@lines) {
		if ($line =~ m{ \( ( D? (WL)? (A|AB|B|W) R? D? [acdehimpuvw] \S* \s+ [0-9A-Z.]+ ) \) }x) {
			$data->{name} = "Wagen $1";
			last;
		}
	}
}

for my $line (@lines) {
	if ($line =~ m{Anzahl Plätze im (?:Großraum|Wagen):\s*(\d+)}) {
		$data->{seats_open} = $1;
	}
	if ($line =~ m{Anzahl Plätze i[nm] Abteil[^:]*:\s*(\d+)}) {
		$data->{seats_comp} = $1;
	}
	if ($line =~ m{Anzahl WC:\s*(\d+)}) {
		$data->{wc} = $1;
	}
}

$data->{seats} = ($data->{seats_open} // 0) + ($data->{seats_comp} // 0);

$json->{$key} = $data;

for my $extra_key (@extra_keys) {
	$json->{$extra_key} = {};
}

write_file($json_file, JSON->new->utf8->encode($json));
