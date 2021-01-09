class SearchsController < ApplicationController
    def index
        @select = params[:select].to_i# '1' => 1
        @word = params[:word]
        @books = Book.all
        @users = User.all
        if @select == 1
            @books = Book.where(title: @word)
            if @
        else
            @users =User.where(name: @word)
        end
        
    end

end
