# == Schema Information
#
# Table name: domains
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  owner      :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  theowner   :user
#

class Domain < ActiveRecord::Base
  attr_accessible :name, :theowner
  has_many :users
  has_many :types
  validates :name, presence: true, length: { maximum: 50 }

  #before_save :create_owner

  private
  	def create_owner
  		self.owner = self.users.first.name
  	end



end
