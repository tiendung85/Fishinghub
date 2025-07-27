package dal;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import model.Post;
import model.PostNotification;
import dal.*;

import java.sql.Timestamp;
import java.sql.Statement;

public class PostDAO extends DBConnect {

    public PostDAO() {
        super();
    }

    public boolean createPost(Post post) {
        String postSql = "INSERT INTO Post (UserId, Topic, Title, Content, CreatedAt, Status) VALUES (?, ?, ?, ?, ?, ?)";
        String imageSql = "INSERT INTO Image (PostId, ImagePath) VALUES (?, ?)";
        String videoSql = "INSERT INTO Video (PostId, VideoPath) VALUES (?, ?)";

        try {

            // Insert post
            PreparedStatement postSt = connection.prepareStatement(postSql, Statement.RETURN_GENERATED_KEYS);
            postSt.setInt(1, post.getUserId());
            postSt.setString(2, post.getTopic());
            postSt.setString(3, post.getTitle());
            postSt.setString(4, post.getContent());
            postSt.setTimestamp(5, (Timestamp) post.getCreatedAt());
            postSt.setString(6, post.getStatus());
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

                    // Insert videos
                    if (post.getVideos() != null && !post.getVideos().isEmpty()) {
                        PreparedStatement videoSt = connection.prepareStatement(videoSql);
                        for (String videoPath : post.getVideos()) {
                            videoSt.setInt(1, postId);
                            videoSt.setString(2, videoPath);
                            videoSt.executeUpdate();
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
        String postSql = "SELECT * FROM Post WHERE Status = N'đã duyệt' ORDER BY CreatedAt DESC";
        String imageSql = "SELECT ImagePath FROM Image WHERE PostId = ?";
        String videoSql = "SELECT VideoPath FROM Video WHERE PostId = ?";
        try {
            PreparedStatement postSt = connection.prepareStatement(postSql);
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

                imageSt.setInt(1, postId);
                ResultSet imageRs = imageSt.executeQuery();
                while (imageRs.next()) {
                    post.addImage(imageRs.getString("ImagePath"));
                }

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

    public boolean updatePost(int postId, String topic, String title, String content, List<String> images,
            List<String> videos) {
        String postSql = "UPDATE Post SET Topic = ?, Title = ?, Content = ?, Status = ? WHERE PostId = ?";
        String deleteImagesSql = "DELETE FROM Image WHERE PostId = ?";
        String deleteVideosSql = "DELETE FROM Video WHERE PostId = ?";
        String insertImageSql = "INSERT INTO Image (PostId, ImagePath) VALUES (?, ?)";
        String insertVideoSql = "INSERT INTO Video (PostId, VideoPath) VALUES (?, ?)";

        try {

            // Update post details
            try (PreparedStatement postSt = connection.prepareStatement(postSql)) {
                postSt.setString(1, topic);
                postSt.setString(2, title);
                postSt.setString(3, content);
                postSt.setString(4, "chờ duyệt"); // Set status to pending approval
                postSt.setInt(5, postId);
                postSt.executeUpdate();
            }

            // Delete existing images
            try (PreparedStatement deleteImagesSt = connection.prepareStatement(deleteImagesSql)) {
                deleteImagesSt.setInt(1, postId);
                deleteImagesSt.executeUpdate();
            }

            // Delete existing videos
            try (PreparedStatement deleteVideosSt = connection.prepareStatement(deleteVideosSql)) {
                deleteVideosSt.setInt(1, postId);
                deleteVideosSt.executeUpdate();
            }

            // Insert new images
            if (images != null && !images.isEmpty()) {
                try (PreparedStatement imageSt = connection.prepareStatement(insertImageSql)) {
                    for (String imagePath : images) {
                        imageSt.setInt(1, postId);
                        imageSt.setString(2, imagePath);
                        imageSt.executeUpdate();
                    }
                }
            }

            // Insert new videos
            if (videos != null && !videos.isEmpty()) {
                try (PreparedStatement videoSt = connection.prepareStatement(insertVideoSql)) {
                    for (String videoPath : videos) {
                        videoSt.setInt(1, postId);
                        videoSt.setString(2, videoPath);
                        videoSt.executeUpdate();
                    }
                }
            }

            connection.commit();
            return true;
        } catch (SQLException e) {
            e.printStackTrace();
            try {
                connection.rollback();
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
            return false;
        }
    }

    public void repostRejectedPost(int postId, String topic, String title, String content, List<String> images,
            List<String> videos, String newStatus) {
        updatePost(postId, topic, title, content, images, videos);
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

    public void insertRejectionReason(int postId, String reason) {
        String sql = "INSERT INTO PostRejections (PostId, Reason) VALUES (?, ?)";
        try (PreparedStatement st = connection.prepareStatement(sql)) {
            st.setInt(1, postId);
            st.setString(2, reason);
            st.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void insertNotification(int userId, int postId, String message) {
        String sql = "INSERT INTO PostNotification (UserId, PostId, Message) VALUES (?, ?, ?)";
        try (PreparedStatement st = connection.prepareStatement(sql)) {
            st.setInt(1, userId);
            st.setInt(2, postId);
            st.setString(3, message);
            st.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public List<PostNotification> getNotificationsByUser(int userId) {
        List<PostNotification> notifications = new ArrayList<>();
        String sql = "SELECT * FROM PostNotification WHERE ReceiverId = ? ORDER BY CreatedAt DESC";
        try (PreparedStatement st = connection.prepareStatement(sql)) {
            st.setInt(1, userId);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                PostNotification notification = new PostNotification();
                notification.setNotificationId(rs.getInt("NotificationId"));
                notification.setPostId(rs.getInt("PostId"));
                notification.setReceiverId(rs.getInt("ReceiverId"));
                notification.setMessage(rs.getString("Message"));
                notification.setIsRead(rs.getBoolean("IsRead"));
                notification.setCreatedAt(rs.getTimestamp("CreatedAt"));
                notifications.add(notification);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return notifications;
    }

    public List<Post> getPostsByStatusAndUser(String status, int userId) {
        List<Post> posts = new ArrayList<>();
        String postSql = "SELECT * FROM Post WHERE UserId = ? AND Status = ? ORDER BY CreatedAt DESC";
        String imageSql = "SELECT ImagePath FROM Image WHERE PostId = ?";
        String videoSql = "SELECT VideoPath FROM Video WHERE PostId = ?";
        try {
            PreparedStatement postSt = connection.prepareStatement(postSql);
            postSt.setInt(1, userId);
            postSt.setString(2, status);
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

    public List<Post> getRecentPosts(int limit) {
        List<Post> posts = new ArrayList<>();
        String postSql = "SELECT * FROM Post WHERE Status = N'đã duyệt' ORDER BY CreatedAt DESC OFFSET 0 ROWS FETCH NEXT ? ROWS ONLY";
        String imageSql = "SELECT ImagePath FROM Image WHERE PostId = ?";
        String videoSql = "SELECT VideoPath FROM Video WHERE PostId = ?";

        PostCommentDAO commentDAO = new PostCommentDAO();
        PostLikeDAO likeDAO = new PostLikeDAO();

        try {
            PreparedStatement postSt = connection.prepareStatement(postSql);
            postSt.setInt(1, limit);
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

                // Lấy hình ảnh
                PreparedStatement imageSt = connection.prepareStatement(imageSql);
                imageSt.setInt(1, postId);
                ResultSet imageRs = imageSt.executeQuery();
                while (imageRs.next()) {
                    post.addImage(imageRs.getString("ImagePath"));
                }
                imageRs.close();
                imageSt.close();

                // Lấy video
                PreparedStatement videoSt = connection.prepareStatement(videoSql);
                videoSt.setInt(1, postId);
                ResultSet videoRs = videoSt.executeQuery();
                while (videoRs.next()) {
                    post.addVideo(videoRs.getString("VideoPath"));
                }
                videoRs.close();
                videoSt.close();

                // Lấy số lượng bình luận
                post.setCommentCount(commentDAO.countCommentsByPostId(postId));

                // Lấy số lượng lượt like
                post.setLikeCount(likeDAO.countLikesByPostId(postId));

                posts.add(post);
            }
            rs.close();
            postSt.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return posts;
    }

    public int countPendingPostsThisWeek() {
        int count = 0;
        String sql = "SELECT COUNT(*) FROM Post WHERE Status = N'chờ duyệt' AND CreatedAt >= DATEADD(DAY, -7, GETDATE())";
        try (PreparedStatement ps = connection.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {
            if (rs.next()) {
                count = rs.getInt(1);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return count;
    }

    public int countPendingPostsPreviousWeek() {
        int count = 0;
        String sql = "SELECT COUNT(*) FROM Post WHERE Status = N'chờ duyệt' AND CreatedAt >= DATEADD(DAY, -14, GETDATE()) AND CreatedAt < DATEADD(DAY, -7, GETDATE())";
        try (PreparedStatement ps = connection.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {
            if (rs.next()) {
                count = rs.getInt(1);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return count;
    }

    public List<Post> getTopPendingPosts(int limit) {
        List<Post> list = new ArrayList<>();
        String sql = "SELECT TOP (?) P.PostId, P.UserId, P.Topic, P.Title, P.Content, P.CreatedAt, P.Status, U.FullName "
                +
                "FROM Post P JOIN Users U ON P.UserId = U.UserId " +
                "WHERE P.Status = N'chờ duyệt' " +
                "ORDER BY P.CreatedAt DESC";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, limit);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Post p = new Post();
                p.setPostId(rs.getInt("PostId"));
                p.setUserId(rs.getInt("UserId"));
                p.setTopic(rs.getString("Topic"));
                p.setTitle(rs.getString("Title"));
                p.setContent(rs.getString("Content"));
                p.setCreatedAt(rs.getTimestamp("CreatedAt"));
                p.setStatus(rs.getString("Status"));
                p.setAuthorName(rs.getString("FullName"));
                list.add(p);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

}
