require 'rails_helper'

RSpec.describe User, type: :model do
  describe "ユーザーの新規登録機能" do
    before do
      @resistrated_user = create(:user)
      @user = build(:user)
    end

    describe "ユーザー登録成功（正常系）" do
      context "name,email,password,password_confirmationが存在するとき" do
        it "passwordが6文字以上であれば登録できる" do
          expect(@user).to be_valid  
        end

        it "passwordが使用済みでも登録できる" do
          @user.password = @resistrated_user.password
          @user.password_confirmation = @user.password
          expect(@user).to be_valid 
        end
      end
    end
  end
    
  describe "ユーザー登録失敗（異常系）" do
    context "name,email,password,password_confirmationのどれかが存在しないとき" do
      it "nameが空では登録できない" do
        @user.name = nil
        @user.valid?
        expect(@user.errors.full_messages).to include("Name can't be blank")  
      end
      
      it "emailが空では登録できない" do
        @user.email = nil
        @user.valid?
        expect(@user.errors.full_messages).to include("Email can't be blank")  
      end
      
      it "passwordが空では登録できない" do
        @user.password = nil
        @user.password_confirmation = nil
        @user.valid?
        expect(@user.errors.full_messages).to include("Password can't be blank")  
      end

      it "password_confirmationが空では登録できない" do
        @user.password_confirmation = nil
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation can't be blank")  
      end
    end
    
    context "name,email,passwordが存在するとき" do
      it "nameが使用済みだと登録できない" do
        @user.name = @resistrated_user.name
        @user.valid?
        expect(@user.errors.full_messages).to include("Name has already been taken")  
      end
      
      it "emailが使用済みだと登録できない" do
        @user.email = @resistrated_user.email
        @user.valid?
        expect(@user.errors.full_messages).to include("Email has already been taken")  
      end
      
      it "emailに@マークが含まれないと登録できない" do
        @user.email = "aaaexample.com"
        @user.valid?
        expect(@user.errors.full_messages).to include("Email is invalid")  
      end
      
      it "passwordが5文字以下だと登録できない" do
        @user.password = "12345"
        @user.password_confirmation = @user.password
        @user.valid?
        expect(@user.errors.full_messages).to include("Password is too short (minimum is 6 characters)")  
      end
    end
  end
end

