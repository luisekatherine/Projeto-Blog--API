json.extract! post, :id, :title, :description, :user_id

if with_tags
    json.tags do
        json.array! post.tags, partial: 'tags/tag', as: :tag
    end

    json.comments do
        json.array! post.comments, partial: 'comments/comment', as: :comment, with_likes: false
    end

    json.likes do
        json.array! post.likes, partial: 'likes/like', as: :like
    end
end

if !with_tags
    json.comment post.comments.size
    json.like_post post.likes.size
end
