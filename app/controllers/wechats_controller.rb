class WechatsController < ApplicationController
  # For details on the DSL available within this file, see https://github.com/Eric-Guo/wechat#wechat_responder---rails-responder-controller-dsl
  wechat_responder

  on :text do |request, content|
    openid = request[:FromUserName]
    Message.create({openid: opeind,title: openid,:body => content,:body_html => content})
    request.reply.text "收到你的秘密，我已经把他藏了起来" # Just echo
  end


  # 当用户加关注
  on :event, with: 'subscribe' do |request|
    openid = request[:FromUserName]
    @user = User.find_by_openid(openid)
    
    if @user.nil?
      @user = user.create({openid: openid})
    end

    request.reply.text "亲爱的,#{@user.nick} ! 欢迎回家"
  end

  # 当用户取消关注订阅
  on :event, with: 'unsubscribe' do |request|
    request.reply.success # user can not receive this message
  end

end
