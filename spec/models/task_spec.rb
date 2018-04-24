require 'rails_helper'

RSpec.describe Task, type: :model do

  it "Task is valid" do
  expect(FactoryGirl.create(:task)).to be_valid
  end


end
