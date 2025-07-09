package dal;

<<<<<<< HEAD
import java.sql.Date;
=======
>>>>>>> origin/NgocDung
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import model.Post;
<<<<<<< HEAD
import java.sql.Timestamp;
import java.sql.Statement;
=======
>>>>>>> origin/NgocDung

public class PostDAO extends DBConnect {

    public PostDAO() {
        super();
    }

    public boolean createPost(Post post) {
<<<<<<< HEAD
        String postSql = "INSERT INTO Post (UserId, Topic, Title, Content, CreatedAt, Status) VALUES (?, ?, ?, ?, ?, ?)";
        String imageSql = "INSERT INTO Image (PostId, ImagePath) VALUES (?, ?)";
        String videoSql = "INSERT INTO Video (PostId, VideoPath) VALUES (?, ?)";
=======
        String postSql = "INSERT INTO Post (UserId, Topic, Title, Content, CreatedAt) VALUES (?, ?, ?, ?, ?)";
        String imageSql = "INSERT INTO Image (PostId, ImagePath) VALUES (?, ?)";
>>>>>>> origin/NgocDung

        try {

            // Insert post
<<<<<<< HEAD
            PreparedStatement postSt = connection.prepareStatement(postSql, Statement.RETURN_GENERATED_KEYS);
=======
            PreparedStatement postSt = connection.prepareStatement(postSql, PreparedStatement.RETURN_GENERATED_KEYS);
>>>>>>> origin/NgocDung
            postSt.setInt(1, post.getUserId());
            postSt.setString(2, post.getTopic());
            postSt.setString(3, post.getTitle());
            postSt.setString(4, post.getContent());
<<<<<<< HEAD
            postSt.setTimestamp(5, (Timestamp) post.getCreatedAt());
            postSt.setString(6, post.getStatus());
=======
            postSt.setTimestamp(5, post.getCreatedAt());

>>>>>>> origin/NgocDung
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
<<<<<<< HEAD

                    // Insert videos
                    if (post.getVideos() != null && !post.getVideos().isEmpty()) {
                        PreparedStatement videoSt = connection.prepareStatement(videoSql);
                        for (String videoPath : post.getVideos()) {
                            videoSt.setInt(1, postId);
                            videoSt.setString(2, videoPath);
                            videoSt.executeUpdate();
                        }
                    }
=======
>>>>>>> origin/NgocDung
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
<<<<<<< HEAD
        String postSql = "SELECT * FROM Post WHERE Status = N'đã duyệt' ORDER BY CreatedAt DESC";
        String imageSql = "SELECT ImagePath FROM Image WHERE PostId = ?";
        String videoSql = "SELECT VideoPath FROM Video WHERE PostId = ?";
        try {
            PreparedStatement postSt = connection.prepareStatement(postSql);
            PreparedStatement imageSt = connection.prepareStatement(imageSql);
            PreparedStatement videoSt = connection.prepareStatement(videoSql);
=======
        String postSql = "SELECT * FROM Post ORDER BY CreatedAt DESC";
        String imageSql = "SELECT ImagePath FROM Image WHERE PostId = ?";

        try {
            PreparedStatement postSt = connection.prepareStatement(postSql);
            PreparedStatement imageSt = connection.prepareStatement(imageSql);
>>>>>>> origin/NgocDung
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
<<<<<<< HEAD
                post.setStatus(rs.getString("Status"));
                // Get images for this post
                imageSt.setInt(1, postId);
                ResultSet imageRs = imageSt.executeQuery();
                while (imageRs.next()) {
                    post.addImage(imageRs.getString("ImagePath"));
                }
                // Get videos for this post
                videoSt.setInt(1, postId);
                ResultSet videoRs = videoSt.executeQuery();
                while (videoRs.next()) {
                    post.addVideo(videoRs.getString("VideoPath"));
                }

                posts.add(post);
            }
        } catch (SQLException e) {

            e.printStackTrace();
        }

        return posts;
    }

    public List<Post> searchPostsByTopic(String topic) {
        List<Post> posts = new ArrayList<>();
        String postSql = "SELECT * FROM Post WHERE Topic LIKE ? AND Status = N'đã duyệt' ORDER BY CreatedAt DESC";
        String imageSql = "SELECT ImagePath FROM Image WHERE PostId = ?";
        String videoSql = "SELECT VideoPath FROM Video WHERE PostId = ?";

        try {
            PreparedStatement postSt = connection.prepareStatement(postSql);
            postSt.setString(1, "%" + topic + "%");
            PreparedStatement imageSt = connection.prepareStatement(imageSql);
            PreparedStatement videoSt = connection.prepareStatement(videoSql);
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
                post.setStatus(rs.getString("Status"));
=======
>>>>>>> origin/NgocDung

                // Get images for this post
                imageSt.setInt(1, postId);
                ResultSet imageRs = imageSt.executeQuery();
                while (imageRs.next()) {
                    post.addImage(imageRs.getString("ImagePath"));
                }

<<<<<<< HEAD
                // Get videos for this post
                videoSt.setInt(1, postId);
                ResultSet videoRs = videoSt.executeQuery();
                while (videoRs.next()) {
                    post.addVideo(videoRs.getString("VideoPath"));
                }

                posts.add(post);
            }
        } catch (SQLException e) {
=======
                posts.add(post);
            }
        } catch (SQLException e) {
            
>>>>>>> origin/NgocDung
            e.printStackTrace();
        }

        return posts;
    }
