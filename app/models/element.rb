# == Schema Information
#
# Table name: elements
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  link       :string(255)
#  domain_id  :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Element < ActiveRecord::Base
  attr_accessible :domain_id, :link, :name
  belongs_to :domain
  has_and_belongs_to_many :types
end
