class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  enum role: [ :user, :admin ]

  scope :excluding_archived, lambda { where(archived_at: nil) }
  has_many :roles

  def is_admin?
  	 admin?
  end

  def to_s
  	"#{email} (#{role.titleize})"
  end

  def archive
  	self.update(archived_at: Time.now)
  end

  def active_for_authentication?
  	super && archived_at.nil?
  end

  def inactive_message
  	archived_at.nil? ? super : :archived
  end

  def role_on(project) 
    roles.find_by(project_id: project).try(:name)
  end

  def generate_api_key
    self.update_column(:api_key, SecureRandom.hex(16))
  end
end
