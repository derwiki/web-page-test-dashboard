require 'json'

class WebPageTest
  class << self
    def start_test(script)
      fail "Need to set WEB_PAGE_TEST_KEY" if ENV['WEB_PAGE_TEST_KEY'].nil?
      url =
        "http://www.webpagetest.org/runtest.php?video=1&"\
        "k=#{ ENV['WEB_PAGE_TEST_KEY'] }&f=json&script=#{ script }"
      command = "curl --silent -L '#{ url }'"
      puts "command: #{ command }"

      response = JSON[`#{ command }`]
      fail 'Invalid request' if response['statusCode'] != 200
      response['data']['jsonUrl']
    end

    def get_results(results_url)
      puts "Getting #{ results_url }"
      data = JSON[`curl --silent #{ results_url }`]['data']
      status_code = data['statusCode']
      puts "#{ status_code }: #{ data['statusText'] }"

      if status_code == 200 || status_code.nil?
        return data
      elsif status_code == 100 || status_code == 101
        sleep 10 and return get_results(results_url)
      end
    end

    def extract_stats_from_results(results)
      first_view = results['runs']['1']['firstView']
      {
        first_byte: first_view['TTFB'],
        first_paint: first_view['firstPaint'],
        render: first_view['render'],
        load_time:  first_view['loadTime'],
        full_load_time:  first_view['fullyLoaded'],
        total_bytes: first_view['bytesIn'],
        requests: first_view['requests'].count,
        visual_complete: first_view['visualComplete']
      }
    end

    def test_script(script)
      json_url = start_test(script)
      results = get_results(json_url)
      extract_stats_from_results(results)
    end
  end
end
