require 'rails_helper'

RSpec.describe Message, type: :model do
  describe 'メッセージ送信機能' do
    
    before do
      #messageを作成する
      @message = build(:message)
    end
    
    describe '保存成功（正常系）' do
      it 'contentが存在すれば、imageがなくても保存できる' do
        @message.image = nil
        expect(@message).to be_valid  
      end

      it 'imageが存在すれば、contentがなくても保存できる' do
        @message.content = nil
        expect(@message).to be_valid
      end

      it 'contentとimageが両方あれば保存ができる' do
        expect(@message).to be_valid
      end
    end

    describe '保存失敗（異常系）' do
      it 'contentとimageが両方空だと保存できない' do
        @message.content = nil
        @message.image = nil
        @message.valid?
        expect(@message.errors.full_messages).to include("Content can't be blank")
      end

      it 'groupの情報なければ保存できない' do
        @message.group = nil
        @message.valid?
        expect(@message.errors.full_messages).to include("Group must exist")
      end

      it 'userの情報がなければ保存できない' do
        @message.user = nil
        @message.valid?
        expect(@message.errors.full_messages).to include("User must exist")
      end
    end
  end
end
