class Post < ActiveRecord::Base

	belongs_to :user
	belongs_to :category
	has_many :comments

	default_scope -> { order('created_at DESC') }
  has_attached_file :photo, 
		{:styles => {:thumb => "300x300#"},
  	:path => "assets/:id/:basename.:extension"}.merge(PAPERCLIP_STORAGE_OPTIONS)

  validates :user_id, presence: true
	validates_attachment :photo, :presence => true, content_type: { content_type: ["image/jpg", "image/jpeg", "image/png", "image/gif"] }

	attr_accessor :new_category
	before_save :create_category 

	def self.search(search)
	    where('title LIKE ? OR description LIKE ?', "%#{search}%", "%#{search}%")
	end

	def create_category
		self.category = Category.create!(name: new_category) if new_category.present?
	end
	
end
