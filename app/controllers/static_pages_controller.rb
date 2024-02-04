class StaticPagesController < ApplicationController

    def initialize
    require 'flickr'
    require 'ostruct'
    @flickr = Flickr.new
    end

    def index
        @pics = @flickr.photos.getRecent.map {|pic| Flickr.url_n(pic)}
    end

    def show
        if params[:id].include?('@')
            @pics = @flickr.photos.search(user_id: params[:id]).map {|pic| Flickr.url_n(pic)}
            @info = @flickr.people.getInfo(user_id: params[:id])
        else
            @pics = @flickr.photos.search(text: params[:id]).map {|pic| Flickr.url_n(pic)}
            @info = OpenStruct.new({username: params[:id]})
        end
    end

    def search
        unless params[:id].nil?
            redirect_to static_page_path(params[:id])
        end
    end


end
