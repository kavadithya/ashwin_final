# == Schema Information
#
# Table name: types
#
#  id          :integer          not null, primary key
#  name        :string(255)
#  description :string(255)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  user_id     :integer
#  domain_id   :integer
#

class Type < ActiveRecord::Base
  attr_accessible :description, :name
  has_and_belongs_to_many :users
  has_and_belongs_to_many :elements
  belongs_to :domain
end
