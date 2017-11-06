#!/usr/bin/perl

#License upgrader
my @environments=("poc","mst","tst","rel","ref","ace2","ace","ply","sup");

my @servers=("poc_host","mst_host","tst_host","rel_host","ref_host","ace2_host","ace_host","ply_host","sup_host");

my $counter=0;

foreach $env (@environments) {
        $command="ssh ".$servers[$counter]." 'multi_upgrade_cache_license.ksh $env'";

        @output=`$command`;
        print @output;
        print "Instance $env completed.\n";

        $counter++;
}
