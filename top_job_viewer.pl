#!/usr/bin/perl

print "Instance to analyze: ";
$instance=<STDIN>;

chomp($instance);
$instance=uc($instance);

print "Attemtping to autodetect RedAlert data directory...\n";
if (-e "/epic/redalert/data/$instance/ctop") {
        print "Directory found!\n";
        $data_dir="/epic/redalert/data/$instance/ctop/";
}
else {
        print "Data directory not found.\n";
        print "Enter the data directory (ctop): ";
        $data_dir=<STDIN>;

        chomp($data_dir);

        if (!(-e $data_dir)) {
                print "Directory does not exist!\n";
                exit(1);
        }

}

print "Enter a date in YYYYMMDD format: ";
$date=<STDIN>;
chomp ($date);
if (!($date=~m/\d{8}/)) {
        print "Invalid date.\n";
        exit(1);
}

print "Choose: (G)lobal references/sec or Lines of (C)ode: ";
$file_type=<STDIN>;
chomp($file_type);

#Lines of code analysis
if (($file_type=~m/C/) or ($file_type=~m/c/)) {

        $file_path=$data_dir."/".$instance."_xtop2C_".$date.".txt";
        if (!(-e $file_path)) {
                print "File for date $date does not exist!\n";
                exit(1);
        }
        open CFILE,"$file_path";

        @lines=<CFILE>;

        close CFILE;
        $choice="00:00";
        chomp($lines);
        while ($choice ne "") {
                print "$date, $choice\n";
                print "Lines of code/sec,PID,Routine,User,Type\n";
                foreach $line (@lines) {
                        if ($line=~m/$choice:/) {
                                ($jdate, $jtime, $loc, $pid, $routine, $device,$user,$facility,$type) = split (/,/,$line);
                                print "$loc,$pid,$routine,$user,$type\n";
                        }
                }
                print "Pick a time (HH:MM)/24 hour: ";
                $choice=<STDIN>;
                chomp ($choice);
                if ($choice eq "" ) {
                        exit(0);
                }


        }

}
#Global references/sec analysis
if (($file_type=~/G/) or ($file_type=~m/g/)) {
        $file_path=$data_dir."/".$instance."_xtop2G_".$date.".txt";
        if (!(-e $file_path)) {
                print "File for date $date does not exist!\n";
                exit(1);
        }
        open GFILE,"$file_path";

        @lines=<GFILE>;

        close GFILE;

        $choice="00:00";
        chomp($lines);
        while ($choice ne "") {
                print "$date, $choice\n";
                print "Grefs/sec,PID,Routine,User,Type\n";
                foreach $line (@lines) {
                        if ($line=~m/$choice:/) {
                                ($jdate, $jtime, $grefs, $pid, $routine, $device,$user,$facility,$type) = split (/,/,$line);
                                print "$grefs,$pid,$routine,$user,$type\n";
                        }
                }
                print "Pick a time (HH:MM)/24 hour: ";
                $choice=<STDIN>;
                chomp ($choice);
                if ($choice eq "" ) {
                        exit(0);
                }


        }

}
else {
        print "Invalid option.\n";
        exit(1);
}
