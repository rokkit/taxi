json.array!(@inform_mails) do |inform_mail|
  json.extract! inform_mail, :client_id, :body
  json.url inform_mail_url(inform_mail, format: :json)
end
