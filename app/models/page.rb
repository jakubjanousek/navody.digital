class Page < ApplicationRecord
  default_scope { order(position: :asc) }
  scope :faq, -> { where(is_faq: true) }

  validates :title, presence: true
  validates :content, presence: true
  validates :slug, presence: true, uniqueness: true
  validates :is_faq, inclusion: { in: [true, false] }

  # FIXME: fill in position from id!

  before_save :generate_search_terms

  def to_param
    slug
  end

  private

  def generate_search_terms
    self.search_terms = "#{Transliterator.transliterate(title&.downcase)} #{Transliterator.transliterate(keywords&.downcase)}".strip
  end
end
