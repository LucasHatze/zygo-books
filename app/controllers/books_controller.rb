class BooksController < ApplicationController
  before_action :set_book, only: %i[ show edit update destroy ]
  before_action :authenticate_user!, except: %i[index search]

  # GET /books or /books.json
  def index
    @books = Book.all
  end

  # GET /books/new
  def new
    @book = Book.new
  end

  # GET /books/1/edit
  def edit
  end

  # POST /books or /books.json
  def create
    @book = Book.new(book_params)

    respond_to do |format|
      if @book.save
        format.html { redirect_to books_path }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /books/1 or /books/1.json
  def update
    respond_to do |format|
      if @book.update(book_params)
        format.html { redirect_to @book }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /books/1 or /books/1.json
  def destroy
    @book.destroy
    respond_to do |format|
      format.html { redirect_to books_url }
    end
  end

  def search
    books = Book.all
    books = books.where("title ilike ? or description ilike ?", search_params[:query]+'%', '%'+search_params[:query]+'%') if !search_params[:query].blank?
    books = books.where("author ilike ?", search_params[:author]+'%') if !search_params[:author].blank?
    books = books.order(title: search_params[:order]) rescue books

    respond_to do |format|
      format.turbo_stream { render turbo_stream: turbo_stream.replace('books', partial: 'books', locals: { books: books } ) }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_book
      @book = Book.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def book_params
      params.require(:book).permit(:title, :description, :author, :image)
    end

    def search_params
      params.permit(
        :query,
        :author,
        :order
      )
    end
end
