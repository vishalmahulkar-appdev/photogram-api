class ApplicationController < ActionController::Base

  def list_users
    answer = User.all

    render( {:plain => answer.to_json } )
  end

  def user_details
    u = User.where({ :username => params.fetch(:username) }).at(0)
    if u.nil?
      answer = "No Record with username: " + params.fetch(:username)
    else
      answer = u
    end

    render( {:plain => answer.to_json } )
  end

  def user_own_photos
    u = User.where({ :username => params.fetch(:username) }).at(0)
    if u.nil?
      answer = "No Record with username: " + params.fetch(:username)
    else
      answer = u.own_photos
    end

    render( {:plain => answer.to_json } )
  end

  def user_liked_photos
    u = User.where({ :username => params.fetch(:username) }).at(0)
    if u.nil?
      answer = "No Record with username: " + params.fetch(:username)
    else
      answer = u.liked_photos
    end

    render( {:plain => answer.to_json } )
  end

  def user_feed
    u = User.where({ :username => params.fetch(:username) }).at(0)
    if u.nil?
      answer = "No Record with username: " + params.fetch(:username)
    else
      answer = u.feed
    end

    render( {:plain => answer.to_json } )
  end

  def user_discover
    u = User.where({ :username => params.fetch(:username) }).at(0)
    if u.nil?
      answer = "No Record with username: " + params.fetch(:username)
    else
      answer = u.discover
    end

    render( {:plain => answer.to_json } )
  end

  def photo_details
    p = Photo.where({ :id => params.fetch(:id) }).at(0)
    if p.nil?
      answer = "No Record with photo_id: " + params.fetch(:id)
    else
      answer = p
    end

    render( {:plain => answer.to_json } )
  end

  def photo_likes
    p = Photo.where({ :id => params.fetch(:id) }).at(0)
    if p.nil?
      answer = "No Record with photo_id: " + params.fetch(:id)
    else
      answer = p.likes
    end

    render( {:plain => answer.to_json } )
  end

  def photo_fans
    p = Photo.where({ :id => params.fetch(:id) }).at(0)
    if p.nil?
      answer = "No Record with photo_id: " + params.fetch(:id)
    else
      answer = p.fans
    end

    render( {:plain => answer.to_json } )
  end

  def insert_like_record
    answer = "working on it"
    render( {:plain => answer.to_json } )
  end

end
