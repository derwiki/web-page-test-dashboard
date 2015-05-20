class PerformanceMailer < ApplicationMailer
  DAILY_REPORT_CC = ["user@example.com"]
  def format_duration(d)
    "#{ d / 1000.0 }s"
  end
  helper_method :format_duration

  def daily_report
    @snapshots = PerformanceSnapshot
      .where(created_at: (1.day.ago)..(Time.now))
      .includes(:target)

    mail to: DAILY_REPORT_CC,
         from: 'no-reply@example.com',
         subject: "Front end performance report for #{ Date.today }"
  end
end
