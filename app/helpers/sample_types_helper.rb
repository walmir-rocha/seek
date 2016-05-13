module SampleTypesHelper
  def sample_attribute_details(sample_type_attribute)

       type = sample_type_attribute.sample_attribute_type.title
       unit = sample_type_attribute.unit ? "( #{ sample_type_attribute. unit.symbol } )" : ''
       req = sample_type_attribute.required? ? required_span : ''
       "#{sample_type_attribute.title} (#{type}) #{unit} #{req}".html_safe


  end

  def sample_attributes_xml(builder, object)
    builder.tag! 'attributes' do
      api_partial_collection builder, object.sample_attributes
    end
  end

  def sample_attribute_type_xml(builder, object)
    builder.tag! 'sample_attribute_type' do
      core_xml(builder, object)
      builder.tag! 'base_type', object.base_type
      builder.tag! 'regexp', object.regexp
    end
  end

  def sample_data_xml(builder, sample)
    builder.tag! 'attribute_values' do
      sample.sample_type.sample_attributes.each do |sample_attribute|
        builder.tag! 'attribute_value' do
          value = sample.data[sample_attribute.accessor_name]
          builder.tag! 'key', uri_for_object(sample_attribute)
          builder.tag! 'value', value
        end
      end
    end
  end
end
