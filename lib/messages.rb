module Messages
  def get_messages(num = "all")
    if num == "all"
      response = self.class.get("/message_threads",
        headers: { "authorization" => @auth_token }
        )
    else
      response = self.class.get("/message_threads",
        body: { "page" => num },
        headers: { "authorization" => @auth_token }
        )
    end
    JSON.parse(response.body)
  end

  def create_message(recipient_id, subject, body, token = "new")
    if token == "new"
      response = self.class.post("/messages",
      headers: { "authorization" => @auth_token },
      body: {
        "sender" => @user_email,
        "recipient_id" => recipient_id,
        "subject" => subject,
        "stripped-text" => body
      }
      )
    else
      response = self.class.post("/messages",
      headers: { "authorization" => @auth_token },
      body: {
        "sender" => @user_email,
        "recipient_id" => recipient_id,
        "token" => token,
        "subject" => subject,
        "stripped-text" => body
      }
      )
    end
  end
  
end
