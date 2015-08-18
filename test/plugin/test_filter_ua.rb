require 'helper'
require 'fluent/test'

class Fluent::UAFilterTest < Test::Unit::TestCase
  #include Fluent

  def setup
    Fluent::Test.setup
    @ua_list_path  = File.expand_path('../spiderlist.txt', __FILE__)
  end

  def create_driver(conf = '')
    Fluent::Test::FilterTestDriver.new(Fluent::UAFilter).configure(conf, true)
  end

  sub_test_case 'filter_stream' do
    def messages
      [
        "2013/01/13T07:02:11.124202 INFO GET /ping",
        "2013/01/13T07:02:13.232645 baidu WARN POST /auth",
        "2013/01/13T07:02:21.542145 Y!J-BSC WARN GET /favicon.ico",
        "",
        "2013/01/13T07:02:43.632145 WARN POST /login"
      ]
    end

    def emit(config, msgs)
      d = create_driver(config)
      d.run {
        msgs.each { |msg|
          d.emit({'foo' => 'bar', 'message' => msg}, @time)
        }
      }.filtered
    end

    test 'empty config' do
      es = emit('', messages)
      assert_equal(5, es.instance_variable_get(:@record_array).size)
    end

    test 'ua_list_path' do
      config = "ua_list #{@ua_list_path}"
      d = create_driver(config)
      assert_equal('baidu', d.instance.uas[4])
    end

    test 'n_records_match' do
      config = "ua_list #{@ua_list_path}"
      es = emit(config, messages)
      assert_equal(3, es.instance_variable_get(:@record_array).size)
    end

    test 'ua_list is valid' do
      config = "ua_list #{@ua_list_path}"
      d = create_driver(config)
      assert_equal(10, d.instance.uas.size)
    end

  end

end
