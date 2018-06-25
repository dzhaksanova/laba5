# !/usr/bin/env perl
use strict;

open FILE, 'access.log';
my @array = ();
while (defined (my $file_line = <FILE>)) {
	if ($file_line =~ /\d+\.\d+\.\d+\.\d+/) {
		my $ip = "$&";
		push @array, $ip;
	}
}

print "Всего запросов: " . @array . "\n"; #658 вхождений

#заполняем хеш-таблицу 
my(%hash, $element) = ();
$hash{ $element }++ while ( $element = shift @array );

# сортировка по значению
print "Топ 10 IP адресов:\n";
my $var = 1;
foreach my $key (sort {$hash{$b} <=> $hash{$a}} keys %hash) {
	print "$var) $key - $hash{$key} шт.\n";
	$var++;

	if ($var > 10) {
		last;
	}
}
close FILE;
