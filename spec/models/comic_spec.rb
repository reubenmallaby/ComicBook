require 'rails_helper'

RSpec.describe Comic, type: :model do
  subject {
    Comic.new(
      publish_date: DateTime.new,
      title: "Test now",
      description: "Testing todays comic"
    )
  }

  it "is not valid without a title" do
    subject.title = nil
    expect(subject).to_not be_valid
  end

  it "is not valid without a description" do
    subject.description = nil
    expect(subject).to_not be_valid
  end

  it "is valid with valid attributes" do
    expect(subject).to be_valid
  end

end
