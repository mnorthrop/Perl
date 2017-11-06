#!/usr/bin/perl

# This script prints yesterday's cconsole.log and emails it
# cconsole_emailer.pl

$instance=$ARGV[0];
chomp ($instance);
$instance=lc($instance);

$today=`date "+%m"/"%d"/"%y"`;
chomp ($today);

($month, $day, $year) = split ("/",$today);

#Calculate yesterday's date
$yesterday_month=$month;
$yesterday_day=$day-1;
$yesterday_year=$year;

if ($yesterday_day < 1 ) {
        $yesterday_month=$yesterday_month-1;

        if ($yesterday_month == 1) {
                $yesterday_day=31;
        }
        if ($yesterday_month == 2) {
                $yesterday_day=28;
        }
        if ($yesterday_month == 3) {
                $yesterday_day=31;
        }
        if ($yesterday_month == 4) {
                $yesterday_day=30;
        }
        if ($yesterday_month == 5) {
                $yesterday_day=31;
        }
        if ($yesterday_month == 6) {
                $yesterday_day=30;
        }
        if ($yesterday_month == 7) {
                $yesterday_day=31;
        }
        if ($yesterday_month == 8) {
                $yesterday_day=31;
        }
        if ($yesterday_month == 9) {
                $yesterday_day=30;
        }
        if ($yesterday_month == 10) {
                $yesterday_day=31;
        }
        if ($yesterday_month == 11) {
                $yesterday_day=30;
        }
        if ($yesterday_month < 1) {
                $yesterday_month=12;
                $yesterday_day=31;
                $yesterday_year=$yesterday_year-1;
        }

}

# Purge extra zero from month
$yesterday_month = $yesterday_month - 0;

#add zeroes if needed to date stamp portions
if ($yesterday_month < 10) {
        $yesterday_month="0".$yesterday_month;
}
if ($yesterday_day < 10) {
        $yesterday_day="0".$yesterday_day;
}
if ($yesterday_year < 10) {
        $yesterday_year="0".$yesterday_year;
}
$yesterday=$yesterday_month."/".$yesterday_day."/".$yesterday_year;


#Email report
print `grep "$yesterday" /epic/$instance/cachesys/mgr/cconsole.log | mail -s "$instance cconsole.log report for $yesterday" -r "cconsole_report<cconsole_report\@company.com>" emailto\@company.com,additionalemailto\@company.com`;
