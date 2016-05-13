xml.instruct! :xml

xml.tag! "samples_types",xlink_attributes(uri_for_collection("sample_types", :params => params)),
xml_root_attributes,
         :resourceType => "SampleTypes" do
  
  render :partial=>"api/core_index_elements",:locals=>{:items=>@sample_types,:parent_xml => xml}
  
  
end