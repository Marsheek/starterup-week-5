class User < ApplicationRecord
  has_one :seller_profile
  rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  after_commit :assign_role

  def assign_role
   self.add_role self.user_type.to_sym
  end

end
