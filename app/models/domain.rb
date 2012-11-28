# == Schema Information
#
# Table name: domains
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  ownerid    :integer
#

class Domain < ActiveRecord::Base
  attr_accessible :name
  has_many :users
  has_many :types
  has_many :elements
  validates :name, presence: true, length: { maximum: 50 }

  before_save :create_owner

  private
  	def create_owner
  		self.ownerid = self.users.first.id
  		self.users.first.toggle!(:admin)
  	end



end
