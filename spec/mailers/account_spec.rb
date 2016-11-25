require "rails_helper"

RSpec.describe AccountMailer, type: :mailer do
  describe "account_activation" do
    let(:mail) { AccountMailer.account_activation }

    it "应发送正确的邮件内容" do

      user = create :send_mail_user
      mail = AccountMailer.account_activation(user.id)
      assert_equal "来自BREEZE IN 的账号激活", mail.subject
      assert_equal [user.email], mail.to
      assert_equal ["13428725296@163.com"], mail.from
      assert_match user.username,           mail.body.encoded
      assert_match user.email,              mail.body.encoded
    end

  end

end
