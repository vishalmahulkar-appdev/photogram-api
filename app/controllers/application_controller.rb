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

  def photo_comments
    p = Photo.where({ :id => params.fetch(:id) }).at(0)
    if p.nil?
      answer = "No Record with photo_id: " + params.fetch(:id)
    else
      answer = p.comments
    end

    render( {:plain => answer.to_json } )
  end

  def insert_like_record
    photo_id = params.fetch(:input_photo_id,nil)
    user_id = params.fetch(:input_user_id,nil)

    cb = Like.count
    if photo_id.nil? || user_id.nil?
      answer = {:before_count =>cb, :after_count => cb, :record_added => "No record added, Photo ID or User ID incorrect"}
    else
      l = Like.new
      l.fan_id = user_id
      l.photo_id = photo_id
      l.save
      ca = Like.count
      answer = {:before_count =>cb, :after_count => ca, :record_added => l}
    end

    render( {:plain => answer.to_json } )
  end

  def delete_like_record
    like_id = params.fetch(:id,nil)

    cb = Like.count
    if like_id.nil?
      answer = {:before_count =>cb, :after_count => cb, :record_deletec => "No record deleted, Like ID incorrect"}
    else
      l = Like.where( {:id => like_id}).at(0)
      if l.nil?
        answer = {:before_count =>cb, :after_count => cb, :record_deletec => "No record deleted, Like ID incorrect"}
      else
        l.destroy
        ca = Like.count
        answer = {:before_count =>cb, :after_count => ca, :record_removed => l}
      end
    end

    render( {:plain => answer.to_json } )
  end

  def insert_comment_record
    photo_id = params.fetch(:input_photo_id,nil)
    user_id = params.fetch(:input_user_id,nil)
    comment_text = params.fetch(:input_body,"")

    cb = Comment.count
    if photo_id.nil? || user_id.nil?
      answer = {:before_count =>cb, :after_count => cb, :record_added => "No record added, Photo ID or User ID incorrect"}
    else
      c = Comment.new
      c.author_id = user_id
      c.photo_id = photo_id
      c.body = comment_text
      c.save
      ca = Comment.count
      answer = {:before_count =>cb, :after_count => ca, :record_added => c}
    end

    render( {:plain => answer.to_json } )
  end


  def update_comment_record
    comment_text = params.fetch(:input_body,"")
    comment_id = params.fetch(:id,nil)

    if comment_id.nil?
      answer = {:record_updated => "No record updated, Comment ID incorrect"}
    else
      c = Comment.where( {:id => comment_id}).at(0)
      c.body = comment_text
      c.save
      answer = {:record_updated => c}
    end

    render( {:plain => answer.to_json } )
  end


end
