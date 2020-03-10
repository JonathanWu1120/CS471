#!/usr/bin/perl
# Problem 13.11 (Should be 14.11?)

use diagnostics;

sub foo {
	my $lex = $_[0];
	$bar = sub{
		print "$lex\n";
		$lex = 5;
	};
	print "Call to foo";
	print "$lex\n";
	$bar->();
}
foo(2);

foo(3);
