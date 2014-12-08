class User < ActiveRecord::Base
  enum role: [:user, :vip, :admin]
  after_initialize :set_default_role, :if => :new_record?

  def set_default_role
    self.role ||= :user
  end

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :token_authenticatable, :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable, :timeoutable
  validates :email, :uniqueness => true, :length => { minimum: 6, maximum: 255}, :presence => true, on: 'create'
  validates :first_name, :length => {minimum: 1, maximum: 255}, :presence => true
  validates :last_name, :length => {minimum: 1, maximum: 255}, :presence => true

  has_many :aquariums, :dependent => :destroy
end
