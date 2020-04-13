class WechatsController < ApplicationController
  # For details on the DSL available within this file, see https://github.com/Eric-Guo/wechat#wechat_responder---rails-responder-controller-dsl
  wechat_responder

  on :text do |request, content|
    openid = request[:FromUserName]
    Message.create({openid: openid,title: openid,:body => content,:body_html => content})
    request.reply.text "收到你的秘密，我已经把他藏了起来\n发送 me 查看我的秘密\n发送 ta 查看ta的秘密" # Just echo
  end


  on :text, with: 'me' do |request|

    openid = request[:FromUserName]
    messages = Message.includes(:user).order("created_at desc").where(:openid=>openid.to_s).limit(10)
    data = messages.map do |message| 
      "#{message.created_at.strftime('%Y-%m-%d %H:%M:%S').to_s} : #{message.body} @#{message.user.nick}" 
    end
    request.reply.text data.join("\n").to_s  if data.length > 0  #回复帮助信息
  end

  on :text, with: 'ta' do |request|

    openid = request[:FromUserName]
    messages = Message.includes(:user).order("created_at desc").where.not(:openid=>openid.to_s).limit(10)
    data = messages.map do |message| 
      "#{message.created_at.strftime('%Y-%m-%d %H:%M:%S').to_s} : #{message.body} @#{message.user.nick}" 
    end
    request.reply.text data.join("\n").to_s  if data.length > 0 #回复帮助信息
  end


  # 当用户加关注
  on :event, with: 'subscribe' do |request|
    openid = request[:FromUserName]
    @user = User.find_by_openid(openid)
    
    if @user.nil?
      @user = User.create({openid: openid})
    end

    request.reply.text "亲爱的,#{@user.nick} ! 欢迎回家\n发送 me 查看我的秘密\n发送 ta 查看ta的秘密"
  end

  # 当用户取消关注订阅
  on :event, with: 'unsubscribe' do |request|
    request.reply.success # user can not receive this message
  end


  # 成员进入应用的事件推送
  on :event, with: 'enter_agent' do |request|
    request.reply.text "发送 me 查看我的秘密\发送 ta 查看ta的秘密"
  end

end




