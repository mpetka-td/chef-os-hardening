# encoding: UTF-8
#
# Copyright 2014, Deutsche Telekom AG
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

describe 'os-hardening::limits' do
  cached(:chef_run) do
    ChefSpec::ServerRunner.new.converge(described_recipe)
  end

  subject { chef_run }

  it 'creates /etc/sysconfig/init' do
    is_expected.to create_template(
      '/etc/security/limits.d/10.hardcore.conf'
    ).with(
      user:   'root',
      group:  'root',
      mode: '0440'
    )
  end

  it 'creates /etc/security/limits.d directory' do
    is_expected.to create_directory('/etc/security/limits.d').with(
      user:   'root',
      group:  'root',
      mode: '0755',
      recursive: true
    )
  end
end
