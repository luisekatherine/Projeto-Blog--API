json.extract! comment, :id, :text, :user_id, :updated_at

if with_likes
    json.likes do
        json.array! comment.likes, partial: "likes/like", as: :like
    end
end

if !with_likes
    json.comment comment.likes.size
end

if @user && comment.likes.find { | userLiked | userLiked.user_id == @user.id }
    json.liked true
else
    json.liked false
end