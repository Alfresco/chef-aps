#
# Cookbook Name:: chef-aps
# Recipe:: default
#
# Copyright (c) 2017 The Authors, All Rights Reserved.

include_recipe 'aps-proxy::default' if node['aps']['components'].include?('proxy')
include_recipe 'aps-db::default' if node['aps']['components'].include?('db')
include_recipe 'aps-core::default' if node['aps']['components'].include?('core')
