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
require 'rails_helper'

RSpec.describe Book, type: :model do
  describe "#create" do
    context "when valid" do
      let(:book) { Book.new(author: 'test', title: 'test' , description: 'test' ) }
      before do
        book.image.attach(
          io: File.open(Rails.root.join('spec', 'images', 'test-image.png')),
          filename: 'test'
        )
      end

      it { expect { book.save }.to change(Book, :count).by(1) }
    end
    
    context "when invalid" do
      let(:book) { Book.new(author: 'test', title: 'test', description: 'test' ) }

      it { expect { book.save }.to change(Book, :count).by(0) }
    end
  end

  describe "#destroy" do
    let(:book) { Book.new(author: 'test', title: 'test' , description: 'test' ) }
    before do
      book.image.attach(
        io: File.open(Rails.root.join('spec', 'images', 'test-image.png')),
        filename: 'test'
      )
      book.save
    end

    it { expect { book.destroy }.to change(Book, :count).by(-1) }
  end

  describe "#update" do
    context "when valid" do
      let(:book) { Book.new(author: 'test', title: 'test' , description: 'test' ) }
      before do
        book.image.attach(
          io: File.open(Rails.root.join('spec', 'images', 'test-image.png')),
          filename: 'test'
        )
        book.save
      end

      it { expect( book.update(author: 'tset') ).to be_truthy }
    end
    
    context "when invalid" do
      let(:book) { Book.new(author: 'test', title: 'test' , description: 'test' ) }
      before do
        book.image.attach(
          io: File.open(Rails.root.join('spec', 'images', 'test-image.png')),
          filename: 'test'
        )
        book.save
      end

      it { expect( book.update(author: '') ).to be_falsey }
    end
  end
end
