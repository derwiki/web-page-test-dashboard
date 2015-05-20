# Preview all emails at http://localhost:3000/rails/mailers/performance_mailer
class PerformanceMailerPreview < ActionMailer::Preview
  # Preview this email at http://localhost:3000/rails/mailers/performance_mailer/daily_report
  def daily_report
    PerformanceMailer.daily_report
  end
end
