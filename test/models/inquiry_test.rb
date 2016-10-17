require "test_helper"

describe Inquiry do
  let(:inquiry) { Inquiry.new }

  it "must be valid" do
    value(inquiry).must_be :valid?
  end
end
