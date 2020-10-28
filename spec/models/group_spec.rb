require 'rails_helper'

RSpec.describe Group, type: :model do
  describe "グループ作成機能" do
    before do
      @resistrated_group = create(:group)
      @group = build(:group)
    end
    describe "グループが作成できる（正常系）" do
      it "nameが存在すれば登録できる" do
        expect(@group).to be_valid
      end
    end
    
    describe "グループが作成出来ない（異常系）" do
      it "nameが存在しない場合登録できない" do
        @group.name = nil
        @group.valid?
        expect(@group.errors.full_messages).to include("Name can't be blank")  
      end
      
      it "nameが重複する場合登録出来ない" do
        @group.name = @resistrated_group.name
        @group.valid?
        expect(@group.errors.full_messages).to include("Name can't be blank")  
      end
    end
  end
end
