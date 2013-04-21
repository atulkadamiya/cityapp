class User < ActiveRecord::Base
  attr_accessible :email, :fname, :lname, :password, :password_confirmation, :role, :publisher
  has_secure_password

  validates :email, :format => { :with => /\A[a-z A-Z]+(\.?)\w+@\w+\.{1,2}\w+\z/ }
  validates :email, :uniqueness => { :case_sensitive => false}, :if => proc { self.email.present?}
  validates :password, :presence => {:message => "password cannot be blank"}, :if => :password
  validates :publisher, :presence => true

  has_many :issues, :through => :issues_users
  has_many :authentications

  def send_password_reset
    generate_token(:password_reset_token)
    save!
    Notifier.forget(self).deliver
  end

  def generate_token(column)
    begin
      self[column] = SecureRandom.urlsafe_base64
    end while User.exists?(column => self[column])
  end

end
