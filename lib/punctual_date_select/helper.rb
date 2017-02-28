module PunctualDateSelect::Helper

  module Builder
    def punctual_date_select(method, options={}, html_options={})
      @template.select_date(object.send(method), {:prefix => "#{@object_name}[#{method}]"}.merge(options), html_options)
    end
  end

  module DateHelper
    def select_year
      old_datetime = @datetime
      @datetime = nil if @datetime.respond_to?(:year) && !@datetime.year
      ret = super
      @datetime = old_datetime
      ret
    end
  end

end

ActionView::Helpers::FormBuilder.send(:include, PunctualDateSelect::Helper::Builder)
ActionView::Helpers::DateHelper.send(:prepend, PunctualDateSelect::Helper::DateHelper)
