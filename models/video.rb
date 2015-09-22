class Video
  include Mongoid::Document
  include Mongoid::Timestamps # adds created_at and updated_at fields

  field :title, type: String
  field :description, type: String
  field :url, type: String
  field :tags, type: Array
  field :slug, type: String

  before_create :generate_slug

  belongs_to :user

  validates_presence_of :title, :description, :url, :user_id
  validates_uniqueness_of :title

  protected

  def generate_slug
    self.slug = title.tr(' ', '-')
  end
end
