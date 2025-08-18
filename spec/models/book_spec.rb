require 'rails_helper'

RSpec.describe Book, type: :model do
  context 'associations' do
    it { is_expected.to belong_to(:author) }
  end

  context 'validations' do
    it { is_expected.to validate_presence_of(:title) }
    it { is_expected.to validate_presence_of(:description) }
    it { is_expected.to validate_presence_of(:release_date) }
    it { is_expected.to validate_presence_of(:author_id) }
  end
end
