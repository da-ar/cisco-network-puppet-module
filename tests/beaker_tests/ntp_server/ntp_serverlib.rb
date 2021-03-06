###############################################################################
# Copyright (c) 2014-2017 Cisco and/or its affiliates.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
###############################################################################
# NTP Server Utility Library:
# ---------------------
# ntp_serverlib.rb
#
# This is the utility library for the ntp server provider Beaker test cases
# that contains the common methods used across the ntp server testsuite's
# cases. The library is implemented as a module with related methods and
# constants defined inside it for use as a namespace. All of the methods are
# defined as module methods.
#
# Every Beaker ntp server test case that runs an instance of Beaker::TestCase
# requires NtpServerLib module.
#
# The module has a single set of methods:
# A. Methods to create manifests for ntp_server Puppet provider test cases.
###############################################################################

# Require UtilityLib.rb path.
require File.expand_path('../../lib/utilitylib.rb', __FILE__)

# A library to assist testing ntp_server resource
module NtpServerLib
  # A. Methods to create manifests for ntp_server Puppet provider test cases.

  # Method to create a manifest for ntp_server resource attribute 'ensure'
  # where 'ensure' is set to present.
  # @param none [None] No input parameters exist.
  # @result none [None] Returns no object.
  def self.create_ntp_server_manifest_present
    manifest_str = "cat <<EOF >#{PUPPETMASTER_MANIFESTPATH}
node default {
  ntp_server {'5.5.5.5':
    ensure => present,
  }
}
EOF"
    manifest_str
  end

  # Method to create a manifest for ntp_server resource attribute 'ensure'
  # where 'ensure' is set to absent.
  # @param none [None] No input parameters exist.
  # @result none [None] Returns no object.
  def self.create_ntp_server_manifest_absent
    manifest_str = "cat <<EOF >#{PUPPETMASTER_MANIFESTPATH}
node default {
    ntp_server {'5.5.5.5':
      ensure => absent,
    }
}
EOF"
    manifest_str
  end

  # Method to create a manifest for ntp_server attributes:
  # ensure, timeout, deadtime, encryption_type, encryption_password
  # @param intf [String] source_interface
  # @result none [None] Returns no object.
  def self.create_ntp_server_manifest_present_nondefault(intf)
    manifest_str = "cat <<EOF >#{PUPPETMASTER_MANIFESTPATH}
node default {
  ntp_auth_key { '1':
    ensure    => 'present',
    algorithm => 'md5',
    mode      => '7',
    password  => 'test',
  }
  ntp_server {'5.5.5.5':
    ensure => present,
    key => 1,
    prefer => true,
    maxpoll => 12,
    minpoll => 6,
    source_interface => '#{intf}',
    vrf => 'red',
    require => [ Cisco_vrf['red'], Ntp_auth_key['1'] ],
  }
  cisco_vrf { 'red':
    ensure   => 'present',
  }
}
EOF"
    manifest_str
  end

  # Method to create a manifest for ntp_server resource attribute 'ensure'
  # where 'ensure' is set to present.
  # @param none [None] No input parameters exist.
  # @result none [None] Returns no object.
  def self.create_ntp_server_manifest_present_ipv6
    manifest_str = "cat <<EOF >#{PUPPETMASTER_MANIFESTPATH}
node default {
  ntp_server {'2002::5':
    ensure => present,
  }
}
EOF"
    manifest_str
  end

  # Method to create a manifest for ntp_server resource attribute 'ensure'
  # where 'ensure' is set to absent.
  # @param none [None] No input parameters exist.
  # @result none [None] Returns no object.
  def self.create_ntp_server_manifest_absent_ipv6
    manifest_str = "cat <<EOF >#{PUPPETMASTER_MANIFESTPATH}
node default {
    ntp_server {'2002::5':
      ensure => absent,
    }
}
EOF"
    manifest_str
  end
end
