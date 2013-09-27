APN = Houston::Client.development
APN.certificate = File.read(Rails.root.join('apple_push_notification.pem').to_s)
