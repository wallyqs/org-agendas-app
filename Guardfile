# -*- mode: ruby -*-
require 'org-converge'

watch('org/app.org') do |m|
  OrgConverge::Command.new({
    '<org_file>' => 'org/app.org',
    '--tangle'   => true
  }).execute!
end

interactor :off
