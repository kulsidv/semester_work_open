package ru.kpfu.itis.kulsidv.entity;

import jakarta.persistence.*;
import org.hibernate.annotations.Check;

import java.util.ArrayList;
import java.util.List;

@Entity
@Table(name = "chapters")
public class Chapter {
    @Id
    @Column(name = "id")
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @Column(name = "title", nullable = false, unique = true)
    private String title;

    @Column(name = "chapter_num", nullable = false, unique = true)
    @Check(constraints = "chapter_num > 0")
    private Integer chapterNum;

    @OneToMany(mappedBy = "chapter")
    List<Paragraph> paragraphs = new ArrayList<>();

    @OneToMany(mappedBy = "chapter")
    private List<Progress> progresses = new ArrayList<>();

    public Chapter() {}

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public int getChapterNum() {
        return chapterNum;
    }

    public void setChapterNum(int chapterNum) {
        this.chapterNum = chapterNum;
    }

    public List<Paragraph> getParagraphs() {
        return paragraphs;
    }

    public void setParagraphs(List<Paragraph> paragraphs) {
        this.paragraphs = paragraphs;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public void setChapterNum(Integer chapterNum) {
        this.chapterNum = chapterNum;
    }

    public List<Progress> getProgresses() {
        return progresses;
    }

    public void setProgresses(List<Progress> progresses) {
        this.progresses = progresses;
    }
}
