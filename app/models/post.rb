class Post < ActiveRecord::Base

	belongs_to :user
	default_scope -> { order('created_at DESC') }
  has_attached_file :photo, :styles => { :thumb => "300x300#" }

  validates :user_id, presence: true
	validates_attachment :photo, :presence => true, content_type: { content_type: ["image/jpg", "image/jpeg", "image/png", "image/gif"] }

end
