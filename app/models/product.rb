class Product < ApplicationRecord
    has_many_attached :images
    validates :name, presence: true
    validates :description, presence: true
    validate :image_type

    def thumbnail
        return self.variant(resize: "300x300!").processed
    end

    private
    def image_type
        if !images.attached?
            errors.add(:images, "are missing")
        end

        images.each do |image|
            if !image.content_type.in?(%('image/png image/jpg))
                errors.add(:images, "not png or jpg")
            end
        end
    end
end
