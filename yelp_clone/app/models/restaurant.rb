class Restaurant < ActiveRecord::Base
  include WithUserAssociationExtension
  has_attached_file :image, :styles => { :medium => "300x300>", :thumb => "100x100>" }, :default_url => "/images/:style/missing.png"
  validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/
  
  validates :name, length: {minimum: 3}, uniqueness: true
  belongs_to :user
  has_many :reviews, dependent: :destroy

  def build_review(attributes = {}, user)
    attributes[:user] ||= user
    reviews.build(attributes)
  end

  def average_rating
    return 'N/A' if reviews.none?
    reviews.inject(0) {|memo, review| memo + review.rating} / reviews.length
  end
end
