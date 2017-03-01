# class ClickBait < ActiveModel::Validator
#   def validate(record)
#     good = Regexp.union([/Won\'t\ Believe/, /Secret/, /Top\ \d*/, /Guess/])
#     unless record.title.match(good)
#       record.errors[:title] << 'Need something more clickbaity.'
#     end
#   end
# end

class Post < ActiveRecord::Base
  # include ActiveModel::Validations
  # validates_with ClickBait
  validates :title, {presence: true}
  validate :clickbait
  validates :content, length: {minimum: 250}
  validates :summary, length: {maximum: 250}
  validates :category, inclusion: {in: %w(Fiction Non-Fiction)}

  def clickbait
    good = Regexp.union([/Won\'t\ Believe/, /Secret/, /Top\ \d*/, /Guess/])
    if title.present? && !title.match(good)
      errors.add(:title, 'Need something more clickbaity.')
    end
  end
end
