class Contacts < ActiveRecord::Base
  establish_connection "mssql"
  self.table_name = "dbo.contacts"
  belongs_to :natural_person, foreign_key: "id_parent"
end
