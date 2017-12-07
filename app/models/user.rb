class User < ApplicationRecord
  has_secure_password
  has_many :user_group_connectors, dependent: :destroy
  has_many :groups, through: :user_group_connectors
  has_many :items, through: :groups
  # has_many :document_librarys, dependent: :destroy
  # has_many :documents, through: :document_librarys

  def self.confirm(params)
    @user = User.find_by({:user_name => params[:user_name]})
    @user ? @user.authenticate(params[:password]) : false
  end
end
