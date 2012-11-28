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

require 'test_helper'

class ElementTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
