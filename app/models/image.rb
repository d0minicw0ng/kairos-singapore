class Image < ActiveRecord::Base
	has_attached_file :avatar, 
		styles: { 
			large: '500x500>', 
			medium: '300x300>',
			thumb: '100x100>'
		}, 
		default_url: 'images/missing.png'

	validates_attachment :avatar, 
		presence: true,
		content_type: { 
			content_type: ['image/png', 'image/jpg', 'image/jpeg'] 
		},
		size: { :in => 0..2.megabytes }

	belongs_to :project
end
