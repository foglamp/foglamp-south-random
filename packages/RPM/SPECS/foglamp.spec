%define __spec_install_pre /bin/true
  
Name:          __NAME__
Vendor:        Dianomic Systems, Inc. <info@dianomic.com>
Version:       __VERSION__
Release:       1
BuildArch:     __ARCH__
Summary:       FogLAMP, the open source platform for the Internet of Things
License:       Apache License
Group:         IOT
URL:           http://www.dianomic.com

%define install_path    /usr/local

Prefix:        /usr/local
Requires:      foglamp
AutoReqProv:   no


%description
C++ South Random plugin package for FogLAMP

%pre

%preun

##### Post Install
%post
#!/bin/sh

##--------------------------------------------------------------------
## Copyright (c) 2019 Dianomic Systems
##
## Licensed under the Apache License, Version 2.0 (the "License");
## you may not use this file except in compliance with the License.
## You may obtain a copy of the License at
##
##     http://www.apache.org/licenses/LICENSE-2.0
##
## Unless required by applicable law or agreed to in writing, software
## distributed under the License is distributed on an "AS IS" BASIS,
## WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
## See the License for the specific language governing permissions and
## limitations under the License.
##--------------------------------------------------------------------

##--------------------------------------------------------------------
##
## @postinst DEBIAN/postinst
## This script is used to execute post installation tasks.
##
## Author: Massimiliano Pinto
##
##--------------------------------------------------------------------
set -e
set_files_ownership () {
    chown -R root:root /usr/local/foglamp/plugins/south/Random
}
set_files_ownership

%files

### Files to include in package
%{install_path}/foglamp/plugins/south/Random/*
