class ApplicationRecord < ActiveRecord::Base
  primary_abstract_class

  def slugging
    Digest::SHA1.hexdigest("#{id}")[0..8]
  end

  def form_attributes
    form_attributes = {}
    self.attributes.each do |attr_name, attr_value|
      if(attr_name != "id" && attr_name != "updated_at" && attr_name != "created_at" && attr_name != "status" && attr_name != "transport_company_id" && attr_name != "slug" && attr_name != "work_order_id" && attr_name != "work_order_route_id")
        form_attributes[attr_name] = attr_value
      end
    end

    return form_attributes
  end
end
