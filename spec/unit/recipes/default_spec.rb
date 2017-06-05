#
# Cookbook Name:: chef-aps
# Spec:: default
#
# Copyright (c) 2017 The Authors, All Rights Reserved.

require 'spec_helper'

RSpec.describe 'aps::default' do
  let(:chef_run) do
    ChefSpec::SoloRunner.new(
      platform: 'centos',
      version: '7.2.1511',
      file_cache_path: '/var/chef/cache'
    ) do |node|
    end.converge(described_recipe)
  end

  it 'converges successfully' do
    expect { chef_run }.to_not raise_error
  end

  it 'includes the `proxy` recipe' do
    expect(chef_run).to include_recipe('aps-proxy::default')
  end

  it 'includes the `db` recipe' do
    expect(chef_run).to include_recipe('aps-db::default')
  end

  it 'includes the `tomcat` recipe' do
    expect(chef_run).to include_recipe('aps-core::default')
  end
end
