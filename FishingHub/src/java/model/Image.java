/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author pc
 */
public class Image {

    private int imageId;
    private int postId;
    private String imagePath;

    public Image() {
    }
    
    

    public Image(int imageId, int postId, String imagePath) {
        this.imageId = imageId;
        this.postId = postId;
        this.imagePath = imagePath;
    }

    public int getImageId() {
        return imageId;
    }

    public void setImageId(int imageId) {
        this.imageId = imageId;
    }

    public int getPostId() {
        return postId;
    }

    public void setPostId(int postId) {
        this.postId = postId;
    }

    public String getImagePath() {
        return imagePath;
    }

    public void setImagePath(String imagePath) {
        this.imagePath = imagePath;
    }

    @Override
    public String toString() {
        return "Image{" + "imageId=" + imageId + ", postId=" + postId + ", imagePath=" + imagePath + '}';
    }
    
    
    
    

}
