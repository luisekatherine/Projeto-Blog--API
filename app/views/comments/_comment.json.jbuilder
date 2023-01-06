json.extract! comment, :id, :text

if with_likes
    json.likes do
        json.array! comment.likes, partial: "likes/like", as: :like
    end
end

if !with_likes
    json.comment comment.likes.size
end