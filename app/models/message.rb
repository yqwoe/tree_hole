class Message < ApplicationRecord
    belongs_to :user, class_name: "User", foreign_key: "openid",primary_key: "openid"
end
