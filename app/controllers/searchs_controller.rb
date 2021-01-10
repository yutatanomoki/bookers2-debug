class SearchsController < ApplicationController
    def index
        @select = params[:select].to_i# '1' => 1
        @match = params[:match]
        @word = params[:word]
        @books = Book.all
        @users = User.all
        if @select == 1 && @match == "forward_match"
            @books = Book.where("title LIKE?","#{@word}%")
        elsif @select == 1 && @match == "backward_match"
            @books = Book.where("title LIKE?","%#{@word}")
        elsif @select == 1 && @match == "perfect_match"
            @books = Book.where(title: @word)
        elsif @select == 1 && @match == "partial_match"
            @books = Book.where("title LIKE?","%#{@word}%")
        elsif @select == 2 && @match == "backward_match"
            @users = User.where("name LIKE?","%#{@word}")
        elsif @select == 2 && @match == "forward_match"
            @users = User.where("name LIKE?","#{@word}%")
        elsif @select == 2 && @match == "perfect_match"
            @users = User.where(name: @word)
        else
            @users = User.where("name LIKE?","%#{@word}%")
        end
        
    end

end
