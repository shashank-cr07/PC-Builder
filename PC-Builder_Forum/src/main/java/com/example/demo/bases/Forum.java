package com.example.demo.bases;

import jakarta.persistence.*;
import java.util.List;

@Entity
public class Forum implements ForumComponent {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;

    private String name;

    @Column(name = "created_by")  // Map it to the 'created_by' column in the database
    private int createdBy;

    @OneToMany(mappedBy = "forum", cascade = CascadeType.ALL, orphanRemoval = true)
    private List<Post> posts;

    // Getters and Setters
    public int getId() {
        return id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public List<Post> getPosts() {
        return posts;
    }

    public void setPosts(List<Post> posts) {
        this.posts = posts;
    }

    public int getCreatedBy() {
        return createdBy;
    }

    public void setCreatedBy(int createdBy) {
        this.createdBy = createdBy;
    }

    // Composite pattern method
    @Override
    public void display() {
        System.out.println("Forum: " + name);
        if (posts != null) {
            for (Post post : posts) {
                post.display();
            }
        }
    }
}
