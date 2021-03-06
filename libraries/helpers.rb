#
# Author:: Seth Chisamore (<schisamo@opscode.com>)
# Author:: Sean OMeara (<schisamo@opscode.com>)
#
# Copyright:: Copyright (c) 2011-2013 Opscode, Inc.
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
#

module Opscode
  module Mysql
    # Opscode Mysql Helpers
    module Helpers
      def debian_before_squeeze?
        (node['platform'] == 'debian') && (node['platform_version'].to_f < 6.0)
      end

      def ubuntu_before_lucid?
        (node['platform'] == 'ubuntu') && (node['platform_version'].to_f < 10.0)
      end

      def assign_root_password_cmd
        str = '/usr/bin/mysqladmin'
        str << ' -u root password '
        str << " '#{node['mariadb']['server_root_password']}'"
      end

      def install_grants_cmd
        str = '/usr/bin/mysql'
        str << ' -u root '
        node['mariadb']['server_root_password'].empty? ? str << ' < /etc/mysql_grants.sql' : str << " -p'#{node['mariadb']['server_root_password']}' < /etc/mysql_grants.sql"
      end
    end
  end
end
