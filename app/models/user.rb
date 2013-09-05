class User < ActiveRecord::Base

  validates :email, presence: true, uniqueness: true
  validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i

  def password=(new_password)
    @password = new_password
    self.password_hash = Password.create(new_password) unless new_password.blank?
  end

  def self.authenticate(email, password)
    user = User.find_by_email(email)
    (user && Password.new(user.password_hash) == password) ? user : nil
  end

end