<<<<<<< HEAD

    public boolean updatePost(int postId, String topic, String title, String content) {
        String sql = "UPDATE Post SET Topic = ?, Title = ?, Content = ? WHERE PostId = ?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, topic);
            st.setString(2, title);
            st.setString(3, content);
            st.setInt(4, postId);
            return st.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean deletePost(int postId) {
        String deleteImages = "DELETE FROM Image WHERE PostId = ?";
        String deleteVideos = "DELETE FROM Video WHERE PostId = ?";
        String deletePost = "DELETE FROM Post WHERE PostId = ?";
        try {

            PreparedStatement stImg = connection.prepareStatement(deleteImages);
            stImg.setInt(1, postId);
            stImg.executeUpdate();

            PreparedStatement stVid = connection.prepareStatement(deleteVideos);
            stVid.setInt(1, postId);
            stVid.executeUpdate();

            PreparedStatement st = connection.prepareStatement(deletePost);
            st.setInt(1, postId);
            int rows = st.executeUpdate();
            return rows > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public List<Post> getPostsByUser(int userId) {
        List<Post> posts = new ArrayList<>();
        String postSql = "SELECT * FROM Post WHERE UserId = ? AND Status = N'đã duyệt' ORDER BY CreatedAt DESC";
        String imageSql = "SELECT ImagePath FROM Image WHERE PostId = ?";
        String videoSql = "SELECT VideoPath FROM Video WHERE PostId = ?";
        try {
            PreparedStatement postSt = connection.prepareStatement(postSql);
            postSt.setInt(1, userId);
            PreparedStatement imageSt = connection.prepareStatement(imageSql);
            PreparedStatement videoSt = connection.prepareStatement(videoSql);
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
                post.setStatus(rs.getString("Status"));

                imageSt.setInt(1, postId);
                ResultSet imageRs = imageSt.executeQuery();
                while (imageRs.next()) {
                    post.addImage(imageRs.getString("ImagePath"));
                }
                imageRs.close();

                videoSt.setInt(1, postId);
                ResultSet videoRs = videoSt.executeQuery();
                while (videoRs.next()) {
                    post.addVideo(videoRs.getString("VideoPath"));
                }
                videoRs.close();

                posts.add(post);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return posts;
    }

    public int countPosts(String keyword, String status) {
        String sql = "SELECT COUNT(*) FROM Post WHERE 1=1";
        if (keyword != null && !keyword.trim().isEmpty()) {
            sql += " AND (Title LIKE ?)";

        }
        if (status != null && !status.trim().isEmpty()) {
            sql += " AND Status = ?";
        }
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            int idx = 1;
            if (keyword != null && !keyword.trim().isEmpty()) {
                st.setString(idx++, "%" + keyword + "%");
            }
            if (status != null && !status.trim().isEmpty()) {
                st.setString(idx++, status);
            }
            ResultSet rs = st.executeQuery();
            if (rs.next())
                return rs.getInt(1);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    public List<Post> searchPosts(String keyword, String status, int page, int pageSize) {
        List<Post> posts = new ArrayList<>();
        String sql = "SELECT * FROM Post WHERE 1=1";
        if (keyword != null && !keyword.trim().isEmpty()) {
            sql += " AND (Title LIKE ?)";

        }
        if (status != null && !status.trim().isEmpty()) {
            sql += " AND Status = ?";
        }
        sql += " ORDER BY CreatedAt DESC OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            int idx = 1;
            if (keyword != null && !keyword.trim().isEmpty()) {
                st.setString(idx++, "%" + keyword + "%");
            }
            if (status != null && !status.trim().isEmpty()) {
                st.setString(idx++, status);
            }
            st.setInt(idx++, (page - 1) * pageSize);
            st.setInt(idx++, pageSize);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                Post post = new Post();
                post.setPostId(rs.getInt("PostId"));
                post.setUserId(rs.getInt("UserId"));
                post.setTopic(rs.getString("Topic"));
                post.setTitle(rs.getString("Title"));
                post.setContent(rs.getString("Content"));
                post.setCreatedAt(rs.getTimestamp("CreatedAt"));
                post.setStatus(rs.getString("Status"));
                posts.add(post);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return posts;
    }

    public boolean updatePostStatus(int postId, String status) {
        String sql = "UPDATE Post SET Status=? WHERE PostId=?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, status);
            st.setInt(2, postId);
            return st.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public Post getPostById(int postId) {
        String postSql = "SELECT * FROM Post WHERE PostId = ?";
        String imageSql = "SELECT ImagePath FROM Image WHERE PostId = ?";
        String videoSql = "SELECT VideoPath FROM Video WHERE PostId = ?";
        try (PreparedStatement postSt = connection.prepareStatement(postSql)) {
            postSt.setInt(1, postId);
            try (ResultSet rs = postSt.executeQuery()) {
                if (rs.next()) {
                    Post post = new Post();
                    post.setPostId(rs.getInt("PostId"));
                    post.setUserId(rs.getInt("UserId"));
                    post.setTopic(rs.getString("Topic"));
                    post.setTitle(rs.getString("Title"));
                    post.setContent(rs.getString("Content"));
                    post.setCreatedAt(rs.getTimestamp("CreatedAt"));
                    post.setStatus(rs.getString("Status"));

                    try (PreparedStatement imageSt = connection.prepareStatement(imageSql)) {
                        imageSt.setInt(1, postId);
                        try (ResultSet imageRs = imageSt.executeQuery()) {
                            while (imageRs.next()) {
                                post.addImage(imageRs.getString("ImagePath"));
                            }
                        }
                    }

                    try (PreparedStatement videoSt = connection.prepareStatement(videoSql)) {
                        videoSt.setInt(1, postId);
                        try (ResultSet videoRs = videoSt.executeQuery()) {
                            while (videoRs.next()) {
                                post.addVideo(videoRs.getString("VideoPath"));
                            }
                        }
                    }

                    return post;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
=======
>>>>>>> origin/NgocDung
}
