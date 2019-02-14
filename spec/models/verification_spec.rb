require 'rails_helper'

RSpec.describe Verification, type: :model do
  describe "Verification process" do
    let(:user) { FactoryBot.create(:user) }
    it "not yet starting" do
      expect(user.verification.step).to eq(nil)
    end

    it "Step 1" do
      user.verification.update_attribute(:ktp_number, Faker::IDNumber.valid)
      expect(user.verification.step).to eq(1)
    end

    it "Step 2" do
      user.verification.update_attribute(:ktp_number, Faker::IDNumber.valid)
      user.verification.update_attribute(:ktp_selfie, Rack::Test::UploadedFile.new(File.open(File.join(Rails.root, '/spec/images/html.png'))))
      expect(user.verification.step).to eq(2)
    end

    it "Step 3" do
      user.verification.update_attribute(:ktp_number, Faker::IDNumber.valid)
      user.verification.update_attribute(:ktp_selfie, Rack::Test::UploadedFile.new(File.open(File.join(Rails.root, '/spec/images/html.png'))))
      user.verification.update_attribute(:ktp_photo, Rack::Test::UploadedFile.new(File.open(File.join(Rails.root, '/spec/images/html.png'))))
      expect(user.verification.step).to eq(3)
    end

    it "Step 4" do
      user.verification.update_attribute(:ktp_number, Faker::IDNumber.valid)
      user.verification.update_attribute(:ktp_selfie, Rack::Test::UploadedFile.new(File.open(File.join(Rails.root, '/spec/images/html.png'))))
      user.verification.update_attribute(:ktp_photo, Rack::Test::UploadedFile.new(File.open(File.join(Rails.root, '/spec/images/html.png'))))
      user.verification.update_attribute(:signature, Rack::Test::UploadedFile.new(File.open(File.join(Rails.root, '/spec/images/html.png'))))
      expect(user.verification.step).to eq(4)
    end

    it "Reset to 4" do
      user.verification.update_attribute(:ktp_number, Faker::IDNumber.valid)
      user.verification.update_attribute(:ktp_selfie, Rack::Test::UploadedFile.new(File.open(File.join(Rails.root, '/spec/images/html.png'))))
      user.verification.update_attribute(:ktp_photo, Rack::Test::UploadedFile.new(File.open(File.join(Rails.root, '/spec/images/html.png'))))
      user.verification.update_attribute(:signature, Rack::Test::UploadedFile.new(File.open(File.join(Rails.root, '/spec/images/html.png'))))
      user.verification.reset! 4
      expect(user.verification.step).to eq(3)
    end

    it "Reset to 3" do
      user.verification.update_attribute(:ktp_number, Faker::IDNumber.valid)
      user.verification.update_attribute(:ktp_selfie, Rack::Test::UploadedFile.new(File.open(File.join(Rails.root, '/spec/images/html.png'))))
      user.verification.update_attribute(:ktp_photo, Rack::Test::UploadedFile.new(File.open(File.join(Rails.root, '/spec/images/html.png'))))
      user.verification.update_attribute(:signature, Rack::Test::UploadedFile.new(File.open(File.join(Rails.root, '/spec/images/html.png'))))
      user.verification.reset! 3
      expect(user.verification.step).to eq(2)
    end

    it "Reset to 2" do
      user.verification.update_attribute(:ktp_number, Faker::IDNumber.valid)
      user.verification.update_attribute(:ktp_selfie, Rack::Test::UploadedFile.new(File.open(File.join(Rails.root, '/spec/images/html.png'))))
      user.verification.update_attribute(:ktp_photo, Rack::Test::UploadedFile.new(File.open(File.join(Rails.root, '/spec/images/html.png'))))
      user.verification.update_attribute(:signature, Rack::Test::UploadedFile.new(File.open(File.join(Rails.root, '/spec/images/html.png'))))
      user.verification.reset! 2
      expect(user.verification.step).to eq(1)
    end

    it "Reset to 1" do
      user.verification.update_attribute(:ktp_number, Faker::IDNumber.valid)
      user.verification.update_attribute(:ktp_selfie, Rack::Test::UploadedFile.new(File.open(File.join(Rails.root, '/spec/images/html.png'))))
      user.verification.update_attribute(:ktp_photo, Rack::Test::UploadedFile.new(File.open(File.join(Rails.root, '/spec/images/html.png'))))
      user.verification.update_attribute(:signature, Rack::Test::UploadedFile.new(File.open(File.join(Rails.root, '/spec/images/html.png'))))
      user.verification.reset! 1
      expect(user.verification.step).to eq(nil)
    end
  end
end
