class Article
  include MongoMapper::Document

  key :title, String
  key :urlrewrite, String
  key :tag, String
  key :content, String

  timestamps!

  def to_param
    urlrewrite
  end

end
