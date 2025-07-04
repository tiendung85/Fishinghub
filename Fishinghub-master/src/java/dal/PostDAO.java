package dal;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import model.Post;

public class PostDAO extends DBConnect {

    public PostDAO() {
        super();
    }

    public boolean createPost(Post post) {
        String postSql = "INSERT INTO Post (UserId, Topic, Title, Content, CreatedAt) VALUES (?, ?, ?, ?, ?)";
        String imageSql = "INSERT INTO Image (PostId, ImagePath) VALUES (?, ?)";

        try {

            // Insert post
            PreparedStatement postSt = connection.prepareStatement(postSql, PreparedStatement.RETURN_GENERATED_KEYS);
            postSt.setInt(1, post.getUserId());
            postSt.setString(2, post.getTopic());
            postSt.setString(3, post.getTitle());
            postSt.setString(4, post.getContent());
            postSt.setTimestamp(5, post.getCreatedAt());

            int postRows = postSt.executeUpdate();

            if (postRows > 0) {
                ResultSet rs = postSt.getGeneratedKeys();
                if (rs.next()) {
                    int postId = rs.getInt(1);

                    // Insert images
                    if (post.getImages() != null && !post.getImages().isEmpty()) {
                        PreparedStatement imageSt = connection.prepareStatement(imageSql);
                        for (String imagePath : post.getImages()) {
                            imageSt.setInt(1, postId);
                            imageSt.setString(2, imagePath);
                            imageSt.executeUpdate();
                        }
                    }
                }
            }

            return true;
        } catch (SQLException e) {

            e.printStackTrace();
            return false;
        }
    }

    public List<Post> getAllPosts() {
        List<Post> posts = new ArrayList<>();
        String postSql = "SELECT * FROM Post ORDER BY CreatedAt DESC";
        String imageSql = "SELECT ImagePath FROM Image WHERE PostId = ?";

        try {
            PreparedStatement postSt = connection.prepareStatement(postSql);
            PreparedStatement imageSt = connection.prepareStatement(imageSql);
            ResultSet rs = postSt.executeQuery();

            while (rs.next()) {
                Post post = new Post();
                int postId = rs.getInt("PostId");
                post.setPostId(postId);
                post.setUserId(rs.getInt("UserId"));
                post.setTopic(rs.getString("Topic"));
                post.setTitle(rs.getString("Title"));
                post.setContent(rs.getString("Content"));
                post.setCreatedAt(rs.getTimestamp("CreatedAt"));

                // Get images for this post
                imageSt.setInt(1, postId);
                ResultSet imageRs = imageSt.executeQuery();
                while (imageRs.next()) {
                    post.addImage(imageRs.getString("ImagePath"));
                }

                posts.add(post);
            }
        } catch (SQLException e) {
            
            e.printStackTrace();
        }

        return posts;
    }
}
