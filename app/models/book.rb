# == Schema Information
#
# Table name: books
#
#  id          :bigint           not null, primary key
#  title       :string
#  description :string
#  author      :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
class Book < ApplicationRecord
    has_one_attached :image

    validates :title, presence: true
    validates :author, presence: true
    validates :description, presence: true
end
