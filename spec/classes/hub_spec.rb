require 'spec_helper'

describe 'hub' do
  let(:boxen_home) { '/opt/boxen' }
  let(:config_dir) { "#{boxen_home}/config/git" }
  let(:repo_dir)   { "#{boxen_home}/repo" }
  let(:env_dir)    { "#{boxen_home}/env.d" }
  let(:facts) do
    {
      :boxen_home    => boxen_home,
      :boxen_repodir => repo_dir,
      :boxen_envdir  => env_dir,
      :osfamily      => "Darwin"
    }
  end

  it { should include_class('boxen::config') }
  it { should contain_package('hub').with_ensure('latest') }

  it 'sets up hub.sh file' do
    should contain_file("#{env_dir}/hub.sh")
  end

  it 'sets up global hub protocal config option' do
    should contain_git__config__global('hub.protocol').with_value('https')
  end
end
