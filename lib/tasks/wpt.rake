require 'web_page_test'

REPEAT_RUNS_PER_TARGET = 5.freeze

namespace :wpt do
  desc "Run performance test suite"
  task run: :environment do
    Rails.logger = Logger.new(STDOUT)

    Target.all.each do |target|
      REPEAT_RUNS_PER_TARGET.times do
        Rails.logger.info "Running test target #{ target.id }: #{ target.label }"
        data = WebPageTest.test_script(target.script).merge(target_id: target.id)
        Rails.logger.info "Performance data: #{ data }"
        PerformanceSnapshot.create! data
      end
    end
  end
end
