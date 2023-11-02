# frozen_string_literal: true

# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron

require 'tzinfo'

timezones = ['America/New_York', 'Australia/Sydney']

timezones.each do |timezone|
  tz = TZInfo::Timezone.get(timezone)
  diff = tz.utc_offset / 60 / 60

  day = diff.negative? ? '28-31' : 1
  hour = diff.negative? ? 24 + diff : diff

  every "0 #{hour} #{day} * *" do
    runner "User.reset_monthly_hits(#{tz.name}, #{diff})"
  end
end

# Learn more: http://github.com/javan/whenever
