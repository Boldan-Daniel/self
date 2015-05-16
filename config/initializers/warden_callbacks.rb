Warden::Manager.before_logout do |user|
  ensure_em
  Keen.publish_async :sign_outs, user.to_keen
end

Warden::Manager.after_set_user do |user|
  ensure_em
  Keen.publish_async :logins, user.to_keen
end