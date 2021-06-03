require 'rails_helper'

RSpec.describe Track, type: :model do
  describe 'Associations' do
    it { should belong_to(:activity) }
  end
  describe 'Validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:duration) }
    it { should validate_presence_of(:distance) }
  end
end
