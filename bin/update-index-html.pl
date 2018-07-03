#!/usr/bin/env perl
use strict;
use warnings;
use 5.010;
use Data::Dumper;

my (@dirs) = @ARGV;

for my $dir (@dirs) {
    update($dir);
}

sub update {
    my ($dir) = @_;
    # remove trailing slash if there is one
    $dir =~ s{/$}{};

    opendir my $dh, $dir or die $!;
    my @files = grep {
        not m/^\./ and $_ ne 'index.html'
    } readdir $dh;
    closedir $dh;

    my $listing = join "\n", map {
        my $size = -f "$dir/$_" ? -s "$dir/$_" : '&nbsp;';
        qq{<tr><td><tt><a href="$_">$_</a></tt></td><td><tt>$size</tt></td></tr>}
    } sort @files;

    my $html = <<"EOM";
<html>
<head><title>Index of /$dir/</title></head>
<body bgcolor="white">
<h1>Index of /$dir/</h1><hr>
<table>
<tr><td><tt><a href="../">../</a></td><td></td></tr>
$listing
</table>
<hr></body>
</html>
EOM

    open my $fh, '>', "$dir/index.html" or die $!;
    print $fh $html;
    close $fh;
}
