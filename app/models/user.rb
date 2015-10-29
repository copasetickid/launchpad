class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable


  enum role: [ :user, :admin ]

  def is_admin?
  	 admin?
  end

  def to_s
  	"#{email} (#{role.titleize})"
  end
end
