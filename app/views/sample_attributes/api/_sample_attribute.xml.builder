is_root = false unless local_assigns.has_key?(:is_root)

parent_xml.tag! "sample_attribute",
core_xlink(sample_attribute).merge(is_root ? xml_root_attributes : {}) do
  
  render :partial=>"api/standard_elements",:locals=>{:parent_xml => parent_xml,:is_root=>is_root,:object=>sample_attribute}

  parent_xml.tag! "accessor_name", sample_attribute.accessor_name
  parent_xml.tag! "required", sample_attribute.required?
  parent_xml.tag! "is_title", sample_attribute.is_title?
  sample_attribute_type_xml parent_xml, sample_attribute.sample_attribute_type
end

