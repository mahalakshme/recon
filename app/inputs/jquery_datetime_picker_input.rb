class JqueryDatetimePickerInput < ::Formtastic::Inputs::StringInput
  def input_html_options
    super.tap do |options|
      options[:class] = [ options[:class], 'jquery-datetime-picker' ].compact.join(' ')
      options[:data] ||= {}
      options[:data].merge! datepicker_options
      options[:value] ||= value
    end
  end

  def value
    val = object.send(method)
    val.is_a?(Time) ? val.strftime('%Y-%m-%d %H:%M') : val.to_s
  end

  private

  def datepicker_options
    options = self.options.fetch(:datepicker_options, {})
    options = Hash[options.map{ |k, v| [k.to_s.camelcase(:lower), v] }]
    { datepicker_options: options }
  end
end
