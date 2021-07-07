class StatusRequest < ApplicationRecord
  belongs_to :requester, class_name: 'User'
  belongs_to :client, class_name: 'User'
  belongs_to :reciever, class_name: 'User', optional: true
end
