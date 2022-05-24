class ApplicationRecord < ActiveRecord::Base
  primary_abstract_class

  def form_attributes
    form_attributes = {}
    self.attributes.each do |attr_name, attr_value|
      if(attr_name != "id" && attr_name != "updated_at" && attr_name != "created_at" && attr_name != "status" )
        form_attributes[attr_name] = attr_value
      end
    end

    return form_attributes
  end
end
