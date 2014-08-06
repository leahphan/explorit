class Post < ActiveRecord::Base

	belongs_to :user
	belongs_to :category

	default_scope -> { order('created_at DESC') }
  has_attached_file :photo, {:path => "assets/:id/:basename.:extension"}.merge(PAPERCLIP_STORAGE_OPTIONS)


  validates :user_id, presence: true
	validates_attachment :photo, :presence => true, content_type: { content_type: ["image/jpg", "image/jpeg", "image/png", "image/gif"] }

	def self.search(search)
	    where('title LIKE ?', "%#{search}%")
	end
end
