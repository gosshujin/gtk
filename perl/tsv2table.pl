#!/usr/bin/perl -w
# tsv から table へ変換するスクリプト
use strict;
use warnings;

my $filename = shift(@ARGV);

if (!defined($filename)) { die("usage: perl $0 [*.tsv]"); }

open(FH, $filename) or die("$! -> $filename");
my @data = split("\n", join('', <FH>));
close(FH);

my @output = ();

push(@output, '<table>');

# table header
my @header = split("\t", shift(@data));
push(@output, '<tr>');
push(@output, map({sprintf("<th>%s</th>", $_);} @header));
push(@output, '</tr>');

# table body
for my $row (@data) {
    push(@output, '<tr>');
    push(@output, map({sprintf("<td>%s</td>", $_);} split("\t", $row)));
    push(@output, '</tr>');
}

push(@output, '</table>');

print(join("\n", @output));
