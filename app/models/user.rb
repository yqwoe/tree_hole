
require 'chinese_name'
class User < ApplicationRecord


    before_validation :normalize_name, on: :create
    has_many :messages, class_name: "Message", foreign_key: "openid",primary_key: 'openid'

    private
    def normalize_name
        g = ChineseName.generate
        name = g.full_name
        user = User.find_by_nick(name)
        if user.nil?
            self.nick = name
        else
            g1 = ChineseName.generate
            self.nick = g1.full_name
        end
    end
end
