#  Makefile.PL for WebDyne::Session
#
package WebDyne::Session;


#  Compiler Pragma
#
use 5.006;
use strict qw(vars);


#  External Modules
#
use ExtUtils::MakeMaker;
use IO::File;


#  All done, init finished
#
#------------------------------------------------------------------------------


#  Create the Makefile params in hash
#
my $prereq_hr;
my %makefile=(

    NAME				    =>  __PACKAGE__,
    VERSION_FROM			     =>  File::Spec->catfile(

	'lib',
	split(/::/, __PACKAGE__),
	'VERSION.pm'

       ),

    PREREQ_PM				    =>	do { $prereq_hr={

	'WebDyne::Chain'		    =>  undef,
	'CGI::Cookie'			    =>  undef

       }; ($ENV{'PREREQ_PM'} eq '0') ? {} : $prereq_hr },

    CONFIGURE				    =>  sub { { PREREQ_PM=>$prereq_hr } },

    'dist'				    =>  {

	COMPRESS			    =>  'gzip -9f',
	SUFFIX				    =>  '.gz'

       },

    'depend'				    =>  {

	Makefile			    =>  '$(VERSION_FROM)'

       },

    'macro'				    =>  {

        COPYRIGHT			    =>  'Copyright (c) 2006-2010 Andrew Speer, All rights reserved',
	LICENSE				    =>  'GPL: GNU General Public License'

       },

    AUTHOR				    => 'Andrew Speer <andrew@webdyne.org>'

);


#  Debugging on or off ?
#
my $debug=$ENV{'WEBDYNE_DEBUG'} ? 1 : 0;


#  Get ExtUtils::MakeMaker version. see if it supports PM_FILTER. From SpamAssassin Makefile.PL
#
my $mm_version=$ExtUtils::MakeMaker::VERSION;
my $mm_has_pm_filter=$mm_version >  5.45 || ($mm_version == 5.45 && $] > 5.006);


#  Install if supported
#
if (!$debug && $mm_has_pm_filter) {


    #  Write filter script and assign
    #
    my $fn='pm_filter.pl';
    my $fh=IO::File->new($fn, O_WRONLY|O_CREAT|O_TRUNC) ||
	die ("unable to write filter file '$fn', $!");
    print $fh 's/debug\\(/0 && debug\\(/m; print';
    $fh->close();
    my $pm_filter="\$(PERL) -nl $fn";
    $makefile{'PM_FILTER'}=$pm_filter;

}

WriteMakefile(%makefile);

package MY;

sub constants {


    #  Add license file, other support files here
    #
    my $mm_or=shift();
    $mm_or->{'PM'}{'LICENSE'}='$(INST_LIBDIR)/$(BASEEXT)/LICENSE';
    $mm_or->SUPER::constants;

};
