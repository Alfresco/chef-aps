#
# Cookbook Name:: chef-aps
# Recipe:: default
#
# Copyright (c) 2017 The Authors, All Rights Reserved.

include_recipe 'aps-proxy::default'
include_recipe 'aps-db::default'
include_recipe 'aps-core::default'
