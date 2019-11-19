class Note < ActiveRecord::Base
  belongs_to :user
  has_many :viewers
  has_many :readers, through: :viewers, source: :user

  before_save :ensure_owner_can_read

  def visible_to
    readers.map {|reader| reader.name}.join(', ')
  end

  def visible_to=(comma_string)
    self.readers = comma_string.split(',').map do |name|
      User.find_by(name: name.strip)
    end.compact
  end

  private

    def ensure_owner_can_read
      if self.user && !readers.include?(self.user)
        readers << self.user
      end
    end
end
