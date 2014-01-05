class ArticleTag < ActiveRecord::Base
  attr_accessible :article_id, :tag_id
  validates_presence_of :article_id, :tag_id
  validates_uniqueness_of :tag_id, scope: :article_id
  belongs_to :article
  belongs_to :tag
end
