class WechatsController < ApplicationController
  # For details on the DSL available within this file, see https://github.com/Eric-Guo/wechat#wechat_responder---rails-responder-controller-dsl
  wechat_responder

  on :text do |request, content|
    puts request
    request.reply.text "echo: #{JSON.stringfy(request)} #{content}" # Just echo
  end


  # 当用户加关注
  on :event, with: 'subscribe' do |request|
    request.reply.text "亲爱的,#{request[:FromUserName]} ! 欢迎回家"
  end

  # 当用户取消关注订阅
  on :event, with: 'unsubscribe' do |request|
    request.reply.success # user can not receive this message
  end

end
