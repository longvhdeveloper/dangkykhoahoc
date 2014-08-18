class Student < ActiveRecord::Base
  attr_accessor :password
  validates :email , :presence => {:message => "Email khong hop le"},
            :format => {:with => /[\w\.]+@[a-zA-Z_]+?\.[a-zA-Z]{2,3}/},
            :uniqueness => {:on => create}
  validates :password, :presence => {:message => "Password not valid"}, :confirmation => true

  validates :enscripted_password, :presence => true, :on => :create

  before_validation :enscript_password, :if => "password.present?"

  def enscript_password
    self.enscripted_password =  self.class.md5_text(@password)
  end


  def self.login_by_email_and_password(email, password)
    student = where(:email => email).first
    password.present? && student.password = md5_text(password)
  end

  def self.md5_text(text)
    Digest::MD5.base64digest(text)
  end

end
