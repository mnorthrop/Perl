#!/usr/bin/perl
# Receive a CSV file of all directories that need to be changed and what max size should be changed to.
# CSV example line : mes,/ahf/mes/mgr/samples/,100
# Command: /home/cachedba/scripts/change_max /home/cachedba/work/max_size_changes.csv >> /home/cachedba/log/max_size_change.log
use strict;
use warnings;

my $file = $ARGV[0] or die "Need to get CSV file on the command line.\n";

open(my $data, '<', $file) or die "Could not open '$file' $!\n";

while (my $line = <$data>) {
	chomp $line;
	
	my @fields = split "," , $line;
	my $env = $fields[0];
	my $database = $fields[1];
	my $max_size = $fields[2];
	my $command = "echo 'SET db=##Class(SYS.Database).%OpenId(\"'$database'\")\nSET db.MaxSize='$max_size'\nSET status=db.%Save()\nh\n' | csession '$env' -U %SYS";
	
	print "Changing max size of '$database' to '$max_size'.\n";
	system($command);
}
