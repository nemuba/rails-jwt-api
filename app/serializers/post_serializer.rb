class PostSerializer < ActiveModel::Serializer
  attributes :id, :title, :body, :likes
  has_one :user
  has_many :comments

  def likes
    object.likes.count
  end
end
