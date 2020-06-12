require 'rails_helper'

describe MessagesController do
  #  letを利用してテスト中使用するインスタンスを定義
  let(:group) { create(:group) }
  let(:user) { create(:user) }
  
  describe '#create' do
    let(:params) { { group_id: group.id, user_id: user.id, message: attributes_for(:message) } }

    context 'ログインしている場合' do
    # この中にログインしている場合のテストを記述
      before do
        login user
      end

      context '保存に成功した場合' do
        subject {
           post :create,  # postメソッドでcreateアクションを擬似的にリクエストをした結果
           params: params
         }
      
        it 'messageを保存すること' do
           expect{ subject }.to change(Message, :count).by(1)
                                # Messageモデルのレコードの総数が1個増えたかどうかを確かめることができます
        end

        it ' group_messages_pathへリダイレクトすること' do
          subject
          expect(response).to redirect_to(group_messages_path(group))
                                          # createアクションを動かした際のリダイレクト先
        end
      end


      context '保存に失敗した場合' do
        let(:invalid_params) { { group_id: group.id, user_id: user.id, message: attributes_for(:message, text: nil, image: nil) } }
      # 擬似的にcreateアクションをリクエストする際にinvalid_paramsを引数として渡してあげることによって、意図的にメッセージの保存に失敗する場合を再現することができます。
        subject {
          post :create,
          params: invalid_params
        }
      
        it 'messageを保存しないこと' do
          expect{ subject }.not_to change(Message, :count)
        end                  # not_toは、「〜でないこと」。not_to change(Message, :count)で、「Messageモデルのレコード数が変化しないこと ≒ 保存に失敗したこと」を確かめることができます。
        
        it 'index.html.haml へ遷移すること' do
          subject
          expect(response).to render_template :index
        end
      end
    
    
    end



    context 'ログインしていない場合' do
      it ' new.html.hamlに遷移すること' do
        post :create, params: params
        expect(response).to redirect_to(new_user_session_path)
        # redirect_toマッチャの引数に、new_user_session_pathを取ることで、ログイン画面へとリダイレクトしているかどうかを確かめることができます。
      end
    end
  end
end