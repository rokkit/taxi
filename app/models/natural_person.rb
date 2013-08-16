class NaturalPerson < ActiveRecord::Base
  establish_connection "mssql"
  self.table_name = "dbo.natural_person"
  has_many :contacts, class_name: "Contacts", foreign_key: 'id_parent'
  has_many :orders, class_name: "Orders", foreign_key: 'id_client'
  scope :search_by_full_name, lambda { |name|
     (name ? where(["name LIKE ? or surname LIKE ? or (name + ' ' + surname) like ?", '%'+ name + '%', '%'+ name + '%','%'+ name + '%' ])  : {})
   }
  def full_name
    phone = contacts.first.contact_content
    "#{name} #{self.try(:surname)} - #{phone}"
  end
end
