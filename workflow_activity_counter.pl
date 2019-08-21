#!/usr/bin/perl
#
# workflow_activity_counter.pl
# Usage: workflow_activity_counter.pl <workflow_file.xml>
# 
# Derek Pascarella <derekp@ayehu.com>
# Ayehu, Inc.
#
# Count the number of activities in a given WorkFlow XML file.  The full file path should be passed to this script as an argument.
#
# This script can be executed on Windows using the Strawberry Perl distribution (http://strawberryperl.com/) and executed at the
# Windows command prompt as follows:
# > perl C:\full\path\to\workflow_activity_counter.pl C:\full\path\to\WorkFlow.xml
#
# For Windows users, note that a shortcut can be created with the path "perl C:\full\path\to\workflow_activity_counter.pl", after which
# WorkFlow XML files can be dragged from the file explorer directly onto the shortcut.  This would launch a command prompt window and
# display the activity count results.  If utilizing this shortcut method, simply add "<STDIN>;" to the last line of this script.
#
# Sample output:
# WorkFlow file:	C:\SSH - Linux System Administration\SSH - Linux - Service Status.xml
# WorkFlow name:	SSH - Linux - Service Status
# Total activities:	4

# Our modules.
use strict;

# Our variables.
my $count = 0;
my $pattern = "; id=&quot;";
my $workflow_file = $ARGV[0];
my $workflow_xml;
my $workflow_name;

# Open WorkFlow XML file or print error if not found.
open(FH, '<', $workflow_file) or die $!;

# Iterate through each line of the file until the WorkFlow XML is found.
while(<FH>)
{
	if(grep/\<WorkflowInfo/, $_)
	{
		# Store current line of file in "workflow_xml".
		$workflow_xml = $_;
	}
}

# Extract the WorkFlow's name from the XML.
$workflow_name = $workflow_xml;
$workflow_name =~ s/^[^Name=\"]*Name=\"//;
$workflow_name =~ s/\" Description.*//;
$workflow_name =~ s/^\s+|\s+$//g;

# Count the number of instances "pattern" is found in the WorkFlow XML.
$count = () = $workflow_xml =~ /$pattern/gi;

# Print results.
print "WorkFlow file:\t$workflow_file\n";
print "WorkFlow name:\t$workflow_name\n";
print "Total activities:\t$count\n";