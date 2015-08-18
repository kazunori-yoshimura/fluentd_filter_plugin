module Fluent
  class UAFilter < Filter
    Plugin.register_filter('ua', self)

    attr_reader :uas

    def configure(conf)
      super
      @uas = []
      if conf['ua_list'] then
        File.open(conf['ua_list']) { |file|
          file.each { |line|
            l = line.chomp
            unless l.empty? then
              @uas.push(l)
            end
          }
        }
      end
    end

    def filter(tag, time, record)
      @uas.each do |ua|
        if record['message'].include?(ua)
          retrun nil
        end
      end
      record
    end

  end
end
