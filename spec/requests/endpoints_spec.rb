require "rails_helper"

describe "/users" do
  it "has a list of all users", :points => 1 do
    first_user = User.new
    first_user.username = "alice_#{rand(100)}"
    first_user.save

    second_user = User.new
    second_user.username = "bob_#{rand(100)}"
    second_user.save

    get "/users"

    expect(response.body).to eq(User.all.to_json)
  end
end

describe "/users/[ANY EXISTING USERNAME]" do
  it "has the details of the user", :points => 1 do
    user = User.new
    user.username = "alice_#{rand(100)}"
    user.save

    get "/users/#{user.username}"

    expect(response.body).to eq(user.to_json)
  end
end

describe "/users/[ANY EXISTING USERNAME]/own_photos" do
  it "has the photos posted by the user", :points => 1 do
    user = User.new
    user.username = "alice_#{rand(100)}"
    user.save

    other_user = User.new
    other_user.save

    first_photo = Photo.new
    first_photo.owner_id = user.id
    first_photo.caption = "First caption #{rand(100)}"
    first_photo.save

    second_photo = Photo.new
    second_photo.owner_id = other_user.id
    second_photo.caption = "Second caption #{rand(100)}"
    second_photo.save

    third_photo = Photo.new
    third_photo.owner_id = user.id
    third_photo.caption = "Third caption #{rand(100)}"
    third_photo.save

    get "/users/#{user.username}/own_photos"

    expect(response.body).to eq(user.own_photos.to_json)
  end
end

describe "/users/[ANY EXISTING USERNAME]/liked_photos" do
  it "has the photos the user has liked", :points => 2 do
    user = User.new
    user.username = "alice_#{rand(100)}"
    user.save

    other_user = User.new
    other_user.save

    first_photo = Photo.new
    first_photo.owner_id = other_user.id
    first_photo.caption = "Some caption #{rand(100)}"
    first_photo.save

    second_photo = Photo.new
    second_photo.owner_id = user.id
    second_photo.caption = "Some caption #{rand(100)}"
    second_photo.save

    third_photo = Photo.new
    third_photo.owner_id = other_user.id
    third_photo.caption = "Some caption #{rand(100)}"
    third_photo.save

    first_like = Like.new
    first_like.photo_id = first_photo.id
    first_like.fan_id = user.id
    first_like.save

    second_like = Like.new
    second_like.photo_id = second_photo.id
    second_like.fan_id = other_user.id
    second_like.save

    third_like = Like.new
    third_like.photo_id = third_photo.id
    third_like.fan_id = user.id
    third_like.save

    get "/users/#{user.username}/liked_photos"

    expect(response.body).to eq(user.liked_photos.to_json)
  end
end

describe "/users/[ANY EXISTING USERNAME]/feed" do
  it "has the photos posted by the people the user is following", :points => 4 do
    user = User.new
    user.username = "alice_#{rand(100)}"
    user.save

    first_other_user = User.new
    first_other_user.save

    first_other_user_first_photo = Photo.new
    first_other_user_first_photo.owner_id = first_other_user.id
    first_other_user_first_photo.caption = "Some caption #{rand(100)}"
    first_other_user_first_photo.save
    first_other_user_second_photo = Photo.new
    first_other_user_second_photo.owner_id = first_other_user.id
    first_other_user_second_photo.caption = "Some caption #{rand(100)}"
    first_other_user_second_photo.save

    second_other_user = User.new
    second_other_user.save

    second_other_user_first_photo = Photo.new
    second_other_user_first_photo.owner_id = second_other_user.id
    second_other_user_first_photo.caption = "Some caption #{rand(100)}"
    second_other_user_first_photo.save
    second_other_user_second_photo = Photo.new
    second_other_user_second_photo.owner_id = second_other_user.id
    second_other_user_second_photo.caption = "Some caption #{rand(100)}"
    second_other_user_second_photo.save

    third_other_user = User.new
    third_other_user.save

    third_other_user_first_photo = Photo.new
    third_other_user_first_photo.owner_id = third_other_user.id
    third_other_user_first_photo.caption = "Some caption #{rand(100)}"
    third_other_user_first_photo.save
    third_other_user_second_photo = Photo.new
    third_other_user_second_photo.owner_id = third_other_user.id
    third_other_user_second_photo.caption = "Some caption #{rand(100)}"
    third_other_user_second_photo.save

    fourth_other_user = User.new
    fourth_other_user.save

    fourth_other_user_first_photo = Photo.new
    fourth_other_user_first_photo.owner_id = fourth_other_user.id
    fourth_other_user_first_photo.caption = "Some caption #{rand(100)}"
    fourth_other_user_first_photo.save
    fourth_other_user_second_photo = Photo.new
    fourth_other_user_second_photo.owner_id = fourth_other_user.id
    fourth_other_user_second_photo.caption = "Some caption #{rand(100)}"
    fourth_other_user_second_photo.save

    first_follow_request = FollowRequest.new
    first_follow_request.sender_id = user.id
    first_follow_request.recipient_id = first_other_user.id
    first_follow_request.status = "rejected"
    first_follow_request.save

    second_follow_request = FollowRequest.new
    second_follow_request.sender_id = user.id
    second_follow_request.recipient_id = second_other_user.id
    second_follow_request.status = "accepted"
    second_follow_request.save

    third_follow_request = FollowRequest.new
    third_follow_request.sender_id = user.id
    third_follow_request.recipient_id = third_other_user.id
    third_follow_request.status = "pending"
    third_follow_request.save

    fourth_follow_request = FollowRequest.new
    fourth_follow_request.sender_id = user.id
    fourth_follow_request.recipient_id = fourth_other_user.id
    fourth_follow_request.status = "accepted"
    fourth_follow_request.save

    get "/users/#{user.username}/feed"

    expect(response.body).to eq(user.feed.to_json)
  end
