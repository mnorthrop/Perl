#!/usr/bin/perl
######
#       Execute command: ./current_used_space.pl [environment]
#       Author: Mike Northrop
#       Description:
#               The purpose of this script is to calculate the current used file system space on a server.
######

# Exit unless there is an argument
$num_args = $#ARGV + 1;
if ( $num_args != 1 ){
        print "\nPlease include an environment, see usage below.\n\nUsage: current_used_space.pl environment\n\n";
        exit;
}

# Set argument
$env = $ARGV[0];
$env = lc $env; # Convert to lowercase

# Gather file system space information
@file_system = `df -g | grep $env | grep -viE "extract|load|claim|su|imo|revenue|home|install"`;
foreach $line (@file_system) {
        if ($line=~m/\/dev\/\w+\s+(\d+\.\d+)\s+(\d+\.\d+)\s+.*/) {
                $gb_blocks=$1;
                $free_blocks=$2;
        }
        $used_blocks=$gb_blocks-$free_blocks;
        print "$line Used GB Blocks: $used_blocks\n";
}
