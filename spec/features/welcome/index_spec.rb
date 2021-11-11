require 'rails_helper'

RSpec.describe 'Welcome page' do
  it 'has project title' do
    visit '/'

    expect(page).to have_content('Little Esty Shop')
  end
end