end

describe "/photos/[ANY EXISTING PHOTO ID]" do
  it "has the details of the photo", :points => 1 do
    user = User.new
    user.save

    photo = Photo.new
    photo.owner_id = user.id
    photo.caption = "Some caption #{rand(100)}"
    photo.image = "http://some.random.url/file#{rand(100)}.jpg"
    photo.save

    get "/photos/#{photo.id}"

    expect(response.body).to eq(photo.to_json)
  end
end

describe "/insert_like_record" do
  it "adds a fan to a photo", :points => 3 do
    user = User.new
    user.save

    other_user = User.new
    other_user.save

    photo = Photo.new
    photo.owner_id = user.id
    photo.caption = "Some caption #{rand(100)}"
    photo.image = "http://some.random.url/file#{rand(100)}.jpg"
    photo.save

    get "/insert_like_record?input_photo_id=#{photo.id}&input_user_id=#{other_user.id}"

    expect(photo.fans).to include(other_user)
  end
end

describe "/delete_like/[ANY EXISTING LIKE ID]" do
  it "removes a fan from a photo", :points => 2 do
    user = User.new
    user.save

    other_user = User.new
    other_user.save

    photo = Photo.new
    photo.owner_id = user.id
    photo.caption = "Some caption #{rand(100)}"
    photo.image = "http://some.random.url/file#{rand(100)}.jpg"
    photo.save

    like = Like.new
    like.fan_id = other_user.id
    like.photo_id = photo.id
    like.save

    get "/delete_like/#{like.id}"

    expect(photo.fans).to_not include(other_user)
  end
end

describe "/photos/[ANY EXISTING PHOTO ID]/comments" do
  it "has the comments left on the photo", :points => 1 do
    user = User.new
    user.save

    photo = Photo.new
    photo.owner_id = user.id
    photo.save

    first_commenter = User.new
    first_commenter.save

    first_comment = Comment.new
    first_comment.author_id = first_commenter.id
    first_comment.photo_id = photo.id
    first_comment.body = "Some comment #{rand(100)}"
    first_comment.save

    second_commenter = User.new
    second_commenter.save

    second_comment = Comment.new
    second_comment.author_id = second_commenter.id
    second_comment.photo_id = photo.id
    second_comment.body = "Some comment #{rand(100)}"
    second_comment.save

    get "/photos/#{photo.id}/comments"

    expect(response.body).to eq(photo.comments.to_json)
  end
end

describe "/update_comment/[EXISTING COMMENT ID]" do
  it "updates a record in the comments table", :points => 3 do
    user = User.new
    user.save

    photo = Photo.new
    photo.owner_id = user.id
    photo.save

    commenter = User.new
    commenter.save

    comment = Comment.new
    comment.author_id = commenter.id
    comment.photo_id = photo.id
    comment.body = "Some comment #{rand(100)}"
    comment.save

    edited_body = "A better comment #{rand(1000)}"

    get "/update_comment_record/#{comment.id}?input_body=#{edited_body}"

    expect(comment.reload.body).to eq(edited_body)
  end
end
