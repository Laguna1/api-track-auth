require 'rails_helper'

RSpec.describe User, type: :model do
  it { should validate_presence_of(:name) }
  it { should validate_uniqueness_of(:name) }
  it {
    should validate_length_of(:name)
      .is_at_least(3)
  }
  it { should validate_presence_of(:email) }
  it { should validate_presence_of(:password_digest) }
  it {
    should validate_length_of(:password_digest)
      .is_at_least(6)
  }
end
