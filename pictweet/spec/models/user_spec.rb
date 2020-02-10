require 'rails_helper'
describe User do
  describe '#create' do
    # nicknameとemail、passwordとpassword_confirmationが存在すれば登録できる
    it "is valid with a nickname, email, password, password_confirmation" do
      user = build(:user)
      expect(user).to be_valid
    end
    # nicknameが空では登録できない
    it "is invalid without a nickname" do
      user = build(:user, nickname: "")
      user.valid?
      expect(user.errors[:nickname]).to include("can't be blank")
    end
    # emailが空では登録できない
    it "is invalid without a email" do
      user = build(:user, email: "")
      user.valid?
      expect(user.errors[:email]).to include("can't be blank")
    end
    # passwordが空では登録できない
    it "is invalid without a password" do
      user = build(:user, password: "")
      user.valid?
      expect(user.errors[:password]).to include("can't be blank")
    end
    # passwordが存在してもpassword_confirmationが空では登録できないこと
    it "is invalid without a password_confirmation although with a password" do
      user = build(:user, password_confirmation: "")
      user.valid?
      expect(user.errors[:password_confirmation]).to include("doesn't match Password")
    end

    # # nicknameが7文字は登録できない
    it "invalid nickname 7 over" do
      user = build(:user, nickname: "1234567")
      user.valid?
      expect(user.errors[:nickname][0]).to include("is too long")
    end

    # # nicknameが6文字は登録できる
    it "to be valid nickname 6" do
      user = build(:user, nickname: "123456")
      expect(user).to be_valid
    end

    # # 重複したemailが存在する場合登録できないこと
    it "email unless unique" do
      user = create(:user)
      user2 = build(:user, email: user.email)
      user2.valid?
      expect(user2.errors[:email]).to include("has already been taken")
    end

    # passwordが6文字であれば登録できること
    it "passwordが6文字であれば登録できる" do
      user = build(:user, password: "123456", password_confirmation: "123456")
      expect(user).to be_valid
    end

    # passwordが5文字以下であれば登録できない
    it "invalid password 5 chara" do
      user = build(:user, password: "12345", password_confirmation: "12345")
      user.valid?
      expect(user.errors[:password][0]).to include("is too short")
    end
  end
end