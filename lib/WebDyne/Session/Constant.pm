#
#
#  Copyright (c) 2006-2010 Andrew W. Speer <andrew@webdyne>. All rights 
#  reserved.
#
#  This file is part of WebDyne::Session.
#
#  WebDyne::Session is free software; you can redistribute it and/or modify
#  it under the terms of the GNU General Public License as published by
#  the Free Software Foundation; either version 2 of the License, or
#  (at your option) any later version.
#
#  This program is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#  GNU General Public License for more details.
#
#  You should have received a copy of the GNU General Public License
#  along with this program; if not, write to the Free Software
#  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
#
#


#  Constants
#
package WebDyne::Session::Constant;
use strict qw(vars);
use vars qw($VERSION @ISA %EXPORT_TAGS @EXPORT_OK @EXPORT %Constant);
no warnings qw(uninitialized);
local $^W=0;


#  Version information. Must be all on one line
#
$VERSION='1.002';


#  The guts
#
%Constant = (

    #  This is the name of the cookie the browser will receive to keep session id
    #
    WEBDYNE_SESSION_ID_COOKIE_NAME	=>	'session',


);


#  Export constants to namespace, place in export tags
#
require Exporter;
require WebDyne::Constant;
@ISA=qw(Exporter WebDyne::Constant);
+__PACKAGE__->local_constant_load(\%Constant);
foreach (keys %Constant) { ${$_}=$Constant{$_} }
@EXPORT=map { '$'.$_ } keys %Constant;
@EXPORT_OK=@EXPORT;
%EXPORT_TAGS=(all => [@EXPORT_OK]);
$_=\%Constant;
