class Room < ActiveRecord::Base
  belongs_to :user
  has_many :photos
  has_many :reservations

  geocoded_by :address
  after_validation :geocode, if: :address_changed?

  validates :home_type, presence: true
  validates :room_type, presence: true
  validates :accommodate, presence: true
  validates :bed_room, presence: true
  validates :bath_room, presence: true
  validates :listing_name, presence: true, length: { maximum: 50 }
  validates :summary, presence: true, length: { maximum: 500 }
  validates :address, presence: true
  validates :price, presence: true, numericality: true
  # validate :at_least_one_photo

  # private

  # def at_least_one_photo
  #   if photos.size < 1
  #     errors.add :base, "You have to upload at least one photo for your room."
  #   end
  # end

end
