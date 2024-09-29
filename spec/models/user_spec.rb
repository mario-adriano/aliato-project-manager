require 'rails_helper'

RSpec.describe User, type: :model do
  describe "associations" do
  end

  describe "database columns" do
    it { should have_db_column(:id).of_type(:integer).with_options(null: false) }
    it { should have_db_column(:deleted_at).of_type(:datetime) }
    it { should have_db_column(:email).of_type(:string).with_options(default: "") }
    it { should have_db_column(:encrypted_password).of_type(:string).with_options(null: false, default: "") }
    it { should have_db_column(:is_reset_password).of_type(:boolean).with_options(default: false) }
    it { should have_db_column(:name).of_type(:string) }
    it { should have_db_column(:remember_created_at).of_type(:datetime) }
    it { should have_db_column(:reset_password_sent_at).of_type(:datetime) }
    it { should have_db_column(:reset_password_token).of_type(:string) }
    it { should have_db_column(:type).of_type(:string) }
    it { should have_db_column(:username).of_type(:string) }
    it { should have_db_column(:created_at).of_type(:datetime).with_options(null: false) }
    it { should have_db_column(:updated_at).of_type(:datetime).with_options(null: false) }
  end

  describe "indexes" do
    it { should have_db_index(:deleted_at) }
    it { should have_db_index(:reset_password_token).unique(true) }
    it { should have_db_index(:username).unique(true) }
  end

  describe "validations" do
    it { should validate_presence_of(:username) }
    it { should validate_uniqueness_of(:username).case_insensitive }
    context "when the user is an Operator" do
      it "validates presence of name" do
        operator = build(:user, type: "Operator", name: nil)
        expect(operator).to_not be_valid
        expect(operator.errors[:name]).to include("não pode ficar em branco")
      end
    end

    context "when the user is not an Operator" do
      it "does not require name to be present" do
        admin = build(:user, type: "Administrator", name: nil)
        expect(admin).to be_valid
      end
    end
  end
  describe "validations" do
    it { should validate_presence_of(:username) }
    it { should validate_uniqueness_of(:username).case_insensitive }
    it "validates presence of name if user is an Operator" do
      operator = build(:user, type: "Operator", name: nil)
      expect(operator).to_not be_valid
      expect(operator.errors[:name]).to include("não pode ficar em branco")
    end
    it "does not validate presence of name if user is not an Operator" do
      admin = build(:user, type: "Administrator", name: nil)
      expect(admin).to be_valid
    end
  end

  describe "callbacks" do
    it "sets the user type as 'Administrator' if no users exist and the type is blank" do
      user = build(:user, type: nil)
      user.valid?
      expect(user.type).to eq("Administrator")
    end

    it "sets the user type as 'Operator' if users already exist and the type is blank" do
      create(:user)
      user = build(:user, type: nil)
      user.valid?
      expect(user.type).to eq("Operator")
    end

    it "sets the name for Administrator before creation" do
      admin = build(:user, username: "admin_user", type: "Administrator")
      admin.save
      expect(admin.name).to eq("admin_user")
    end
  end

  describe "instance methods" do
    describe "#admin?" do
      it "returns true if the user is an Administrator" do
        admin = build(:user, type: "Administrator")
        expect(admin.admin?).to be_truthy
      end

      it "returns false if the user is not an Administrator" do
        operator = build(:user, type: "Operator")
        expect(operator.admin?).to be_falsey
      end
    end

    describe "#operator?" do
      it "returns true if the user is an Operator" do
        operator = build(:user, type: "Operator")
        expect(operator.operator?).to be_truthy
      end

      it "returns false if the user is not an Operator" do
        admin = build(:user, type: "Administrator")
        expect(admin.operator?).to be_falsey
      end
    end

    describe "#requires_reset_password?" do
      it "returns true if the user is an Operator and requires reset password" do
        operator = build(:user, type: "Operator", is_reset_password: true)
        expect(operator.requires_reset_password?).to be_truthy
      end

      it "returns false if the user is not an Operator" do
        admin = build(:user, type: "Administrator", is_reset_password: true)
        expect(admin.requires_reset_password?).to be_falsey
      end
    end

    describe "#email_required?" do
      it "returns false as email is not required" do
        user = build(:user)
        expect(user.email_required?).to be_falsey
      end
    end

    describe "#email_changed?" do
      it "returns false as email change is not tracked" do
        user = build(:user)
        expect(user.email_changed?).to be_falsey
      end
    end
  end

  describe "class methods" do
    describe ".find_for_database_authentication" do
      it "finds a user by case-insensitive username" do
        user = create(:user, username: "testuser")
        expect(User.find_for_database_authentication(username: "TESTUSER")).to eq(user)
      end

      it "returns nil if no user is found" do
        expect(User.find_for_database_authentication(username: "nonexistent")).to be_nil
      end
    end
  end
end
