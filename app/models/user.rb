class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  
  validates :username, presence: true, uniqueness: { case_sensitive: false },
             :format => { :with =>/\A[a-z0-9A-Z]+\z/ ,
             :message=>"Only letters and numbers with no spaces allowed" }
  
  has_attached_file :profile_picture, :styles => { :medium => "300x300#", :thumb => "100x100#" }, :default_url => "/images/:style/missingprofilepicture.png"
  validates_attachment_content_type :profile_picture, :content_type => /\Aimage\/.*\Z/ 
  
  has_many :sales 
  has_many :pictures
end
