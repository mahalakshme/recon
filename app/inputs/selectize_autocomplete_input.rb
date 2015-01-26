class SelectizeAutocompleteInput < ::Formtastic::Inputs::SelectInput
  def input_html_options
    super.tap do |options|
      options[:class] = [ options[:class], 'selectize-autocomplete' ].compact.join(' ')
      options[:data] ||= {}
      options[:data].merge! autocomplete_options
    end
  end

  private

  def raw_collection
    res = object.send(method)
    (res.kind_of?(ActiveRecord::Relation) || res.kind_of?(Array)) ? res : [res]
  end

  def autocomplete_options
    options = self.options.fetch(:selectize, {})
    options = Hash[options.map{ |k, v| [k.to_s.camelcase(:lower), v] }]
    { selectize: options }
  end
end
